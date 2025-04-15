Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9AA29291E
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744712818; cv=none; b=FLRq9/lPBLG2kqcBBEkUYK5+Rh+P7nojN/42d5QTYbxI29FsqFWDwohp6onypLi/SrfHeJiNGrWMPJkJmiqLX2lKRt/cH773DiLyqczo3p4wXtX/94vcW8E/kHKAlhwymMpdMJcHNiPGMYBK7BYHzpWJ+px4Z08aRpTql+Ctu2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744712818; c=relaxed/simple;
	bh=SztbOzgjXE69EuVsUU9P0W89WPttX5FOqME9rXpSYCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EAaDLU5bkxEBOuUvZPgP81dm4p937my9Ok4ktQg2mERAkkW3m0x9aGbdOy7cgG0BqOMIwVggDJS9eRtSmWvh04iDyBrdAbBXEWP+94tUH4XUZlULQ9TU9FVf8dLc+gCpUJ5TN3mAoTQFQUh61WaORAT4sy6gZ8umSbF274gXG/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E9ZiHSt8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YksUQAlu; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E9ZiHSt8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YksUQAlu"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E268911402D9;
	Tue, 15 Apr 2025 06:26:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Tue, 15 Apr 2025 06:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744712814;
	 x=1744799214; bh=BVpIv3DNO5wD9hJkUUAQzMeYX/Tffuijf0YVFJdigik=; b=
	E9ZiHSt8Q201HD6eJikmSEYcodONX9uR5OpwKdTnLznJq6QEwLziNJaWpgWXbupQ
	EAZfyQvYXKmCux7njYoPwPE0Tf+xsaIG1hmdeqdxkO+DjX+SmFaODqP2jJYSAbtO
	jkwDfGmQlX4hK2bp3GCt6KW1+83BO1mshKIVCs78MIoiRgl21t7vee/JSMuf8KlM
	rY4+CMfW1QU/4pv7qQkH11wUwxUZDCza5F7IQ8GF9b5fSzN1YjftcDlgB3gJDeFp
	2HNhL6NKCeFap7SM0IOdJ4iW1mv83yy1W8yf7CmwRsPsFEMnAp5R7zASr980QPnD
	SV+M8SBVOFdVblwdQ4nTnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744712814; x=
	1744799214; bh=BVpIv3DNO5wD9hJkUUAQzMeYX/Tffuijf0YVFJdigik=; b=Y
	ksUQAluYMv3/E7QsRQfzTzygLwDQNhsuy/qXXlgKuMK5mt8Pg6Edj6CcjYRM0Yjp
	yU8Gk3jx+7ZAcwMdzpDfVkz5wZV3nuY474MDjcQdZutFOi3U7k4Pwu/vqis9YNZD
	fDihVljQx/ZrBspxudREIAyb+6zbpd2rdAjAToOX0Ba52OQO+nkLyn0eFhPJZpWP
	spMvG7phsKB9awWLpTPHH2DgCEJK0TEmC6rZAt/AGZB5Vc6zs8KeNnNrZ7qVdCSS
	agG9nvZ0EiH3fZdTCrX6mE0/hQktuISPbUvXZ2PnrC2f8MQ0l24+0HnBeqGf8lne
	E2dkdVaMUsHt7krkNKFiQ==
X-ME-Sender: <xms:bjT-Z4ax7pXMxxYNpMYPus-EdXYjns5xIjtyPhvuDw76LuK9ixmdgA>
    <xme:bjT-ZzYWnm0oD2CgC_spARU-I1xJqg5iDIWcbQVnddH_iKhJZC4s_OCdTdWvFux1C
    7BAgz8uvkN94ZXR5w>
X-ME-Received: <xmr:bjT-Zy9RbPl7RT79hntQsWmJKIEEm0uYVmNCPWjg_cLkSspsoWsUc4ljomiwxYL_IYW0uICOxr9qXsfWSIi5cfYap9VJNW5Pa9FIPohHBGp4Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehglhgruhgsihhtiiesphhhhihsihhkrdhfuh
    dqsggvrhhlihhnrdguvgdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdr
    tghomhdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplh
    drshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:bjT-Zyo3RmJDraydS8uAWLk2U2nxnFiUXzFciPK5iLVZTRUXoke_5w>
    <xmx:bjT-Zzr9cHA35lrPzbrixM7oJFE4t40ygNZ-Vu-8ZGE-yJaclsH4LA>
    <xmx:bjT-ZwSK_KHQFuxuUUv7oRKvPKAegKMv1FVYr74nfxn-GhcApGSPAQ>
    <xmx:bjT-Zzrt0wJSLN6NhI614VGdzipJbNg3dIVtK-5kZt5FEfnkqqDJbw>
    <xmx:bjT-Z9ghWFfTqyS1lQ_Df3aBfSD_nzyFYL45vmwvO62SJpHVWpYQQhfk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 06:26:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ae7277f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 10:26:50 +0000 (UTC)
