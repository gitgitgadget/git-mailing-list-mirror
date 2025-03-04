Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4ED2836BF
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 16:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106422; cv=none; b=QSRpU620JjgyaEGKbGzeYFAy/quMSmbAmxN2rringOrpecKz00lHlnYNwVPiapARQGP7wzoOvkSyOJ2ZFHSh2RerprEdkgRK31IMB9h2YxrtEVaP9q7Cjud1f4uBr8wEP3N7TnaWlprG5oHpi58Al9KnWTdJBW41+Vwx4m88WuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106422; c=relaxed/simple;
	bh=cj9dKAk/QduIfIxzEcztFunKWhFenYS/h8g+gODcvss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+xmB54nC4ozMuK7hciwlFHjC09KEdIKJvTP0ps6qr+uXcUxnOL4F6h52hOEjJ/4WIk5n3B7bGmqXlGwrtGhGadjoe08296MpacTgKmJwmxP9Kxver5Xl76EuDIZk9SkBXE1R2jOV68y1IPXx2Hsw315CRTsVblp25HMCIfpSZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BZd3z3yF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BZd3z3yF"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso4102129276.3
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741106419; x=1741711219; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pHD7s3h1vAGySKOKjMCmT2EltXV5B9S4m+FbsKmD960=;
        b=BZd3z3yF1epp7/1ameJpVtNsTmCJldil+q1IKQ3yFv+Yh9UOzpF2AzWyA7TtYVWjWZ
         8Wt8bsd6oRUhRyj6+Gn1/zJApEVC+XMUc9dOXmev41qkB101nZWuSZxJKi4fx/ABnKxh
         k13ES6qDipNW2kODgvGS3P4vQALcNBfdfTs68LC/9AmgffQAeL6v4CK4ioWtGniwvxRq
         WDZnRHbuat9xbYTU1KPRXVTcNEuPRszdErDAZXWk43OTMlWWVyNc/LUWmCImPa7dkqJv
         LJX8yrJRCZ/+rP6a6mPq7gbuZyF+sbcwkZYFhGo7s9qVvorq8vk5C+5QnW+6X2qEZ+gk
         ErJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741106419; x=1741711219;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHD7s3h1vAGySKOKjMCmT2EltXV5B9S4m+FbsKmD960=;
        b=gbzR77D8h2RBBYPr0jYZ9lP7Cs0tWETbqAGK3/Wu4wNNyAoOiDvDIl/XTCYOCgMlf6
         g30yQR5F6IXcjkXedq/xKp1TS4Auy5dmZW5VhpZEVCnM7XVdWfpEJPziIAvrLtKVYuBK
         sg0yIcZpGoIHAikUPsChcvsbgZpI7k3X+ivh0MheqSwcQYQgX9TvhKe1V+g0GTzgNfsR
         YngccbqOrQ/28WG3gtL+/Gbv+VrazYmHCgLvENe6Sf6NyzAqYhVacvd8UqCcYSu+wAUS
         WHvJjF4FVxZv3wLZeaEHrEEnedRCBLIUAuzunlK980lJOTBNxKZ+1zDetiTc1bFXh1Xk
         iOBw==
X-Forwarded-Encrypted: i=1; AJvYcCUOUXrCrG2wAvZj45DjZU5C4NX44aEaOOlP0s16bmRKGRZbmh4j+lrczDJY4fUJ8xdyHb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywiofrd5sJF7r++NLwm/tFPOanTfJU6llL3sy1lWsI/XM1hYGYA
	tx+aF9t4m1gq+Wdt+HZTivWKoPLpnegxQkMWomKzc248+YkXHQeAb8HzEQTt9rfPEhpKOHsEqmj
	z
