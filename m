Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E9F6166F
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 18:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577325; cv=none; b=fqhheUnDjV0InnCcad6sii4j/tJ5E7F/yejCTEXC/QY4s7nC/ViKx7f6dr6udcpQ2O3Wcgh3aBXTY1ClvH9nq9NmrLl/lsynA7qHzMrgaIjC94itakkt6Zy1xD/RnJL2705gZ1YKty+nrfNJ5EY4k9g2/RgStZZSSUN6vuLaoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577325; c=relaxed/simple;
	bh=641yfLt4bs7XfaVp0WsBWDg68OOPt5PP7Ff7eiUGE4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ/BEMf6I7yYTrgMmIFMevgcYMcVI4C45De8LSwPSTPB4Po5nmtaDEvFpJVenrjyd7d6Bmpw1xyOXGRggJ3TTjgUKf/JT6Ak2gOGJHcie/CedQ/1QOxDpwFuWhG1JCNVg9DX4e4xo9D5r1V+RPOL0KSEQ9FM2N4nuFonqX6DcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lm4vaDNC; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lm4vaDNC"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29acdf99d5aso2239595a91.2
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 10:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709577323; x=1710182123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BEPzLxNWrDg4km/XwPLXW6OCpbC2sbJQIfWYTFoRqCw=;
        b=Lm4vaDNCI1WSgNi89CoAd2oxFNL7WxMx+HmEaWz3cLVUrLCOncdDtTdycvcIYfvCFj
         mHru3fk4/1ZBCGbi/sDOau7Pd6KtQSRvOfdtrlFySsHhlhg9P6WQXBCXXOAvFrRTDrKn
         VRQp8WzrVJmvhEufu4lI37UgGD/X6p8o16WAm4erl4z3aiI2uo+z0bRS+zrO5P6byrLr
         Mnlxl8zy6QOt9KdQhAYpEViKNFGvzlthWNlachj5N/Z0WEpTd6iy2mIL6YWcmcpH3OIj
         8pKKSvh2Nktp/dm9iWbAkaKHf9atN6kEwXNeKiKKoTkvOBhL9TQvc4VICdMHy/JmGpTI
         zhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709577323; x=1710182123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BEPzLxNWrDg4km/XwPLXW6OCpbC2sbJQIfWYTFoRqCw=;
        b=EpSasRbY+r0w0wBM9pFujCrxXmFT5zooQ3Zj1YuQdfm9AqOOlvNPngkh0kE7I9sWVZ
         hvS6yT9HNzi+M62/NnY8jL05/NsND7lcl79rgOrl7px+eazhwRBEEP0RG1CtbfVRXDkI
         fhZLa6LcI7igim1G7N6wq4i3oBOki+kRYdkWa148XJ1IuIDutr8Et2ZkCt/A2KBo4A1a
         mA9vhPDhmC+NMy++F0zfv4j5ZvrWdbKMul7PP2NAY35wgbmJ2dDG0DPnE625U9kjstrQ
         Wy8ErGD83h4MqPh0DpU7D1NuOUMP2m6AMabqWD+gIxS6T8ywIrx5Eol5m4Xv3lSawbjz
         X99A==
X-Forwarded-Encrypted: i=1; AJvYcCWbgAFwQHw6AjHtnXB/nLx5dH694hsQkfH29c8CLQcIpxQi+15mO/aM3sb8cN4/FZzy+bMEO+8ouIbuwKCvAx5Q0Sas
X-Gm-Message-State: AOJu0YyOWjDkOJppKthNYz5QhePrFaEpAghNtneBe/LwcRBYtRtPCH76
	+YY0j8xJ3p2aGGAiQQrGmttYjIRyVZUTXhd8JsrUOt5Bwnr0+9ryAX5tbdtIqA==
