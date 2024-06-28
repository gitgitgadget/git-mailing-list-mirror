Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E85EDC
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 02:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719542738; cv=none; b=C8gIfOLRKsNRdPUBbgTer5L5CrsozJKnMHDJe7tKq4ABRdZNI9y1eRyWt3xhApLweOrourZVSfaLWeJOCaBhPi8WMXT8/q5jwvDsaarwlq2QDLl+3lwgKE61alPmigKzHqzeG4yDZLTR358+5udkL84UWnqitvduoUvApA9Iwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719542738; c=relaxed/simple;
	bh=KzyoNPJaOLop8Xre6++N9nXQXZQ7CGvl5LJYhSQAq8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QVLM9orMqfnn1X4psMlAZPXfUzKa4GfIhQr6u5d3pQotFQ0lit9wFPj9c8sgSEcURHD7hdanu8Ht7iDyBRwh7FYovgeHWHHnWyclJl6U6RStDAe0ldpMPXiruJ2g6EAIS5aJrg984x0kKfsVlAnCZJ9a2uEBRnjfq0IfCYqFrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuHuc9lM; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuHuc9lM"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64a6bf15db9so1010897b3.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 19:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719542736; x=1720147536; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5efyPkbdhkTIySFYsxbq7pXPTAHR/OqCoGBbKao0c4=;
        b=kuHuc9lMJQFBjTjRqlmPEkm+bgZslEmPc3A5i/9vVLk8pOc53wyJmGwcq1gzvK0XO8
         vn/M21aSYjr6tBWisAhij96WfJ0BItQwV3baiyORnBH/OUW4Xcu/VX319LMxg8AUDNzu
         R0HHdp8ORF6sSSIUveuH75VtKzu3cO+QDBZbKImZeyxUJyMNDw9zTTkSjOsTktECSiOZ
         mmV3moaLUmicvZHpBoeRthQfdebcrvelt9dA8cFzG3OQqG1Aa33+T+JTioZlXmxV/Nh5
         MNsYvknI47kVFiVO6gNrmwfuHaZ0Vl2Yd07rDVfB0QeeEGFfx0ilwczL2sPtEkhoqkZf
         lDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719542736; x=1720147536;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5efyPkbdhkTIySFYsxbq7pXPTAHR/OqCoGBbKao0c4=;
        b=EMfmpEKulvlbJwMMB9z91x/wRQCsgRYkx5Cbui9YyBOP6d2PbYRJx3Be7ZMSGlTf7p
         iB0ARcWkTl3FDvmuEnav2T0kgT/yRJHwrvW12idDGuXJFE8F9dqzs1tT0r67pnzAGjyZ
         6lBNOOwRkgKBz8N0ARMnjVBH62zqPFdbcEgpXC4uS6NIoRp1YV09stsHPTUALOUiwgDz
         qgyZECSe9iC3LIgG6M9PywP5oruzQrlDvcMM0/0jQxlJsgqVw27Zb9tfCivuQ9/GJm3w
         ixQTd+OcDHPnmNHtq2qtLtcYsyXg+9r/2r/kb/G7GEpyw+7tpndWyhJLCiJYRKu4K0Yx
         +g5g==
X-Forwarded-Encrypted: i=1; AJvYcCWcKRIg27DK/2zx+xXW5hSf/FUAx2+5v2rNpIhPCXW5dIaEHQODmVv75HsV/ukr5KBLWlcTkuXd3BIGG3xbiib9l2R/
X-Gm-Message-State: AOJu0Yz1GnMDlPZoVLSmWbDITNGfMYRe6C21lXdeCEjV0xnYP+Gbj0+N
	36blWL/VLg1uvsBb2dVU1nWLCryg10R78vgfprGNpTwY8QXJH+5G
X-Google-Smtp-Source: AGHT+IGL6LH6t/yd3vOmNCqoEEPMGT3hLyzau88qVtFFbRRfcQHta1uR+qW46LIvsoZn8en26fu1vg==
X-Received: by 2002:a05:690c:318:b0:64b:77e:84cf with SMTP id 00721157ae682-64b077e87bemr2906017b3.43.1719542735833;
        Thu, 27 Jun 2024 19:45:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5a1fesm1833287b3.101.2024.06.27.19.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 19:45:35 -0700 (PDT)
Message-ID: <3f1e155f-f559-42ac-9454-8ddcf7873f48@gmail.com>
Date: Thu, 27 Jun 2024 22:45:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Fix and improve some error codepaths in merge-ort
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Elijah Newren <newren@gmail.com>
References: <pull.1748.git.1718310307.gitgitgadget@gmail.com>
 <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1748.v2.git.1718766019.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/24 11:00 PM, Elijah Newren via GitGitGadget wrote:
> This series started as a just a fix for the abort hit in merge-ort when
> custom merge drivers error out (see
> https://lore.kernel.org/git/75F8BD12-7743-4863-B4C5-049FDEC4645E@gearset.com/).
> However, while working on that, I found a few other issues around error
> codepaths in merge-ort. So this series:
> 
>   * Patches 1-2: fix the reported abort problem
>   * Patches 3-4: make code in handle_content_merges() easier to handle when
>     we hit errors
>   * Patch 5: fix a misleading comment
>   * Patches 6-7: make error handling (immediate print vs. letting callers get
>     the error information) more consistent

I saw this in Junio's email about series requiring review, so I took a
look despite missing v1. Stepping through each commit in my local copy
helped make sure that these changes were correct in their proper context.

> The last two patches change the behavior slightly for error codepaths, and
> there's a question about whether we should show only the error messages that
> caused an early termination of the merge, or if we should also show any
> conflict messages for other paths that were handled before we hit the early
> termination. These patches made a decision but feel free to take those last
> two patches as more of an RFC.

I also support this change in the final two patches.

One thing I mentioned in an earlier reply was "why not use an
enum in this tri-state 'clean' variable?" and then I tried to
make just such a patch. There were two problems:

  1. There were hundreds of changes that would be difficult to
     do in small bits (but maybe doable).

  2. There is already an 'enum ll_merge_result' in merge-ll.h
     that is silently passed back from merge_3way() in merge-ort.c.
     While it's technically four states, maybe it would suffice to
     use that enum instead of creating a new one.

But I'll leave that as something to think about another time. It
does not change the merit of this series. I left a note about
another "&=" case that wasn't touched, but it's not wrong as-is.

Thanks,
-Stolee
