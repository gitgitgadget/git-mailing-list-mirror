Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444C2238D3A
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757446531; cv=none; b=UIzonhApzDksPNc8xeOyTL5NSib4AqNgMrWyTKsc7hSiNxW5dnDr/z3JNLOsESAF8S1Kn4wDQlGUs4hvyljAiDW5nC6ZzGrqThsC/648WLOG/6RhvMa6HEWj1MPzMZNSihKrMdgewZa8cuzE42qpo9tqb3k/k2C1HRzcllGTgsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757446531; c=relaxed/simple;
	bh=ORCu9UENJ8THaBb/t8Iuu4M5rDUS/v2UixGBHCscfyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tt6P2J4q6dvYJMfgRxrPyQWrw0Bv8jVpiGrNdjPuu2RHHK+gDS2sUQEJQsb0e6zcWI4FSzQdF2X9wy3wTG6bobhMFbLYzv5xzcySklb7QmunCJ7KS0HjUKz4R3PzAg04cwd/rTU3jie1b6fnTzO3J9aVesncWubVc5Kx3dpCe3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjbA78S0; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjbA78S0"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-726ee1a6af3so66526456d6.1
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757446529; x=1758051329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OAyzlyByjEu8Ob36fEkOIYUcE6d8DCup59/zOGPqebQ=;
        b=TjbA78S07AAjiLEzk7x0h3yUW9jZEGp7vNN+FqXOAwPqhdCagA/bul30e1pAPvPVkw
         s0yHDRmpQGIG3L0M9LSlfohJIB0IpEPD8u51uNnNur7Sx4dF1lGpaU2RyLS7OC7tCcAr
         QEciMnc5URgPz06+XB9FYK9Gl0qTkcX9PUMGDdr/8T+FJNHwaQBkdC+ZcUL0V1GVI3/+
         gCWTYoxxoFv4w5UMsvtfloIMWXbvN0g+AurWx/SfWIVWYq7V0129gABaGJfQ8bONkQFF
         M3o1DfoW6o15lnoYepgKDdYqWfLWV1vrxV0bETPC5S0iBqxaGpWwn4J+8zIRZ3zu3GBC
         +rWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757446529; x=1758051329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OAyzlyByjEu8Ob36fEkOIYUcE6d8DCup59/zOGPqebQ=;
        b=N8B/nmsNqPz/xvIrRsqj24QUWPceQJL80Eia/WwH/ri6PsMT4ysvAQAQm1hFqIOlSR
         hTxNcUC3j/oNAmLV7Pjob+SABI5K7SIiC1g7DZ1Mpy9baqIFL5Gz7BJ1LikoSBnW/q9w
         2Oi6cJ9k8u74NE1Doys2ZG+uNje/8hJO2bvDyhR8iUPkLL0Fuv2nyz00TWTs9dcnJu20
         +tEi3MGMTh/98+QETz1qKj0DPiCKIXaR/FY8cZVADtkdRpM8lchG2URYBPeIddo2miLA
         4zcDJZjI1Bqc+X0spr67/LnUUHQPYXbD+bmuc0z6O52PzlLsOJqbuqEw9WKUrrgtjcx/
         fY+Q==
X-Gm-Message-State: AOJu0Yx039IwphI2yIxbwzp5RsEBGg85h+CgknxK/MnumgLrag9em3Bt
	aI28GKXsvjWnTscjuLAhFhoaq+n1MFg8tWWzw7Wir7FG1UzFx7KcvnhA43/yqg==
X-Gm-Gg: ASbGncslFtuVsx7mc7zn6BcnZ5FdLJGUKFTzAIXiuirb0I8RUPzA69Hzz0zUxjUo8J5
	EvgBKwahJTeqaBKFxZpZEYCs9+wyUBfDxWeXer/ZDJYeHyj5YLIKwlJpBjWMxk7R18HVFfiIOfk
	TtBKOy+LbkKU2PvS+lQ8MkCH+Ft+4HJoeeATBiu3QvqiiRbpstlhOw56BPKQuinlp61KhJMdVjN
	0aNYmlxdawYTyVLRXJhUrdqXiXRZgLL0wAMdH3B1xxALMKxE6Ty9oFz7QP6Izxy/OV2qzxC4Vtc
	nTS2JRlSYs5mtXD1330esNPFIF5uWCbSEjojs6yoQICgQX+DmfO0RF+c8Dk814K2ZG9WwoKHT8v
	mvGLoysyEhqbljMxEAUAaDLAcHNd3FFQ4Hab9lnejTtGP2g==
X-Google-Smtp-Source: AGHT+IGpiw292r7+LJ2FLDZd0b8GtP3EcW/cXpRns3G+r8F+19nPidR/LLzENo/EWdFt9TPOSTDNPw==
X-Received: by 2002:a05:6214:5007:b0:722:429a:f9a5 with SMTP id 6a1803df08f44-739435ce90emr110181706d6.65.1757446528687;
        Tue, 09 Sep 2025 12:35:28 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-73cdb176b21sm72874806d6.72.2025.09.09.12.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:35:27 -0700 (PDT)
Message-ID: <e76a86b3-f913-49a9-a886-32d8d3baefb4@gmail.com>
Date: Tue, 9 Sep 2025 15:35:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: What's cooking in git.git (Sep 2025, #03; Mon, 8)
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <xmqqjz28v21e.fsf@gitster.g>
 <CABPp-BGxzRmkqdkpsVE=b9hQUsA9QO8iTNL=Wan1Vwatq5bMMQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BGxzRmkqdkpsVE=b9hQUsA9QO8iTNL=Wan1Vwatq5bMMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/9/2025 2:58 AM, Elijah Newren wrote:
> On Mon, Sep 8, 2025 at 6:38 PM Junio C Hamano <gitster@pobox.com> wrote:
> 
>> * ds/sparse-checkout-clean (2025-07-16) 7 commits
>>  - sparse-checkout: make 'clean' clear more files
>>  - t: expand tests around sparse merges and clean
>>  - sparse-index: point users to new 'clean' action
>>  - sparse-checkout: add --verbose option to 'clean'
>>  - dir: add generic "walk all files" helper
>>  - sparse-checkout: match some 'clean' behavior
>>  - sparse-checkout: add basics of 'clean' command
>>
>>  "git sparse-checkout" subcommand learned a new "clean" action to
>>  prune otherwise unused working-tree files that are outside the
>>  areas of interest.
>>
>>  Rebased not to depend on ac/deglobal-sparse-variables
>>  Will merge to 'next'?
>>  source: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
> 
> No, please.  Responses to review comments are still needed, as noted
> over at https://lore.kernel.org/git/c3c0fbef-f395-4972-8352-dd89af6799d5@gmail.com/

Indeed, I am delinquent with responses to those review
comments. I hope to have a v3 this week.

Thanks,
-Stolee

