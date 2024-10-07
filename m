Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAD1DE3D4
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728336235; cv=none; b=mr3eGrRelmSo5VMZ249RfKfkzF/h1hrbL145ZsKHESrylPPrJi322Ix+sG74yiafM5fxo0SD5BzpqfwQ8VS0/wlK78/U5GlKJYRlgGupo2QlCevqrhjgGdki/t0qyklPR31iSW2AlctYDKsIPnfTuvtatQyr+HYXOD9U0Rip5mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728336235; c=relaxed/simple;
	bh=Ap9p1BhGQVPMh2ooZaN3ygNanbbEk+WuZxsfeIiQQHE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5q+VocsZ6lsG8DO0CcUrd9S9GZBjJ5jN4r+a49Yf2YvREYV3EGvXF2P06REGEUBOCZT3X51ggxEUL+a+AFcU0Q98+33+Y4EVsUgUs+IOixxkaM1x9c8EQgGvTdanwGvTFGAXDeH4QIqYDE6zFbYhbmNtzXZOfw7+24HKtKxqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4rFSGxp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4rFSGxp"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20b40c7fd8eso71055ad.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 14:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728336233; x=1728941033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=78btymFfIsuUKPi67/Xs5+8hBDSnevLcTzbJWMlIzZo=;
        b=Y4rFSGxpEEKAcil/B07IZieCYsiHpMl3BuNELMrcACjunizrC1WCeAKc3Ds4P2SX5C
         fTXOnPfUrMNNWTo9CsaFtQWpwiVmIHboIUpYVvjL4UBmStaP5Am4EBbUKPA6buL5X3j2
         3rteYABrdi5tgrSM+uJmvCDUypfQAJg02o8UWrj+4hBpNereWPBWFg5bhJ9OLrIDc510
         +P3sMGtJuoLi+0nZ94942tS7K+CZ+FFkKrpI1OPmNhq2SeZ1c6et/loIA/s7yO0OiBSC
         8VBebWd5cq47hISTqSWWgD4TPzblQO4tFSDgns+BqS2yY/YOsb5iSsLekn/jsgqHxTlj
         PZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728336233; x=1728941033;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=78btymFfIsuUKPi67/Xs5+8hBDSnevLcTzbJWMlIzZo=;
        b=a1+/wCRJ8vLUNDdd2wNOpX5biJvsrifwO1sdrntvZ6CykP+6QAXjGrGSdc3rwGPBGR
         3glXm1z0QCJmTVT3BJOtCf+bOI9XVvR2Pltkqj2TX/tjvRFZuFltmu2QVhWnGH6p8s9J
         j6abBynr2d597m4joopAWRci7TmJ47c+QlKkTQUAkvWGAFb5yS4Kr3yub8TBzfgPpYN7
         +02483NC3NNVjrlPpcZVxk9fcG5Cb/EbgjHo8iwLiOtYEhVN9QTSnyrnLRXfXWzD2kOt
         a91Pnzbcui0ahKcP+X9hV5Q9n36JzGrhwkLN0jFIZDGYRYfG95Zj8oIYRiMMkWSkZSH2
         UvWA==
X-Forwarded-Encrypted: i=1; AJvYcCWJQAnfsYCzN+zkwWhAOfu2IiIMsGH88NRAY1wZsQT/pr2vE/O+zc95+BYNZUyhpJIXmHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJE307SHBzk6AyQG6Jlmp7Q+ocgOit7x8adk1syKuox7+0QtPC
	ovD1iQ8GW0y5ILltxtFkjm5Rgn+RVw3WD2TPHgK3uo6FtXUZr5eHbCzunmuaczkLiJRTSMLtekb
	RaA==
X-Google-Smtp-Source: AGHT+IHz4kYmtyyfznZc21HyuzjDY60k7DcJ4YQu340cTIv9nQIKGuwhm7rKJuAH1m7LxqQ/rfpefg==
X-Received: by 2002:a17:902:f68a:b0:200:ac2c:6794 with SMTP id d9443c01a7336-20c5018ab8emr850005ad.12.1728336232967;
        Mon, 07 Oct 2024 14:23:52 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:2b15:5dbe:c4f0:bf3f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d47ed4sm4861757b3a.133.2024.10.07.14.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 14:23:51 -0700 (PDT)
Date: Mon, 7 Oct 2024 14:23:47 -0700
From: Josh Steadmon <steadmon@google.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Sean Allred <allred.sean@gmail.com>, Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, gitster@pobox.com, mh@glandium.org, Jason@zx2c4.com, 
	dsimic@manjaro.org
Subject: Re: [PATCH v3 6/6] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
Message-ID: <ynw3s2kqurwsdrghdfqq7k2i7bonyylhp6ddoxcitgvvoloha5@p4fc7hfkknvu>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Sean Allred <allred.sean@gmail.com>, 
	Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, gitster@pobox.com, 
	mh@glandium.org, Jason@zx2c4.com, dsimic@manjaro.org
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-6-calvinwan@google.com>
 <m0seubo5q7.fsf@epic96565.epic.com>
 <ZuSMFAyoD0CIfE3H@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuSMFAyoD0CIfE3H@tapette.crustytoothpaste.net>

On 2024.09.13 19:01, brian m. carlson wrote:
> On 2024-09-07 at 15:15:12, Sean Allred wrote:
> > Calvin Wan <calvinwan@google.com> writes:
> > > Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
> > > to their respective Makefiles so they can be built and tested without
> > > having to run cargo build/test.
> > 
> > I feel like clippy should be run as part of these somehow, but I'm not
> > sure where.
> 
> Yes, that seems like a good idea in CI.
> 
> > > +libgitrs-sys:
> > > +	$(QUIET)(\
> > > +		cd contrib/libgit-rs/libgit-sys && \
> > > +		cargo build \
> > > +	)
> > > +.PHONY: libgitrs
> > > +libgitrs:
> > > +	$(QUIET)(\
> > > +		cd contrib/libgit-rs && \
> > > +		cargo build \
> > > +	)
> > 
> > We should definitely be setting `RUSTFLAGS=-Dwarnings` as an analog to
> > `-Wall` in the C world, no? These crates should build without warnings.
> 
> I believe -Dwarnings turns warnings into errors (at least it does in my
> tests), which is equivalent to -Werror.  We don't want that because it
> breaks compiling older code with newer versions of the compiler, which
> makes it harder to bisect changes or compiler on the system compiler (or
> sometimes, other architectures or OSes).
> 
> That would be fine for clippy, however, because that would only run in
> CI, where we _would_ want to catch newer changes, but we want to
> compile nonetheless.
> -- 
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA

Sorry, I missed your message before replying on this point last week.
I'll remove this from our build.rs in V4.
