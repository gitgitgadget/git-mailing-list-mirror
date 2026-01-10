Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCE72581
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 22:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768083509; cv=none; b=PUePpI884wo3tiFOoeB7rJ6KrT3u+BTh4afH3lCJK4NmEh5I7mi9ZiiuQZ1FjC6l1EPqzlTDWIFWJulixMDe9YyOqfwU+tjwxUokv8Mr47XtXPMS02siOZX0zkI/kZVNQYuIx2XpSP682yUv4JUBkvicRYWcIJYrEAXfQ6gSKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768083509; c=relaxed/simple;
	bh=Wolg1lyk/SJCfG4oUHFMXxSpawJQpoxqHF3CZw9q/TI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WM1bUZVbt6ZVPF7W/sD2ui69dBUuewmwrmsrz1ypTRiOkTSwj7QU0q97z835x5T7NVfJFzQOj5ZoQYSWg/ZlfOiuQKrO+7ZYWlkQUY0Hg26NNc7Cu+RcmIoC9Umfr4El1MOdeVclGWWGDBR0PcKxL9O2nPfubJoa8gJ69Da/WH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPaH6aWr; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPaH6aWr"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5ec96028b32so2868843137.2
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 14:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768083507; x=1768688307; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wolg1lyk/SJCfG4oUHFMXxSpawJQpoxqHF3CZw9q/TI=;
        b=mPaH6aWr4bUgJEV8LVbTqXJoxGqwXpuRSohraK+Sd07BD/JEteU3UvLXpsxwZqmAFJ
         yT9V9rJz8rOqsvSfVqbyq8U/FcAd2NcNBc8SyAln3I5XkanmYcYd9fB5gkpdD3D40ZvU
         QZ9Z6WNSqj5o9wKWXT8f/sYiX6Srj3kacU8J1Z70bw8kQdeCKiy17UYUtwmFn6Fsul1A
         xXjxYg231s+DASliRuzKh1wLtLIBdoAiS2MN7Uauy3ZsoBKXKZSRMcKS/4Ao6818q+NT
         ZA2GCS+L5W7GNMIdVmJZWFW3f3G8W9tf5MGazWq+g8MBDRV01ys6hV+b3WqJ9+d7cLYh
         Dc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768083507; x=1768688307;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wolg1lyk/SJCfG4oUHFMXxSpawJQpoxqHF3CZw9q/TI=;
        b=Z9xWHqE3cXKw+Xtjf4BvC+cmgvePhcM8Y3eTgKrnJFt+AmKHu8F2wIDqKito19yJ7O
         LjbGxd8T0YFT5HmF6y2bOUfBGv25GutESbSfLpo8yie/PFE3aue8Rhop9BjmDbvWma/h
         Ow/6gp1fObdNGgQf2rK3SX2Gu+W22b7ga3Z2TnC49dehRY0rTthu3AXIubK1GRfWGxsI
         f8wW4KfBJsupyBvr80xU6uBeSZZ6inz5f48eI/JCx6LDAVn9co044ZGvRQJJEutYuiW5
         IUQaSQy6sNWCrlde7XB0PJl8GGv8y1KPD2raSB8n2fBL1zRIbkpNoDgizc/0P8pDT5xe
         EzCw==
X-Gm-Message-State: AOJu0Yz1h5RZHSWTnO2f8WtSm8q64rmQwBGrmmCYS0dbZpYPhpv94N5d
	Qs8NloCSDT3dpXG/8qYirCeHW2OQMeH05QXY3KgO5D266SMDLW7wZMwD
X-Gm-Gg: AY/fxX5zzFMJl5MDg8r/eeJfvA913N7VVljMGm8B2OQkGRtVFZvQt7XtF9d95kdqyoX
	+38XnEab3y4AFuxiTo5L67Wl+F6H9JJ4JYlyoMTQcLZb5Oq39LrOoYt98YybB51IfM3oYiqRzRX
	JFfRZ4fbZn344sMICa0L3EXqoonFM/3Teu4HxY+Nu06cUeeRe7FupZgrRGof4z3OMyArWmBVMk0
	35dXt3Zypnsg8KWzP64G17EeN+R3bz6m0/pgi7ckKsBuIGCf9RUA45VEpa4GUHmUVxvkyeYrDDD
	JDsjLs8LmgOVhwvS0fP5RXUFzMSmUXHZcW0GLFpQuhEg7U00pJpi0R4BTNPd48/dTqL+/2aZ4JT
	+9U8SJ1x5JHnBhWaoTRk4CHnsxjzlW9VERguP3k5VFwHDZm8HG7NTx05FlFcplOWkEQL1n8c1C0
	ztWCPb1cTWRuoWDR5JJVgpkDayNHT2WbtnyyDTtO0ggQ==
X-Google-Smtp-Source: AGHT+IHCQ2mIIT4yfdO8SvkMvQl+TkdfAKQPIQ13Fquoy65lvsfsO6xKNmbnbQSyb7TTUJ6bXiZ5HA==
X-Received: by 2002:a05:6102:5f02:b0:5db:d07c:218f with SMTP id ada2fe7eead31-5ecb9851efcmr5663334137.40.1768083507357;
        Sat, 10 Jan 2026 14:18:27 -0800 (PST)
Received: from smtpclient.apple ([177.103.85.119])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5ed091d93f8sm11674235137.9.2026.01.10.14.18.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Jan 2026 14:18:27 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 2/2] repo: add new flag --keys to git-repo-info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <12814829.O9o76ZdvQC@piment-oiseau>
Date: Sat, 10 Jan 2026 19:00:35 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 gitster@pobox.com,
 jltobler@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <C2D91A8E-F034-4604-8B02-155BAADD14A2@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260109211554.90828-4-lucasseikioshiro@gmail.com>
 <12814829.O9o76ZdvQC@piment-oiseau>
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> We use the placeholder format for character names: _NUL_

Thanks. I'll change it in v4 and I'll change other occurrences in this
document in future patches.


