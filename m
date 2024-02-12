Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2AE4C63F
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 20:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707771200; cv=none; b=d3jhCI1NXWFu49cLG8Gc08JiYC9Cms3iq4c/DE7adx0nLDSHTxrfCzdXIAW26TVLV41FscJo0NG41td//Z7u4sNjyx7AKWa7jItF1mdWzkQcbYd8LZROag897zDP/68IdjjMKv60PlSZs2biBZCIoTxbMP7T8V9jseCcPdD1cy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707771200; c=relaxed/simple;
	bh=MTUEUOUNXVr0opkTvb1oKZ1zcfyEC0M62pWlY89x+gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KezzT8e+CWYnfjXxkrXGhtPaLi1I2NgbPxHsR+nqXE1+krSvDPpFVn/dwObnJOpBk+QwlJAOKnU0J45zSGDBqVk0S8YTqXltZzMQlXmUi3vch/kwbqSzpGyZBMv6e2A/ogXvRH7JKCjFQbjyloKyn2a6FKGDXsQQlfRxxBjYY0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qbVjsY9O; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbVjsY9O"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d9bd8fa49eso26145485ad.1
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 12:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707771198; x=1708375998; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gt/I+Y81B0Xb3Nh6Iokii0/c3mr1F6Upf4fnukZDyOY=;
        b=qbVjsY9OGN+/TFVbC7B8n/skf7DQvKiQQM+5Y9JOzvVAd9wNFFIbc2qFT/JRoOUnAo
         jOBbHg844EKeBeKlHqDc4gDl/leZRoJlQVLlxvzgN2Gi+6jx3emNYhYjWcFcXTrcr3hA
         NbOV6BELEWATo8rwjVy9vemUBehDVPoHxBqsspmwIfr0oShkeYZA/yLYZqxNapjeuwMe
         YE90oIW2h82bSrVLOr/mMLQ6t6nF/AuO590yYaAbkoBPN1BvOwVwOX2FqQoGRBYYBZF4
         3bs9P5o4SzY/X5OT18XZVQ7tA+E1mBeojTO+y2ERhzW6EGdH3iWjSokMvMWJ1lpJ799z
         MVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707771198; x=1708375998;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gt/I+Y81B0Xb3Nh6Iokii0/c3mr1F6Upf4fnukZDyOY=;
        b=kpXKP7/067jN2JennoD8Z5XD2UF13y1f1yFb+rrlBPKvGS5kVYIAKmcWYoiMDHzMy9
         XC9MZcEziuicxEodl3JSGici5h75Wi+QpmgyLGMmzCsMWkIMESi6D4mJ+My3jjRP3lTv
         qVQSVfi6ig+LV4O/HUlW1fi4Vn6EmhQto0wikx1Nd4PCsRgto73ZfVUMmD1mwr5ql1CN
         4ckc9OgEwu5+2mQgyfH/kQqf99gdG2RJgAU6j/liGQ4R3gfjUGBYmAq3SHke8MXpGLCD
         Cai7nzit8sHqNQ9wGNQd5vPNJMnmhSxqRno+6hKkAXV7/Go4fjBJmGKGv8suRhAExRI0
         ZKWQ==
X-Gm-Message-State: AOJu0YyGbTUksBNMMdqM7uHe8S54OAbOHDY5v15AbULU6XDCzCnbAz/q
	CVLI5RTnnijvTfZgpkKHWVuXNOSspz6ba4sUfqROOcuu8HqjHxEDwObANtN4JA==
X-Google-Smtp-Source: AGHT+IF51iCGAZ3HpcaHYy4nZliG3mmZe+vNjHweKgx+JHDNF9VrpEbiJTSp+GGdGchV+IPjJrmVDQ==
X-Received: by 2002:a17:903:41c5:b0:1db:3076:21e3 with SMTP id u5-20020a17090341c500b001db307621e3mr317207ple.56.1707771198230;
        Mon, 12 Feb 2024 12:53:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXGlfEO4/wFbr6s0RmnO0ZPv6Te/T+HsVJMPz2/QiV2LlSz7JTKdMsf2QIFw3n1SwytXSSjQwYRgDxwXud2IJQKd6JFrU3yF2S7RXup9u7rZI50EPryghpuufYDZ78Jiw2XPeD+RWZsBD38+ByAM/TY2WIED5phY5zf
Received: from google.com ([2620:15c:2d3:204:5bb3:9725:3d2f:4438])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e35200b001d8e04de78asm747623plc.132.2024.02.12.12.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:53:17 -0800 (PST)
Date: Mon, 12 Feb 2024 12:53:13 -0800
From: Josh Steadmon <steadmon@google.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	phillip.wood@dunelm.org.uk, gitster@pobox.com
Subject: Re: [RFC PATCH v2 1/6] t0080: turn t-basic unit test into a helper
Message-ID: <ZcqFOVuR0sxFDDUv@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, phillip.wood@dunelm.org.uk,
	gitster@pobox.com
References: <cover.1705443632.git.steadmon@google.com>
 <cover.1706921262.git.steadmon@google.com>
 <da756b4bfb9d1ce0d1213d585e72acfbf667e2a2.1706921262.git.steadmon@google.com>
 <20240207225802.GA538110@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207225802.GA538110@coredump.intra.peff.net>

On 2024.02.07 17:58, Jeff King wrote:
> On Fri, Feb 02, 2024 at 04:50:26PM -0800, Josh Steadmon wrote:
> 
> > This has the additional benefit that test harnesses seeking to run all
> > unit tests can find them with a simple glob of "t/unit-tests/bin/t-*",
> > with no exceptions needed. This will be important in a later patch where
> > we add support for running the unit tests via a test-tool subcommand.
> 
> Is this last paragraph still accurate? I think in this rebased version
> of the series, we'll continue to use $(UNIT_TESTS) derived from the
> source list rather than a glob in bin/.

Right, thanks for the catch. Removed in V3.


> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -44,8 +44,7 @@ TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
> >  CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
> >  CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
> >  UNIT_TEST_SOURCES = $(wildcard unit-tests/t-*.c)
> > -UNIT_TEST_PROGRAMS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
> > -UNIT_TESTS = $(sort $(filter-out unit-tests/bin/t-basic%,$(UNIT_TEST_PROGRAMS)))
> > +UNIT_TESTS = $(patsubst unit-tests/%.c,unit-tests/bin/%$(X),$(UNIT_TEST_SOURCES))
> 
> This drops the intermediate UNIT_TEST_PROGRAMS, which makes sense. It
> was only used to keep the long lines a bit more readable. But it also
> drops the $(sort) call. Do we need to keep it?
> 
> Certainly I'd think we want the contents of $(UNIT_TESTS) to be in a
> deterministic order. Does the $(wildcard) function already return things
> in sorted order? I can't find any mention in the documention. It seems
> to do so for me in a simple test, but aae5239be2 (t/Makefile: Use $(sort
> ...) explicitly where needed, 2011-09-04) argues otherwise.

I see this line in the docs [1]: "As with wildcard expansion in rules,
the results of the wildcard function are sorted". GNU Make has restored
the sorted behavior of $(wildcard) since 2018 [2]. I'll leave the sort
off for now, but if folks feel like we need to support older versions of
`make`, I'll add it back.

[1] https://www.gnu.org/software/make/manual/html_node/Wildcard-Function.html
[2] https://savannah.gnu.org/bugs/index.php?52076
