Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2971E132D
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728512738; cv=none; b=ebccAaJsSoeSc2y2QWvmANTjcr54U8s8Oeg7sFpAtKd5TZIejvnN84xF3UNgRV+SB1F5y5u94RBb8RNUadQLYiwzNTli7nJbKZViSihuCW8VGHtjGTWxGmQm6yRNnQQT3iF5eCY6zsJay7bmVnxkBG0LZyzrjUlBrX5jVBNYZSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728512738; c=relaxed/simple;
	bh=kih+9wJw7CuhGn0TTMH0h/9Am9K2atg+ZyPYK4/fq6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYmjBJaR3PlLUnrWweg2VT2Ba7Ka6vilQJ1rKyJGRiGxmn2MZoUc+jv02/BmIN6PdVzXbLPsh7iltdOwx4M1V+zLSTxOek0lpLBYs4VEtHkpMQcC92fCHV/5KNk3Fe4XTMSw3YKXSd0zVaya06lFalixc1OdTV0ls7pxaq7pG8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bMpeou7E; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bMpeou7E"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20c87b0332cso11155ad.1
        for <git@vger.kernel.org>; Wed, 09 Oct 2024 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728512736; x=1729117536; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+dI622EoSYoW6bXijqcLOi7TNNexpVgggwiAHIAyHk=;
        b=bMpeou7EI73nUlSUUb3jOchxhAVnjcrmbm7DUF2IPdkPBP2VcELF7Dd5PIlrxv5FqI
         5orJSSTfefxyPL27CSPEfFP5JiIpWqj4iY7wtl8J1zFeSPzJLWOuqg4RGZahD68j23U1
         y0NkiNxdUyIW7WYig5fRSlhr8LivGj+OSmtpH0dDgZ9hcVhjBTyjvq2mlVXVugFao7tZ
         /YarQbc6wuOXZ7dcVi9oCGxRRuv+bF/wuBdm7SZksuGOD4BH0cS85bGQF1ES1sgpzcRO
         N4lEuM1H1CV05/EkiuYm3Y+Y+oUT4P/rlDnyPeEYnTVIFG828xDudpsoPpuYxC4IXOqN
         4Utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728512736; x=1729117536;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+dI622EoSYoW6bXijqcLOi7TNNexpVgggwiAHIAyHk=;
        b=rp0SfpE3ZRKymtd7Y/vKh+3Rx94rPAFEIi6Rg+il49fmlrtCVpB3ZQ/NlOFsckme0F
         nxH26EBOkbYRU8BmuOCsQvDiB0AbNf5JEMt0IUV/tY6GmSreNk8gduOcmW2/WA5f89vo
         E/zcUEsm32T6Li9F+Bz4svTysQ7WUMM4IL4zHaJUAb4cEngUZghOEQMMKLV9rUJx4fCp
         CS3XXVCgBnPgxVIoyC5lTRNLf9sFTGj0ZTPMqhFTF7yvyVONms23hpDOUCoRJNsOwYJ2
         F0yEiN4jL2qFUnk24/J5oUnvntL9q+MAxFtxueHWJ5gTHwtWvPD52aQHP4tIXozl3+sc
         oVpg==
X-Gm-Message-State: AOJu0Yy72mUSCHv5rd3oefuRx9b7VTh/hVoVyn4rpBYmQeQoc5NBHi72
	baHToQ3EkbZJfFC4xdJJH/rJhnMoCVmmZVd8trgRmU02TbQPVMb6EJ6mJtP81oqTHb/f+9vX3GN
	ipQ==
X-Google-Smtp-Source: AGHT+IEiMpgx7ivTEUEORNtkgwVEgo4fW8XGjmc1QWiOfDOXscwbrtxPECV62JMQpC+w7K8gglY73g==
X-Received: by 2002:a17:902:ce8a:b0:209:dc6d:76a7 with SMTP id d9443c01a7336-20c8298f0a6mr1193125ad.14.1728512735366;
        Wed, 09 Oct 2024 15:25:35 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4268:1c66:e2c:2ffb])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138afc65sm75303295ad.38.2024.10.09.15.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 15:25:34 -0700 (PDT)
Date: Wed, 9 Oct 2024 15:25:29 -0700
From: Josh Steadmon <steadmon@google.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, 
	emrass@google.com, gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	ps@pks.im, sunshine@sunshineco.com, phillip.wood123@gmail.com, 
	allred.sean@gmail.com
Subject: Re: [PATCH v4 4/5] libgit: add higher-level libgit crate
Message-ID: <sojvhdl2jfsvngaixtccfsezlp7mpoj3ag62q66zphragf7o2l@3auva7nngupm>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, ps@pks.im, 
	sunshine@sunshineco.com, phillip.wood123@gmail.com, allred.sean@gmail.com
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1728429158.git.steadmon@google.com>
 <29599e9c7be1737bcf0de0541c9635212a1b691d.1728429158.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29599e9c7be1737bcf0de0541c9635212a1b691d.1728429158.git.steadmon@google.com>

On 2024.10.08 16:19, Josh Steadmon wrote:
> From: Calvin Wan <calvinwan@google.com>
> 
> Wrap `struct config_set` and a few of its associated functions in
> libgit-sys. Also introduce a higher-level "libgit" crate which provides
> a more Rust-friendly interface to config_set structs.
> 
> Co-authored-by: Josh Steadmon <steadmon@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  .gitignore                              |  1 +
>  Makefile                                |  2 +-
>  contrib/libgit-rs/Cargo.lock            | 77 ++++++++++++++++++++
>  contrib/libgit-rs/Cargo.toml            | 15 ++++
>  contrib/libgit-rs/build.rs              |  4 ++
>  contrib/libgit-rs/libgit-sys/src/lib.rs |  4 ++
>  contrib/libgit-rs/src/lib.rs            | 95 +++++++++++++++++++++++++
>  contrib/libgit-rs/testdata/config1      |  2 +
>  contrib/libgit-rs/testdata/config2      |  2 +
>  contrib/libgit-rs/testdata/config3      |  2 +
>  10 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 contrib/libgit-rs/Cargo.lock
>  create mode 100644 contrib/libgit-rs/Cargo.toml
>  create mode 100644 contrib/libgit-rs/build.rs
>  create mode 100644 contrib/libgit-rs/src/lib.rs
>  create mode 100644 contrib/libgit-rs/testdata/config1
>  create mode 100644 contrib/libgit-rs/testdata/config2
>  create mode 100644 contrib/libgit-rs/testdata/config3

Just realized that this commit message is not accurate anymore (and
could provide more useful info anyway). I've reworded it in V5.
