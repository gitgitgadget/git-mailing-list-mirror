Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534FD3016EB
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769183885; cv=none; b=sl7Wtg67Q9xz90mALqd3nGsY27FYneFsnTjSfqhr4TsjxbtsVt4MGiXMCfeQh+ih24Yh0cLp99cYFTAlYzdNH7uJzVgAIujHckMDPTots0wXFor2PZyedTd2IJumMAkJwXafUxRqOqM+KgWyzatI0PCPRc0Ylup/qTFwLtAU20Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769183885; c=relaxed/simple;
	bh=3XJLwFbqHun4CghojPObJVgbMX749aHA/NvUP5iBUC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fxn0ckswKYBrJ4VtoDMaJB2cweafXS1GL4ObBn28dq6Y8UD2p08nahHDQ2xxaJZlCmC/pm8rLbMEmm5hUsA8eSg4tLEPTu9XyJAj7jD0ImE1va8jKazAdGUlVKX1v7NWUfychJxhY3imzFyIgDiTSZPtz483uyZo2LejCS0/gUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aMsHE89W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xpozSPvB; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aMsHE89W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xpozSPvB"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5EBDB7A017A;
	Fri, 23 Jan 2026 10:58:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 23 Jan 2026 10:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769183882; x=1769270282; bh=7kdawayYl8
	P4TgKeV+s39dYB50E/Ce4TURhzTRn5MD8=; b=aMsHE89WdyGbygIuD9gXz8VT8+
	55YtnP3JLMV1oRpH/W7T9vPVfQau1oAGD+RevrRDTrAytzTY5xTcsqhWEAuzgUBW
	zLXk39i3rLMcw23WLIgGpgELNoLFEv512dxqakNW82V3MmgSAqvHtwxMI29FcElX
	KINVoUq/qTVCcfziWuhVgmLfNLJf6SchTYSVizb1BV/fgv6CdQOgNJcYBt7TIxCd
	jySIQCykxIE30lR8BA5S7CkFM5PvF4vXnDk3nv1SAYo1TTcLT3xmybCMmcIFjYPb
	SZwx8QfYXlFxrc2kaIx8Js+O5TXI9azVMJ4YL6WWxT/NfTJxr1762hRpBVtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769183882; x=1769270282; bh=7kdawayYl8P4TgKeV+s39dYB50E/Ce4TURh
	zTRn5MD8=; b=xpozSPvBP7OYtQTDXhFYs2PUzOeVPGtS0b8/cdbl8k3owd9f5oi
	uqoMcZYqZ5p/9FiftCPMXy//qeoTsEmkOmTdPKGvUT5Zxgvu4JRcdo5d4woDKPoH
	lADmBDbeEZ5Xkh5j1bMW5Y/QfvztT6p/IKWoLGti3W3pnfyE1ZEWlxbMnArSSlon
	QHpAVMmyAlh9q8o5W/aPxOinGOcJ94za3GhDBZw41VlLNSnhUpAaKySCs+dpV46c
	avq0PI5qa3cmMmWGNVq8OUv59GKZcbJJGWQkbtiB/yzGjfWNJqUxUWn7tiGhSs/E
	tzgTiAx1crbCGVwJLE1QWR/o9UDjqHA9QXw==
X-ME-Sender: <xms:ippzaUSQm2l0iBUfT07F7RyuUBo93C6V5GYyVOkianQPu-mJyEKDzg>
    <xme:ippzaYprtszIjOH8niqkEVnKp9zfNITDjHrK3yXIg_teJo1a6JN2fYxX0i457VKlk
    XlUZdjGdH_C4bdwqmnkh3cH2QK3gwL-rkxcPcu5fNRfZ6CMKJUTDA>
X-ME-Received: <xmr:ippzaaJYlICkrpbt6NNHtSlHZbPXGAhMDTX8vUTqivmxsg4TpiQuunww6RCtl56UW_0Stld7-yIkrrb5cYWfd1UyGND-zM-cb--DS0c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeelgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ippzaTpzxL0fIjU7mdG_dD7Pp0Z1Wg0AhFISP-TBirkRF0W6aWCYgA>
    <xmx:ippzaazouAbWoOMlLAKQ05V7KzjsS2vpCdpP-3YI_680tsUXaNcCFQ>
    <xmx:ippzafPyUajF7Kz7qzv2dUOJzI4SLImAXcRwuf_P0z1_ZxXhaSsGRw>
    <xmx:ippzaX4LaFN8z8NuAYEPEtF0HQK0bqFKTfsT28yAvkUMz3nd0yf3fg>
    <xmx:ippzaX65R8_OQ1wxr4ZLvmopcXLLSULsDGz7QHqQIPLLIc-kdJBnmP4Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Jan 2026 10:58:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Derrick Stolee <stolee@gmail.com>,  git@vger.kernel.org,  Derrick Stolee
 via GitGitGadget <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2] revision: add --maximal-only option
In-Reply-To: <13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org> (Johannes Sixt's
	message of "Fri, 23 Jan 2026 07:38:08 +0100")
References: <pull.2032.git.1768703645125.gitgitgadget@gmail.com>
	<pull.2032.v2.git.1769097958549.gitgitgadget@gmail.com>
	<xmqqikctl3vj.fsf@gitster.g>
	<7daff220-f93a-463a-b586-dd876b51edae@gmail.com>
	<13ff1d94-401e-4fa7-b247-fe8396ca9970@kdbg.org>
Date: Fri, 23 Jan 2026 07:58:00 -0800
Message-ID: <xmqqecngjp87.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.01.26 um 23:15 schrieb Derrick Stolee:
>> Unfortunately, it also says "print a minimal subset" which in some
>> sense is correct by "it cannot be made smaller without losing
>> information" but we actually choose the maximal set there, not a
>> minimal set.
>> ...
>> You are presenting interesting overlaps of terminology and needs.
>> One thing that is different about 'git rev-list --maximal-only' with
>> a list of starting commits is that it wants the maximal set from
>> the _union_ of the histories, instead of the _intersection_ like
>> 'git merge-base --independent' does.
>
> I don't quite understand how a union or intersection come into play
> here. The difference between the two is that `git rev-list
> --maximal-only` permits negative revisions as input, but `git merge-base
> --independent` does not. In the case where the input is only positive
> revisions, the result of --maximal-only should always be exactly
> identical to --independent, right? Even if the revisions are on
> disconnected histories?

Ahh, it is an ancient history that I forgot how the command worked.
"merge-base --independent A B C" does not do any "merge-base"
computation over the commits A B C and shows the ones that cannot be
reached from any other.  If it were to compute merge bases across
these commits and then find commits, among the computed merge bases,
that cannot be reached from any other merge bases, "intersection"
might come into play, but I do not think that is what the command
does.
