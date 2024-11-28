Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666DA1BBBE5
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732808085; cv=none; b=JEU8TONBne7Etdy9OdxxH/NhORI6CzAO86vegAZq+RHCXPeAiYoFk8T9QCavpbfybXYjRa0MmD5af6ogD52YYGhzdc8cu1purvCv6Vdq8Im/fvy0mqT/G1eeUyjLZkZO4V1ZKyC3oXpflO/37ks64z0XO5vTSJO0L3kqbkD/jzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732808085; c=relaxed/simple;
	bh=yHBuniG6mOjmIFEJ/gsMxfcwSqMaC3FLB+lmqfDCXxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=q1UAe/dDVeydPknxfWWTraXWSEt6k5Hm81YGNr8prollkW6UvdsTSuBw479NxM7VPrdWLp4ljzlC32dXfctl4lNXOy8i0pv3zr1q3azxydsl8DR0wS0lK4mx8wiOR2YKj71SfIG0WW64AONbTKL7kVrSkKXxh/kM4SUy8WbJDiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkUo/FU7; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkUo/FU7"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434a1fe2b43so8468355e9.2
        for <git@vger.kernel.org>; Thu, 28 Nov 2024 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732808082; x=1733412882; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBhVWu6nWpGg+m7+N+tYXyzE2LUwrda6XkH4XAB4iuI=;
        b=VkUo/FU7feud1RDeyJ8xluXlK2JPKeZvqN/6QzmZfcNn/wyj6772PreakVGTX3ZDZc
         I6f3tAplTDGkE8xPYTfck8NW5yUdXf70jJVGVAmxxKA1xXmvDRnK+slxHYeWFCX7uqcy
         hFyYEPDIH+qeDkd5N8oiS9jidkcxIHLHkNeyOPvuj5XAx2YMaJVfPE5g1s5WmpKbs8SK
         AD4OtaEth44CfzpnMs27nagUPAcre8M79ed1Zz7ZBTTsI1eOC5pAFCPOz6lhwYxc9q37
         XaKa5ycrT/fcE467AiLgQo5tSK/5CjLG0SMXEGQFJhVYGw91ciNOBWzERHUO+TOuCZ5Q
         Vuww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732808082; x=1733412882;
        h=content-transfer-encoding:in-reply-to:cc:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBhVWu6nWpGg+m7+N+tYXyzE2LUwrda6XkH4XAB4iuI=;
        b=D0kUbbnuVDPbBbtKFNUNzBNWzu5DDBqRzF2VpAI7grcWdMKOYN1Kh+nSad7ePC0vD4
         yaxDcntIzgas1GhI8y7c7t4h/rW80HcbmAHe8Fz74e9Qv2nm3Bl3dSN6uDs+SyPI9n8d
         bzRZYSsM94MP4uCmGZNmDMfXafKBtDRqaT5LKIg/mNkffxQZz/nLhuSAzR6grPPPNoqx
         BYvBf+2F32sDQmXap0SPNuxjM5FaB+C5IzKjWw4GEWjIByYeTv3AAh2yjl4kFntmGEf2
         A3qpsh0Y3Fy8A6zowtW/O5iuL+yDF9SaoRNczvR4oFAD+9BZk8T6ZTmaiyP1VLB0Q6lz
         55tg==
X-Forwarded-Encrypted: i=1; AJvYcCX6OB0yJZPxkY44RPTGHw16P2HAxP8vA8UKflmVdmhjd2HtTJzOqpYa9HhKbdXFCFFj2BM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxe7jsVjoNZFVE3tTlrCnAHqREnF4td61XGR5WbIeRoOm7F3n2
	coEjwLc6xnQ7XCGuCMoosE7k/Mx0hiPHWZuYljuD2+dKlD5qgvCb
X-Gm-Gg: ASbGncuFPQDBHLOqfpPt73lI/nCqAhC5M8KVMmzrzcFmrVvewShTraKRjZwIyy1pVaK
	8UlncB6Rs+/OcDUUNmnUsTDQjIiJcvd1uNI1bvYEA8e6mQGzwR6zQzjO+/52EeZUts17pg56b6b
	7pKDYf35IDeFpHSIH3fnrary1WnHPMtwIJ1p9zFcoPrF4xty3T2QB8dj7l0eaO2wyIO0nbX5cu3
	Q+QPM6SUSIocjvT6YiiAdpFTyCfC8QKT+jwCvCOcZVenmBDj+zuA37/iNYVBIylS1lwUjBFa70z
	4WHJ2FBP+cOgtOfBAWStO1FAn1ye
X-Google-Smtp-Source: AGHT+IH2DXoy5Y4UI94pISL1qo90W1Df6wAKhjjDh6Olp6MWlv8saLdY2bpz15jQRZSB9kzVWzeOCA==
X-Received: by 2002:a05:600c:4447:b0:42c:b9c8:2bb0 with SMTP id 5b1f17b1804b1-434a9dbaed6mr74131175e9.4.1732808081361;
        Thu, 28 Nov 2024 07:34:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b? ([2a0a:ef40:6f7:6401:d76b:efc0:c762:b74b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7e4df1sm56520335e9.39.2024.11.28.07.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 07:34:41 -0800 (PST)
Message-ID: <fbda37b9-41e7-4b18-a831-dfb5a9a9c54f@gmail.com>
Date: Thu, 28 Nov 2024 15:34:40 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Nov 2024, #10; Thu, 28)
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq8qt3q5t1.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Cc: Calvin Wan <calvinwan@google.com>
In-Reply-To: <xmqq8qt3q5t1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 28/11/2024 05:35, Junio C Hamano wrote:
> * cw/worktree-extension (2024-11-26) 8 commits
>   - worktree: refactor `repair_worktree_after_gitdir_move()`
>   - worktree: add relative cli/config options to `repair` command
>   - worktree: add relative cli/config options to `move` command
>   - worktree: add relative cli/config options to `add` command
>   - worktree: add `write_worktree_linking_files()` function
>   - worktree: refactor infer_backlink return
>   - worktree: add `relativeWorktrees` extension
>   - setup: correctly reinitialize repository version
> 
>   Introduce a new repository extension to prevent older Git versions
>   from mis-interpreting worktrees created with relative paths.
> 
>   Will merge to 'next'?
>   source: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>

I've had a look at the range-diff for the latest version and had a query 
about the removal of a check from one of the tests[1]. Perhaps we should 
wait to hear from Caleb about that, but if you're keen to get these 
merged down in time for the next release we could just fix up the test 
later if it turns out to be necessary - I think the code changes are all 
fine.

Best Wishes

Phillip

[1] 
https://lore.kernel.org/git/054b70c2-accd-4d85-a576-66910d35a26d@gmail.com

