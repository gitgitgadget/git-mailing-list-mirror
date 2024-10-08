Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223CA20CCDC
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412589; cv=none; b=MPTCIl4CollE4z7RmbEcVhHdL/KUte/hUvBpGqm0++HYWANWpkuiWVkEtiUs74ZjD9anaS4cDtyvpoGoF40RE6LEvgCrBkvm9KPyk0o1cw2yvH3eb5ITX/daNq7JFqdc9KUFTr71FJ1MqTRLfqPd7lzLWJRK16QtKtbTgDjfNqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412589; c=relaxed/simple;
	bh=lDYmhGdVEKIhlK82b3qIhe68aGBQ/B7ZF7ImtR/2CWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h08Nc1lHVhO5Lbeo4ETb7dmALG9slg3gBg9Jhd8f6ffO2weq+A7B9VJ/UDfEYC8QiX8UF50hRPpkwL1OAgETDufRMmqGeflIP7h/59VBPJ3YYARBWWbF4Se98PL0MCUXS2m6PY8ZWXIjFaoRYhQigPIRDm3pbl/4jvhIjaNjEW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv851DQl; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv851DQl"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6e2e424ab49so26500207b3.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 11:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412587; x=1729017387; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asRYasVfjfEisOhPVCvFVmsIIFkzqn6c5VH/KHpMtpk=;
        b=dv851DQlUJdz6rFrxbjZ2wKMX9bdrWbgFDMLj3xuFFSIA8YbpEorqzOoHOfvJ3tLfM
         75WAhqlYgYB2KY8yOvXO8ryjN4mTTdswZQlRgycC3/aObcNtnT45YHDmvElA2urSeQnp
         GtK4C3fr2soGd94JZFEdj0T483y2cstSqKPIV0uVPx/T72gf1z67d5pj/mp2HuKjd8lj
         ZflU2hv8PRfzDV3jn4I87U0zZ88IWAxgLmA31/hfE6pSdSQ7yfcXw5lA6o+rCXt2d3Vu
         euuhYJBGx0/hmC7Z3/CsYaW9Vx13pRq8ihsET8QZLG+lSW3ALf8fCbJ4IT52SXLSLan5
         xfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412587; x=1729017387;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asRYasVfjfEisOhPVCvFVmsIIFkzqn6c5VH/KHpMtpk=;
        b=jbRoHFouXUQ5LFXIj9ai3n7HRlJI2iKQPEBLJIRCGyAkJCheQmHhXqtblmRAwoGAFO
         xEQAsZZGKJNCpjW9+qZ/3Cm2JbMMITgB0YfsVEN7pwpv5Y3/YWj1KN+PPrfdZyvc33Dl
         DMYB8eNnVZ9fhi7T6Naz93Tb50p8rLgYnCi1tchwzH1h5/eoxjwUJ9ijZcO1LV2/36au
         YXzbambVGyJSRxmskCnkDda9V08I3E6T1gaYvYGXs1QgbP0qXkcpey5XY6M+H7p0bdtJ
         s3dNJAxzXTz8SDOCEQdiBXAiTOXttdgBcbetJ+BGgw7sL1a3GiUI0fxVNcEwdEZjOMGg
         YElA==
X-Forwarded-Encrypted: i=1; AJvYcCV79lXZ1JhT1JsctbE0+j5LyX5dw8ELhTVurHrMZIfSGmHCIPF/lgKybqO54HB3NrHLO/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw0T2iG6aKDiGEhM7ou3xhl6v/vzCj2tjwKQizE6LafQT39LVc
	6aK3DOfual3041pYvQ30ayJ/HnxfY78Z4ih9ytOfGcDHC/s8R1Fx1STx0A==
X-Google-Smtp-Source: AGHT+IHAgihQkXGMkeDZYFDJS5OHJsbJExwa3dqoCJpv8tF4rPz2d0d6gZ1lzdira073dt9TvpRLjw==
X-Received: by 2002:a05:690c:9:b0:6b1:2825:a3cd with SMTP id 00721157ae682-6e3224913d7mr151127b3.35.1728412587039;
        Tue, 08 Oct 2024 11:36:27 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:799f:a786:d66d:649f? ([2600:1700:60ba:9810:799f:a786:d66d:649f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e2d9388d7dsm15403197b3.73.2024.10.08.11.36.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:36:26 -0700 (PDT)
Message-ID: <f89ba1ef-4cd4-4963-8de0-0323216246aa@gmail.com>
Date: Tue, 8 Oct 2024 14:36:26 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: ds/pack-name-hash-tweak (was Re: What's cooking in git.git (Oct 2024,
 #04; Sun, 6))
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq4j5naozf.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq4j5naozf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/7/24 11:53 AM, Junio C Hamano wrote:

> * ds/pack-name-hash-tweak (2024-10-04) 6 commits
>   - test-tool: add helper for name-hash values
>   - p5313: add size comparison test
>   - git-repack: update usage to match docs
>   - pack-objects: add GIT_TEST_FULL_NAME_HASH
>   - repack: test --full-name-hash option
>   - pack-objects: add --full-name-hash option
> 
>   In a repository with too many (more than --window size) similarly
>   named files, "git repack" would not find good delta-base candidate
>   and worse, it may not use a blob from exactly the same path as a
>   good delta-base candidate.  Optionally replace the name hash so
>   that only blobs at the same path and nothing else are used as
>   delta-base candidate.
> 
>   On hold.
>   cf. <34346998-deac-4e1f-9d5f-218f664e9e08@gmail.com>
>   source: <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>

This topic has been on hold waiting for greater interest in this
approach. It was the first topic carved out of the path-walk API
RFC due to how simple the change was, but the 'git pack-objects
--path-walk' feature is a higher priority for helping Git clients
and is now available for review [1].

Junio: please pull ds/pack-name-hash-tweak out of 'seen'.

[1] https://lore.kernel.org/git/pull.1813.git.1728396723.gitgitgadget@gmail.com

Thanks,
-Stolee

