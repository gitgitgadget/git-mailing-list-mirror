Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0840114AD0D
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138803; cv=none; b=DPjEZ5F8ZhNzUSc5Les4mRl0ygAtfVuIOAaRTc5iIGYbSyF8gmnrSz2+JX34rB/eDRXqjF7Fgztq5715lHPZ7sIt5ksXJ/aweAJ5ZjR++smUJA0Y4eJ14ZX6DbuXtpZV9ITua2tTp9ZGG6CzjTUIh9HpmzYcv+JMqduIo5/gyl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138803; c=relaxed/simple;
	bh=1UQgj5BvVlza6cU1DtSgazohdDMWxEIx655wKDp1d8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QMXqaix8+n1eSQFvl/cRIUGCPGSHJGhxe13jQSikBYSuQmWJwAO44MKEysf6XTuU/EPA8hxfSt/grqT5Oisdu+KrhmhuMKud8Q7Ci9Qd3qnO74wKZbczjX9nj+8SZ0cgJqHyS9LDiyjjuKNGsj6W8rkhvchzV7hKcC0ZCn7Wnp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGYmhonA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGYmhonA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4852ff06541so29888865e9.2
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:33:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138799; x=1773743599; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bY7DyI68GL3u2F0aZtRE1BFHlu2lodiPQJNq39eIPyU=;
        b=kGYmhonAf9a93wrIRET9QKKMM/4mFuojQml6Xjyo59+szcl/YK6HF81U5A8D1lv+Xf
         DSZTZ8ccqF+tmrIS1Ek3hERm/wUmh3AY9H0M3SgpBmfESjp6TuaIWlwt6BxdRGhc/+Xs
         TgonM5AoRG2taXrEbx2IbbUxwt0bBcuvWY9fInDt0KxwNq58sXrCXlN/lAU90Coxs+0y
         mCjGTxZRCavR4Ht8Wm3MyxiKZQV6EjoIgEbUejCDi5CAQJulEhB9Six14+8W5AJCtSq7
         b6t41AII0xje/7kepMibtYXpeAOcw6pkWOnd73Q9Qyzl3+NZsMTdOesKtjRsma/je0VZ
         AiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138799; x=1773743599;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bY7DyI68GL3u2F0aZtRE1BFHlu2lodiPQJNq39eIPyU=;
        b=RbAN7TWOcFOrEoXN6KX/DG1P6w3BJEpl3ceiybQpeYSTVX1mz7UZbN6MayD4OfGmz5
         kC7BTqePsiyeAgkBTSUPGxafoKBFd1ZLkVH/vWW9fQxxAxmPQmcUVPxioGOsZR4DqHc8
         s8qn3NkVpyfuEsgOws1jiExx8wT532H5GVnOKJRJsEU7stWPbOPdZKTN+NwpoRJUF7ZC
         UYardUZR75YK8h9CMxPZh6DYV532hSnLwKinFBW68SPPFykdjuTeQ2F8zIdTyAdUEkyE
         iTn+YYm2SoMr1L5xx16l5QRTnJRFMbKoTuKLAoyNr5iQ2lKYWZVqy8cL0zjcr+LfLbgS
         zwZw==
X-Forwarded-Encrypted: i=1; AJvYcCXEw/i+KAWW796RsX9yEsJdn3xSj28qwEfokjTUgwtv5Gyey4PSciE67UdbyQRPtHkJWsg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7JtoPkrtt/ZDrDnT0nKZQaAqqbAkjkBHX1HIAlMMJ4dy9b1e0
	WapQvWp0w8RQ4O8C1S0ff6xfaPjV6NWtrplQhc+lg8WD9X5HqteZG7zd4KCx5w==
