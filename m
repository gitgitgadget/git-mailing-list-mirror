Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306303BB27
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 14:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707748696; cv=none; b=ZwKMxx43ui1Q2cXQbh15reIZiPOBnQ2pEtfovv3ZzdxJXSUeeJ3mcbV/rUHlKBzEm9Lf4Jak2B5ii2ujDb69VY6Tzu5QQRFfWvXuWiETVoc/2U6opLYo4oUe0DUVXO+r/ZLgOEZK0waNBQuz/kElhk0/G/ab70sYxH/Jt8TIYtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707748696; c=relaxed/simple;
	bh=5UAN1XEHe7WI8F66psgysQUsjGkychNv28YLFM+Z8K8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=a3IUh/kWxiY75o/H5YfyPgaveXqZTZr6xKA5CX22nCT7L4kb1macnri/p0vOXKMd3TLi+WWZwwkzfMKR4n2jynpA68bWY0b+dDgsySckgnT8fyYFvw4Z26++USyQcWRnxARRUbyM/MkYwR22567YVUdVSC1FNAlsi0nMNrfcLrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RPE7xcE7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPE7xcE7"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b8441198cso425880f8f.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 06:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707748693; x=1708353493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ui2uDtnsALN7AW8oBb0pugyf4X4sk2YpD6bGzn/Z3+8=;
        b=RPE7xcE7qkc4RruRi+IZnldikqRHYT6mRwztGZdtfrHJpMU8BgaIyjOPHpLBC1219q
         KXK+xFAV9MAVFT+W/6uxsiENtGq2z2P/CoGeKYGTLbu8vXiL0k5aAxpwp2Ml2RZlAiD5
         XVrJX65ox8EYXOl7YkAzoF+qJelKlsdG5TBFtPrfp9GLHwLJC2Mg3IIPrYeCb3s2JGeH
         YZs5jFOKUHvv59A7WQHLwRKZcIGmx/R9fyQyPhLQ8aUUXuxAkUzwVt9Pip/dV9UkcEik
         1s2KX26G73oP0nPqoqBOR6s23NFx/NySAJ+qeRldqO13pnBrskzyV+9FlFx3MNfdlkTV
         PO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707748693; x=1708353493;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ui2uDtnsALN7AW8oBb0pugyf4X4sk2YpD6bGzn/Z3+8=;
        b=b5nyXkh5JDLr9iJZAwVmMgGA4TjhI/yGjeNX8e7nknlTTtwCuI4NAIqOKZXxiizY+O
         i8c2Ij2t+VHDgWVyd18bF8m4lOdQcpr14wMDCoTGeg8PPC8cYGNHUJsh2JTSC4bf8/ZZ
         czh+qJyv3gnfuyUevz7Cl/Sv25P7e8PuSoydjHLB2C4Fnlzh5YqqC6oAKjw3gTk5l8Dq
         sd3ZXwynWvpZMRydlqLPQOye7n7QcQZlR7ODoLCoXuPixlKz9J1IWMJFggNabi1A1+zQ
         MOvOc3tBAU8iDjpIYl6VA3GPPET906iTaayGNOyIGBTEKchDgUCaCd+5HL3J8i0oCh9Q
         5yBg==
X-Gm-Message-State: AOJu0Ywrlaw6cvJ9e4Ljcsxpf4mmMs6erOdwHYeXlVTIgU1PedW8OB8p
	qkv/B15s7y8FlCBn/SzFGi9dualWvk6KU2QR2CgBN5rZ1nUB2rz1TNVJBHtk
X-Google-Smtp-Source: AGHT+IFW8nYRq5RslW9orcNSfpryuuQh9DlR9/BEYhQtuDzwzx2WPHAUsf94Mf5VkeMnxQVErOCnvQ==
X-Received: by 2002:adf:e384:0:b0:33b:49da:22e5 with SMTP id e4-20020adfe384000000b0033b49da22e5mr5438919wrm.9.1707748693113;
        Mon, 12 Feb 2024 06:38:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVMBx6pX3iHFC6P0W638qM/3/khe6nbblisHCA0LrX2aZYug4YqKzzMmA0H0oenvFcHvjbcZJZXS7YaQqunuae84B/rkh2OujzcCW7vlRKUtrriGZ61gOFAFxAC
Received: from ?IPV6:2a0a:ef40:62e:a901:386f:d8d1:628a:e68d? ([2a0a:ef40:62e:a901:386f:d8d1:628a:e68d])
        by smtp.gmail.com with ESMTPSA id j10-20020a5d618a000000b0033b53d34eb2sm6967069wru.40.2024.02.12.06.38.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:38:12 -0800 (PST)
Message-ID: <040f142c-7ee2-429e-88eb-d328b01a4b8c@gmail.com>
Date: Mon, 12 Feb 2024 14:38:08 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Interactive rebase: using "pick" for merge commits
Content-Language: en-US
To: Patrick Steinhardt <ps@pks.im>, Stefan Haller <lists@haller-berlin.de>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
 <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
 <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
 <ZcnFl8kypKRYeLo3@tanuki>
In-Reply-To: <ZcnFl8kypKRYeLo3@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick and Stefan

On 12/02/2024 07:15, Patrick Steinhardt wrote:
> On Sat, Feb 10, 2024 at 10:23:16AM +0100, Stefan Haller wrote:
>> On 09.02.24 17:24, Phillip Wood wrote:
>> Yes, I'm familiar with all this, but that's not what I mean. I don't
>> want to maintain the topology here, and I'm also not suggesting that git
>> itself generates such "pick" entries with -mX arguments (maybe I wasn't
>> clear on that). What I want to do is to add such entries myself, as a
>> user, resulting in the equivalent of doing a "break" at that point in
>> the rebase and doing a "git cherry-pick -mX <hash-of-merge-commit>"
>> manually.
> 
> It would be neat indeed if this could be specified in the instruction
> sheet. We already support options for the "merge" instruction, so
> extending "pick" to support options isn't that far-fetched. Then it
> would become possible to say "pick -m1 fa1afe1".

It would certainly be possible to extend the sequencer to do that but 
I'm not familiar with why people use "git cherry-pick -m" [1] so I'm 
wondering what this would be used for. It would involve a bit of extra 
complexity so I think we'd want a compelling reason as to why 
cherry-picking merges without maintaining the topology is useful 
especially as one can currently do that via "exec git cherry-pick -m ..."

Best Wishes

Phillip

[1] I did a quick web search and the results all seemed to focus on how 
to do it rather than why you'd want to.
