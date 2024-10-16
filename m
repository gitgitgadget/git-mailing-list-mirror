Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51450204F6F
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729069409; cv=none; b=jz1eT69eOgtQqy1EMoubIAPAoXdxTKAueCTBeB9//45CsL2m+iJlpiQ5gp06ckPkY74j1Jklsf6RGUM7gRrOXXQ9YFEEeYeO+0vNB0+l+nek/Z/ciMQFDI405dO7K+YXiw2C3N6l7SqS4h0opNfiL6ZA0+0wFhG9ueHZaZTRBlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729069409; c=relaxed/simple;
	bh=Tknx/KvY+EYdW0idXrA4vKhEiE/7j4i/jE3/jKJJ944=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jOlkQfMTV1U2EhABTo1i7FLsI9UlURDAjmu2gpb9E44e2FZUdMZihXZmFlmlz0xpmF2GqC3pE9uMn82LJ1uMCPHMQ5y1ohvFLBRFjZ7jdmdcgbqSc3H5k8QIH0PaRLstAJ3S9dupHSsIr4yIlPCHEtDKyyDu1SMbEwIeoG28i8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L5Ev1giX; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L5Ev1giX"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d47eff9acso3744620f8f.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 02:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729069406; x=1729674206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dROu/xRbc5lDAnlewx55NbsjgXXih4+llw06j+tN8RY=;
        b=L5Ev1giXoA46uWemXbdRiMd72dMk4crr45QVwDi2ITy+3y4JhtQ4BF04/DyX5Eg3wB
         ZnNBanECplg7klcH5+zfM/aPYpwM/Ffy56zs1cMClZgfqJrGkaBkLTvH2pmagx65tA/G
         YHZwhuqyYHJ+7K5GtQK/Yrduxp9WZGk38VSO2tlpkuipz1qgBlPpgeYeth/h6L22Tfft
         vRx+YBpq6pVysZfrIkDXE7w5wd3ApYH1KaJF8OFeFAKqbHlI3E4qCmh16vylXanE43dm
         Oj6X32IAL1eH0eDw9+/sxHzUlYIBkZmK/CO3eGf+S3OO5k3zDhfixUJdhY8ikyHyCtHJ
         wr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729069406; x=1729674206;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dROu/xRbc5lDAnlewx55NbsjgXXih4+llw06j+tN8RY=;
        b=G5FCqoYKSkHKFtes3qYhSZPjKjScI0iB3Cnm/bdS9QFKt72zG7/2QnD3WdXGOT6A7k
         Es/OPLg5nhhxA74rnkPmbW4D4Z3jiF0peCfCqzk+JLP3AuLuSi1dZJsklbVXg2dRt2fW
         wnPu5s4bq9N0BmglMkVf4Z5OP57piUSq7qfGwwVM2hLQJjN1w2C0Dq1wTMjtnw0aX2i9
         MvPS13be9db8NaZa9jPTSe3V49Vpmd1cUIH/epd42HGy0pagFZQMVOsdsY6DxAUN4wZQ
         kUmFJrTndcuATB1sK4kBLEOpb4nkAOv4TG9c006gDS078gywkXrUt0dmNFrYHUh2LQet
         gufw==
X-Forwarded-Encrypted: i=1; AJvYcCXOMW8qCtujSEx1FVeiwBkPR3AnIjUFLSgo5HB4Zpwx9ekDQEIehBbNbHORuurS0OgiixQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpuDB4DGal5d0tiH64hC4zIYEAF6pYmJN4RfkuqU4flYKpd4EK
	XBZIwLOE7ZQRGiw1aCVKvNPPHGOH+YRiE6vuLWB7Orj64Gw98AOTYRzF3w==
X-Google-Smtp-Source: AGHT+IFglYMMBBQ/jJDqDEziXeKySflrMnEwqYjqlMR4oPKAC6RGOUCuUDBi3f5Na9RQCCoIff6bng==
X-Received: by 2002:a05:6000:18a:b0:37d:41c5:a527 with SMTP id ffacd0b85a97d-37d5feaa088mr8212098f8f.13.1729069406324;
        Wed, 16 Oct 2024 02:03:26 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa87c44sm3734294f8f.33.2024.10.16.02.03.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 02:03:25 -0700 (PDT)
Message-ID: <dea863c3-7b54-4f8d-b6b0-6087b4cb1abe@gmail.com>
Date: Wed, 16 Oct 2024 10:03:25 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: core.hooksPath cannot revert to the default locally
To: Sam Newbold <sam@rwsh.org>, git@vger.kernel.org
References: <20241016022613.37813826@scaldcrow>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20241016022613.37813826@scaldcrow>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sam

On 16/10/2024 07:26, Sam Newbold wrote:
>  From my testing, reading the documentation and hunting through the
> source code, it appears that if a system administrator sets the
> --system core.hooksPath or a script over which you have limited control
> sets the --global core.hooksPath, then there is no way for an
> individual repository to configure --local core.hooksPath to get the
> default behavior. The naive solution of setting core.hooksPath to be
> .git/hooks breaks in the case of worktrees.

I'm pretty sure I've used "git -c core.hookspath=/dev/null ..." in the 
past when I've wanted to temporarily disable my hooks path, I can't find 
anything in the documentation though. If

     git config core.hookspath /dev/null

does work for you it would be really helpful to update the documentation.

Best Wishes

Phillip

> I would be happy to code a patch for this if I knew how it should be
> configured. Obviously, no local setting for a config variable is meant
> to inherit the global or system value. We can go all "set of the null
> set" by making the empty string mean "revert to default". We could go
> fancy "I know what you really mean" by interpreting ".git/hooks" (or
> perhaps any path beginning with ".git") not literally in the case of
> worktrees, but as relative to GIT_DIR. Or there could be another
> setting set on a local repository to ignore global and system values of
> core.hooksPath.
> 
> Thank you,
> Sam Newbold
> 

