Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D505717BEA1
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723715285; cv=none; b=JY/e0sUJyRlehvJz039/Id0uN1KaaZQKsO7xd1EkVOSHWkO1nneB6mqnyV+5QyCW36YAPUmf6Ygd9Yc03iyT/XBwsXAWcKO1qL60qHrlylGR62P+o7ZWintYaVICd6Kr9kf90aFsaUBwDrMz6AcsV3dg3uID2YZXGo+w2/oVAO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723715285; c=relaxed/simple;
	bh=th8MYjelp1RIRt1J5sEqJDh5GkTTqXQhrvYEDlwPfMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwOVHUS+W/HJo1sMqfPloxC9U1CGs2wWEM5eMAf8CsWkuH5daP5+NUWLkFkAbFUYV8tmc4I1fonPLvGm2mc90mX1Gq2pZRk5eGkOz/I7Zb82rCUhiyfrMD8ujvHE8pI/dDartOtz+GndyEkZq3AdRvAxMHOIxjdRnwcKHxPvLH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioQLKj7D; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioQLKj7D"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37172a83a4bso309154f8f.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 02:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723715282; x=1724320082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bqjHAcUoZ9oa+AnJhHj8UrIRaupbrGrmNMrrL2EPTG8=;
        b=ioQLKj7DZl4Z1hk9kjFkjl+R12/PsgQXbhQPq3wUqgVtlJn54hFjU0sG17yIlKzw85
         95bv5yZcLMO+CU/uSCOKX6wY9OCsCjp36pXsCIHQ8X7kKO7wDe4Fv9lIgvvuZxb3QonN
         gI9xdLrU/aOX51uC4bN3XAgF5RKItddM2cDZAjY2K6ZYNlzC3dfKhkw/XmQcKc/jWzdc
         FyuvYQP6qdIzp5sTKIMHHm/av/ggAfBOa0ddAvJS1A8JTshzvKGgdlDqykrl7d/OEE86
         ctBOImtic02wAX38i/j/EAtUCCU+PIzpxG913dOPbVqF6Rpvr5H33h51qppJWmYBiSDa
         o4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723715282; x=1724320082;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqjHAcUoZ9oa+AnJhHj8UrIRaupbrGrmNMrrL2EPTG8=;
        b=q2jpvwIym9L1heH1te3YqnKu//bqRpHSGNfiVHw1QIguLO6dPZbauoStWOoIyQniIM
         cxz5dK19lDEgKfqnuwJTfxjGqMRdDKYvDBU/Tv49nwmTtC8XT8frAYFCRSdzUA3S7Fbc
         QZgxpD2MUnkM5aAhT/OgS1vmgSb9TfZWQdetdHhPECmLDJ2d0Tkw7t0vd7k63QZ6ZB5X
         WL5pecmAAPJKq3M3tlx6sSxTXxcth8p8yfm5IL9v4b+PErSafSEwjKeQT0jfmhJwGi9E
         1b8+fYrUey24IOEq0tWxQFkw3Q0gcsOUFB85AX25g/ocnxtjtfvCDNJ1eQYcVPRKSUKw
         w3Rw==
X-Forwarded-Encrypted: i=1; AJvYcCUUllyjnV3AITCFbFT5P3QkyJxyU7w4+DFgE4iWcFKuWEYVNIO5b/yroYOhi58Brt+LNEVYvqLaj1R+5y5L6rMBUnqG
X-Gm-Message-State: AOJu0Yw/IEbYFIzSIeSp1u4hU/TLedV1zVCxUMnDMSvreMAl2E8nrPmx
	zBYhBmNpulgLwPuSzYPFnCBwVLANRe76xzWeGg8kugfd2bsOxYbwMOSdAA==
X-Google-Smtp-Source: AGHT+IH+gBRR8Gglv9tJLvxHpBaWv1xRDkXvobKjaXsG28NBGooOzNsltcTP0r3fwbNxLwmcfluT8Q==
X-Received: by 2002:adf:eb08:0:b0:368:64e:a7dd with SMTP id ffacd0b85a97d-37177818fc4mr3125665f8f.53.1723715281791;
        Thu, 15 Aug 2024 02:48:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69b:eb01:545f:b423:671d:5e99? ([2a0a:ef40:69b:eb01:545f:b423:671d:5e99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898aabf5sm1044085f8f.97.2024.08.15.02.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 02:48:01 -0700 (PDT)
Message-ID: <0ca8ce79-6c9f-4836-99d6-b2a86dfe4109@gmail.com>
Date: Thu, 15 Aug 2024 10:47:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase: apply and cleanup autostash when rebase fails to
 start
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>,
 Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Brian Lyles <brianmlyles@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1772.git.1723641747309.gitgitgadget@gmail.com>
 <ZrzA0yp45w9NuTp2@tanuki> <b676bd17-1cc8-4639-acb7-675dde32a1ae@gmail.com>
 <xmqq8qwzypz2.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq8qwzypz2.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 14/08/2024 18:27, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Applying the stash should not fail because the rebase has not started
>> and so HEAD, the index and the worktree are unchanged since the stash
>> was created. If it does fail for some reason then apply_autostash()
>> creates a new entry under refs/stash. We definitely do want to remove
>> the directory otherwise we're left with the inconsistent state we're
>> tying to fix.
> 
> If it is not expected to fail 99% of times, it feels more prudent to
> abort loudly without making further damage to lose information and
> ask the user to check what happened in the working tree, rather than
> blindly removing the clue to understand what went wrong.  For
> example, could the reason why applying the stash failed be because
> the user forgot that the working tree was being used for rebasing
> and mucked with its contents from say another terminal?

If the working tree has changed then the stash will still apply but 
possibly with conflicts - the same thing can happen when the branch has 
been successfully rebased. If there are conflicts then the stash is 
saved in refs/stash as well. This code is just doing what we do at the 
end of a successful rebase so I'm don't really understand what the issue 
is. Looking at finish_rebase() we don't even check the return value of 
apply_autostash() when applying the stash at the end of a successful rebase.

Best Wishes

Phillip

> Thanks.
> 
