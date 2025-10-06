Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15E1DF254
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 19:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778362; cv=none; b=u3deG4YyEXHfH8SrpBo494VGzUXkTkL3BfZLw9vJL3Yv6iPIx6b2PlNTCw+FSlhTX+TBjLp9nZJ2LeUIxL33gsPPh1xwW00UkCK5des5h6Ay/mUYuVMXh+KYrzEl2ENLbO2SNOY6FKbv9Oz9SpDD+tZ4FHO0D5fiAzj/j11etkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778362; c=relaxed/simple;
	bh=dil+GcMFv+oX7neozZmG8LcnBws4yDbkl7c8AsmXHNk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZ7LcOrXUh3H0XaOqN562nGSS6dBDaRV4CYTU2oNtqrKEotRB0pVoPXMTvowFIrNIrgH/seJGayMDLjBvnCGHFzA7WSjfpx51i3VE1ovsoQvZKDqXdPv+Pfa08M5X3KznfeHDjXt80+WomqKTbJ8dODtCl0yE+islUY5yDk/Dwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=lxClFop2; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="lxClFop2"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-93607aec358so127128739f.0
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 12:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759778360; x=1760383160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vyn3suVSRdJuzeBElz/Gpy8hed05GbQdxGFsUcFmNFc=;
        b=lxClFop2kFiok+07U9eaZtsqN9p57RLDU7cz9eAlDHtEbBpZRj5YSB0+CmqHJc8lhG
         HpIX1zTWdRcSUNje/LB/Q4EutS4Win/ZoQrkcKbrKzmOdwZap1ShUgWtDZeZpZb99WKZ
         j9/gyI6tFd/EQ66p2MKCGcRDc5sgPUiMtIZu+dXcQS9V3FcXzh45TrFXh/G7432NicZc
         +k3rdR6EVOfTsNz7RsaLVHLo1m/I0dlvnf1nn1qT0ICY43rhP7Jl518mG7WZlL1l27Wh
         FkneT3+Cx5l+xPKzXBg3aQB8iBg/WmDQzHl9DSaCRUX3nDEk03XW69JtP6AVhvP53y8k
         BiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759778360; x=1760383160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vyn3suVSRdJuzeBElz/Gpy8hed05GbQdxGFsUcFmNFc=;
        b=YsfXicfbuCljXLngvD/elz+HQSudiFt6SY5FNOhmjdJh0eUiW/ZFDYbYovb7NQytxO
         esN0G+HOR6e3fRpop2O3K1bjX+KXTugalewnxII/aLIoplasIPlz6X7hciQU5g8Xu00L
         SJVEgoP4j4ZbyDm7Ac1Ai/3PNktVD+O9LI78/ScjI2GTZp1SrS/bZkTb66wxYlcl4ZtF
         G3Fi1qd7ERuWBz36CKOT2eYOiqfYqHUh4vx3IY96JwTe1VUOmiuVWet1pFA9h0C1dn8k
         ZiOLfQ3f2ebpm/hXJIlbFYnzC/KpJmVmde+uXbxhAJFHgSCxK3H/t8dRrUNMsspg5iwU
         B/OA==
X-Gm-Message-State: AOJu0YzdcAD46okjrS642TZDfyL3IRwyMiW0GB5cS9ZJGend06hRiIhe
	RUeiEm1Q0X1aJO6Wk9JIHC4Fmlt0IGYldnIwOWUlN+Lrm/HxCInCpKXNS1bgZqiLCpKnZQlAWPu
	0x5YGns9b9A==
X-Gm-Gg: ASbGncsGRTljNt/3jh4u738E1ReQUXZ8QHur2plhr4/pGkqW6SGQjwQCj71yvu4PY2Y
	4F+6FSmf94vW91u1tNsv1S0FrDM8YWMEk3OqqKZZjNVZqNT9P0GVsrb7V+NWTW5wzr7siflT70Y
	1NbMGAaeCKIWEx4rwuk21KNsIUc8WWyTtE9SHOrydZkvCEDTLyUe4SHCPHn2hEMIfr63+E//oLJ
	1gNZt38TLH7Vpmb0xmVRYwbuujG3kbmQ1QmIuzoJzL2u2O1eVdm9guENbpMP3oco5VqQKahPbOf
	U5M5VdNgJwqmyLyf5BnMctew4rBYiftng8RBl6ZlVOMzXzs5bh5R9aP58vcITjsfKdvZkbwzcug
	Z4GK1Bzv/ChOKp0K98u8+ABFL+NYOd9gZEK0jOvZKT/amy5v/D/uogfw2IxpeK+KnUV+/bs+FTL
	GaCVJyPUc0GP8cMgRikT3TekM3L9Po6BqcWRIFrj2GU0kIOKPPFA==
