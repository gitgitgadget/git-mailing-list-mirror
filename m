Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C924A06D
	for <git@vger.kernel.org>; Mon,  5 May 2025 12:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746447419; cv=none; b=rVzGfD85YWPCE8ax/69S4fe6zdyfnTaKIBRgJNOvniaRKJad8rGfppQCSzhW3RB3qrBeai4ruwfYB2k0SLkWpefHEmV3YfC1b6CmMrCIB6cUo49wfsGOJv+uHdQpjiaNQUalabfOVksgvq81VwBm3hOGZXXUUbV4iP/uo6vGAi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746447419; c=relaxed/simple;
	bh=i0CLOEnPEhqxFdXMMqsM6ZMRgaXbBjBarkQoMeO2ZWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNfKNCPk5MxoPidFIGOnumAIbGD4TJsl+DFCwhFwWRnQNOOOT8zY7TL3UCxpKNYCTjPrlEmrqzZ3nb0Bk8AtLoFiIQZQNqWcYdejFA5bn02Ovfdyr+Pz2DxksUCf2bfj7i+mmJs5gnUfYJlT2Tf7k/4Sg+PiN/8gZGASq8JF1dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQxz/h1j; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQxz/h1j"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-af908bb32fdso3649602a12.1
        for <git@vger.kernel.org>; Mon, 05 May 2025 05:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746447417; x=1747052217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8RR8ka4+vdZPdB4MAUEg7WCcyvwByptClWQkWUDlYak=;
        b=GQxz/h1jx1yyNKv8agCtbeLSLLlkJG7/sOoBcrDux+nXyQU2hSSS1HIThlP2RyugRL
         dFxUlvPexWyalNl43R9qr1d5FG0u+ONGSbz69kriQtajnsh6imVuPIu9ygVos96k4Geu
         MtHwsbR7Y9a4heUfZmWN9ADcqHyaj/QgLvSGtc211oczh9saSCEB52NzNRPqfqO676qU
         yB8wjz0IU0tok4Nqd4//Zy0VCTyK0uG3XNjXZno714DdRDf9K/qi3CzKWLPER+x93mXL
         9jqMU5FaDmRbGjdjL3F62uL2DdyYVR6AQalbq3HCrHPXPFW60JVJwD4dTJIIuz1ScDIu
         vDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746447417; x=1747052217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RR8ka4+vdZPdB4MAUEg7WCcyvwByptClWQkWUDlYak=;
        b=txyXrFC1Z6U9Psmn/NsJ2Nyo+18hsmutN+KOlvbaQhNcuBlETlJ0OKc5rFsdgHX9Qu
         un1G3pHeO9/QHyPIEOHg7Ag/aZrq3rH+OZx2lO023FXpmIR+v1f+aeTZUlkST6jnxRn6
         gTx0aF5Gf5OeKmf8k0X6CITY+Aj3AflBNKQt7MwSFrgOJ2ENVrORymAr//LA6QLZrjJN
         ydNIDGbSslRoLEdkd5sR1FsmiVbsUIj8LvXftAOPH7wj4DY2nYqMoBMcWXS+RSggkvzu
         u+//CVYg5w7ttjmsjPt7dEM/nz3E8OsUrPhA/P6a+2C3aysy4ZIlKH/1vNvvYN7C+4J9
         9/Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXIGYo9EkymdQnmuLhyBBrwe0ukvHAgYePwpnmuHI3RD0i0h+C06DgbR8wrhqhpnvn4krE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkM9lrw1hrOfR77V7reL1mlSbS3qlDoCv8a7RdW9FdoypN82JH
	Y4QZE2vNNBNjnXSMdwzORjwfLwpCPFK+sf1ZVubcK03+EomnbGHI
X-Gm-Gg: ASbGnctbRvDayuD6RLiYaEPmvkb1LRc8RXl+PyMiwQ+Dqhz4III1mxbsSsBhxSk5zb2
	b7LtXb3N245kJFWguenJMyKBpQu53SHC8Qdhe2Ft82OWeP9e0tMeOIwMcPY94cu0NAR1J9iPzBQ
	i2IQUzckO4iSuwYPW6CJGVpIncsSWHjchs5fOIE2TG1BGGrPK4KVLhKH1t0dZUMlR5LqbvzZkir
	eBB7/DINLRKMeI/SLEx+ryl7jVibZbY54R/r0827/LInBMOzKoHgCsxc4LgmQWr6EZENBGvJd2G
	Wjbrql3M8nl5hSCQXtIzPZ8S+5hi87i0DOQ0
