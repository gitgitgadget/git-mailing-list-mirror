Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03EF224234
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 20:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732284; cv=none; b=iZQadW6n+fELJCguV1NGuxZGolcGG8h6b6lGYevh9xPTdlv8iW60yse1YUjQ32sul8+l+uOVw2W3P+Y+km+V7M4x5W7vuTz9G0GRsG6peGyNNXB4tiypuOOkM27pVWNObFZ49dJXofoNb98MYvzDP5qVaVoxbQF8Qi1RPlyXelI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732284; c=relaxed/simple;
	bh=jopgU6elcizjboWKJRMHtlDIM4jVfGPkmCmeHiBjGY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eN1KNe5UAzoPkwOwKHcriiF5hn1o3THMByElwkakJkaZ/zQOcNAM40GciOwCcmVdsHpUczWxISO19BjRT1mqgPmjD7y6FyIUO920qkPrjzLTV+/+yc7F5Axo+3ES0HAvt4vIYAl3MBIsrgvPfa9TcWEa4h3v0Vil9aK8kw9fVFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Z0j1ZoO6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JtRX8MtP; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Z0j1ZoO6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JtRX8MtP"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 733461D00107;
	Fri, 17 Oct 2025 16:18:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Fri, 17 Oct 2025 16:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760732281; x=1760818681; bh=BHXUEzuwwr
	XrVJzVoKVKoqLyl8qCQyhcsV4RRdLHxE0=; b=Z0j1ZoO6MojX3Pba+yOX3sgElx
	PtaffssWqdO7+2d5N+gW5/piX72uVbGo7QgVVaBAbdEJ5YJ/D/3kkNqhC92C1+mm
	ApzLZIeRz3qHzX7amAbsPnTKItH28LJXBe7HIm9F9WYXNweD6QZsU3bZrAy0wJmn
	DnSq5xci4eZgP6dAjpRLF/jxHcj328CxZxH3L5ef4RKig5lcgXlTX+VbhlJVL5Ps
	wWS7Ymls6vkGtjYvB8HQXvqWYZ0GcEhzhEY/kdRZ2iSaACQyEz5AxaklLKyTGXxI
	Bxq63MxGpglCY8plvQ/TdX5lCsph5P5eK3wva2FmkhUW8hofWKk4XXYpFZEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760732281; x=1760818681; bh=BHXUEzuwwrXrVJzVoKVKoqLyl8qCQyhcsV4
	RRdLHxE0=; b=JtRX8MtPYkUWukmL8p1N5b9h2epSRQ4Ktd+zmcFFAhZ0Kqx0RQB
	71IsEpEJ4fIJSZRiJFJJnT9Co8GwFZ5bbaITw7UkCrdlol7dtFOrIZGO5pvLoGCT
	K9BAFqg/SBzbTrmAIH9KWKUfdp8wt6hz5ICxzZKD9XjApKXL5r3w9FqauLVGVu28
	0veDj27pFOiTrt0hRYMv7tBWLqQRNB+ZM/XzWGBjIQMApm7rlVnoukQ8Qlw/Fs6w
	3ft/Sf+eYJvyIGnOwsfW9QxXTyuUFEU1bOlwq2Osa1SVOkaJXD00FSbhL8/NaR5s
	HSRp/qum3XN7DGRegM4AFCGVspXjRVSvTPw==
X-ME-Sender: <xms:eKTyaO-FkjdBWbNzrK9QsHiZK9UY3EzBjk8zciJ1MDZcLfDr528z2g>
    <xme:eKTyaJrfO5cQ2Pcw2vgJK0nZ1G8mg4h1boIhERaTn1K9EX4qBDQwwpE872gtuXAPh
    Q2mZP_am7Jlvh4dAgaVtBs7An8SZd_XUxixDRcaOfj7kV7BECcCZw>
X-ME-Received: <xmr:eKTyaDAHY-vpq7QOaiIvIgSDz63oxSKrVKmas0B1uigjNpknkvq6al7duhBFnfAzh7TvxPwIRV_5LgyFr5j5zpZBa2o4kVFPlJFM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddufedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    ehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthht
    ohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eKTyaLwzrXBgHC08SibUgPrqUcDNR2iMKYxTIIrdd2srNSqBDHuz9g>
    <xmx:eKTyaA3LzTpVjDzvbvZOtg_mXQXuPxUzqj-7IOxnaFBL3f35vf8jrA>
    <xmx:eKTyaLyQuPL74usL3Caz8QeCBduRcYg0sTErFjqHDvztWysVqH8uMA>
    <xmx:eKTyaHFco-c43rfeRo3y5zC_wICirhvVI7dq9G1o_zTEEFFQiruzww>
    <xmx:eaTyaCaH6BT5szVUwqL3mVv96FuISk5zjF1Vs45LG-qWmqDVuzRuKTaP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 16:17:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Lidong Yan <502024330056@smail.nju.edu.cn>,  Lidong
 Yan <yldhome2d2@gmail.com>
Subject: Re: [PATCH] diff: stop output garbled message in dry run mode
In-Reply-To: <4ff55fc5-7880-b8bf-257f-3186552e9c36@gmx.de> (Johannes
	Schindelin's message of "Fri, 17 Oct 2025 14:07:50 +0200 (CEST)")
References: <pull.2071.git.git.1760671049113.gitgitgadget@gmail.com>
	<4ff55fc5-7880-b8bf-257f-3186552e9c36@gmx.de>
Date: Fri, 17 Oct 2025 13:17:58 -0700
Message-ID: <xmqqa51pz3ih.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I do see a still-unguarded `fprintf(o->file, ...)` call in
> `run_diff_cmd()`, but as far as I can see, this call is not in any code
> path where `dry_run` is set.

Among the callers of run_diff_cmd(), only the caller that wants to
report "this path is unmerged" passes NULL diff_filespec pointers in
parameters one and two, in which case run_diff_cmd() would give that
message.  So if you have an unmerged filepair in queued_diff, this
callchain

	diff_flush()
	  loop over diff_queued_diff
          -> diff_flush_patch_quietly()
	     fiddle with dry_run bit
	     -> diff_flush_patch()
		-> run_diff()
		   -> run_diff_cmd() with one&two set to NULL

may hit the fprintf into o->file.

So you are right to worry about that fprintf().  If I make a
whitespace-only change to one file, and then make another path
unmerged, here is what I would see:

    $ rungit v2.48.0 diff --raw
    :100644 100644 b82c4963e7 0000000000 M  cache-tree.h
    :000000 100644 0000000000 0000000000 U  t/lib-gpg.sh

This is version before that dry-run thing.  It operated under the
old rule to show "--raw" to report object differences, hence
ignoring "-w".

    $ rungit v2.48.0 diff --raw -w
    :100644 100644 b82c4963e7 0000000000 M  cache-tree.h
    :000000 100644 0000000000 0000000000 U  t/lib-gpg.sh

With a version with the dry_run thing, here is what we see:

    $ git diff --raw -w
    * Unmerged path t/lib-gpg.sh
    :000000 100644 0000000000 0000000000 U  t/lib-gpg.sh

As dry_run thing intended, the entry on the whitespace-only path is
gone from the output, but the fprintf(o->file) you noticed comes out,
which is not what we want to see.  Of course, if we omit -w to avoid
triggering the dry-run thing, we won't see it.

    $ git diff --raw
    :100644 100644 b82c4963e7 0000000000 M  cache-tree.h
    :000000 100644 0000000000 0000000000 U  t/lib-gpg.sh

As a regression-fix change, I'd feel safer with Peff's version.

Thanks.
