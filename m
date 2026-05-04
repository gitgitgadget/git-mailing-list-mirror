Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B262542A82
	for <git@vger.kernel.org>; Mon,  4 May 2026 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777857031; cv=none; b=c+SqOMcnFjHKmFIePclQckOV0wXAQ4OEDAPEvDYXxxCgRrFj81BnMd6S89hdo1n5Y6Gsi1G73rfbTktAQRCxh5m3BE4to45Kbg+emUAtnOTCcu720m/xPH9XE1c4P38+ZET4B/nmMiMb9PtVBrvwjb9xEn1TA2YD1VjQvxSy728=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777857031; c=relaxed/simple;
	bh=1kFuMIrNO8skLaXQFxfcC5m+Ivbsw35sjKnO0xaAUQk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p1e+W7CTeo7rOeC7bh0pxMHje/XFvnH2Dc9zSvQWyBhLWx6p3Lj2kb4RztDu7qmNpLj+9Dt/SugsE36CruBiR2B6m1Nvr4A+digUKmkdPw2sMciKvexkKVZ9Ds9rTmR2dSneivuapVacD3coB7dyjeggGk9N8pdT9Db4VX4g/qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ryhltVdG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k78Ag/k/; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ryhltVdG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k78Ag/k/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AE01C7A003F;
	Sun,  3 May 2026 21:10:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sun, 03 May 2026 21:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777857028; x=1777943428; bh=qlZjakXmLr
	PiMUfuIJoSAXzyL4BWzVPmpVp3CJX5FBA=; b=ryhltVdGbm++13AHlL0uFzJQpn
	7wKzM/JJvLbWwU5Be0vbJ6hreiGemXPLIkZCzOWafzHSVmg/bf1empYOob//DjSI
	XSNJHQwXOtvGpq4ch6FRZLsnilt2BxHI/WP0Pzvs7Azwhe1HZUZz1CtP8r47VBBH
	3FCiom49JtPMGljhqUgkZu3pfZfqR+NufPEUKAxKndTVQTUsKgwvmIDxpazG+aR3
	KLT2HEX4/LW1e9x5qz1IFlg7XrkTSLfFnNviC65lWC3vN6qgdP8G/Hphmi/SxCz+
	5/0hUoHEWruWN1Wfju/Bn13iynhmrhfPCvI6G0K+doLIrZGAX2Ky7ZW1MzfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777857028; x=1777943428; bh=qlZjakXmLrPiMUfuIJoSAXzyL4BWzVPmpVp
	3CJX5FBA=; b=k78Ag/k/3EqfiEZ5tMWWjLl2Uv5jpzR9oI5EBrHTb6Egbho27OC
	yQ/oXNZvwM+4koE9i+o/siAdv+IFcOXH4rhuVKw9ydkIZHbJQI8z7kFWfm6SkfQY
	BDsetul31/Ufq0igpMXmJJ1d5V0Vf4bIym5CPaCgEC6mky1J8n4zL7JJOnMNc1Gr
	gwA0OS9rzxcKokBvSfWSG3EBenYW/8GpizKFUg4NSn2jH/EahYXSxX1Bnmp67aDI
	tC1CSE6Kg7vepKxlJ6MR6kWNr/1UuLGsknFZ2397lepv00TsAton3CUJFhtv0Tya
	N/VF27rh/swZuYH7z6pHpG68mJgozROBREw==
X-ME-Sender: <xms:BPL3aeedKo_PHiMMQjBwACO5fADSZYkeKjs0h-m4i-Q3aBoncXyLHQ>
    <xme:BPL3aRg15AXc8UCzsacI8a5LtjigN2V0aECNmfum5VuAVGl4_AxMvQyTdxJPwQb6l
    BsyqAFZs2Uo-eugeLic_D72psuPnsaOkdFhGhRFZeyRkZLMUiYjEw>