X-Gm-Gg: ATEYQzwRGY/DTkxgpOxZad7pSk5Y+5xeuZi4SQ9xOqOkNXS9fFRfm1RWDv9opvUB5m9
	grv4nn3zMxLCAJzwCtclD7oWbkDBZBsRMm11Qe1W3ThdIBkgvsay9BGOdwksHPI108pzaSaoq9N
	80vdn9zKGdgiK4/VvigBsyAuAlVjFsr3+K9cfZJY5j9OkHmG62Ss2r49AvmPQ+6+rZBUmr+1NWI
	BNPE2JBn8WZnraAuc/1JdqpcweWsp1/rZGotf6KbI4y/FjJ/aUORw7DzVnOYILPJAH9Eo9DEkn+
	iVP789HNzkU9PUhe7JCiTIVrPcGf2o+hFt2NGdmg6HeAmszRjRn6fiduNnRf49UMebk0lvRJBWW
	ghbFfk03N2TC+eIDzH2CDe2dbFlKhXMEIwbvDmjO0EbH3f/JbmLWgPeho2HJbmoiZjkM0wRB092
	uuHwoy5La+BEGVLvNlCCNfOH/kMBJKCqOeUDcSMS+9jDw0Vzns4ax0hFLzyK1EsYELuhJ9fSbd0
	DOmFw==
X-Received: by 2002:a05:600c:1386:b0:485:3dfc:57d with SMTP id 5b1f17b1804b1-4853dfc0803mr87723395e9.30.1773138798763;
        Tue, 10 Mar 2026 03:33:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485237e8095sm209978285e9.2.2026.03.10.03.33.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 03:33:18 -0700 (PDT)
Message-ID: <5f100fe0-d601-4ee3-adb9-a2458203d10d@gmail.com>
Date: Tue, 10 Mar 2026 10:33:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/5] Advice on checkout dirty files
To: Arsh Srivastava via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Arsh Srivastava <arshsrivastava00@gmail.com>
References: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2233.git.git.1773132678.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Arsh

On 10/03/2026 08:51, Arsh Srivastava via GitGitGadget wrote:
> This is my submission for microproject [GSOC]
> 
> This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help users
> when they attempt to switch branches with local modifications that would be
> overwritten by the operation.

If the intent is for the user to carry over the changes to the new 
branch then recommending "git checkout -m" might be more convenient 
rather than having to stash, checkout and unstash as three separate steps.

Something seems to have gone awry with your branch as there are other 
patches in this series. You should rebase your branch onto the upstream 
master branch with

     git rebase --onto origin/master HEAD^

and then when you push it double check how many commits there are in the 
summary of the pull request before submitting.

Thanks

Phillip

> The new advice follows the same patterns established by existing advice
> functions such as advise_on_updating_sparse_paths(). When triggered, it
> lists the affected files and suggests using git stash push/pop to save and
> restore local changes.
> 
> The advice can be silenced with:
> 
> git config set advice.stashBeforeCheckout false
> 
> Changes:
> 
>> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
>> "stashBeforeCheckout" to advice_setting[] and implement
>> advise_on_checkout_dirty_files() function
>> Documentation/config/advice.adoc: document the new advice key
> 
> Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com
> 
> Arsh Srivastava (1):
>    advice: add stashBeforeCheckout advice for dirty branch switches
> 
> Junio C Hamano (1):
>    The 13th batch
> 
> K Jayatheerth (1):
>    repo: remove unnecessary variable shadow
> 
> LorenzoPegorari (2):
>    diff: handle ANSI escape codes in prefix when calculating diffstat
>      width
>    t4052: test for diffstat width when prefix contains ANSI escape codes
> 
>   Documentation/RelNotes/2.54.0.adoc | 14 +++++++++++++
>   Documentation/config/advice.adoc   |  5 +++++
>   advice.c                           | 27 +++++++++++++++++++++++++
>   advice.h                           |  2 ++
>   builtin/repo.c                     |  1 -
>   diff.c                             | 12 ++++-------
>   t/t4052-stat-output.sh             | 32 ++++++++++++++++++++++++++++++
>   7 files changed, 84 insertions(+), 9 deletions(-)
> 
> 
> base-commit: 3fe08b8fd1f7731edabeab8138547ec88d6407de
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v1
> Pull-Request: https://github.com/git/git/pull/2233

