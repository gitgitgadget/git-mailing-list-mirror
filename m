Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7313FB9F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 03:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273376; cv=none; b=sICr2BvNDpFhs0Or7TCRx6G1MmsLppaNUNv1kN2+UslEE0wW5V7sRJ7EbWKrI9t4QSWWLZV2/3htL8nFz6QEP+/6YWgYzCI83DC28cuMotkx57ViTdO9AOJ1YNZ05pubWCsB2bAwJp/1bCNizl0Ixs/NoJfXSqi1AYb3JLQySFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273376; c=relaxed/simple;
	bh=sD337dmgrWj/l4bc1qPIfVOSNkLZTkG8uy5vHCOzIy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQwRyeA0gL9hzYzyiBdSatbPrx+Q13w4OIrP2ZTkL5jNyX3QPZdOUnvCH8BT9M31X9c6ql3THN9Tri4w8gdhkPwTOZv/TXkkeC1O9FkG8OgBfHWJDgWpRxZKTBOQZCWMCtG6I8QlpV7qPKg+DZJJjY4DMJ/HYHjwltaZxg3zQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7JDiWiW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7JDiWiW"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so859473b3a.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 20:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728273374; x=1728878174; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bUHKtJbGvXGRs9J4d3zESDKlDlRl+z6rUXau9hZsTvs=;
        b=a7JDiWiWe1ueagEXdkYeoYSpZ8Hf5rNcsUZtIPKyeGylqGaCVRStZ/cb9jyyIGwUWF
         Hyi403bYfSwKEHdApyGlgUiivfV4H6O9BrPLn+M/vXFANRAUCEgq2y9QlIVG7cEoE4t/
         45zk+AsbY958sqrcaChYr6oGtD2ehgKF7Ronqj0kXZCI5pap2cIVSH/0lB48yLQRDpXF
         dPksjy++SpdEHBxRlMeWQ8OFDSnp82oHzplzDtk7fXGsrQpecgRtIGmtQlZW/a6jBtjC
         nZWf8OgVY6U2wV2q+aeArBlSqMdoISaJ+YVijacHjDOaUwkMbBsnysIm55qdQsZzN0Mu
         tGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728273374; x=1728878174;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUHKtJbGvXGRs9J4d3zESDKlDlRl+z6rUXau9hZsTvs=;
        b=KzMES2rxN9kKcAVHie961tVWI7XIe3AqrbbUhHqJsvlDZllt7uFyiKcPLTCBMn8LCl
         Zi8kWITrIgmj/9QMG6Qd5xgS7ajmnmnt8ishdtKy4VDX4GPJYB3Eb3PjmcJkICoIwgu4
         oKyklcDxel7SaQtcbE3ogqr7/w3eD5d02td8eyNz8JGDU8Ok5NuXHxGFSkZyaXOWzg+T
         N+enpyqj7i3so6Uk6zr4SQ2szhO6enCsyFyELRBFc8Ku3TKRe/9gTZMlKMn94lm/YqjH
         3YkAfC1yQUTMxqzXGo+mZcWdRAV6zjvvVk0T92sZ+h+AMwWidQ8X/zse2xX917JbWsP+
         3CdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyIJg/ocJDRr+hbhrWU5XZK6tVBU5xhJylTq0tebttVHmdxBEWikyHoSCTK9/vkut2IAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyDgktcs1qxoMBtPRtYiV5qa8W10dYteZV25RsNnOmvAhBMcYl
	9KAXzEQdPhNKZ+Dy+mWSfoZy2z/Lp/kjO4pB6sUswVW4+sL0Wpcr1K71T05n
X-Google-Smtp-Source: AGHT+IHBrBmMogUH3WzfndHrPmLxFAImCQtoYB9dfJbu7np3Jo1ZEwJYHd9f6LL1c2X23Gk2MWfKyA==
X-Received: by 2002:a05:6a00:1820:b0:71e:21c:bf08 with SMTP id d2e1a72fcca58-71e021cc187mr3870402b3a.1.1728273374258;
        Sun, 06 Oct 2024 20:56:14 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbcee2sm3452568b3a.43.2024.10.06.20.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 20:56:13 -0700 (PDT)
Date: Mon, 7 Oct 2024 11:56:20 +0800
From: shejialuo <shejialuo@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/4] worktree: refactor infer_backlink() to use *strbuf
Message-ID: <ZwNb5Aabrub4tW5O@ArchLinux>
References: <20241006060017.171788-1-cdwhite3@pm.me>
 <20241006060017.171788-2-cdwhite3@pm.me>
 <ZwKoNg-HYGaohvCd@ArchLinux>
 <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cQC45_Pofw31h2RSydj_CjqpfajLLa5O_sR9m0AQh5OVw@mail.gmail.com>

On Sun, Oct 06, 2024 at 02:41:22PM -0400, Eric Sunshine wrote:

[snip]

> > Why not simply do the following things here (I don't think
> > "git_contents" is a good name, however I am not familiar with the
> > worktree, I cannot give some advice here).
> 
> I found the name "git_contents" clear enough and understood its
> purpose at-a-glance, so I think it's a reasonably good choice. A
> slightly better name might be "gitfile_contents" or perhaps
> "dotgit_contents" for consistency with other similarly-named variables
> in this function.
> 

Thanks, I don't know the context here.

> > If "git_contents" is not
> > NULL, there is no need for us to check the "err" variable.
> 
> I'm not sure we would want to change this; the existing logic seems
> clear enough.
> 

The reason why I don't think we need to check the "err" variable is that
the "git_contents" and "err" is relevant. If "git_contents" is not NULL,
the "err" must be zero unless there are bugs in "read_gitfile_gently".
So, if we already check "git_contents", why do we need to check again
for "err"?

But, I agree with you that the existing logic is clear enough. I just
explain further what I mean here.

Thanks,
Jialuo
