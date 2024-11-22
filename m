Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22001DE89A
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 16:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293885; cv=none; b=nIHtXMof9aNKveeYY0LgAVgLTMlt6h4m82eW4lKgH1asy4sKoDzfA4SVNx3GFkgK++Mz8+ylRK0+hFjWJ82d4itvmwe8wq+CCqwQscgh0id9CLGMSUUO3nv+UZ4YNl2bR/nEQVHSwoXQWc4O8PFlvR9hDEVp901BpaLlZ1gXtX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293885; c=relaxed/simple;
	bh=R35D5Rwea/EcogQIuiMyV/rCqnIZMqEpdk2KI2uGRKA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GR57TrBO6/ZOQPs3+TAH5oU1/jzTbJ0jdURdBanor/jhcpITO2O9IxW6zPmivSVEZurxUgvjPelR9KsRhWDqDvGX5sqxnC1DA14SF5Z8sN2OtaGUMPyh0xn8uRR76agcZniV+MiRwVMnWUxTloM0ffFiv4EM1AcFm031hK735yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGKmJDxt; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGKmJDxt"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316f3d3c21so20015575e9.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:44:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732293882; x=1732898682; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PIieYpC5Zc8d3cPyDRn3RH5iigrx4QUfn811oBwFrHc=;
        b=kGKmJDxtMNh7TwjAtjyOa0Mk6V32gpTd/GnWDjkWfUrgwTC28L3PTPVsLMMxtNeQ6U
         Qtf7nCW1GxqUHBMAB2TK+xwrgvznGqdeJV/ze8+7+lwrDKqPHVdXzVibsk3GcbzFiXsa
         QCPJFR5pI7dvfiiFWXbxa0rsxdL+Zy1uT43pnb5GT9jHxri5nDy8/6lbouMPO7Ivacrj
         1xrLyMfZqdbI3eMTFuZIVgAXYjkOlfKPzUj/9HDyvDZqIfngpNaR4vUets/WszKzbdDq
         jgMKQYCtxdJnZtAqazB9GS4AgOab0qZXaasVfdEolHzErdidU6l9J3/0ammIh//yWlkC
         29iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293882; x=1732898682;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PIieYpC5Zc8d3cPyDRn3RH5iigrx4QUfn811oBwFrHc=;
        b=HnMUmlS5gv0mEGCFAqHYICciCw4naL2zXA32Fh2D+v2E2X0XAuesxelx+SQLEivGeI
         35K7R8ebv72d/BpPNhVxKhsBaAFgevvjqzLDDTlA/isQHDu8EZscMJWNxnhu8YDcGRng
         K63dVpKIkRI5HKT6yBhv2ljQBwmA2Jyo8qPGnSvSRMjYWrX5I1dkRO8qmc3l+gI4B+Ea
         qM532+wpnexLyfZrd3ePiBD/amyTEzlPNf9efu191H2nky696Xe3eRvuOD8pC5BkuFxp
         rSV9Qwn63mDmaVNeicRezT+L/etT6+Hoaqf1qbYj6X7WRZL0HtlKfWVSbluTC4n5m6DV
         nzrw==
X-Forwarded-Encrypted: i=1; AJvYcCUkg49ennQyREJWF6fJVNAohROH+u/Cm17mTB3Kz9QrBMz+GKCcA8tgz2YqdDYF5PijPiM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx08ia7vasBAltULfEpkUt1LbkG/RTcv/fiRPrHo4rGVNAj+FKB
	qDxmRSyCOJniO/CS2tKR1yLIocgCQQFmBeyquKcMtocSO/VSgh64
X-Gm-Gg: ASbGncsbDlm7mkpKJOIiMAIdQrcTeYMeMZi/6iDy4unBEG2xRRxd9wN0+fp4RPwMeNX
	DtFP2Xqte3Hu95GlhW67mpktGAVXgWgEiDt0LjvJsMgmxSiGJEMF7UExTpKajk9qPOXB8H37zDO
	QXrLn9YY53lW5UCqWvjcYrct12oeKPKRTFepG4ngQ5oKNnM+g5T5K21rS/C+Mnp4fZTy7iGLFq0
	gyFmlaVC8w+diLsZuzXRbgO8zHkny8gTijK9Pp6SpfZx2IBjLHPx0SRqWxWnQhGWhvXlnDmDAxT
	L0Ig0+lT+CVM68bRUJQSO2P7OQ==
X-Google-Smtp-Source: AGHT+IE+wAJeSDgjC6HO+qQufhd+OoPLGnHVhpbwChxgHCHSmGYyfb+RCXVl6gXrVcSUPB6AWEczAQ==
X-Received: by 2002:a05:600c:1c23:b0:42c:b80e:5e50 with SMTP id 5b1f17b1804b1-433ce39c8b5mr32422355e9.0.1732293881802;
        Fri, 22 Nov 2024 08:44:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe91a6sm2892369f8f.86.2024.11.22.08.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 08:44:41 -0800 (PST)
Message-ID: <e207382e-3e6d-477a-9a1d-48949df06160@gmail.com>
Date: Fri, 22 Nov 2024 16:44:41 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 2/8] worktree: add `relativeWorktrees` extension
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-2-07a3dc0f02a3@pm.me>
 <47f2b6bf-1e10-4b01-8365-467cc5ca7779@gmail.com>
 <D5QQZ2X595GX.2FRO57TTXZ548@pm.me>
Content-Language: en-US
In-Reply-To: <D5QQZ2X595GX.2FRO57TTXZ548@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Caleb

On 20/11/2024 05:13, Caleb White wrote:
> On Tue Nov 19, 2024 at 9:07 AM CST, Phillip Wood wrote:
>> On 01/11/2024 04:38, Caleb White wrote:
>>> A new extension, `relativeWorktrees`, is added to indicate that at least
>>> one worktree in the repository has been linked with relative paths.
>>
>> Out of interest what happens in the later patches if we add a worktree
>> with a relative path which sets this extension and then convert it to an
>> absolute path? Will we clear this extension or do we leave it set? I'm
>> mainly curious, I don't think it's the end of the world if we leave the
>> extension set.
> 
> The extension would remain set. I was going to try and unset the
> extension, but it is only safe to do that if all worktrees use absolute
> (meaning they would all need to be checked) and I decided it wasn't that
> important.

Yes, I don't think we need to do that just now

  I suppose the check could be added in the `repair_worktrees()`
> function during `git worktree repair` if it is deemed important.

That could be a nice addition in the future

Best Wishes

Phillip

> 
> Best,
> 
> Caleb
> 

