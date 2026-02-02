Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6063B9
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 18:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055491; cv=none; b=dpuw3IDv7kQFfXXF1mrz3TQh75ftnBfVAiXcVIoLEqISKGFuA2iatWHJKO94Zi27LCt35fplQV/TFQSf/y5/7S5yDPChwxEyUwB0PWLJtQjGfs57BntHt+qCN2LdId/HMn+SvgJJA1skh0TCWKgbNV+d9msWBARSKHtVVBHNYvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055491; c=relaxed/simple;
	bh=7QPvMSBpBp88bBpB2UGDdah3NI0v/cz9//1gtT2dgzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ctRUCr2xQaSgb9u+9AjE8P/CykD2iifO9GcMLl+KS+pw9XLBK2xuZuhIgol11UWg8/EgU3PYZOPCKGzc/6xuJ7qmaPqFLu3XSIa4p1PM+GPka8vqEV/yfrQEWdlisGVA6ELBA8uK6g/3zHJaw8B9cSfFCd5/oaF4ULijH84MiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISF3EFj8; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISF3EFj8"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34ab8682357so211930a91.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 10:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770055489; x=1770660289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gjyb2DZM/hLqpImIY6srFeau6293rkenUgrvNpuZk+0=;
        b=ISF3EFj8dbYUd9SS2jTiUnxNd2Ww/3VhXn/qNOGJLpbqLWHUhrr+rZ+V5MXo248OkO
         NLcC5AluvTAe6dX1e7YWwEkVurawjL8ZeWQ2NJv8jgWV2PU0O6cGWbyNh0qam2duLDmG
         W4QjzKMKODXGWNYjVh3Q/7ZLXPGffo+B8bQf2jRnMLupW0dPwoq1DqC6EuONveLb+wjx
         ka0kdC//F5a9h2kWcNzUx+P3SDZf77dDNzLSmHOUQhJgilCzq6fetu7dNBqez+1biJsp
         9uvwMZE9kc/+TocLm18eM/9sUcdU6bETXA4+w27IqjwtJ4++NwShHn39UgI858oMw8iJ
         P+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770055489; x=1770660289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjyb2DZM/hLqpImIY6srFeau6293rkenUgrvNpuZk+0=;
        b=maK1ROA9H9WSjzIGY++KEif2n7UB5/T9xXsJxuGxMFOBCRqdDCtZ/iJN6tHVzowaJu
         AhRAUxE0sgi2vfWBJWDgXp6bp99Ldb9sKYu4EL6hi3qZ412BcqyXceIACdJRbNP9hUsr
         0smSfrzVLOClKfnvxTUyxmTduBS80GOHKg8rh35yUNrYNcMZR+ScPNLFCHUDKZ029WGC
         E3iCNQj6muJ0Vb63Jk5k+f4LBxg2yLVVZGsZC130M35ioHLkYPMwbCRCTfbPID/22iy/
         I2jrH9XTJ6vjMopI7m+kfXWc9AOUs+oSLXj1M802O+3ehmN6y2MuWre93ynVUXLPx0cC
         p8ng==
X-Forwarded-Encrypted: i=1; AJvYcCWN7lmKObqIFRk01rWV/A3W4lChYZaSMfU3GOPOppP4DP5gCLQc1htICaSTmcRG75uwSXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww+D3j3FHPc7TUuEPbQDTyNRLWxNwYAfYgfilQyGp4IG9kSppT
	Xs860Zw93xnElvqrneFr7xRFGnErHl8Aj0yPN0pvOHFujh6FK/rPicPs
X-Gm-Gg: AZuq6aIH1GZk2I6bcib6dC9wqVGA3kwj3fwliX05Jca7jE1d4CuqTVAgkaZcvV2OSfS
	tf/58si3/dZV3KSkyOCeQcf3w9ubXZaV1DT2PMGNjtTod3H4SMqPs30XVsLGgi3t7CxnxhhpBBP
	bwazdmgCQDdv7NZmRIvx9qokkGgN83H+mxZR2iuMFUA7LoY0Mz2giV/t9DMM9IQuS1exHBTmx9O
	0Qo42d7akXS25Qtie0sKn3K6qNdp25RY+xWWIszON7bskQUNc30BL8OQJTR7KQJKrYmzn9aWe8E
	p//b2ebnPzb/AtrnAdcBibBW0dExhvhzogojRRzGOJVzYaPteMaZgfpfuuNqzHGEC+ioDvCQvAE
	kPuRB//ZRQYBcBQoE9px1PpuHa0ckGV5G1FwnyJP4ER7Z7vzLOofk0gr+p5COQruYLo+Om5kTb6
	rmAn+loMmW1WPGgmk=
X-Received: by 2002:a17:90b:3f88:b0:340:e8ce:7558 with SMTP id 98e67ed59e1d1-3543b18930bmr9555872a91.0.1770055489040;
        Mon, 02 Feb 2026 10:04:49 -0800 (PST)
Received: from [192.168.0.106] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-354776154f2sm131561a91.2.2026.02.02.10.04.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 10:04:48 -0800 (PST)
Message-ID: <1d560aa1-d452-47f5-aaf2-4cb1ccdab100@gmail.com>
Date: Tue, 3 Feb 2026 02:04:45 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug: git add :!x . exits with error when x is in .gitignore
To: "Remy D. Farley" <one-d-wide@protonmail.com>, git@vger.kernel.org
References: <20260131194309.601838-1-one-d-wide@protonmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260131194309.601838-1-one-d-wide@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/26 03:43, Remy D. Farley wrote:

Thanks for the report and the patch! I also agree that the behavior you 
described seems like a bug.

However, though I'm new to git community, I still have concerns about 
the fix in 'dir.c':
   > -	if (!pathspec || !pathspec->nr)
> +	if (!pathspec || !pathspec->nr || pathspec->magic & PATHSPEC_EXCLUDE)
>   		return 0;

I tried to analyze the logic and I believe this patch breaks the basic 
functionality of the negative pathspec (:!):

(I didn't check the caller of exclude_matches_pathspec and I only focus 
on the function itself. Tell me if I'm wrong :)

By returning 0 whenever PATHSPEC_EXCLUDE is set globally, 
exclude_matches_pathspec will report "no match" for all files, 
effectively disabling the exclusion mechanism entirely.

Instead of fixing the issue with ignored files, this patch causes valid 
exclusions to be ignored.

We must check if the specific path matches the exclude pattern, not 
short-circuit based on the global flag.

It will be great if we set a test script for this. I will be working on 
it in the next few days.

Regards,

Yuchen

























