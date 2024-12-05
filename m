Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD11D225797
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 18:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733425125; cv=none; b=ZS1t7lUg/vdkXYIU3hpYPzRRc3Un1KFidca+NwUMsHgrT+nz8HTLONdB/vNqtgs03ruQAnOvip1Z5mOc5pDcYsW0pzt612mT1OcQ9XQnurS7GPMvGhBC+IsksCTJfBbiz9PJXbNGr6YVi9FPTPUnr8zy8XQuZFLvn4xAMI/1A3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733425125; c=relaxed/simple;
	bh=6b5h5jZKRWUhwmSF5o2qZIXCZLMU3RdXHxADJOE27dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tdqgjyo8gZ7rmiRSmpbXn+xJ1gtFRAyXjjdmEQfjEIuZYqxmrK8wl3NgP0Fp5aeeSKqzVSMFgbhwnWFGFIz+LrOjw3026o+aAo+9/JVn4cTlpg5Pv+QsXpT8AAXF6J5lGmTJYfXF7yu17uDJXBHZxmFwT2f5IY+rBQX6mUxnSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDFw8dvG; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDFw8dvG"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-21561f7d135so10295ad.1
        for <git@vger.kernel.org>; Thu, 05 Dec 2024 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733425123; x=1734029923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9oqlNylXQEZ3SIvyu1PQ48bM9QNeh3q5sMf1Wlne+j8=;
        b=KDFw8dvGBrPKKqMRd9f5kj2yzTqm16n+r1EWscRz5NWfA+qpUQrgJZ/0IrXVgHX4Tj
         jtE6kLC1ZkqsRD4YEZYzqIVVtNxxTJMlrBPRUFGkYqjveZt/L1ksKK8RLQ05qhjRgaPh
         Tk2POCZJFr1zzpPg6068K7nZn82L80T9G7E4aD2sCzOCS0QFoEYGKDCeXFD2utTbwQJJ
         1eeNy9wcqtAkqXuLTl+cpOUmJs8758R/Di6UqvmBL8zDI2kNVS1uXj+fZYZnxSws0arh
         kVvr+wAX/LJ4sxGx9CFv7ABHh0HrnfoPy449DMQ9UkrB46mQiXNk6eKcj1tp/1x2WO5D
         Dt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733425123; x=1734029923;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9oqlNylXQEZ3SIvyu1PQ48bM9QNeh3q5sMf1Wlne+j8=;
        b=I3wqUTGj5PQi3RlVklOTVzr4uOXLmXewOyPJq/Ox62QlB+QTT4+Al0/Kyl+JIYoE4B
         YavZRm+eEL4SwHgLPHmoeBPmOD9DaddRcgtbW7ddTPMeV5yBYnpmJFwwzgkiUKaKxx8u
         7FbcX9O9tFRJVbtzcIjGj/ktX5VW6H7e4Tqhi3vcZUIglrfx9r0Cx/CNK3xA/OMNiRvc
         3SAppcXA5fclGxfq11SThzL5W6VFyUN8FSB0seAyXJ0dRhjYQsvOnx3FNPsx0SH1iG9T
         I1S2MEadTgVt58OpkoVsQGhQF9uM4l0OYi5oiZCxg6nHldXzvnoEVEMoGBBJZJFQFTSX
         1O0g==
X-Gm-Message-State: AOJu0Yxil5LrbwG9bhViWMkDFsaBFhocP47VolFpKpxp/tE/LiL3kbh+
	XGWVmyI2tzwGvep1vShJBqJvB/P4b6YblzleOEo7dLVWQQYqmbO2ILEKVJ2c2w==
X-Gm-Gg: ASbGncvSz1+VqDCTgrNMrVn6/exFneGEFckk+ft6cvxu5Y1hUiTTsfU3njY6Ew97qVv
	9uLehBo6QnLA/UUVfTtTOG8aBkK5poIWI2Dp7v68yRpeZtK92RnFsshZbiloDCCl2O8s+Ctgkuw
	bmumL2n2E0vsPzE7oJmJUnQ8W7liqVORVr+V2StmDiSWErmwIgeNYSAEyc5msb1beTktvrZb6fh
	zeRitAG71VnZEKV0HX44RwljBWBCnbOSCANufRVeLA8mbK/
X-Google-Smtp-Source: AGHT+IHj4synO7PxxPj2wrznW+QL7iBY1fyQq08GDT2mMcyOF9060OaTWGJty0mF4eQW7S0/CUrPNQ==
X-Received: by 2002:a17:902:ce03:b0:215:69a3:1c94 with SMTP id d9443c01a7336-21613785d23mr105965ad.28.1733425122877;
        Thu, 05 Dec 2024 10:58:42 -0800 (PST)
Received: from google.com ([2620:15c:2d3:204:80c2:988f:e15c:5983])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215f8e3fd47sm15829205ad.39.2024.12.05.10.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 10:58:41 -0800 (PST)
Date: Thu, 5 Dec 2024 10:58:37 -0800
From: Josh Steadmon <steadmon@google.com>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, jonathantanmy@google.com
Subject: Re: [PATCH v15 09/10] fetch: set remote/HEAD if it does not exist
Message-ID: <wmu5ld4xsfjz2tpp54jmxqroma423t5nn2jh3q5gq2wswr6fkm@vrlhigyuxfzu>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Bence Ferdinandy <bence@ferdinandy.com>, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Junio C Hamano <gitster@pobox.com>, karthik.188@gmail.com, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, jonathantanmy@google.com
References: <20241121225757.3877852-1-bence@ferdinandy.com>
 <20241122123138.66960-1-bence@ferdinandy.com>
 <20241122123138.66960-10-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122123138.66960-10-bence@ferdinandy.com>

On 2024.11.22 13:28, Bence Ferdinandy wrote:
> When cloning a repository remote/HEAD is created, but when the user
> creates a repository with git init, and later adds a remote, remote/HEAD
> is only created if the user explicitly runs a variant of "remote
> set-head". Attempt to set remote/HEAD during fetch, if the user does not
> have it already set. Silently ignore any errors.
> 
> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>

At $DAYJOB, we noticed that this breaks `git fetch --tags`, although I
haven't had a chance to figure out what causes the error just yet.

I was able to bisect down to this commit using Jonathan Tan's
reproduction script:

rm -rf test_tag_1 test_tag_2
GIT=~/git/bin-wrappers/git
mkdir test_tag_1 && cd test_tag_1
REMOTE=$(pwd)
$GIT init .
touch foo.txt
$GIT add foo.txt
$GIT commit foo.txt -m "commit one"
$GIT tag foo
cd ..
mkdir test_tag_2 && cd test_tag_2
$GIT init .
echo fetch --tags
$GIT fetch --tags "file://$REMOTE"
echo regular fetch
$GIT fetch "file://$REMOTE" 'refs/tags/*:refs/tags/*'
$GIT --version


Prior to this change, the first `$GIT fetch --tags "file://$REMOTE"`
fetches the `foo` tag; with this change, it does not.
