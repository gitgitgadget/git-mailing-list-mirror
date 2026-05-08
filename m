Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028AD3E3DA6
	for <git@vger.kernel.org>; Fri,  8 May 2026 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246150; cv=none; b=tVb6nJQc/GSEGe+E6iE+V/vwLHeNm+IP/cqpqDPvmMa1Hiptm6tBRme04WMC9Z6UmuwgtiMQKnMbMJdW/PdHsxUP833v7semDlnkU5D5BFotdTC+NMi+hDUU5CiCFUlWuRN4UBv8KcjXHWAmvY+QzouyC0JUuBeN/BPVv5ksrO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246150; c=relaxed/simple;
	bh=CNy90Z+087x10ZP7zqGfTfYufBvyWNvPWUER+YXL01k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DV7HXlcIwrz+YWlPuL0i0WbnW8Q8+8IM7/fmRLfd92mdYr6ghZHy/i8u9goq+kvAFXXwT6BAs1YcJKi5KOeoswXXSRkkgOH5FhU+Y007/X9Db3J4jAgESSEf1LBpq3CMh6III7QFIAQkBoEl+OMD+ZrryxCebKeV4t55I/NF9cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpJhl5KF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpJhl5KF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4891b0786beso13999135e9.1
        for <git@vger.kernel.org>; Fri, 08 May 2026 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778246145; x=1778850945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Foys3rTgv3uzGQVeyeLcVP3t5AFbwkVt+jkc1xeAeXg=;
        b=VpJhl5KFsJho4GamDlSEe/MXxcEi5im5NGTau2TLT2rd6C5mSsKGuIluEQ+MKfFj4l
         C/zZ82/Qzs1CzWy3mdwT211uGQOAlRg8bhOPR4No7lrCDPgb5Jir8TnL5Nie23hmY5tB
         wlXDx7Wx124wGdFHgCMMLWukDpufV3BfUW+SRKJvqa0C1B834wcA7pINgwpxQcD/V3fL
         G1YMLuZmWuPe7Tg8ufQTH7eb0tCGwMZORIjQetpTRyw0xdBpjpgsmpPox7R18Mbbv9gD
         6vVSBt70VR2q1JCUhDlOl2jx4Ej3v6IsuSJQ0E9qsnke8MwqsRH0hOv4kSfdYw/54tSm
         qj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778246145; x=1778850945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Foys3rTgv3uzGQVeyeLcVP3t5AFbwkVt+jkc1xeAeXg=;
        b=CQJgf1W9M6lxiZB2wBGeHMbuLB7mXG7a94mgwPVPS1fDDJ1aI4kf5qW/5kOR9yRhQU
         d60mEGQWaDmN6WGKWh8N0y0soy7Pkkrd6i+oobyvCIHkKSUQSweOrysAZqld6aiCZ6GJ
         KrGTotxZc3NAx422vy+l/YsT3NoDMF0elqIG/gWm+vqrbRyrEvePDaMhYEdW6gwFeM+6
         77J2kNju81wd90t0+cCm50gjWSCWtTF792ExmjXYnMbzMpRW6+O3WidHcNpwNsku74ap
         tD/a0rq974S6Oy7BIZ6sR4cbVwPdpWpGp4ADroo2KLtVvWiAxPhkMe+sKlUg2ifXlBJZ
         626w==
X-Forwarded-Encrypted: i=1; AFNElJ8+qmVM4fS2EdygiehBtLtXzLUmLda+jXzuWhLNpHkJGsYw1w6/pENx0xGU/VAbndNCRoc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFURKTyPod7I5oQpgOfBjg3uMq0ZO3rd0ZYVKG23tvWU717Sfs
	gy3k/LU5scyxQnIu9yvS7v5yY9tPKKUjMUOKW+y1sEMdfb1GZRxuF8x+
X-Gm-Gg: Acq92OHLzBQcAh067xYADwVx+9n9SfvZoxT//PdBXuTGpK8CsGnQmfa6hbJpKBEV2AC
	p9Ypvkl+dFX/cuPA/5u564V8sgQM7mBxq4x/IQxb74Iqngllc3cH0WxFozAfFp+G5Z3AaFmArGX
	P/bJddj+1VnChfEKT2RTwJ54C/tb9Mat1+UY/ywjaekP/q00NathGWk/z+IlCyelKgiTuVZE4dx
	R1IF/Yx0C3ilGzVGylEOmqMBAq/gVeGbWa4xYt2nskechNrJ+u7kVZdrYV2HzTGx/We6T/2nUTt
	RtbrIH1oQzTDLP1oEFEBi1H8XQsacje9EGCeBXc57pA3B26sTpzWPgiUgXibXevbyhXVqgFc2OV
	O2WjtipeYUtqDiBnl309AH5W5jd0j5weYE83RLYLaElKmqJIxj3yEf7MCMMtqT8hDvtyoLT/Kkb
	j/aQlqXKpIMt8hiJ5C12folea4WsQBZXalpJgjxt8mIG1yQJ4TPetLQNyLG3gyn1AStBkZA/Jlt
	0ERI3HX0TDabNkN8sCbhg==
X-Received: by 2002:a05:6000:2c01:b0:43e:a72e:ec5a with SMTP id ffacd0b85a97d-4515ce1c804mr19962236f8f.20.1778246144470;
        Fri, 08 May 2026 06:15:44 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731? ([2a0a:ef40:76d:4c01:4d98:a9b5:d032:1731])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a73c3sm4745337f8f.3.2026.05.08.06.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 06:15:43 -0700 (PDT)
Message-ID: <f23eb128-958f-475f-911b-eac4f6daddff@gmail.com>
Date: Fri, 8 May 2026 14:15:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Harald Nordgren <haraldnordgren@gmail.com>, gitgitgadget@gmail.com
Cc: ben.knoble@gmail.com, git@vger.kernel.org,
 kristofferhaugsbakk@fastmail.com, marcnarc@gmail.com,
 ramsay@ramsayjones.plus.com
References: <pull.2281.v6.git.git.1777847487823.gitgitgadget@gmail.com>
 <20260507201253.41428-1-haraldnordgren@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260507201253.41428-1-haraldnordgren@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Harald

On 07/05/2026 21:12, Harald Nordgren wrote:
> Is this ready to move to next?

I'm not particularly enthusiastic one way or the other about adding 
this, but so long as we only try to fetch when the user explicitly asks 
for it I don't particularly object. However having had a quick scan of 
the implementation I have a few comments

* "--track=inherit,direct" is nonsense and should be rejected

* currently "--track" has "last one wins" behavior so
   "--track=inherit --track=direct" behaves like "--track=direct". We
   should probably keep that so that "--track=fetch --track=direct"
   behaves like "--track=direct", not "--track=fetch,direct"

* if "git fetch" fails and the remote tracking ref already exists then
   we should print a warning and carry on rather than dying which is more
   convenient if the user or remote server are offline.

* "git checkout --track=fetch origin/branch" should respect
   remote.origin.fetch so that we fetch the ref that we're going to
   checkout. I wonder if we can share this logic with the code that
   sets the upstream branch.

* "git checkout --track=fetch origin" should only fetch the remote
   ref that we're going to checkout, not all the refs from origin. i.e.
   it should read origin/HEAD to work out what to fetch.

Thanks

Phillip

