Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8A1BC46
	for <git@vger.kernel.org>; Wed, 24 Apr 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985070; cv=none; b=gCKaH+RqeCD7Pu/5bvxseDIMd3xHo0v0ajVG23wKiPF+9z/nSIT7wL3807NpFaFh14ICly4Aun9wd7fOdLgW0Xl36d0nypsUJIeBDuYtPpJaWyrjQrruefV6AEcKJq1SpETPoeVlg/2dL5ptD2gnvZTd+QswKy3vmzZyezV3hYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985070; c=relaxed/simple;
	bh=cDgybrDcsbjA8FYudmzBXlOK7xgjza/D3DIpbYniuco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NocUkM6Nn3BRAC732N6jR0Yt3LTcq73E0SlILpVRszI+DSyqlwQMNj/YkUhP3iMQJq6ccadZfrOXxxs0pJS0DYBgnJKJRmef5GRwx7/dCfuK4YodiEudojdquyBs10ssV4oPb1XUdhJYfMzou9geUk5PGgy9V8KsR33ByCnTHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xCjIJ7pM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xCjIJ7pM"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so137721a12.3
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713985068; x=1714589868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wjpJtRnFG66hZb7Lpii2hdm4VmJCfrBsY0QFxdZrxg=;
        b=xCjIJ7pMJkyBOLdrxL0H6/boS0rA1o59k9GSn8Q8HIlNL5r72cMIWf+8Cql+/yOAQD
         +w5yR0bEg7HNZYoL/hkdRwnG4jmUG+TomEg5MF9ffmY6CYDeXjlhuNPT51sM+5Wku1fx
         rdynp9dkudDNpXNkLnMq32gT2aFB29VYU1CIs7Z/dpHuvdyGsyv/rUNhOEz5R2MmSVft
         WS0u6Lwqs2Y3DRv3DIudDs0ghDeWVzSE5RUsd+utIph520yT8DhGrYLwIX7L2Ox+uBVb
         ac20dRK4Lgj/HUXEC6ZCyyMUC61L9+MDDtGKC0c5S3KebU0Wu/Y4gKLM6g3jMEaziSoz
         1dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713985068; x=1714589868;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wjpJtRnFG66hZb7Lpii2hdm4VmJCfrBsY0QFxdZrxg=;
        b=HYv++aHjSGc0FQdCnbuf0CmHOAHPGYTUc3WpREjebmNW0YOwD1i1hXqS4iTZb9iY2a
         PzlIK80MqdMKaM7PyC1QjpecbWJ32KcZgCPZFZVSReXsCgwzPYsrN+p7pBmUtejTqkPx
         X3vcbxqtZjRvm4ay+QnioV2u5D9kRgzMhhZdcKpaKkWMVUSOQ5mMLZ3VX89NaqD6O9QM
         rQsHaWC5vr9sFIJpMn8i4RS+EPVh9fx0BmI30dog4LbRGpIgaU0Y2Vl2AFXP0TdaO6Ph
         n+mhRfKpK/wpMPY+F/ZhGl9YS5fW8Gtko+6GPcvia+ylPQnZJauRNbKMieojnIDrHVp9
         qdyA==
X-Gm-Message-State: AOJu0Yw0xENCruSWELRFVNvA7nMq5DtJ8pAglxp844t1TESB23Cfs+Ia
	aK/wmZAepHWMSagmoJSJj24PIir8Ad2FegJ6ZQspYCbsJv65/Cwxbrnkni2DSA==
X-Google-Smtp-Source: AGHT+IHDVy5+Lq9vCty+ve+vbdzlHkVFZ/MXyvkptMpIeEyDndqpRhIIHnerwJ0ba+4p5/ImFXbjnQ==
X-Received: by 2002:a05:6a21:3e01:b0:1a9:c3ac:c6d4 with SMTP id bk1-20020a056a213e0100b001a9c3acc6d4mr3418282pzc.62.1713985067890;
        Wed, 24 Apr 2024 11:57:47 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:5580:46bd:98b:ecbb])
        by smtp.gmail.com with ESMTPSA id b3-20020aa78ec3000000b006eadfbdcc13sm11795467pfr.67.2024.04.24.11.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:57:47 -0700 (PDT)
Date: Wed, 24 Apr 2024 11:57:42 -0700
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de, 
	phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [PATCH v3 6/7] t/Makefile: run unit tests alongside shell tests
Message-ID: <j3m7hw2tt5znk6ycriion5qn4usimoxseqv66n7wvpznwh774o@waaxau5hyt5y>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Jeff King <peff@peff.net>, git@vger.kernel.org, johannes.schindelin@gmx.de, 
	phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1708728717.git.steadmon@google.com>
 <cfcc4bd427318fed1cacc8457381d5a0c408460a.1708728717.git.steadmon@google.com>
 <20240327085827.GA846805@coredump.intra.peff.net>
 <ZhgvefDKhTQ6rfnD@google.com>
 <20240412042922.GB1077925@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412042922.GB1077925@coredump.intra.peff.net>

On 2024.04.12 00:29, Jeff King wrote:
> On Thu, Apr 11, 2024 at 11:44:09AM -0700, Josh Steadmon wrote:
> 
> > > An earlier step required that runs via "test-tool run-command" have
> > > TEST_SHELL_PATH set correctly. So defaulting to /bin/sh here is
> > > pointless, I'd think? This is used only for the in-Makefile "prove"
> > > invocation, so running individual tests or even a manual "prove" outside
> > > of the Makefile (where the user might not have set TEST_SHELL_PATH)
> > > would not apply.
> > 
> > Actually, I think the "manual prove outside of the Makefile" situation
> > is worth keeping this. I know I sometimes copy commands from Makefiles
> > and run them manually when debugging issues, so it could be annoying for
> > folks if we remove the default here.
> 
> Hmm, by "manually running prove" I meant running:
> 
>   prove t0001-init.sh
> 
> and so on. Or even "prove --state=failed" to re-run failed tests. But
> neither of those would even use this script, because there's no --exec
> option.
> 
> But it sounds like you mean literally cutting and pasting the "prove
> --exec" line from the Makefile. That seems to me like a weird thing to
> want to do, but OK, I'll try not to judge your workflow. ;)
> 
> But if you are worried about making debugging more confusing, it seems
> like silently defaulting to /bin/sh might make things worse. It is not
> necessarily what "make test" did, and complaining loudly might be more
> helpful than trying to run with an alternate shell.
> 
> I don't feel too strongly about it, though. I'd generally just run
> single tests as "./t0001-init.sh", which runs into the same issue. I've
> been working on Git long enough that I know it is one of the possible
> gotchas when a test failure does not reproduce. :)
> 
> -Peff

Alright, fixed in V4. We now set TEST_SHELL_PATH when running `prove`,
and we error out in run-test.sh if TEST_SHELL_PATH is not set.