X-Google-Smtp-Source: AGHT+IHd8HLIxLs4lFwkOCUa+oU+C0Ut7Pt+jtdV9QpMmR16TMLDkghlyUdRs49UmZHMw9hJw0F3Uw==
X-Received: by 2002:a17:903:189:b0:21f:6ce8:29df with SMTP id d9443c01a7336-22e0832d854mr227604425ad.3.1746447417134;
        Mon, 05 May 2025 05:16:57 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74059065555sm6571741b3a.155.2025.05.05.05.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 05:16:56 -0700 (PDT)
Date: Mon, 5 May 2025 20:17:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] wrapper: Fix a errno discrepancy on NetBSD.
Message-ID: <aBisTxORH95BgLIT@ArchLinux>
References: <20250502233403.289761-1-collin.funk1@gmail.com>
 <aBVp51yLwxBpRskt@tapette.crustytoothpaste.net>
 <20250503133158.GA4450@coredump.intra.peff.net>
 <aBYvMjtGjzEhKg4s@ArchLinux>
 <20250503154928.GA3412@coredump.intra.peff.net>
 <aBhdH9jWpnpbkPHn@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBhdH9jWpnpbkPHn@pks.im>

On Mon, May 05, 2025 at 08:39:27AM +0200, Patrick Steinhardt wrote:
> On Sat, May 03, 2025 at 11:49:28AM -0400, Jeff King wrote:
> > On Sat, May 03, 2025 at 10:58:58PM +0800, shejialuo wrote:
> > 
> > > > PS I notice that this same function reads the whole packed-refs file
> > > >    into a strbuf. That may be a problem, as they can grow pretty big in
> > > >    extreme cases (e.g., GitHub's fork networks easily got into the
> > > >    gigabytes, as it was every ref of every fork). We usually mmap it.
> > > >    Not related to this discussion, but just something I noticed while
> > > >    reading the function.
> > > 
> > > Peff, thanks for notifying me. I want to know more background.
> > > Initially, the reason why I don't use `mmap` is that when checking the
> > > ref consistency, we usually don't need to share the "packed-refs"
> > > content for multiple processes via `mmap`.
> > 
> > You're not sharing with other processes running fsck, but you'd be
> > sharing the memory with all of the other processes using that
> > packed-refs file for normal lookups.
> > 
> > But even if it's shared with nobody, reading it all into memory is
> > strictly worse than just mmap (since the data is getting copied into the
> > new allocation).
> > 
> > > I don't know how Github executes "git fsck" for the forked repositories.
> > > Is there any regular tasks for "git fsck"? And would "packed-refs" file
> > > be shared for all these repositories?
> > 
> > I don't know offhand how often GitHub runs fsck in an automated way
> > these days. Or even how big packed-refs files get, for that matter.
> 
> They typically are at most a couple of megabytes, but there certainly
> are outliers. For as at GitLab.com, the vast majority (>99%) of such
> files is less than 50MB and typically even less than 5MB.
> 
> > The specific case I'm thinking of for GitHub is that each fork network
> > has a master "network.git" repo that stores the objects for all of the
> > forks (which point to it via their objects/info/alternates files).  That
> > network.git repo doesn't technically need to have all of the refs all
> > the time, but in practice it wants to know about them for reachability
> > during repacking, etc.
> > 
> > So it has something like "refs/remotes/<fork_id>/heads/master", and so
> > on, copying the whole refs/* namespace of each fork. If you look at,
> > say, torvalds/linux, the refs data for a single fork is probably ~30k or
> > so (based on looking at what's in a clone). And there are ~55k forks. So
> > that's around 1.5G. Not a deal-breaker to allocate (keeping in mind they
> > have pretty beefy systems), but enough that mmap is probably better.
> > 
> > I'm also sure that's not the worst case. It has a lot of forks but the
> > ref namespace is not that huge compared to some other projects (and it's
> > the product of the two that is the problem).
> 
> Yeah, the interesting case is always the outliers. One of the worst
> offenders we have at GitLab.com is our own "gitlab-org/gitlab"
> repository. This particular repository has a "packed-refs" file that is
> around 2GB in size.
> 
> So I think refactoring this code to use `mmap()` would probably make
> sense.
> 

Thank Peff and Patrick for the information. I will send a patch later.

> Patrick
