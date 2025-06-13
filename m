Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1A24A069
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 20:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749846661; cv=none; b=DMNpitYwrHRZzb2MsG8eo7H1J0/9nTJMLXpI3tJbZu+Rpf+W5BQgJRhPYs/O3ZrZ1JXYT5T4klbnPdYX18UvVXzYI3yH79DONRt+FnDeTHCbsUYwWD1dsJ0vyppKzctA6iV9/qt3z12d8KvdaCGowzbVpS4SFj1xhfWZ8d8a/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749846661; c=relaxed/simple;
	bh=sHW4UXcZqngATgCfwuEA4IfKcEFsmTs5m1h2NzhFAH0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bUjp0GHYrC83PtIS5m/H/kiSJF/SV/pvz2LyqLc5eaRGefI5cG1XZQAruF4GAqxdFETDErNVCVGASAwaNC5BXq9l66Jyb//WGWyGTqq4Vj9Z+TqUx9UGx679KARaVNxHDyggSkieHOdxYMgJ5AD5aByBJ4lBHZDL4OKZ1eYaOBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRrjXW0k; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRrjXW0k"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2f11866376so2106313a12.3
        for <git@vger.kernel.org>; Fri, 13 Jun 2025 13:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749846659; x=1750451459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sHW4UXcZqngATgCfwuEA4IfKcEFsmTs5m1h2NzhFAH0=;
        b=iRrjXW0kKFCGYbYge0GYRdVTAa8eqBZ6roAnK7SYueWXiK4OY0xI+1jOm6fzSmBbPA
         1jNTFRMcphcXOtajmhxyld6p8xj1GwCO0KVTpdOpWs6J6T3sVK/zpl8wDQyB90C0wmxg
         EAdmXh0sBXChUXlGme/tViSBVnXnC8WfPVscyYZQUyYHFWOUG2TkzYzvJ0iQdHB4HWCJ
         0jCQcVdNapgi14XAcusrR5zp2Sptf+Y73XDg+dMIrrayQ75FFAfaLZRIi0nHWYPkcbTD
         XlyIm9fQMOj95bZWahWkyV3OZ9pLGMQK1Ie8yuzzLpM40/j1tGhPqhLHDlhcwah8q5ef
         ix/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749846659; x=1750451459;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sHW4UXcZqngATgCfwuEA4IfKcEFsmTs5m1h2NzhFAH0=;
        b=IvSawyY2H68jDMzXxxeHtozS/eKMrjFbywK7/sxy8ohk0VJfI5y1YfePQIiylKQU+6
         j27uIy20Lg4U9iChkesuLznDhkT/Z039HAn+URs7xYIqhZYu7kpgLMVdufzU8KPeZC7O
         5MdWrbywcbNlvtEI8LRpHUj2ZSq2XIlZ+3wvN9cFhvBaSZB3xBruw0Oy4I0K5cr8rTI7
         hCjlHlz4sSBTLa0xL1+wH9sAwNzlasQmB2PzFPcCn8OKO/ZvnW9QYftMSom3LVQhiMjK
         2j1/8fyVCSc8i7B54DNB6uE3i+Trdsa5zEQ4yTdaJa6eSfbI3B9he5IVm9OhV9ungeRZ
         K6LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzQPoFOh6+QiC/pj6bFRmrfomk/Z87XvxmTjfNpWRq9pobgNRNdv6OfZ5DspWNvewp34o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSLw1dUa3hdZHURC2EQelSPWI+wx1pOd2tWUHZNePtBQa01O8X
	tHhRgdy01z4fkY8HCQ2wCVIBVOKG50wHEJX6B6Op+VOIjCT5qJNdfaMla4KtcTl/
X-Gm-Gg: ASbGncu9fnlotR0xNjM8BfsZiH3SqpxtRdkb6YowhOme6JSu8E4glVqyKp6hq/67EOR
	gvdNKwjaqt3neen6x36w0UNUZYthqa2g0XQw80iGk/2HyT5wbXgLxs5CqWe/he1CTd5NMqTrxbi
	aMXz/coC8+G+A59wOtWYxxjLT1VVjUlK9Sp9HdLEz0DwIpuWfn7CUdOI8FAhulQufHBtpRamZr/
	FME/YrhLV6IVKtHu4BqGm4GVLuzoWWvR4bIYZ8je4Bw8l3O/YxQAO5mK2m+HXa9l/nsDtL6Iem7
	f0EzGJpvGH5z4SCeHGaV7PXUr8GDzJ6+jeVOm8K0SQ==
X-Google-Smtp-Source: AGHT+IFpGZyF1wHFVAf5+Lj2FEoZmkgEZsZy263MOMtxLpPX/NwN7ZaNFJ/oRk3jXXQZMqDNmJ8YFA==
X-Received: by 2002:a17:90b:1cc3:b0:311:d05c:936 with SMTP id 98e67ed59e1d1-313f1daa6a7mr1733377a91.17.1749846659399;
        Fri, 13 Jun 2025 13:30:59 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::f55])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a4d3fsm18989285ad.64.2025.06.13.13.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 13:30:59 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>
Cc: Brad Smith <brad@comstyle.com>,  Junio C Hamano <gitster@pobox.com>,
  git@vger.kernel.org
Subject: Re: Solaris sed
In-Reply-To: <5895400.DvuYhMxLoT@cayenne>
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
	<caaa5d54-d32d-40b3-9bf3-0f322e7c4316@comstyle.com>
	<874iwlegmg.fsf@gmail.com> <5895400.DvuYhMxLoT@cayenne>
Date: Fri, 13 Jun 2025 13:30:57 -0700
Message-ID: <87ikkzs7su.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:

> Would it be possible to set up some kind of CI to check for compatibility=
 with=20
> such systems. This is the second time I introduced regressions without ev=
en=20
> knowing it, and it would be really great to catch them before borking a=20
> release process.

I'm sure that Solaris packagers are used to patching stuff like this. I
wouldn't feel guilty about it. It is difficult to remember all these
portability quirks.

With GitHub actions you can add Oracle Solaris and OmniOS (based on
illumos, which was based on OpenSolaris) using vmactions [1]. That might
help catch some stuff.

In this case, the build still works even with the broken sed commands.
Not sure if the tests would have caught it though.

Collin

[1] https://github.com/vmactions
