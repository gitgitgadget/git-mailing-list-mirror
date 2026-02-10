Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E552C2E2DF2
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 16:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770741310; cv=none; b=s7QUUyAmKso9KRjeTLswkzWAPuqvrBBg+13rkAlqwN+qZQZvKZAD3LMUCmhKMakTQGxUy0dLIsVHuMBNae6Qq6UfSEqSSxCrumTcYMWFPT/G2Wzu63+ycN54dvftlbc5J3fbRDhuno4CVp0z4TQSRehVEVa6eiocYLjP27VMl3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770741310; c=relaxed/simple;
	bh=zgGyvr2+Sa/CTVmMqklAkKu4yYyjZrxt8Xy7bVokauQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RJ9ICi+t6AFaYehDL4xUqpBe6Ej4WD1B8IBUrRD9B4bQGrOT9CpYULHnbNkfgHU8JcmSPi8vzTWVXC0QVzU3nknJEnjGX82hm/dMraGFF5e1jVQ+VMCilh1A4BzSwCZWjwXq2/8edub+w0P6O4zgJz9IwznpgWIN2EDKnn5YvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Sb1dajEf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WLXI6bhL; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Sb1dajEf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WLXI6bhL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DF3AEC061D;
	Tue, 10 Feb 2026 11:35:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 10 Feb 2026 11:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770741308; x=1770827708; bh=aN0U7KECmW
	4krN9taGn4I0gsxJz0fV/z4cD1RJj/+hQ=; b=Sb1dajEfGyHFD8eYQg1F2zOIRv
	+IG5fu3A2U3HHp4OQzhoxbK76DUsvqWMkuGNf31ciCnkLQem/kHjJI7FeES5X8bm
	oVz8crxsJqgJQReK6ep3GUX3ABW8gjz0RGPUrOMtt3FAEfrmgYi1vDzciRe11mTG
	dfpK7XT72RPjGivTfa7SCKoBfyZcF4DK5PUY6glgISuIhwVuJYa3vPwiDQg4deOH
	GR4cZhMmHAlYhPeFcDfm05okINXGh4vp+/EbEVrWPbtHxTgVW6sqkKRasua9qMyO
	y9llP8NiqWUyAoime24XF3euNXAgg06t5NkZv/aWvG5cAPaCmeRNAPCcgrMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770741308; x=1770827708; bh=aN0U7KECmW4krN9taGn4I0gsxJz0fV/z4cD
	1RJj/+hQ=; b=WLXI6bhLpn0pJZcMpg35uI+8YsC1tSuuI8xSox6vXqPjLOQkx8C
	hbCJYyB+F5qQJ4F8c7QdLY2XU/n/uVlRM5b0md/XjfMJe/dswJxXP74K3Pj31bBd
	Jv1VyNsuVn23GGAQrqVdSrxSSe0xhX6h/sjLFzE5gyGQgZZuv3Xm6t/MMMOPTH5V
	r1etR9/NbQVi5JEo1SaLRQR/cSeWQwxuVb9XrXZwmxDtGgd+ttGJYrm5BnYNQL7V
	ajsIjUCVbyKi+x6n7hdLlP4Mae8vL9qMgqZStarGCF5fwyENga8QNkTp6IaylJqn
	gzB8uDPHSwnLivlsY+w5I4fPr+60gXpCUng==
X-ME-Sender: <xms:O16Lafrz76xXIPpLT7CDw_CfNVm6cuD52R8gqcicr1d00Mnbp8awnQ>
    <xme:O16LadW-RuUMx_-ZZo1mKa2vhNHlwmYIk8_OIaAUY2sn6zSub3vRqZFYNgZfz3TeN
    zUu7YM9QMHm1dweIGsBKm5GGw4UL5KCYPrKIIUS68rkF_zGfL2y8A>
