Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C4C139D0B
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 21:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725485402; cv=none; b=XRPL5JR2ijgOpILU/p1onWO9SMGv+1U+YuFQ8WaoLPBp4gbOtu6vqFS7Bxmbmaz1cgJELqhixrPQlCS2MoVnxr3iMjxqZ0K3PbjulFKq/PShYakj6WaxmqJp0XFZ4yYJBQpVx+49VUv5w6kGCloC+I7Y1RlbLGS3veHqe+GYcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725485402; c=relaxed/simple;
	bh=R9ZW4au9SnjcG65FysLKAjVLojesBj20q9yr8CGPxb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIeBvyIb8j/06ULSDRYZDbggj64DvujY2t+/CxzZ/M/olTkmzNjYg+FMtDyRMZtYc8h4lS4tE49ZzdQuCQ+nTHSv4RXCvBuqW3emxrCENMp1uKjCNiVwQonIpMP8Njai9d1PaV9n4dee/uAsQGZNU3fDC0KZj0g0RGUcHrwfPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dy5rFCuy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dy5rFCuy"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-202018541afso25045ad.1
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725485397; x=1726090197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJenQ7Ujd5L7HeOo55URrgFaZfUmKEz7oGzjzwUl9RQ=;
        b=Dy5rFCuywxwFIns+MvlQDoaLYOHDHCnK9qiDOqMmgLYjoUg9e+uB2E6ac3pTRLW+6x
         SisLyQM1e04bTmlByhes78aT9ydLpXqt7HDLp7kfn59lvyGVMSf4oJ9BF0A1Iw+ZZo0l
         26ho4tGxRm00MECrSNAOjKaQnZvt389nxUVeW1reKnBRfEVY0Blwxu5lRVipB0jhGyhN
         MDlLIbPf4+3YITL+q+wVmOG5j2gj0yZpV77r65t+beW2lsooVbnFjyD/8Z8QfHVVyZIv
         Y6dzGtNyYz5hirV3tMKFxTuYZlUYmAgx81w1pcpPyMQfla1vR3O155Mmbbnt1ZQCtv9f
         zDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725485397; x=1726090197;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fJenQ7Ujd5L7HeOo55URrgFaZfUmKEz7oGzjzwUl9RQ=;
        b=O+x4kuaemFPFI9J4ISxqQIkdq/wH9pbIJinrlTfHlRRj78vZA28fRaJoKpgjwSh+Z0
         9g898hTdu97bB6FL67y8AOLPWTHRuTlthfXrV7mBvd5qKk0zWHyNV90inAo+xKmCe8io
         3OWKM4ZIMolmgwEhr96AYnKOXdo/hDBW2ewu6+uObAhy94gykwh2mdKcAl/uMljtfYKd
         TESZHPlUA1ONR8yAEwq+h291pFRLLaB2Y5azghWawJXGN6MZsmgnb4TrihTgJrggPGlW
         WySDuRCu7GBcZxyJgZ2O1j/UkVNtg9uSqvmBOac/c27RyOdweI/akinRFFMOB43B05A1
         /93g==
X-Forwarded-Encrypted: i=1; AJvYcCXGMkSMbEpeumDefxVGSZaIWQ9Y8vBhww38JM8/CXWPUVxEkk6OqpDXCfb/mC2j4jdGWrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAsFDHBr+wJVN941FnqtwV/62enjr6aNvqqq5rZD3aF/NwPwIG
	y8lumgA2MlqHRQ4ks9xh4P8gmUxFD6XfCGIpq7z1R48pq/2O+PV8prC5NUts/A==
X-Google-Smtp-Source: AGHT+IE16yFH7S/ErwBIVyogHtEtL+Je9FyxtHmupGdpbOHAHLlTcFRqLPKW+5PLe0f02BGFZ6N6kw==
X-Received: by 2002:a17:902:e5ca:b0:1fb:172a:f3d4 with SMTP id d9443c01a7336-206d0af3a2bmr988345ad.8.1725485396669;
        Wed, 04 Sep 2024 14:29:56 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:8ab0:8477:188c:de4d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea6707csm17669175ad.255.2024.09.04.14.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 14:29:55 -0700 (PDT)
Date: Wed, 4 Sep 2024 14:29:50 -0700
From: Josh Steadmon <steadmon@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Calvin Wan <calvinwan@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
Message-ID: <vtj54bv437e4libwv2a3yycdrva5wsoboo6rs2fbys23sxhvhr@64xsd2uqdbua>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Junio C Hamano <gitster@pobox.com>, Calvin Wan <calvinwan@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
References: <20240904173053.1220621-1-calvinwan@google.com>
 <xmqq8qw79slu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qw79slu.fsf@gitster.g>

On 2024.09.04 11:33, Junio C Hamano wrote:
> Calvin Wan <calvinwan@google.com> writes:
> 
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >> ...
> >> Debian stable is the version that most projects who have defined
> >> lifespans track, so it's also what we should track.  According to my
> >> recommended approach, that would be 1.63.
> >
> > ... I also don't think reinventing the wheel with
> > our own implementation makes sense in this case,
> 
> I do agree that we would want to avoid that.
> 
> > and even if Debian were
> > to upgrade stable to a higher version today, we would still need to
> > support oldstable for another year.
> 
> I doubt that part, though.  As long as the rust binding stays an
> optional code, as long as we are supported by the "current" system,
> we would still have enough audience to matter.
> 
> What's the primary objective of this effort, by the way?  
> 
> Is it "we need to access the guts of Git implementation from Rust"?
> Or does it merely serve as an example application to have Rust
> bindings, a good goal to have to give us an incentive to clean up
> the subsystem interactions in our code?  

For us at $DAYJOB, it's "we need to access the guts of Git from Rust".

> If it is the former, we cannot reasonably achieve that goal until
> some form of standardized foreign function interface becomes
> available to wide audience.  If it is the latter, on the other hand,
> it does not have to be Rust---if the version of Rust that is
> distirbuted to the mainstream users is not yet ready to be used in
> such a way, we could pick another goal (like, "Can we clean-up the
> interface cgit uses to call into us, so that the parts used by them
> look more like a proper library?").
> 
> Thanks.

I think brian already addressed your point about having a standard FFI,
but if there's anything that still needs clarification please let me
know.
