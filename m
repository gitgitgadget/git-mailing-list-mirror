Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED9E1DF25F
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772375172; cv=none; b=bQcpJBWnQh2VXPj47ooHouexg8tPpw1DUdK31jLTdXEMU2u/6FOnTYVnQfPynKOzZ5R7TcWftruRQj73a6T+ECjSFESC4LGAIIJ17kctvwUvF8/AYcam2TLKkCsodpbDbUiqz/v7rPPmF9/PUiI8TBEqNq2sB3POiaRlrk+ZeDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772375172; c=relaxed/simple;
	bh=bLaRzjSE1tWGfuZ1QUSlYcz3Ui4DfgdTYR179QKe/bg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=jRrXMTivWFCw/SuNSuV1gnZhXFlY5WlGR8Nrd6uYmDvIP8DihvSRjf8wPeEA9s6rqTxUHwxdBsXF6sA/HFjWk7RjmMbcyWSVd8cQz0p0/8PqKLxrDHmM7t2KoUs9tnX75q/WJfsa2EZkFEKNsLEv58H1amC1XZA1H+dDo1g/DTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bMWiygsv; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bMWiygsv"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439b5d78592so200252f8f.0
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772375169; x=1772979969; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:content-language:from:reply-to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6q2ZzrG0UjOyc92iD3ovW53FovZKWJ+e4xqUHAgl8Y=;
        b=bMWiygsvuNpuk3chNnqUJRMrOSjDneB7XYo8UvN5BdrZzinLElLmctzNHzCVpdwM98
         ZJIQH9H93mZT/m303kPgQLEzae5GRL4qdJ560Q6oidWVLGCYEUKXJe0dFfr5UeYgrb9h
         umHaV8Jt/UTcQXFo5gAyJQ4IQ9F2bdELYoCWYdTybnzjxSf2rm3bsXikJlrsa//TIykf
         Bi7l1zjwbuLV3w7OxCTkBh1jTIUnpcnBnhqzt1ceYc/9XJg36YHhR9OLDLVphDkgaZpz
         KGvVEmyetRq7BzKQtCzbyu3e/d6dLNW6CgRlR0A38jFP+kyKnKUP9QSKta6jXWS9/Pky
         tOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772375169; x=1772979969;
        h=content-transfer-encoding:to:subject:content-language:from:reply-to
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f6q2ZzrG0UjOyc92iD3ovW53FovZKWJ+e4xqUHAgl8Y=;
        b=YO1LaIYZ4Bk97YtFjO2/oE/VTSyI/b4UahLuvkW66wBIThuaIYP8TgB2Sha94O8tl8
         l4Lv9c1BNxLTLuAYYqzKiNrJRh1QrPUbxMCG6tyz0x+7ypGol/9CG1lutFL4waDLPaWl
         90P8Pv6DlFI/h90jYluxAwQHr4RDzoOCFFBckV7LmTfPcO5FC1jN6Txh8U/wrf14KDFV
         dNEmgIDJ3dQyKACXzAY2F3VovF1RyT0H7IA81alfSSlfda8l4TdwnP8TxsbGitW3JC8S
         mtkYZCsUC7RprOXg8exhtnCr92dK12cPcv9Qt9uyO4Xl46vUaSNrxkRpAXh/1Ju9cZ9/
         6Mww==
X-Forwarded-Encrypted: i=1; AJvYcCUEF2ItXPyggEurvm/kvGk3CNqOreMaHn9ZPNtlcDqK/p6uYhC9L4AlnbUTA35JnrvGmHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb8Pay90/UwlAnf/jk0HBSK1817NXMpoSV9qPnIuAwvuRe0JQX
	UgdQUS6d741CmlVCZuJBqtfXZQPDdiz05AVCmPLwQq/Y+hvW5zowx51s
X-Gm-Gg: ATEYQzwtfgOnPd5MI/fP4LVokZmq8f09X19Gi4m5VEI4/GAcFo6QAdmQg630m1JPGhD
	VcrfXPAQkG+MZRH2aoRhLP0hSYs4W3ghwNk7t3qgaOawMm1STwUl5K6tBcxgUXicEXBVOJ/ZWEi
	muCIVhyCGJLvHvJRgOpQnCEzMZ1/cXFiadaDegJX0k+wZMUFPlQXKfhaGRDazeIjG/T6x/DTn+Y
	zH8j7hiWK0bIN8yns6JtD7TaDS9QvMCiFyF4uXrTXc4A6Et5S3ay1Leg3xHlunWoIhdUt/Iu9eT
	8CscgAracYbJbxnZOQvwWrt5NB6MHfzfZaqa7tLtgxiqDnIcSM2q5w9RVENaygqf9Af1AHkd8fs
	QEWgVXpgOKdn8EXeYcGSbxl8Lxrcq+QEzElzQk2PYlz1AU5ec6wzAhb6z0PgAf4s5HJmaog4qnL
	PZezswCZwrUlzDOqjZSBIAxpDU5sTimLCUFf8hu1/DP+x0OGPLElob3bHX+4cKYfyoRUmznlN3Q
	vpiLQ==
X-Received: by 2002:a05:6000:40db:b0:439:b539:789 with SMTP id ffacd0b85a97d-439b5390e0dmr2150350f8f.52.1772375168639;
        Sun, 01 Mar 2026 06:26:08 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b503424fsm3455200f8f.22.2026.03.01.06.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2026 06:26:08 -0800 (PST)
Message-ID: <c67066fb-f857-4738-a3a2-53108c57456a@gmail.com>
Date: Sun, 1 Mar 2026 14:26:07 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
Subject: Editing GSoC Project Ideas
To: Christian Couder <christian.couder@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I'd be very grateful if someone with write access could please update 
the description of "Refactoring in order to reduce Git’s global state" 
[1] to stop recommending moving settings from `environment.c` into 
`struct repository_settings`. That struct was originally added to hold 
config settings that were already lazily parsed. We've had a number of 
submissions that move eagerly parsed config settings into that struct 
where an invalid config setting causes git to start dying in unexpected 
places when the lazy parsing fails.

The current wording of the suggested microproject does not mention any 
of the subtleties involved which sets students up to fail. A better 
suggestion would be for them to look at what Bello Caleb Olamide has 
been doing in their Outreach project [2].

I haven't been following Stolee's work [3] on "git conifg list --type" 
closely but I think it introduces some functions to parse config 
settings gently. Those functions might enable us to parse some config 
settings lazy where the functions using the lazily parsed settings are 
already set up to return a error. Doing that would require careful 
analysis and should not be a blanket recommendation.

Thanks

Phillip

[1] https://git.github.io/SoC-2026-Ideas/
[2] 
https://lore.kernel.org/48821a3848bef25c13038be8377ad73e7c17a924.1771258573.git.belkid98@gmail.com
[3] 
https://lore.kernel.org/pull.2044.v3.git.1771849615.gitgitgadget@gmail.com
