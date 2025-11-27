Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E532C3276
	for <git@vger.kernel.org>; Thu, 27 Nov 2025 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260469; cv=none; b=kBmNOYm5s4YSHfhjN+RoMevXZyz4WD01qrqeCEnao/8iYioB+mlHI0WYQ04bO4KySl9gLNHW95mUt4xwNUlG0DUAjqILaUEPKvcmNEQNym7S26foF8mxyeW/lSU9+C6rlA9RapTYa4DkvUT4MzGyoSRRggeDjAZwPaWhaC26lOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260469; c=relaxed/simple;
	bh=zqCdtq7AKxTprNUa0M8/N3GHacV/xym5ZoC//DirmhE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PvIzgp+ZtwLLRrWdiW2UbKRHc6yFtXf3NIcz/iLkTZ9RPTD2PaOXTLyeZL0gjMhDOCXt88Mr6qXrAVwsg8isNIV13QwKzPj01RyOdMnQ+tmgHno/L3RSL6vEloqOygyKxX/+ribzdXa4eA5lrCynWXujNAu+m8afvXHcQKQHUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lqhZp2WH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqhZp2WH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42b2e9ac45aso687971f8f.0
        for <git@vger.kernel.org>; Thu, 27 Nov 2025 08:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764260466; x=1764865266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J6fcWqky99WB/dj4na/WLhpcppAGHwtwguDnhSRZFXA=;
        b=lqhZp2WHN4iTMx7EQHR4/4lL0MPMaHJy6OLr2GD487xsyJSxPz2yRoTvkeagCi9PDy
         c9bD6iSN/1+XY4p+5dMm79lSw0xX5Rvp+1bLFZCa67Y8u7XQEnYKcApxXvj8x6Tal4/D
         mWiNyduesfQh+dggrxxzuxh0HEBfVUi2Z0KARE9pVsJUD1nLxeIi1E70Rh1F51clBFnq
         4u4NzIZgiiDS62lGPl3brrEQN9M5RMn8ojV/fu5Yg9qIi+0+8Na4rK3g4cu1pxCWYou6
         HqjRl8acnoR95IZ++LxWyB5wbzcIb+FLkk5m5uOCFNb0JIVnyh9/xccfrsdV3pwfRKwf
         XOjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764260466; x=1764865266;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6fcWqky99WB/dj4na/WLhpcppAGHwtwguDnhSRZFXA=;
        b=FZGHWuH5puYmPnBqIgquhsHqyqFoxrvEe9caq2xbBPCAfECEREeFOIryllr9av+3cy
         F84VGQgFjwJj/5fLL4xWq1Lz1zjwjx/LuGtcxHp2W3iizRTO7yaEXn0wSXS0zWHuFAmJ
         ztsCABJyBhRg33eJXZOZOd7lVYX0KgWRrWuuP8eXFx9lP0rwHhENc9FUibBnVqoKsnfv
         DqkAOeSX1RUzFRzvvFp0VnbiAMHw11cehhgF3yAHK8enu8ITbBNpxvRyABgcfqMZcbsS
         Kz+fZZ4TER4xfQ7VEuFlez/NQjQe06LUoYyWq5rNB0YlyZ0zf6lF9GyhZ3zutXbVb3Fx
         MKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4EeRqZpPX/ttN7AFSfQlYjyN/3jrq+Tq0p+eV5pcVfOKf/cyQZoTk4hVjHrzH28zf/II=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ2yEDBqvRTQY+JHXgQgHMnTBcxxvF/XhjAq0iU5Sh4xIcvmIC
	fmWVj+NnqeF5rvlhjorbJoV+Dw9ZCeQNOUQL5q8Ws4eCgF9SxOMF4dRK
X-Gm-Gg: ASbGncuApvoPnnYlNwPwO17DxQBWV3L+XBUKvIoT9qD2oPnoQi7hU0BvMotZUwo/HnM
	zSnrprNvF+WRNCgG/D5d4G7rPI1R4O/xwuxGbEkjXiUBmzbC2wRORMOxnZjIbkqapKAU+qGs562
	/4NtEX1T+N9MWgVeTj+PvSk8lIjj1T/mKc/mHqHEvem1mXNpovfKPrcbXiuVfN4Kk/M2RP5AqUN
	KShU7baVOFjdkiSiG31niDaVjna/DNifGa0loUdKEV1efzovU7NkC+d3acAM1+NqJXdbiWiKblA
	QxXWmi7Mc01Gg0TY9Gqvp1YSZiQZ1bEpxd2zM7AOPosKF6WuPDdlDw09m23raOxguAj4svuO/Ry
	yg7E+Y7m0LkiNdgHWTikmqC+ODouMGvzgFVJ0n/SWFrS7T/QhGLyd0eqSNsx/soKtZ7XDhIALco
	8CFsSIpCXP7fTXSZFzdJ44NDf0p7QwKgqCDnqPlKcipwHyZ7WbyeOJJtHWCTP30+M=
X-Google-Smtp-Source: AGHT+IHJz1p68/ED715Sg5iCjIH/aSz6bZaAfoLrJldhyzWR3T9dzGTUfev66irIITRscLE/jKIYyw==
X-Received: by 2002:a05:6000:4313:b0:401:5ad1:682 with SMTP id ffacd0b85a97d-42e0f213731mr11683342f8f.14.1764260466539;
        Thu, 27 Nov 2025 08:21:06 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1c5e3857sm4875662f8f.19.2025.11.27.08.21.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Nov 2025 08:21:06 -0800 (PST)
Message-ID: <bc974d63-b3f1-4ef9-8fc5-e7e719b6ae89@gmail.com>
Date: Thu, 27 Nov 2025 16:21:03 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] replay: add --revert option to reverse commit changes
To: Siddharth Asthana <siddharthasthana31@gmail.com>,
 phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251125170056.34489-2-siddharthasthana31@gmail.com>
 <d563b68b-e01d-4b18-bd84-86f36e61a70d@gmail.com>
 <38b51e19-7939-4a5e-8ad0-2d8168bc0fac@gmail.com>
Content-Language: en-US
In-Reply-To: <38b51e19-7939-4a5e-8ad0-2d8168bc0fac@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Siddharth

On 26/11/2025 19:39, Siddharth Asthana wrote:
> 
> The realistic use case is reverting commits from a branch where those 
> commits already exist. For example:
> 
>      git replay --revert main~3..main
> 
> This would revert the last 3 commits on main, creating revert commits on 
> top of main.

We want to be able to revert an arbitary range of commits. That means we 
need to give --revert a branch name to update in addition to the range 
of commits to revert. The following example would update "main", 
reverting all the commits from the branch "feature"

	git replay --revert main main..feature

Thanks

Phillip