X-Gm-Gg: ASbGnctZau/ErM2Cd4+S/El3hmKJ74SIeJsz50CjtXBX+z3rFMUd7Dh8duSMtQZxTXj
	5FTaX/ygykCL+WDGHu7W8M3fcc0MW3P45GjbF5s/+BOYSGS72+Mg35wUZfk3fIrpjU3TXZSt0r7
	/WsVxidoFrp81GXbH7ux09AkcZ1wYJlbRrggPnxpKLfDJolOnFIUNerqLgOVieQ1eOpi+zj8nrt
	HxIQPhROzH6NxMoupQ2pEVMEA+qyIbmI6K5s0yZBRum+L+dYhPIs83dDqAFeXHu5kTSOp2eemTs
	zzg9+xcrbqPPlPpHInxY8sDbZHrHC/D3hX91HW+WRAbR5COpROdF5chpLoZarmrxRtogWgjcgnE
	vwSB+6Xmmjs/Gqffp
X-Google-Smtp-Source: AGHT+IGub2KfH1dMGHyDHHuG/airCVpTSa2uer/wBzjvlCr+eSYmPBe7wFQf1VXcHErMfYkg1x7qRw==
X-Received: by 2002:a05:6902:2185:b0:e60:9842:8639 with SMTP id 3f1490d57ef6-e60b2ed3409mr21382108276.28.1741106418711;
        Tue, 04 Mar 2025 08:40:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e60a3ab1265sm3744175276.57.2025.03.04.08.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 08:40:18 -0800 (PST)
Date: Tue, 4 Mar 2025 11:40:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>, SURA <surak8806@gmail.com>,
	git@vger.kernel.org
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
Message-ID: <Z8cs8Y4CVpP0QHNj@nand.local>
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
 <Z8D/aiqN5e/aRSn7@nand.local>
 <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
 <20250304075113.GD1283943@coredump.intra.peff.net>
 <20250304075146.GA1297781@coredump.intra.peff.net>
 <Z8bmSj_Ds7ePpzBM@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8bmSj_Ds7ePpzBM@pks.im>

On Tue, Mar 04, 2025 at 12:38:50PM +0100, Patrick Steinhardt wrote:
> On Tue, Mar 04, 2025 at 02:51:46AM -0500, Jeff King wrote:
> > On Tue, Mar 04, 2025 at 02:51:14AM -0500, Jeff King wrote:
> >
> > > From your reproduction, it looks like the issue is that for loose refs,
> > > asking for_each_ref() to exclude "refs/heads/foo" will not yield
> > > "refs/heads/foo/bar", but will yield "refs/heads/foo-bar".
> > >
> > > And that was true for packed-refs, too, before 59c35fac54
> > > (refs/packed-backend.c: implement jump lists to avoid excluded
> > > pattern(s), 2023-07-10). After that, packed-refs exclude both.
> >
> > Oh, and of course it would be interesting to know how reftables behave
> > here, too, as I think they recently learned about exclusions.
>
> Well, we have tests that explicitly verify that prefixes cause us to
> exclude such refs in t1419, "overlapping exclude regions". So the
> reftable backend is bug-compatible :)
>
> Guess we'll need something similar to the following:
>
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 7e90e13f745..45462f2ce6d 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -594,6 +594,16 @@ static int should_exclude_current_ref(struct reftable_ref_iterator *iter)
>  		if (cmp < 0)
>  			return 0;
>
> +		/*
> +		 * The exclude pattern needs to either match exactly, or, if it
> +		 * is a prefix of the given reference, it must be a containing
> +		 * directory.
> +		 */
> +		if (iter->ref.refname[iter->exclude_patterns_strlen] &&
> +		    pattern[iter->exclude_patterns_strlen - 1] != '/' &&
> +		    iter->ref.refname[iter->exclude_patterns_strlen] != '/')
> +			return 0;
> +
>  		/*
>  		 * The reference shares a prefix with the exclude pattern and
>  		 * shall thus be omitted. We skip all references that match the

Ah, makes sense. Thanks, both, for looking a little deeper. I can work
on a fix shortly...

Thanks,
Taylor