X-Google-Smtp-Source: AGHT+IHjD+Tc1ktzbmqWC1cposRNYQZtCz1FCDD9N2nwSuAOxCBx00VymfchZ5MAnyexCmzMvu9ryQ==
X-Received: by 2002:a05:6e02:3c02:b0:426:f365:b55a with SMTP id e9e14a558f8ab-42e7ad8e7d0mr206343095ab.30.1759778360133;
        Mon, 06 Oct 2025 12:19:20 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-42d8b1f3474sm56322945ab.9.2025.10.06.12.19.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 12:19:19 -0700 (PDT)
Date: Mon, 6 Oct 2025 15:19:18 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: [NOTES 05/11] Pluggable object databases
Message-ID: <aOQWNrIDSTTZtbnG@nand.local>
References: <aOQVeVYY6zadPjln@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOQVeVYY6zadPjln@nand.local>

Topic: Pluggable object databases
Leader: Patrick Steinhardt

* Already working towards, since git 2.50.
* Allow innovation on the server side on large binary.
* The design will soon be up for discussion.
* Allow migration between different object format, and allow to be picked later
	by the implementer.
* The planned work is to make the new db more pluggable, right now the work is
	still about refactoring. 2.53 will have a proof of concept. Might take into
	the second half of 2026 to be done.
* Blocker1: The current db format is still not clear. Particularly latency perf
	related issues.
	 * Might be using content chunking hashing, might be using existing db impl
		 like cassandra.
* Blocker2: Second problem is how to generate the packfile.
* Taylor wonder whether we can reuse the current object db, but patrick thinks
	the current impl is too large/complex to adopt. The current refactoring effort
	with better abstraction might speed up future changes.
* Gitster wonders whether we can just use the hash of the chunks' hashes.
* Taylor also thinks a new obj db might become just as complex.
* Patrick thinks the new obj db can be more maintainable. Starting off with a
	brand new abstraction allows faster iteration.
* Rewriting obj db in a new world might be challenging because the pack obj is
	so intimate to so many usage and optimizations (e.g. bitmap), also the need to
	identify big binary obj over the wire.
* Taylor thinks maybe we don't need to rewrite pack obj, but abstracting the
	packfile could make it worse and more verbose.
* Patrick mentions there's already many other adjacent projects abstract away
	from the pack format; e.g. jgit, libgit2. Jgit initially already identified
	Casadra's perf would never work due to latency overhead.
* Taylor suggests we identify a proof of concept with comparable latency to
	existing obj db before doing additional refactoring.
* Ezekiel is refocusing the discussion on targeting large binary files. Maybe
	with large binary files, latency degradation is not as important.
* In git, we already have a divergent code path for large binary files, we just
	chose to store them in the packfile, technically people can change the storage
	selection without refactoring.
* Patrick still thinks having sub-system abstraction would make code more
	maintainable.
* Taylor is supportive about some objects can use the current db vs only have
	the large binary files to use the new db; at least we don't impose the
	overhead over all objects.
* The obj chunk design Patrick proposing is meant to benefit both client side
	storage and server side.
* We should resume this discussion with more concrete usage, right now we are
	still talking about potential scenarios.
* The premisor feature from server side cannot satisfy all clients, since some
	clients don't want to use premisor, so the server side might still be expected
	to have the large binary files on disk.
* The packfile url might still be the main direction we can use to fix the large
	binary issue without doing exploding obj chunking.
* Another benefit of obj chunking is to reduce hash time for large binary files.
	Gerrit currently sees 50% of clone time is due to hashing. Parallel hashing is
	also possible with obj chunking.
