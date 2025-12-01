Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF430BF4E
	for <git@vger.kernel.org>; Mon,  1 Dec 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764611212; cv=none; b=LYKqf9nruevk6uOn+69LHp3SY0C//2dF7jxyy4Wf0YGVVG9B0aq5VntAAc14OBRyNxAIY5vLFCreQruh2YQ11PU/cE0U6icjxfgIMJd1TK63l21kqR0BVwMngwMbxsGmHT2lhKM116bLlNJTxpZfgcRIZDAAwjQddTO/W4SFzb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764611212; c=relaxed/simple;
	bh=ddBQLg3PyAvYlVjxw0vA8QT22Un8otcXWoWTu5hL7QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osf+H2F4bAKUtsOGtJNaMaurosM/btMItooradeUCRyP9P1p9W3B4KgIH2bsJUCgf0MzbVgGI20ik0l03Hg+5w/dCNkn0baRS3VfUdFBLFrFxs9xoAa33ANj4KbzUdfwzJNxIdIztMcE8eAItzT+vpSvE/xDPRd1M//WbaygXdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USEyhf9F; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USEyhf9F"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4779cd413b4so3337445e9.2
        for <git@vger.kernel.org>; Mon, 01 Dec 2025 09:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764611208; x=1765216008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fkl26h1iFW/9xS/LEliv3Nz7MYyB2wZqbPVOEXwbxcI=;
        b=USEyhf9FSQ00ZDYpGB6FeiSaE4sQyiTbNLhreCcRQRpjgufZJmblkaeCryT4qy37ur
         ZaBVO5VQnwouhgNc7ZjjiJRWQ8T0Bz12AoUrOMFPmrvzJshAB1rBTYAUbGahsFgVcNI/
         Y1A5vadJo4MmdQtkTFEbhMTCDxtRypeiabqjFt7h8DBlS1XggsyWy2CMx+oWHixC24eI
         9JlLWSNjGU2h29TfalKLCYo7CadkOL7TwbyHemHKVwpMEO8fPWFdSPThbsH/DAtAt2Rb
         pn3EvhCEd8ZAyAXe/OpiKTiAGrYIsBi7I8rZyfkyai8r7EINEmPIvP08taGnB2+oemJl
         J8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764611208; x=1765216008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fkl26h1iFW/9xS/LEliv3Nz7MYyB2wZqbPVOEXwbxcI=;
        b=MSS2IAjfxh6QFDNPw2jzAKJVT8+px32MzgRaAHLrMDGEyJ5oPjSbFPp6lBJIf17e4s
         E/h2C5WAk2ko2L/oN2CsPkqwAcksw9HKz69Jo1Dhr0uuFQ0heVWN4zxXlwod2NaEq8St
         WldxRTNAnX1kGvtZJxtNOANQjwKTYIN1gKbtRxHvW+AQ/9jzb3PAm68XWka+3nVJjtG2
         ce1yKlkSt5OdRxoKD/4HQYTryZXEPIrGJOdED2HLTxDfq6D33UhYCmR6NgvcX4Glm7Sf
         SmvSvcl8bmEqZ0pwrA9Xplw14FIZVC2QGmA9tUsTlZztivOw4ZPQ8RYS+iI1SR7rjFNf
         lUFw==
X-Forwarded-Encrypted: i=1; AJvYcCWdByV5FfulXc2oPRMGhNm0//a2Qz4dw6dE9vmkJ2hJ0W7sT28tlT+dJ0+qGprIfAeI10g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHbKFUgHxTwXw0VxDtWR/oesV2HFVbh0wwZ5dglon8W3WaN3+j
	y/E3yk5U0WFgRlzRcgD4/60luN0lNGgr2PKfQI3PZQ1nl6dejH+X9lTyXL9gMx6i/yZLcg==
X-Gm-Gg: ASbGncviFGEycSFXiMkJoOvLVHO7U28M+BtO1bMlHHEwK28fTpctk1RSXgUPCr50tZt
	LNW4IyGd15qC7gWxMqbfIwPOzO/omAznyzARWlYW69z5Aw28d3WHXGugLDZXQm5G3osLQtZocXz
	p/YrXInQGVQ0HuViqozkHSJg6UKM+VG7CIH0uPhFbcRlGGPyB88IJPndnzp3We78caSQTO1N8Wh
	FLga/YNjJM67JV0jcP9wh1885mbc7dLaMDBlUYKBPFwAMKk6GTHLivsKT9p2/3yCeh0XtWaKO4l
	SuPMbcFnOG7VMqLuX63G5m6EcTH1tfqXcXdpOGm6YGeZgI86X03gIfI5czoX7wQMVj5Ajy+zEDD
	E2pgTO1tj7zrdSeEJSVnFzsnsoY4lArEGlLYAd+D0K07sZL/GfZ2OqA6ezk6vSDpx0uJl8ent+c
	W6EUM/AFIwiGYBTg==
X-Google-Smtp-Source: AGHT+IHzr1vEeU8hudQDYEQl/yf1MRLe0SAo3NIyVsz3WAT6LftAhgqmLBuS8b8Zw4+SfY/beCjPDA==
X-Received: by 2002:a05:600c:3b29:b0:477:9dd9:ac57 with SMTP id 5b1f17b1804b1-477c00f201dmr235820915e9.0.1764611208346;
        Mon, 01 Dec 2025 09:46:48 -0800 (PST)
Received: from desktop ([194.127.199.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5c30b8sm27695886f8f.7.2025.12.01.09.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 09:46:47 -0800 (PST)
Date: Mon, 1 Dec 2025 17:46:46 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, 
	git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im, atthewhughes934@gmail.com, 
	johannes.schindelin@gmx.de, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/5] scalar: remove stale config values
Message-ID: <ciegbs72xbepxawuf42pne7eu354ntbok5e3p6jxcuyddvaea2@6ykt3iej32xt>
References: <pull.2010.git.1764195516.gitgitgadget@gmail.com>
 <pull.2010.v2.git.1764607847.gitgitgadget@gmail.com>
 <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8783db6153875deb52aaa354da189ae611de1057.1764607847.git.gitgitgadget@gmail.com>

On Mon, Dec 01, 2025 at 04:50:45PM +0000, Derrick Stolee via GitGitGadget wrote:
> * core.preloadIndex: This value is true by default, now. Removing this
>   causes some changes required to the tests that checked this config
>   value. Use gui.gcwarning=false instead.

I was going to ask about if we could also rely on the default value of
index.threads like we do here, but then went and did some reading and realised
some config values, like index.recordOffsetTable, have their value set
according to whether index.threads was explicitly set, so I guess there's an
implicit reliance on that behaviour that we want to keep?

> * core.fscache: This config does not exist in the core Git project, but
>   is instead a config option for a Git for Windows feature.
> 
> * core.multiPackIndex: This config value is now enabled by default, so
>   does not need to be called out specifically. It was originally
>   included to make sure the background maintenance that created
>   multi-pack-indexes would result in the expected performance
>   improvements.
> 
> * credential.validate: This option is not something specific to Git but
>   instead an older version of Git Credential Manager for Windows. That
>   software was replaced several years ago by the cross-platform Git
>   Credential Manger so this option is no longer needed to help users who
>   were on that older software.
> 
> * pack.useSparse=true: This value is now Git's default as of de3a864114
>   (config: set pack.useSparse=true by default, 2020-03-20) so we don't
>   need it set by Scalar.

Thanks for the detail on all of these, very helpful
