Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7806521C9E8
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870794; cv=none; b=gpHUu/DBJDNZRfyRrkRVAQuhII7wH2AWIVdr3aZbhJmWXX58kav2Imp5unbimIGbrZ0cw4sk6sMWx7lD61NcXmzUYk/hPth+2R6ew+aJ3+iw7Slpd2NI0HtWJLG1BHygZ0UB5yeKrd+2KRpvSPR2OJCORABbnhWwzVYSarTeQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870794; c=relaxed/simple;
	bh=QHGThgu1zW7mpXLhOUFwpp/YGRsXByhlRN+xu8gfMiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcvqofhrgZCo4pSVs0/4mwybdnxcFgfujHXnByWNYp+EZqTH8i8GPaZRuPeIzqUAqMItOiAlJEiPVkga0ZrHxoKL8WDlujpCPTW/XEkb/Bpngz3N6sAQPycFWgI7s1CWAYMxK7nCvLkm4JMMNpIY1B7CvT2soVZBpf6Sy9ypzP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjwMgYJf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjwMgYJf"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b1ff9b276c2so2502514a12.1
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748870791; x=1749475591; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKh/edT8AVk9O9eNLbeh7JVFEAPcZEjXC2SHMD/B9Vs=;
        b=hjwMgYJfntegcZJbe9zfW1/GQfsOGQiD8D3J8akihC71KcLswFyfXm9LLnhZwcpR2k
         t/kd/4u4mImq7DccaGgQB5q59cK6FHJN0rU+RJ7HRt56uslqJuqD+0Yjaqeu7VWigz5F
         Mz3KnMZVKunOJwP09u+va6xIHp3ib8UfTDx9ngUlkDKSiM647ToMK7SMFYQaSPVIc1Pd
         gkyhE81ePOw8hsEJL4kE7M4UPiEV2hqlY6eyHThjtGS/7byXY2V6alAnVZRRwRJjk9xL
         3/+LweqiLBT+IyLoaB7Kp/JKzF5SrEQoNAE5MiidXzyvlM/GZsSPoRAb7vAAkqaaZqor
         lFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870791; x=1749475591;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKh/edT8AVk9O9eNLbeh7JVFEAPcZEjXC2SHMD/B9Vs=;
        b=RK/3RpjzO2YV9JCWRy/HECfLF+AIC0kw3gJEERltZsggiezJlx8Zby8PVKaAmyXjnt
         x9V+tFQG9P/kQEo2tmjItncpp3v0M4MRS+D85gUvtXHluOj5KAvzv9qN6q2lm+dZYcey
         gP5xCGicP9phWWsB84SOap4Dvg2pOLw+4gH/9E6RfQc9V5U0IBlLTbvejWNdJyjWYd49
         /aMjSa4H0422kEHANdgmThDnwYhuM3pw7ZrK2y4sqQkh68SBiX6dEONEdjkE8q7/5flI
         R2+gJ2Ds8nK73U9NMfBuX3umvm6mVM4CtTC1VWBiE+H/8ekXD/dZPAOj1d4YBW1OkfMm
         Ajsg==
X-Gm-Message-State: AOJu0Yy6MpUZhaBgWlPWBh/4+GEyN9+82rN+yvyMpT30gnsQwkTSRRDK
	E4+u6hH5V+EDFMq7RsV7pWtG3opNqODejt+reWnrX3mPlAj96qFRxl3rHHXC8Vnr
X-Gm-Gg: ASbGncv/CDvPSqAEr1U8aYm7msIKW2tYudl8Bt1uun8A02uENDCSzpNzynMNe+h0S4X
	7M+ZvW0QR29kUHilPOHWxPDto5vbdos9lRdyrjRMtI8DjIHlSsGki0Jbc92TPIitw60fzn0ilpT
	XiRr3HFui5a8pPenbjyQzu5FqqKIMVrd8viBtFhSdP1GvbS9uKxFGiUFkh52/j9g663QArUwsWa
	5jcxNbjIXbomIrS2Kzh4m4mna/huHAUJGI+PQqp8FYafB6fopTeRALupoZ+vS0+PnfmE+Nc7LMj
	8uGbufZVVBm4/vC/bEsFJCENPFcLMacihh9NsZBGnpE2c5Q=
X-Google-Smtp-Source: AGHT+IHVAGM2U9uf7Exv7K78Q57Nu9aEEvulTJr9ORM9op3Xm0LdW7hlIG666y8wrNpPXj/Pk+dz/Q==
X-Received: by 2002:a17:90b:510d:b0:311:f05b:869b with SMTP id 98e67ed59e1d1-3127c75248emr11341819a91.30.1748870791111;
        Mon, 02 Jun 2025 06:26:31 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-3124e3999b6sm5604730a91.25.2025.06.02.06.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 06:26:30 -0700 (PDT)
Date: Mon, 2 Jun 2025 21:26:28 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/1] [BUG] refs: verify does not work if there are v2.43.0
 or older worktrees w/o wt. refs
Message-ID: <aD2mhOlwl1LSYnpe@ArchLinux>
References: <aDp55upE6AhYunz7@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDp55upE6AhYunz7@ArchLinux>

Hi All:

This version updates the following things:

1. Update the commit message to incorporate the commit message that
introduces the BUG to better explain.
2. Update the shell script to avoid hardcode gitdir path.
3. Change "rm -rf" to be "rmdir", which would be safer because we should
delete an empty directory, which has a better semantics.

Thanks,
Jialuo

shejialuo (1):
  fsck: ignore missing "refs" directory for linked worktrees

 refs/files-backend.c     |  3 +++
 t/t0602-reffiles-fsck.sh | 17 +++++++++++++++++
 2 files changed, 20 insertions(+)

Range-diff against v1:
1:  bfde11adb6 ! 1:  d949a8a646 fsck: ignore missing "refs" directory for linked worktrees
    @@ Metadata
      ## Commit message ##
         fsck: ignore missing "refs" directory for linked worktrees
     
    -    It is reported that "git refs verify" would fail when encountering
    -    worktrees created on Git v2.43.0 or older versions. These versions
    -    don't automatically create the "refs" directory, causing the error:
    +    "git refs verify" doesn't work if there are worktrees created on Git
    +    v2.43.0 or older versions. These versions don't automatically create the
    +    "refs" directory, causing the error:
     
             error: cannot open directory .git/worktrees/<worktree name>/refs:
             No such file or directory
     
         Since 8f4c00de95 (builtin/worktree: create refdb via ref backend,
         2024-01-08), we automatically create the "refs" directory for new
    -    worktrees. However, the fsck code incorrectly assumes all linked
    -    worktrees have this directory, thus introducing compatibility issue.
    +    worktrees. And in 7c78d819e6 (ref: support multiple worktrees check for
    +    refs, 2024-11-20), we assume that all linked worktrees have this
    +    directory and would wrongly report an error to the user, thus
    +    introducing compatibility issue.
     
         Check for ENOENT errno before reporting directory access errors for
         linked worktrees to maintain backward compatibility.
    @@ t/t0602-reffiles-fsck.sh: test_expect_success 'ref name check should be adapted
     +	(
     +		cd repo &&
     +		test_commit initial &&
    -+
     +		git worktree add --detach ./worktree &&
    ++
    ++		cd worktree &&
    ++		worktree_refdir="$(git rev-parse --git-dir)/refs" &&
     +		# Simulate old directory layout
    -+		rm -rf ./git/worktrees/worktree/refs &&
    ++		rmdir "$worktree_refdir" &&
     +		git refs verify 2>err &&
     +		test_must_be_empty err
     +	)
-- 
2.49.0