Date: Tue, 15 Apr 2025 12:26:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Todd Zullinger <tmz@pobox.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] parse-options: introduce precision handling for
 `OPTION_INTEGER`
Message-ID: <Z_40Zv_0HCscTo0M@pks.im>
References: <20250401-b4-pks-parse-options-integers-v1-0-a628ad40c3b4@pks.im>
 <20250401-b4-pks-parse-options-integers-v1-2-a628ad40c3b4@pks.im>
 <f6c7c92b-931c-4be4-8d76-9d4ed147e983@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6c7c92b-931c-4be4-8d76-9d4ed147e983@web.de>

On Tue, Apr 01, 2025 at 08:47:12PM +0200, René Scharfe wrote:
> Am 01.04.25 um 17:01 schrieb Patrick Steinhardt:
> > diff --git a/parse-options.c b/parse-options.c
> > index 35fbb3b0d63..dbda9b7cfe7 100644
> > --- a/parse-options.c
> > +++ b/parse-options.c
> > @@ -172,25 +172,50 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
> >  			return (*opt->ll_callback)(p, opt, p_arg, p_unset);
> >  	}
> >  	case OPTION_INTEGER:
> > +	{
> > +		intmax_t upper_bound = (((intmax_t) 1 << (opt->precision * 8 - 1)) - 1);
> 
> Ugh, how does this not overflow?  The macro maximum_signed_value_of_type
> does a similar calculation better.

Oh, nice :) I'll definitely use this, thanks!

> > +		intmax_t lower_bound = -upper_bound - 1;
> 
> This depends on two's complement being used, which is bad for purity and
> portability to obsolete machines, but probably OK in practice.

Agreed. We would notice quite fast in case there are any machines out
there that don't handle this well as our tests exercise this logic.

> > +		intmax_t value;
> > +
> >  		if (unset) {
> > -			*(int *)opt->value = 0;
> > -			return 0;
> > -		}
> > -		if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> > -			*(int *)opt->value = opt->defval;
> > -			return 0;
> > -		}
> > -		if (get_arg(p, opt, flags, &arg))
> > +			value = 0;
> > +		} else if (opt->flags & PARSE_OPT_OPTARG && !p->opt) {
> > +			value = opt->defval;
> > +		} else if (get_arg(p, opt, flags, &arg)) {
> >  			return -1;
> > -		if (!*arg)
> > +		} else if (!*arg) {
> >  			return error(_("%s expects a numerical value"),
> >  				     optname(opt, flags));
> > -		*(int *)opt->value = strtol(arg, (char **)&s, 10);
> > -		if (*s)
> > -			return error(_("%s expects a numerical value"),
> > -				     optname(opt, flags));
> > -		return 0;
> > +		} else {
> > +			value = strtoimax(arg, (char **)&s, 10);
> > +			if (*s)
> > +				return error(_("%s expects a numerical value"),
> > +					     optname(opt, flags));
> > +
> > +		}
> >
> > +		if (value < lower_bound || value > upper_bound)
> > +			return error(_("value %"PRIdMAX" for %s not in range [%"PRIdMAX",%"PRIdMAX"]"),
> > +				     value, optname(opt, flags), lower_bound, upper_bound);
> > +
> > +		switch (opt->precision) {
> > +		case 1:
> > +			*(int8_t *)opt->value = value;
> > +			return 0;
> > +		case 2:
> > +			*(int16_t *)opt->value = value;
> > +			return 0;
> > +		case 4:
> > +			*(int32_t *)opt->value = value;
> > +			return 0;
> > +		case 8:
> > +			*(int64_t *)opt->value = value;
> > +			return 0;
> 
> Do we even need all these sizes?  Or can we whittle it down to ssize_t?

Some of them. We already pass both `int` and `size_t`, which means that
we definitely need at least `int32` and `int64`. Whether we also need to
handle `int8` or `int16` is a different question, but it doesn't add
much complexity anyway.

> And for which quantities do we need to accept negative values anyway?

In most cases we probably don't need that, agreed. But there are
callsites where we use negative values to indicate the default value,
and I bet there are some options where negative values do make sense
indeed.

But in the end I think we should harden our integer handling for
options, which is where the next patch comes in that introduces
`OPTION_UNSIGNED()`. I don't want to convert all users in this patch
series, but I definitely think that we should adapt them over time so
that they stop accepting signed integers.

Patrick