X-ME-Received: <xmr:BPL3aWz6c7IidvVUEAuPX9M6TVQGgvjqmiaezG171i_byahips6iqAxK1r-WeyWe0InDd1lyCF_8gTFNQ7wkWm9EU19rWhmHpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeguohhmihhnihhkrdhlohhiugholhhtsehunhhivhhivg
    drrggtrdgrthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghsvgguvghnohesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghsvg
    guvghnohesmhhithdrvgguuhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BPL3adPGHkHvDqGe_YKTp_zprgKeax7CDk9p66lqCd6LN8wKAM3c5A>
    <xmx:BPL3aXWwSLNSmEyRLy---8NQItcGIkUcu2uj7wvmpNfwlDYbmmgWXg>
    <xmx:BPL3aR1EJsXNYG5M68BsfjvdDHZNHo-HvR63FCZU9FL7Vjy0uBPABg>
    <xmx:BPL3aVrqfC7gmZXBFcUUP6Xblf2Ffy6AudIPJKCyjJwvmuOtnLtpGQ>
    <xmx:BPL3aSyr0zlb3ELKZWvQMHLq4taXy1FFzeDr-JBAisQEW7ObvX4L99Ez>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 21:10:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Dominik Loidolt <dominik.loidolt@univie.ac.at>
Cc: git@vger.kernel.org,  Alejandro R =?utf-8?Q?Sede=C3=B1o?=
 <asedeno@google.com>,
  Alejandro R. =?utf-8?Q?Sede=C3=B1o?= <asedeno@MIT.EDU>,  =?utf-8?B?w4Z2?=
 =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] compat/posix.h: enable UNUSED warning messages for Clang
In-Reply-To: <20260503151210.36036-1-dominik.loidolt@univie.ac.at> (Dominik
	Loidolt's message of "Sun, 3 May 2026 17:12:10 +0200")
References: <20260503151210.36036-1-dominik.loidolt@univie.ac.at>
Date: Mon, 04 May 2026 10:10:26 +0900
Message-ID: <xmqq1pfsq8sd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dominik Loidolt <dominik.loidolt@univie.ac.at> writes:

> Treat Clang like GCC 4.5+ so using an UNUSED parameter emits the
> intended warning message.
>
> Commit 7c07f36ad2 (git-compat-util.h: GCC deprecated message arg only in
> GCC 4.5+, 2022-10-05) restricted use of the deprecated attribute's
> message argument in the UNUSED macro to GCC 4.5 or newer.
>
> Clang identifies itself as GNUC 4.2.1 for compatibility, causing the
> current check to use the deprecated attribute without a message, even
> though Clang supports deprecated("...") since version 2.9 (2011).
>
> Signed-off-by: Dominik Loidolt <dominik.loidolt@univie.ac.at>
> ---
> I am not familiar with git's minimum compiler version but this patch
> drops support for Clang < 2.9 from 2011.

Does this "drop support" because you force _all_ versions of Clang
to use the "deprecated" attribute, even though you _know_ some older
versions do not understand it?  Don't these versions identify
themselves so that you can do

	#if defined(__clang__) && CLANG_VERSION >= 2.9

I do not know if the userbase of GCC and Clang upgrade with a
similar cadence, or we seem to say that we care about GCC 4.5
(2010), so giving  a similar version detection for Clang and exclude
ones older than 2.9 sounds more appropriate.

> Dominik
> P.S. This is my first patch sent by email. Please let me know if I
> missed something.
>
>  compat/posix.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/compat/posix.h b/compat/posix.h
> index 245386fa4a..ed83a4d9d4 100644
> --- a/compat/posix.h
> +++ b/compat/posix.h
> @@ -35,7 +35,7 @@
>   * When a parameter may be used or unused, depending on conditional
>   * compilation, consider using MAYBE_UNUSED instead.
>   */
> -#if GIT_GNUC_PREREQ(4, 5)
> +#if GIT_GNUC_PREREQ(4, 5) || defined(__clang__)
>  #define UNUSED __attribute__((unused)) \
>  	__attribute__((deprecated ("parameter declared as UNUSED")))
>  #elif defined(__GNUC__)
>
> base-commit: 67ad42147a7acc2af6074753ebd03d904476118f
> --
> 2.54.0
