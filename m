Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B32EEC3
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129535; cv=none; b=PlZNoKJSVbkmiq4RC4GCq2YpUuOK3Ez0CXwSr0UnkyTcbBC5B4uHsSmCUN9V4VXrYvtwzUfqu5ZGBSRSIJC+lN3CZ0+HWIn9qfm/YNzdl84UTY+lpRVuiyMCeO3SVEJ98sQ75ZHEP3egZfcMLzxHdr6X68EpGyIDtkTZ+wyLAps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129535; c=relaxed/simple;
	bh=Jhr79JEQDifjOTj48EjBAjgthH3VPdz1oE4c44EmVv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5gEG7jteOJ3pWWDOV2y8JqvCLeQ/qI9pkql5Rw2ouSo05qntQPV0FmlKl9djLYhtb3R75HJhii1zdzPYaJx0cJ/da6AkcsO7qDDbG8Zg6jm9zC3zTvhvx+mfB8ImIPMypLFfv5TKPdnjw+AdcisuT9209MHqBYEJNibFOe1GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8XruytY; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8XruytY"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4327790c4e9so3645174f8f.2
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 06:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770129532; x=1770734332; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DNgoDGsxtO23eyxPZ1+02I1ORtgqTlj2vylUR7Ajx+o=;
        b=E8XruytYt4xKZAjC785pGD1oheeMUCBIkdKa4eZjry9HBKiuHEodRrqDooF1Ciwd09
         ZUidqL1pca1wmj0jjrP/yKiKin+8ywyav6u3GIHc3s3yNsdJz7K21/xKfsuouGTg9iIA
         A1yIORv69gRdR+RLb7u7nqzixnIqV3iF4/3m8vO0GYVoTapJsEJjUSevE/slgmEadeHt
         uYMB11uBz6XDYEI4TS5mPZVOv61529FqZzDFc4t9607OphSV/d13Wg5UKhKP5EfDUqTf
         iE1/3sdrwRw4HrnbymlA4EuJ/JF4a9+zldUdtYGYRumCvPxIEjUUfA+3rWQzCy2Sxjpn
         wx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770129532; x=1770734332;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNgoDGsxtO23eyxPZ1+02I1ORtgqTlj2vylUR7Ajx+o=;
        b=hibBudGNTwFofNZmJ2qZgCYZjLpi5S7E2L4g8ng+HmArRFQ7pMpMIK3bx2kMzApLTk
         T1x49HQjQMM0dAyNVULlN1qrIdmmfFqqmYKk6cBN6xckL6x5nSqQuppFXlRFlJxvyh6k
         yvjTlLKMEccfSQZbVDoM4WeE5xQ5jKZx0WSCDAnbrajVZm7PE3rdizI/jltHOPj9G3pa
         kDkqSkkKCCMoW7wMhXA4fw0vSUKZOjEyWaDv6+ygI66KPnb+qLrXMcj0+vSRZF07zfs7
         +xvkLk97LLlxcRMbdo8CDxbR/tvxq3MkUZTQvnbKjBwLEQEv3NJFWZVRbXtu8B5CEvRg
         evJg==
X-Gm-Message-State: AOJu0Yx41AFakz84IJ9i8swbzolrPCvUIULEOi1zfwaySqfIhIkdWuK2
	UB43boHxbjhnDQj7KWy7hRRrrikDGAgfcAkDIK5hiMIeLzqQucZJPnDt
X-Gm-Gg: AZuq6aKlxnT9QTOM9I5b3hA7gaz2BcHG7ucdTmqeqLUQbl1VwGnSQ1Pmz9TVBQQAuvj
	O2LEtbomU5nwUGi8FOEuiBymmKPFv/OLbk7yWTMIzuTSbuNfKdrJJ+cCFr8REmsydB3+14q+9EE
	P0ptf4Of94JMFP7JkX7VFB44gJr0/TCIJKCZdZej13C0qKa7UE9/eIoUW2hqrDoFS/RWZjTQ1iA
	F8D9s7m75SjkCqhCf9uCNriORVXdZkoNq2LVJ+zYwWotqMSnpSL8TdYXh2rCefBPbuPrr7gUt4A
	+WZQyuL+MtmFtN0uXXTQy4sCo037S62wvy7R5YUZrG4XohkbpHRxBfsTeNPgjja5KcLvbMmFbjX
	8U5h7eDPnmobV47V3Asg85VN4Ht4z47kl6cAKdVJzlsdbDma5on2pBRqB1SCjUGnYMyDp459lYV
	3Ww13KUhJf+TxARmXx22hVtmjLdiKvFrTg4M7YhHe/m8rcwEtkwSLm9lHOstrRvH38mA==
X-Received: by 2002:a05:6000:2409:b0:436:145a:e55a with SMTP id ffacd0b85a97d-436145ae7f7mr2714827f8f.16.1770129532173;
        Tue, 03 Feb 2026 06:38:52 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm50794447f8f.3.2026.02.03.06.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 06:38:51 -0800 (PST)
Message-ID: <9120dbf3-f10f-4333-aa70-f24835d7ef02@gmail.com>
Date: Tue, 3 Feb 2026 14:38:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
 phillip.wood@dunelm.org.uk
References: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com>
 <20260202101445.13790-1-haraldnordgren@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260202101445.13790-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2026 10:14, Harald Nordgren wrote:
>> I don't really understand what you're trying to achieve and I'm not sure
>> if the suggestion above is a good idea but it might help understand what
>> it is you're trying to do.
 >
> I want a shorthand so that when in any of these repos, I'm switching to the
> default branch, I simply have to run
> 
>      git switch @{primary}
> 
> and I would end up with
> 
>        99designs/gqlgen
>        Switched to branch 'master'
>   
>        amplitude/experiment-react-native-client
>        Switched to branch 'main'
>   
>        Antonboom/testifylint
>        Switched to branch 'main'
>   
>        cli/cli
>        Switched to branch 'trunk'

I think I understand now. That sounds tricky to do in the general case 
because we don't know what the remote is called. "origin" and "upstream" 
are popular choices but the user can choose any name they want when they 
run "git clone" (or rename the remote after they clone). If there is 
only one remote then its simple because there is only one choice. It's 
also simple if there are multiple remotes and they all use the same 
default branch name and refspecs. If  remote.pushDefault is set we can 
probably rule that remote out. If there's a branch checked out with an 
upstream set we could use that remote but there's no guarantee that's 
the remote the user wants. I don't think there's a robust way to 
determine the remote the user wants in the general case.

With the "@{local}" thing I suggested yesterday the user would have to 
name the remote which makes everything well defined but I think you want 
to avoid having to do that.

Thanks

Phillip
