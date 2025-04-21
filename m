Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5432110
	for <git@vger.kernel.org>; Mon, 21 Apr 2025 08:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745225168; cv=none; b=WGOeo6Nx8ZFdvoAopdL/IbqFv2ipRnxNZqRlZfUzD4AtoP5diH4Bi9XEBNO8eCdS439WO/amYb4v/dETsY5XArXSuTfHPgwpUpuI4cb002bnItQfVcYAJlS7X3Dn0SE7yo6t3G9B8+es/jRZMpc80YbtMBItNL0O8Ug4m4NEpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745225168; c=relaxed/simple;
	bh=TzGPH9y9PqafrV8Lebadk4tGtLTPJovgBD0IjwBQPAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O5G8lIrP2CyIbTiRMgPobGND+Rcki4RP/Vb8SBPP7/06+GbomMZp0p7qQvVYjWr6y+Fdnyrh9XfSm1zvamU2yZqJq0NoqoJjeh3xHmzqg6N48BrlhRkCbBCqzj2a6KaM09BB2xcZfnTgNOdCEw9ahkGIkE7PRNogav9I+6iY9+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW/rDtAp; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW/rDtAp"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso2284069f8f.2
        for <git@vger.kernel.org>; Mon, 21 Apr 2025 01:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745225165; x=1745829965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Pni0GyP99WX4LZ7F3hmdtpVKdRcLfrWaHtx/i6xRO6o=;
        b=PW/rDtAp3RWmx3zgVavXjThTaE7LBgQVdrvEFgynvs/qUQ6O88KloCMM5/GsbvavS0
         a9E62oCTZuD9WhSLKf8ZHBafcp0l5bLRM/cjE2b0fxRPTYW/TB/w7pj+6b9lZVyaTiae
         ZHAVFV0xvbYzvcSd+hgcE7hT4fRvFPoJrnOWB1QkYVzm1od+qGn+7xOd+hxAyVgf6XDR
         2i9SmT5U0qLDoyDBw4VnOe4RMOvPv8tHEKcLOsk6LMgLdZna/CJzn0JlT3WTFRJyusXY
         M0cxpoomkD4ZfCFgx6A/C8rD+aABSpuK0y+kwaEaDpCtDjLujPhkLUaT9a7VqUu8CFH1
         guPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745225165; x=1745829965;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pni0GyP99WX4LZ7F3hmdtpVKdRcLfrWaHtx/i6xRO6o=;
        b=Euhf5ENhgn5nIvar7ATk3/x4bKlhQU5Ewo2ZA+m6s7hyqCFmSsFYYxS8Tqd9nHGSyT
         s8UhFKUC8CoTa4y4CDgf1ltCdNLG3AA3q6IomiM9RM/oMme9ZJGBtvrs6gaIlRNik1xg
         /CEGtICv82lZgebaFj6HLv5Y+U7kSle7S1rVoz+BjrQLV9U/K6wrnllZxRrv8wHTXQb2
         Z7DNgy8zulwhaOR2ACxyLJlmx32jERZ/fWq0ciOZQVR8cK7eR+Nxm7YtXZhiGyvaU2Pr
         c8RQFTUwbcUGn/cSbSA0z/RfYQVg9XjX8tiqFpvNxbnl7/8wOlDESEC3oLAZ6b4UWvnS
         kZHQ==
X-Gm-Message-State: AOJu0YzfDNYlc3N44pOdjs0JLcz+Hl7sTbsT/KA/2ik+CICsoC8Szi8Q
	8sVp9gKQbbwQFJ9GJXta4aQuUveqrIWEQOJiHzd/hyDDfbio63lo0liXXg==
X-Gm-Gg: ASbGncu/Cw0eKp+d9IzuNY60tORZyXyRcEjJoePdouhcbuUaAwG4PO2sCL2VSXVsEI6
	VVIHJj1KQS/gpkfN00gsLnZLYe6ks7lFw/pmqcVvmqLS8dEFmKt34/GIEBvdjENcVLTw/vgO6Er
	mJ8E6cP6xr8xDT5DH9PXChn5AbpI6jxxfpKmQYwcdRBn7/Dts94+xSZbHddZgjVR9t3TuV7A27S
	SQXhuclRQCmVWNc1IYiiBmbkbj/miY0V+myFw7OaLnGFXBeHre+uUwItgHPegLig0wWjJWHUlo8
	Bp8IZY1+I6ZE/V3nyipoxwelI83deYCNkSL4uUv/Jkw+/clAxNvxLxv/whHDaEL+YUJWbxlMv9u
	IA1FPGb40gEulEnFU
X-Google-Smtp-Source: AGHT+IFS6LFgJf8rzC2CitVJls53Grcmc/3h8IZ8egvc/N89ujY6XCTtLXZvYbzre0WcR3FLH/dfKA==
X-Received: by 2002:a05:6000:2913:b0:390:eebc:6f32 with SMTP id ffacd0b85a97d-39efbaed7b6mr8410899f8f.48.1745225164446;
        Mon, 21 Apr 2025 01:46:04 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5cf313sm126182365e9.30.2025.04.21.01.46.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Apr 2025 01:46:03 -0700 (PDT)
Message-ID: <8b380da4-8d27-4efe-85fd-3bb599188fe9@gmail.com>
Date: Mon, 21 Apr 2025 09:45:59 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 0/5] meson: add corresponding target for Makefile's
 hdr-check
To: Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com, ps@pks.im
References: <20250408-505-wire-up-sparse-via-meson-v1-0-17476e5cea3f@gmail.com>
 <20250420-505-wire-up-sparse-via-meson-v4-0-66e14134e822@gmail.com>
 <xmqqh62i6jli.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqh62i6jli.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/04/2025 08:48, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
> 
>> This is based on master 9d22ac5122 (The third batch, 2025-04-07) with
>> 'es/meson-build-skip-coccinelle' merged in.
>>
> 
> Like the previous round, this round also seems to break linux.meson
> job at GitHub Actions CI when merged to 'seen'.  It may be quite
> possible that it is caused by some semantic conflicts, and help to
> find where the merged result is wrong is very much appreciated.
> 
> For now, I've ejected the topic out of 'seen' again.
> 
> Failing CI run:
> 
> https://github.com/git/git/actions/runs/14563669225/job/40850047961
> 

"git ls-files" is complaining that there isn't a git repository. Looking 
at the output of the checkout action (reproduced below) it appears it is 
extracting a tarball rather than using "git clone" because git is not 
available. I don't know what the best way to fix that is - I guess we 
could run "apt-get install git" before calling the checkout action.

Best Wishes

Phillip


Run actions/checkout@v4
/usr/bin/docker exec 
6334961fdc01ddadb7a7af1fadd8ae33a6fce79b7428255d2231145f5e09f51d sh -c 
"cat /etc/*release | grep ^ID"
Syncing repository: git/git
Getting Git version info
   Working directory is '/__w/git/git'
Deleting the contents of '/__w/git/git'
The repository will be downloaded using the GitHub REST API
To create a local Git repository instead, add Git 2.18 or higher to the PATH
Downloading the archive
Writing archive to disk
Extracting the archive
/usr/bin/tar xz --warning=no-unknown-keyword --overwrite -C 
/__w/git/git/23521f8f-82bd-4a9b-994a-cacfd7101756 -f 
/__w/git/git/23521f8f-82bd-4a9b-994a-cacfd7101756.tar.gz
Resolved version git-git-c9e21a0

