Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852371B413D
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 20:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738097439; cv=none; b=a1Z4tvDNCCmBa0BUhWXAVXo1jhpv8ySqdByIq1JRQqE6UKNRIju96PdLkzA4etlHoZMYLhSy7ugKOt4rcUiPnKuILdt7dbN9l3Yefjjv3YvMXzJ5Tf77vS5hprL/SqhBqgFthWujUD1nwwIih1khOjjKOmetG44vMHgjzzKvUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738097439; c=relaxed/simple;
	bh=Y8VWaO8vcjrhVB2bhpJmZJq1P72LPynSkCA80D8gDPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R15hUerGRy3UuS+FXTuymH59ySRLAvo6Gy0nfLSz/bFC3NMH/iqfLgknViAWUXRq6xRblPkHsH/wYH6agx9BrTAkPgUkgwHz6ZGjZm8E8WaekIHh9cyeG8Q2doM1FlQeYoOavMMDeuMzeHwyeeuGRJ/cCNDC98I3pNWNtiRA0j0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mSqkTyOF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mSqkTyOF"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2163affd184so185485ad.1
        for <git@vger.kernel.org>; Tue, 28 Jan 2025 12:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738097438; x=1738702238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iogMDHFre8qnwBC6Tb+dFIMzwrRJaE5qWhC4sanfC48=;
        b=mSqkTyOFYU8y9a+Rro/hoc23UtWpGjG8nL2FOLDvkk4HxtuKugV7/GEl4Fcnp33xbM
         4NMCZAOKkzKlosl/TO9Osjl/A32Bs3TRN4G87c1ELbIlS48Br4MZpGQTVWBXUvZCPjGc
         1Kf/HUu8fM1kTh+RUfFI0AsoBUquqrSt0TBgxaMWHTp87RHnNObdUW0Q8026RU8Umazj
         LhrDHJIUVLBzX/2neVsez8BWvlzPkN+hLpkxeSZmfdVHc+QjQLf6lCqWbnYAQyfrkqjL
         gGpMwt92aus8Km1tlD8BBljZF1/HRF8DbAVFA3O8dfe4k/iMxw0WYh2i5/WY1JtiMWDz
         mu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738097438; x=1738702238;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iogMDHFre8qnwBC6Tb+dFIMzwrRJaE5qWhC4sanfC48=;
        b=CQHtxMudPNB+dnwcil5fQILmPpsfeL3cun5u7DhRe4G7O4z0qalsPGa0GAXw1GuUGy
         RwQfkfDsMLLpsZWy9zL4ktqt5bxQCzVfAUaZdRVrhUd6LIJD5BLrES90QCUSOpEUXBP9
         jFwhPExcRVpKl6f2jms1H9BCcOBNa5kAuuWV4OWHiOUPMp7E8Qyj9VmYaYbPPRhVkWYD
         cS7sVRSMuO99cxK4vTktAhZkK3+rQ/oVGPXy4V6t5QJhrjwiY5MOmjSrx3pOuUNGmV8g
         2vrjqyVwvQpunmc13UiPP8/kczqJsCpnQR6Fz4wQwmnlTwbY4SHHNswH+cvgKFuhkTts
         fprA==
X-Gm-Message-State: AOJu0Yz5T6Uxc84yS16JCXXosKWk1SnKWpExVoRVMGFjfNdHJ8Lp6WYD
	N0UiXYhpeaMtcBgDVRGwea/gaiaZnVzldgp6xUVWh1tnvWPVfKOG2IK5ZoDEEg==
X-Gm-Gg: ASbGncvkd3SrY7J9rt/Dj7jjkG4X4uzGvbPsF2Sa7FvsYaolI3JVlcUx/N1jCe1R3du
	OsJK4H2UWRZypbPemESsoS9fB4zV8r+OptunqUMncaYdW9LUW1LyzvbRA5jOIlHxuk32WUYH2lN
	jjMmCWi902/NYbsQyQ1FHBpPsfrgilGl1ilT7iNBUHroXAwunuwi5/vnJl4LDTUKCYz7aZawza5
	89xU+bXQwS2Qf8Lm9pvufIiCsKJE0ZJtOzZVULYGeap3tXz7EYrGDk4e0we8Hh2H/9rkVkVqvp2
	uwUbkThtcHYwTQ==
X-Google-Smtp-Source: AGHT+IHRNSUcobXRqqS4lGSP2/X5XC95m+yWChCtWMrQEIsUEm24m1OLuauxG9kuqRx4wrGqPdRkHw==
X-Received: by 2002:a17:902:ce05:b0:215:884a:e8d1 with SMTP id d9443c01a7336-21dd809d2e1mr443185ad.24.1738097437589;
        Tue, 28 Jan 2025 12:50:37 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:ad31:b9eb:e4cd:2ffc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa77043sm10914261a91.35.2025.01.28.12.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 12:50:36 -0800 (PST)
Date: Tue, 28 Jan 2025 12:50:32 -0800
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, sandals@crustytoothpaste.net, ps@pks.im
Subject: Re: [PATCH v7 4/4] libgit: add higher-level libgit crate
Message-ID: <iexpjuyxdg3yzk2eeibtzfgyzzrnpo2fg2ic6eeajky5lm7elw@tby4wimoqjrg>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, calvinwan@google.com, nasamuffin@google.com, 
	emrass@google.com, sandals@crustytoothpaste.net, ps@pks.im
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1738023208.git.steadmon@google.com>
 <88425bb0b1b90cf6b3d2d5a1af57e46c7a03ad39.1738023208.git.steadmon@google.com>
 <xmqqzfjbo7sb.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzfjbo7sb.fsf@gitster.g>

On 2025.01.27 20:56, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > -.PHONY: libgit-sys
> > +.PHONY: libgit-sys libgit-rs
> >  libgit-sys:
> >  	$(QUIET)(\
> >  		cd contrib/libgit-sys && \
> >  		cargo build \
> >  	)
> > +libgit-rs:
> > +	$(QUIET)(\
> > +		cd contrib/libgit-rs && \
> > +		cargo build \
> > +	)
> >  ifdef INCLUDE_LIBGIT_RS
> > -all:: libgit-sys
> > +all:: libgit-sys libgit-rs
> >  endif
> 
> I somehow would have expected this part of the patch to do
> 
> 	libgit-sys libgit-rs:
> 		$(QUIET)( \
> 			cd contrib/$@ && cargo build \
> 		)
> 
> but the above longhand is fine.

Fixed since I'm sending out a V8 for Phillip's feedback anyway. Thanks.

> > +    /// Load the value for the given key and attempt to parse it as an i32. Dies with a fatal error
> > +    /// if the value cannot be parsed. Returns None if the key is not present.
> > +    pub fn get_int(&mut self, key: &str) -> Option<i32> {
> > +        let key = CString::new(key).expect("Couldn't convert to CString");
> > +        let mut val: c_int = 0;
> > +        unsafe {
> > +            if libgit_configset_get_int(self.0, key.as_ptr(), &mut val as *mut c_int) != 0 {
> > +                return None;
> > +            }
> > +        }
> > +
> > +        Some(val.into())
> > +    }
> 
> Nice.
> 
> I was wondering why libgit_configset_get_int() in [3/4] does not do
> better than just wrapping the raw C interface, which returns the
> error/success status separately from the value we parsed.  With this
> higher-layer wrapper around it, the interface becomes a bit more
> like a higher-level language.
> 
> Thanks, will queue.