X-ME-Received: <xmr:O16LaWD5sRlxQcyxgguSwcwtyJVT1pwqEVQNjjeUFFgn8Iw4p_jBUgKa1kYa8IhK7Q_JUWz98THVWdJGCTENYkR1njyRUyiY5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhonhgrthgrnhesjhhonhhtvghsrdhprghgvgdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgv
    fhhfsehpvghffhdrnhgvthdprhgtphhtthhopegsvghnkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgv
    rdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:O16LaZ3dQN8MhdbrnrZym7eTSwL6pvTyZK3DAwceycZMLqwSI4FUSg>
    <xmx:PF6LaQ056y6PWNdtMT5a3tkZXBbJMW7SnsEuEiwy92aksbS3j4_CHQ>
    <xmx:PF6LaWAXlbw1omMPIF0ESghvDgWFa6WbnH6UmogLtuCvvjtlMxUihw>
    <xmx:PF6LaX6qAxknRfnwwDXzv2zZnAuED2bwKirCbIta9wdo9xrLsLDebQ>
    <xmx:PF6LaWm7W7XeHU41yOJB8fv8Fqm3V-RZQto13lH6onltJON14W5pdRFG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 11:35:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonatan Holmgren <jonatan@jontes.page>
Cc: git@vger.kernel.org,  peff@peff.net,  "D . Ben Knoble"
 <benknoble@gmail.com>,  "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v1] alias: support UTF-8 characters via subsection syntax
In-Reply-To: <20260209220115.461109-1-jonatan@jontes.page> (Jonatan Holmgren's
	message of "Mon, 9 Feb 2026 23:01:15 +0100")
References: <3124b359-2929-4f3f-9ac6-793277fe422b@jontes.page>
	<20260209220115.461109-1-jonatan@jontes.page>
Date: Tue, 10 Feb 2026 08:35:06 -0800
Message-ID: <xmqqy0l0zhdx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonatan Holmgren <jonatan@jontes.page> writes:

> diff --git a/Documentation/RelNotes/2.54.0.adoc b/Documentation/RelNotes/2.54.0.adoc
> index 20c660d82a..8cb00a21bb 100644
> --- a/Documentation/RelNotes/2.54.0.adoc
> +++ b/Documentation/RelNotes/2.54.0.adoc
> @@ -7,6 +7,14 @@ UI, Workflows & Features
>   * "git add -p" and friends note what the current status of the hunk
>     being shown is.
>  
> + * Git aliases now support UTF-8 characters in alias names through
> +   subsection syntax: `[alias "name"] command = value`. This enables
> +   aliases in non-English languages. The flat syntax continues
> +   to work for backward compatibility.
> +
> + * The new subsection syntax uses case-sensitive matching and
> +   the flat syntax remains case-insensitive for backward compatibility.

Thanks for summrizing the topic well.  "The flat syntax" is a new
phrase to us, I think.  Do we have a term to call two-level
configuration variables in contrast to threee-level ones defined in
the glossary?  I've seen phrases like two- and three- level names to
distinguish them in the past, but that is no way "official".

"git config --help" has Syntax section that calls "alias" a
"section", and "foo" a "subsection", and "command" a "variable name"
in "alias.foo.command".  Perhaps "the alias definition without
subsection, e.g., "[alias] co = checkout", continues to work", or
something, perhaps?

In addition to what Peff already mentioned, we would not want the
second bullet point; the fact that the traditional two-level config
is still supported is very much worth mentioning, which is already
done in the previous point.  So all it remains in this bullet point
is that this topic did not change anything in the three-level
configuration case, which is not noteworty.


> +# Simple syntax (ASCII names)
> +[alias]
> +    co = checkout
> +    st = status

It is somewhat misleading to call this "ASCII" as it is stricter
than that (e.g., there are '.' and other ASCII characters that you
cannot have in the name).  

    "Limited to alphanumeric and '-' letters (the same limitation as
    configuration variable names), case insensitive"

or something.

