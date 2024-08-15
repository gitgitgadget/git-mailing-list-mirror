Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002744376
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723729611; cv=none; b=giIll7vp2qs0ty6igBDqN8Jx/U0erEOQuXZ9GYger1LgvF8wY+xEXXRqd1HkA2+C/fM5YRMTrrXDVRJZ7BJsc28DwNdT5GOWC9Q5CwYBBo3RPu3Xgc8L3gFUI/oIqYhK+cVS0T1ckyXb1s4oXJBnEIaOKyy6/XtAwki4P2VGZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723729611; c=relaxed/simple;
	bh=0o7F4DqOL1jYjshNqUbZ81oLMvLDKgF8eQnwg9U81U0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UKOlAPyemAbtwt95bTf/Uuy2/Wv9PZmfvnMlZoOUFwB0OqIGvWkBqnGIOkTIdwISvXeGwUvcIm59fRYfhs70ME5UQ22xQSIvSyVRsSKKGkb9H+8tpEt+Ub4EkZHdNGNGkBof4JC21QugRib3I1P5pCmw7N+PpgXCPdnWDHNtWuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M87zEECg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M87zEECg"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc65329979so9406795ad.0
        for <git@vger.kernel.org>; Thu, 15 Aug 2024 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723729610; x=1724334410; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nDXTAQJ08iITgHoCs9d3i707AEFQcZL10q8d4//0Fko=;
        b=M87zEECgBOd8dvnazeGEGN2TLNQ1LocoMP5z0U864WLshvCCAQPQMfVX68FKSbbLPc
         liSyDj2xV44WFwXcG+EocwNnWpylBpmiiAbK/vEVzd01LeVnpGxGZPrkUrHxNwxzMWuy
         HhC8PU6hLLaeaeePjlDmVNiPPB3TUFMuljK28Jpke8ii55s5U1rSbK5mt+BCwc/aF+W/
         +WnncSh5kfZo5q93mh2MT4CuPZRg1+eAaqi4wlxiT6XKw4eYBv/U9MMv2H6eX9q48GV5
         qZDh1bk4oH1IXFwqWCgkpIbMURYRMpKGmIIMc91g8hDGrwVF5nA8p0uxzjQjrg0QPYaZ
         z5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723729610; x=1724334410;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nDXTAQJ08iITgHoCs9d3i707AEFQcZL10q8d4//0Fko=;
        b=oOr2F7cRH6Q9UDuiFf0L3cXuST6CgjyQsFh2UoYRbIlDbksRSlXLsTROszRQ/xsI2R
         /RD2266RECMkuwZKsZ9kbf+2gVy8jTL6bcVyR1DCETq74G2TogBpmg2mOQhy8RGM4nea
         MzrpDZT9eTxgMG4M0/pc/YZj9JcjPmzPIoWL/x5AnQsj/ZSRKDZSCnaW2pHoQsMTLB0q
         sEJbx4548dRh1Zs5dLBYfNbGxZ061KfBw4jTVbEjjHtyg2si80IksuqWbBpax7Q9tt1K
         iMeipJMD6v9M9SeXZdI0p722uGddTFRlggOPdcXpYDKJ996zLVKIZB8u6tuL8WOi9hdQ
         0nZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlV1bpEYOqbyVZVyqIujcp1DcCfrQFrM3CQz8yfjf4RbD+AiZDkCeiR8rrMGxeuKe7KDWkchj3HHygc/FdA/0YQf6S
X-Gm-Message-State: AOJu0Ywv49A/HMoeO8sedTqet93f8H3ay832uz924TI3P8HXTw8vmVT3
	mUpwSC8X4sQgBev7TiOoMY08DhFfJkdALyKwbnwWsFd0EE6oDv5/
X-Google-Smtp-Source: AGHT+IHri0HQf6XNKPasvATTSkzTeOcHWs68oUr0xyoaSTbR19skLrSIq+kRffGq83rsjT3uitAkfQ==
X-Received: by 2002:a17:903:192:b0:1fa:abda:cf7b with SMTP id d9443c01a7336-201d63b3e42mr86826185ad.9.1723729609281;
        Thu, 15 Aug 2024 06:46:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:69ca:a1c4:ca16:9d53? ([2600:1700:60ba:9810:69ca:a1c4:ca16:9d53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038e26esm10244655ad.216.2024.08.15.06.46.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 06:46:48 -0700 (PDT)
Message-ID: <6304df4c-705a-42f7-9e43-1d89404731c6@gmail.com>
Date: Thu, 15 Aug 2024 09:46:47 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] builtin/gc: refactor to read config into structure
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1723533091.git.ps@pks.im>
 <ff6aa9d7ba0bd67d3682ecb44c024a6d59a7decd.1723533091.git.ps@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <ff6aa9d7ba0bd67d3682ecb44c024a6d59a7decd.1723533091.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/13/24 3:17 AM, Patrick Steinhardt wrote:
> The git-gc(1) command knows to read a bunch of config keys to tweak its
> own behaviour. The values are parsed into global variables, which makes
> it hard to correctly manage the lifecycle of values that may require a
> memory allocation.
> 
> Refactor the code to use a `struct gc_config` that gets populated and
> passed around. For one, this makes previously-implicit dependencies on
> these config values clear. Second, it will allow us to properly manage
> the lifecycle in the next commit.

I think this is a valuable goal.

> -static const char *gc_log_expire = "1.day.ago";
> -static const char *prune_expire = "2.weeks.ago";
> -static const char *prune_worktrees_expire = "3.months.ago";

I was going to mention this in the previous patch where you change how
these variables are cast into git_config_get_expiry(). They aren't
changing to non-const here, either.

> +struct gc_config {
...
> +	const char *gc_log_expire;
> +	const char *prune_expire;
> +	const char *prune_worktrees_expire;

The fact that they are initialized to const strings makes it
difficult to know if they've been updated. I wonder if we need
to change them to have a "if NULL, then use a const default"
somewhere. (And maybe you do this later in the series).

> +static void gc_config(struct gc_config *cfg)

I appreciate that you are taking the step to make the structure
a process parameter and not just another global.

Thanks,
-Stolee

