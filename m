Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC426296
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636882; cv=none; b=VRJb8pzzI8CIwnSaGf0iUwzAYyoOl6HwxSCpHUVScLSqu4DmWNg18EKo+huBqnosVMOhPpU23+6F/qR1YuPbkNYEynET6jwazWXFAYcV0Pjs+sUau9L3J1h642A9f278vquuYZ1NFkpGICBnQgD3l0av0PfLUYD/IjmbFx7OW3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636882; c=relaxed/simple;
	bh=InvKXQn+oj8henIZ7Zfn6GqOmU6NG6pLXw1NMk4Xn7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZL2hflzy4y/0kG6wGDgosjCb4T+0dgKsNqsG1kNWq9P49duzA+7hbHdQqIU++8Nf0Rg58k/hQznAAo78vkyIwMMN82G9RG/zCr1xM7SI/V8ZDfWwzw67Tb6a9lhVCkAIta1Iw3eiKvjyH1Y+5A4016uQ+lmeVVaKFlNgC7GlMpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SvjHypX0; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SvjHypX0"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-296b0d23303so2698692fac.2
        for <git@vger.kernel.org>; Tue, 26 Nov 2024 08:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732636879; x=1733241679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUDXj97GmaA2kGggJXeOheOOY4Z4THN9tkwi2APWa7Y=;
        b=SvjHypX0n2xnGgfg/dY5s5dIH2mFrVoTosrGWJyASGy5nuvh1LuETPPok4R2dGoDMo
         eGR+Dqix3cK/oxtAkTxgaxSLrJDzDEyDSHIwYRc1Q49ucXDmW9dXCSmUUDFz73M/LcMM
         sUhYVwmfXXA00/Wnx9Qa0z/0rPXHjWcVIiLxJvPSeHinM7oyR27EK2H9H0dtH706PbLi
         xFxVT2GwMOXhk6n5Beb/USbfv7ZfKA659C1j4eeWuqKNdVJ3Qe2qW/zJ+ziHBbkxJCWY
         NbqYOOOAm2nGqA4ZK9JoEn5s6DMH8jw6A4GNW7eA0JOCK08YAZtva0i1CmPjrHCTio2E
         H//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732636879; x=1733241679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUDXj97GmaA2kGggJXeOheOOY4Z4THN9tkwi2APWa7Y=;
        b=Mj4Gd54iU9Qm1mgCtXhxM7PwmXR5AES4Qyh/bfOo+kiFobZOkognaMi7psoLtT1YaJ
         PPTbrtJpiyvDcTyzXCPI4USZSIqBMTZDX0OB1SyOTDFB94wLIuQgzKltc+JBl+4Y9mn1
         zuPT9tuQ12YrTbKG+eKRQwr9A+leYLTJL5qgmtXBd3K15DwhQhrifZwwFi7m4yoBtpGL
         RPd1aIFgA5/guMP0Eor3VB22zN8v2N5ielSKFx/OdVDIH072Dp+ryzECXXZIUVkxGyMf
         IyCrrql12sv4mrf2kVti0b8QtCE2Rc2UzImf4t6dQK0OHIigzXGx3smQQqhVGlyYFKw0
         9HLw==
X-Gm-Message-State: AOJu0YwR31AhJ8bzoRs7+K1ryfjmb8Qi6uzBKh+EIbOnCkP9bI4/Z2a7
	LUFPc6xKh5RaRzgxQ0irvYZtrt88Ao1Sq/75ZpF1yIvLBIdxWeYiUYsLag==
X-Gm-Gg: ASbGncvWHoQx+df8qKYqoseJXmwbCgCIM4oScniv9Kt4OUTOSdo8TuxAnM0U0yhxsmm
	1zsHLS/eX/e0rM9qLhpgau9mC/pnfGvaqBylcFwgf/lb7AP4DaRgu7OqFkjNLPAfUdP/V89fSo9
	RcXFYisdmzSr1wwa7F13FyRYaGvUEFMkYM3r13FXdf7P3jRUAQXSKSJ4Xam0PZEi/IQKcxF5F+O
	vpQG4azf1sxKtfcjcWDCQ5ENWyNKXNgLwBFmecWQM4=
X-Google-Smtp-Source: AGHT+IGA56/3QcfDwImZAHuWt5I+rCqMCQ8TJZwXPxFOqa3/zJMZvKWbf0huQwjWJ/O0JY4INog1gw==
X-Received: by 2002:a05:6870:75ca:b0:296:f1f6:5067 with SMTP id 586e51a60fabf-29720e7b011mr14531932fac.39.1732636878611;
        Tue, 26 Nov 2024 08:01:18 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2971d897320sm3963760fac.54.2024.11.26.08.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 08:01:17 -0800 (PST)
Date: Tue, 26 Nov 2024 09:59:20 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/5] bundle: add bundle verification options type
Message-ID: <hg6gq4izm3jmmrmh5g6fy7ojxbgxc35y33gvm2blntfmto2hd2@ecd546locmbg>
References: <20241121204119.1440773-1-jltobler@gmail.com>
 <20241121204119.1440773-2-jltobler@gmail.com>
 <Z0WQC7mFvT4pKn0n@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0WQC7mFvT4pKn0n@pks.im>

On 24/11/26 10:08AM, Patrick Steinhardt wrote:
> On Thu, Nov 21, 2024 at 02:41:15PM -0600, Justin Tobler wrote:
> > diff --git a/bundle.h b/bundle.h
> > index 5ccc9a061a..bddf44c267 100644
> > --- a/bundle.h
> > +++ b/bundle.h
> > @@ -39,6 +39,10 @@ enum verify_bundle_flags {
> >  int verify_bundle(struct repository *r, struct bundle_header *header,
> >  		  enum verify_bundle_flags flags);
> 
> Curious. I would have expected that `verify_bundle()` should receive the
> full `verify_bundle_opts` because these are so similarly named. Like
> this we have the weird situation where `unbundle()` seemingly receives
> the options that are intended for `verify_bundle()`, but we never pass
> them through in the first place.

The `verify_bundle_opts` type should probably be renamed to
`unbundle_opts`. As you mentioned, these options are not used directly
by `verify_bundle()` as the current naming would suggest which is
confusing. Really the intent is allow further configuration of
`unbundle()`. This is evident in the next patch where the options are
extended to further configure the git-index-pack(1) spawned through
`unbundle()`. I'll update the naming in the next version.

-Justin
