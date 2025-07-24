Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBB0186E2E
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 06:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340161; cv=none; b=ePYEHrhG14ak/woDH8vqxwwntT7gcDQCInutkkFFfK2brZB6x0WYQ70LZrr1AdDTzj8R5dewPSrY33PAK5gXDVqX3qRczZldEK1xcsIZ6lZrP3d/Xa57MomgoQs4gUHNIxgStwGxv62l62twTzgoImIM5NEF6KCcYS+M4anUsm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340161; c=relaxed/simple;
	bh=KsHGg55/tz+RIby84yTVyWSl5YjTAxre5HOpOFfrmFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JtPSmkiuBzm9ndcvFny2+YCFy2t153uOul9PBlZ0Y80U9NGbNgtljgPdvs8+iC0LB+wsJQwFxXWCuhYMKAq/77jMkYxrhjR4VCIPx61h72xQIQOp0r4VLRfKsVNrWw8eR1H/DYKy+FeihYQxFd1zWd8t31jisYP4k7TMzL1ttG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kL4JTozQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UHNdagHa; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kL4JTozQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UHNdagHa"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 969D21D00125;
	Thu, 24 Jul 2025 02:55:58 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 24 Jul 2025 02:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753340158; x=1753426558; bh=gaIqLAG2VK
	MmDpEabHfnobxbZSJNTsHv5lnGDjRxJGA=; b=kL4JTozQim+mZTjz4vBAs+KOBO
	Vx+pR5rEY+g8Dn1zCsltQIYPxepwwjP7wUFadxUXrQ8A2Cvg5oNf0h5WLncSCfd+
	BpTNOPPCcCtx8eTGl+SEaD024GBGd25Oxs2t9BHCGOn7hgJz6GIm6hhbNtH8fu4V
	BUbcvgrniXAn1DfdkGzYNMvwjmUQk1zBVAkou9pOj55bqlQSEmF3qXIH8bc4HjYV
	2ZczNz8Gmmnn3lfjz56diRX2z6NQaoDQtN0lb2D3oQmKgVIryOo2xs4gAPgh1Ew6
	IklcZCQjkQYd7nJFXCzOzE6nROxG1hg+pXyhGNdBVFB3Naam6KKZQExazA4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753340158; x=1753426558; bh=gaIqLAG2VKMmDpEabHfnobxbZSJNTsHv5ln
	GDjRxJGA=; b=UHNdagHa3GvsTgnaJCz7amWKWWgLRlSBiahm3QaY6JBgSeM0We5
	pKvxERKR5WA8llyqnAXQphGLdqI5tHR55eqyX6tss/HAbVb85YA/KVq00dpBHbiF
	hT3Kmm8dBtLsK6ZwNUUJCM7mF3QPoHFI0IPtaYxfxtnVJrrInxPa+nKIuAYQEH98
	nF7/GurVnpYklFeWJqOCsZOFenLRnJmmRBh76BLqX2/E9VrPllwOxACNFPfaZP4f
	suWqs7RjjmkTd8+k4verVWk0TRLDQXb9//Di9P4SGIXtrddjMozBLo2+4A5FoXep
	mzkw1CJsfa/vp+E08S7Iu0xmngVvM2k6z3A==
X-ME-Sender: <xms:_tiBaDhwgxnmbv4edEg1Nj5sLGedAg8qSEvLlNr79KXYueBSf1eGvQ>
    <xme:_tiBaDQg5ytIO9fD20p5biJq28D3vtgIyiw2rNIOstWGwaOjK67JAtDEPnd6s-TPh
    zgwY492YB1jZvc9dQ>
X-ME-Received: <xmr:_tiBaMjxEQnr6MZhVfWxl9s9sGvl5ORsvaP-k5kOZe54e6eQzoddk5C0pAlxMiDoU9JwPwriUQiB8bjTFp81vNeu1mcRDyRBTUpV970LMzI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejleellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_tiBaL4dn7qPEFKSYDe0q64xnOS3kr1XTsYXacD5FLcxCaKB6n75Lw>
    <xmx:_tiBaBDfMaTi7-xqZvjpDO4VtJD8mtzg_cNemVgwwKaQeWN6yp5N6g>
    <xmx:_tiBaKZjN6i90ZLrAvhFGarNnhg1smMV3fg_sJAFemUH6sONerOh4A>
    <xmx:_tiBaEZSU5fgSTn1z4DNbF3H1nWkZzx0-wYeFmDRGAsYOwF1lXWwxA>
    <xmx:_tiBaL5d_k-mq3ZLKsFoueElB4KfdraY3IDzfi0Dx1h8ELEqGHpeAK2e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 02:55:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7027350d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 06:55:56 +0000 (UTC)
Date: Thu, 24 Jul 2025 08:55:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document test balloons in flight
Message-ID: <aIHY-PXYYzE8JULj@pks.im>
References: <xmqqldoen5v3.fsf@gitster.g>
 <xmqqecu6n1pt.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecu6n1pt.fsf@gitster.g>

On Wed, Jul 23, 2025 at 12:31:26PM -0700, Junio C Hamano wrote:
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c1046abfb7..0776d15a95 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -298,6 +298,14 @@ For C programs:
>     . since late 2021 with 44ba10d6, we have had variables declared in
>       the for loop "for (int i = 0; i < 10; i++)".
>  
> +   C99 features we have test balloons for:
> +
> +   . since late 2024 with v2.48.0-rc0~20, we have test balloons for
> +     compound literal syntax, e.g., (struct foo){ .member = value };
> +     our hope is that no platforms we care about have trouble using
> +     them, and officially adopt its wider use in mid 2026.  Do not add
> +     more use of the syntax until that happens.

Nice. I like that we now have an explicit deadline for people to
complain about this feature not being supported on their platform.

So this looks good to me, thanks!

Patrick
