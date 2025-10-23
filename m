Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B3EEACD
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 00:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761177928; cv=none; b=bjBZPDthaZT8lFdkwKMHRg75Tk2R95QwUeHyM+b5UlS8UmENhbC8PH878oAnoSMTzdR0kvrBmAuObrk0Zzn2noptI4Ei+V9IwshwimzS0WKcnrQMlv2kUoSD0LU4mgWcLKhJ8q0U7+anzd74JlAjIXuo4Cp1ZjfPm+AjA+kcDgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761177928; c=relaxed/simple;
	bh=DBg68vaYGLhZ6X0s1ylIyWzKSiRLAFdZmLT5JZoKX9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MgapUq0CbV9rnyEr8pay44PClTuaN6iVAhre8SKwz1pBH+O2mf4YLcypN4hPdM2yrxk3olex24b85u26M0apD7BvEC6f2/nNEhqEXTEoQFGUqTdnC+vVBW2x9tgIWWr7wT8dpWlQt0keh6O3TXvx8vVFX6WwZvPwzPFW57kAyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCncYSZn; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCncYSZn"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-3c9a42d6349so351003fac.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761177926; x=1761782726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yfoz8hvJ9fi2FdBMLQnWKvV6e5EGHsT3b8oRn+2cupA=;
        b=PCncYSZndBYRAgah6rGw0iwOmDBgWBtSgFuZOrAfAgK/KLSy/wmRJTd5vKp7xsQoMp
         xbA5jNmZI/P2YjQzdUKeNSKqEmngV6UmFuy4es77y0AqGwnL6Wj6ENKd67p/Qd0djIR+
         ZdycSLMpoaD88JWYNk7GGDSCjc4DX3sXjKyxvNYJZM9UwmtKU5toDiaej83m99Le8vCR
         ei0K1lSf6DFCjwwYJnSacGhatCd4nbcTIYWoMFuFXHNeT/MBtoIBnhPAg0c6deq0/HVJ
         24TQvUy2rhvTiInNjEub9pA2Xmuasaf02lzG7VLPXQJydkhKqGxsF2Tj02yMiKFjorF/
         9amQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761177926; x=1761782726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yfoz8hvJ9fi2FdBMLQnWKvV6e5EGHsT3b8oRn+2cupA=;
        b=IdzIyoQa4zPj9tgT8TyMPT0z0bYTSjHR/n3qHmLsI10uYk871xN8HJ4TPTU4rZDdvO
         spo3jYkyaHOi1TKS/7SMJZhY82x7tIBtHUjkfp1ZqTMc85oohYwhcF6ea8+1IVLeznuF
         H/NHYMllrze7B5/an7rdGIXiVRtIWv8r/tmVAH44mGeDdgFNZgiCjJl5wQwvUb5AydQ4
         hkrgs0FoTAAfJjO6ay5cjKVDl3wVjQSS/XxsVD1m2/giv41tXq1Xuuq4BcqYL6WHpHJp
         eis+if5ZCTgRbGDsQw2pULwJM6wYZ7+HLgvapWoqqO81JWN7mL+KmRODEvT4M6ZXAH3N
         ZbCw==
X-Gm-Message-State: AOJu0Yy3HXeop1Qaq8hMozGDptuIeFVAooZrsYsHdMuoJEEDFZWEJE1f
	6kAjWnWEeJausHKTCSV+OmCqAUQqVfJHUliR345q/rpg89hJG8q8NaFRyXLPRw==
X-Gm-Gg: ASbGncvnRPkF5WK3ybYri+ijFE75rxsc0KGyByTXAwKwSJdkrOmE1oFKBHK7rK4nEbV
	cRZ9+8gAA4MeXWytQ7TyTKE4u0yPvp4G3dIJTIIAvYcyySgxPmL+PCDOi+v6o5LYzFKBYb6WCY+
	oYSCDv/Wr4nPai6nMC7UNe1X9Gmfkd6czIVr4bbtqnj1Jowm13L/qUIo99oli5jcT3ywfpJqLuQ
	bTsVAdVK9em6687eE2G/ovmfXneb5EiakHPk8yKsljl0lAVFeuFeJWBE54vorHLSby/RtZBnAkl
	4MN1w2iJbEOLsYl6ttF+mGJkqYHH3TB5oPwO7jTPmYwnOBN0shO8oraxvsgbj7vCUcQ2GJvpi3Q
	2qApm92BcPWU17YePjq3nZpgtjYd2tpqsDF3yvBzOiGOMmKg1RMzX+1vuejHDCYI+5i80Kg==
X-Google-Smtp-Source: AGHT+IGU0djkOK5HWTCCSsLIWu7AGPMe81Htof5J7dujdUNtVpEzq1oGE2dtdAFgWmHgdWM2W4qfMg==
X-Received: by 2002:a05:6870:8551:b0:3c9:46b1:953f with SMTP id 586e51a60fabf-3cdc57c30fbmr270134fac.19.1761177925996;
        Wed, 22 Oct 2025 17:05:25 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3cdc4e0affesm225924fac.15.2025.10.22.17.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 17:05:25 -0700 (PDT)
Date: Wed, 22 Oct 2025 19:05:24 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im, karthik.188@gmail.com, 
	sunshine@sunshineco.com, gitster@pobox.com
Subject: Re: [PATCH v6 0/7] builtin/repo: introduce structure subcommand
Message-ID: <eesy5qhqzi56qrzv7wlpenxag23l2zykakvpmr6p5rnak6cril@ap3rugp44bcz>
References: <20251015211213.361797-1-jltobler@gmail.com>
 <20251021182601.2687284-1-jltobler@gmail.com>
 <64D5752D-AAEB-4559-A5FD-EA7BDEF16553@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64D5752D-AAEB-4559-A5FD-EA7BDEF16553@gmail.com>

On 25/10/22 04:23PM, Lucas Seiki Oshiro wrote:
> 
> Hi, Justin!
> 
> Nice to see this happening. I'm really happy to see `git repo` getting
> new features, and I think that these new features will be very useful
> especially for people who research on free/open source software.
> 
> Sorry for only review this today, I've been busy finishing my master's
> and I didn't have enough time to see your work here. Can you please CC
> me in the next versions?

Thanks Lucas for taking a look. If I do need to send out another
version, I'll make sure to CC you. :)

-Justin