X-Google-Smtp-Source: AGHT+IFPwAxZ6Zj5u0bu64qOnEIFWU1ku2Kojn2y1PgIfGuEBSv91aGJd3ysIRSY8j5I9cKRuHcGnw==
X-Received: by 2002:a17:90b:955:b0:29a:de1f:e305 with SMTP id dw21-20020a17090b095500b0029ade1fe305mr7683536pjb.26.1709577323166;
        Mon, 04 Mar 2024 10:35:23 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:3ccb:2f09:89c5:5915])
        by smtp.gmail.com with ESMTPSA id b6-20020a17090a990600b0029af4a029acsm8246553pjp.55.2024.03.04.10.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 10:35:22 -0800 (PST)
Date: Mon, 4 Mar 2024 10:35:17 -0800
From: Josh Steadmon <steadmon@google.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>
Subject: Re: [PATCH 3/3] t-ctype: do one test per class and char
Message-ID: <ZeYUZZ6Z8VtYnBn7@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
	Phillip Wood <phillip.wood123@gmail.com>,
	Achu Luma <ach.lumap@gmail.com>
References: <20240225112722.89221-1-l.s.r@web.de>
 <20240225112722.89221-4-l.s.r@web.de>
 <CAP8UFD0Wi3ot-t0Q7ruMauwj4zkMfd89Xr9SmxYa4eQ3=2VKOw@mail.gmail.com>
 <d96aaf45-f073-42d0-b69c-703393634848@web.de>
 <ZdzfYPim2SP22eeS@google.com>
 <CAP8UFD2t1KRo01eenK_RVndyVx5Vp9F4FepTgnR+mwhTGTvXnw@mail.gmail.com>
 <bd48f19b-0600-4e64-835b-98d3a97bb7f2@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd48f19b-0600-4e64-835b-98d3a97bb7f2@web.de>

On 2024.03.02 23:00, René Scharfe wrote:
> Am 27.02.24 um 11:04 schrieb Christian Couder:
> > On Mon, Feb 26, 2024 at 7:58 PM Josh Steadmon <steadmon@google.com> wrote:
> >>
> >> On 2024.02.26 18:26, René Scharfe wrote:
> >
> >>> The output is clean as well, but there's a lot of it.  Perhaps too much.
> >>> The success messages are boring, though, and if all checks pass then the
> >>> only useful information is the status code.  A TAP harness like prove
> >>> summarizes that nicely:
> >>>
> >>>    $ prove t/unit-tests/bin/t-ctype
> >>>    t/unit-tests/bin/t-ctype .. ok
> >>>    All tests successful.
> >>>    Files=1, Tests=3598,  0 wallclock secs ( 0.08 usr +  0.00 sys =  0.08 CPU)
> >>>    Result: PASS
> >>>
> >>> Filtering out passing checks e.g. with "| grep -v ^ok" would help when
> >>> debugging a test failure. I vaguely miss the --immediate switch from the
> >>> regular test library, however.
> >>
> >> Yeah, I agree here. It's a lot of output but it's almost always going to
> >> be consumed by a test harness rather than a human, and it's easy to
> >> filter out the noise if someone does need to do some manual debugging.
> >
> > Yeah, I know about TAP harnesses like prove, but the most
> > straightforward way to run the unit tests is still `make unit-tests`
> > in the t/ directory. Also when you add or change some tests, it's a
> > good idea to run `make unit-tests` to see what the output is, so you
> > still have to see that output quite often when you work on tests and
> > going through 3598 of mostly useless output instead of just 14 isn't
> > nice.
> 
> I was starting the programs from t/unit-tests/bin/ individually because
> I didn't know 'make unit-tests' exists.  This is much nicer, thank you!
> Especially after adding 'DEFAULT_UNIT_TEST_TARGET = unit-tests-prove' to
> config.mak to complement the 'DEFAULT_TEST_TARGET = prove' I added long
> ago.  It would be even nicer if the former was the default when the
> latter is set.

After js/unit-test-suite-runner [1] is merged, then using
'DEFAULT_TEST_TARGET = prove' will also run the unit tests alongside the
shell test suite.

[1] https://lore.kernel.org/git/cover.1708728717.git.steadmon@google.com/
