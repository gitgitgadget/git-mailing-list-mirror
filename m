Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343127D07D
	for <git@vger.kernel.org>; Fri, 16 May 2025 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747410121; cv=none; b=CYwB81NIeTn5gkLjouyYKMVcLNFBzKxj2sroXOABiWTRKZuxwxc67L0N1V8ugLPrTZVBayUzHIb6NzoX4KoxBI7epILYrT+RG92RfndT0CBbSw8FX+FrEWjgKK9okCtV4whfXtfoOwMoDu79akIsH3VlIj3AFmadWNwp2r7eej4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747410121; c=relaxed/simple;
	bh=Mt/Ims2IO4JBOUQd1CDBvupQ+HldDYJP8m4Zjzyojlg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=biAySkSL6PhX32C4OUsh1XcZuXweO4MXf+ArTg6on40Ma717AXBnCeg3tz07qZY89U1grEVhKwvbYWHDIchuiUAuIfMJ/CGF4WbxwlfNC4g0TZD9b/dGz29kqfiIHO/L7Ldly34NEaQP06VwuXTJGR20uQgxLGaOF0iOU7xvRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxJWgaG/; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxJWgaG/"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e7b451b708aso1714637276.3
        for <git@vger.kernel.org>; Fri, 16 May 2025 08:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747410119; x=1748014919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mt/Ims2IO4JBOUQd1CDBvupQ+HldDYJP8m4Zjzyojlg=;
        b=dxJWgaG/JYNcQdeYysiLbMycDwsgxmw3nsHdIzXlRj3AMLwf+zkUMsaJI2dSiYOv4R
         Xt2rpozcsDsZqcJQhTX0DsNXiOC7TM5OFaoRMpHDpXqFAneZsfRpbT7GNQkzcEi2hNZm
         2DxEBkbIj58x9PYKyqk3FI7Zj/3z2vQpYYr8HT7xyRFudkkFFsmYbULQjewsFiGTONMM
         +pFKnZ3WNOcNxQiCx9Mv0Wg5Hl3jAnD96t2dFAGU4YS02Ok+RoVNgIqYpP2cEGuCD5mv
         Zl1E2E+kXBynkqmTtULpLTF2jCMfxmSzJJYzKCPHge7qk1Hit+Edw31p7Lfy6BBHINer
         cVOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747410119; x=1748014919;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mt/Ims2IO4JBOUQd1CDBvupQ+HldDYJP8m4Zjzyojlg=;
        b=AS+5uwXjn7qJiv4DWDwciCiP5+Ypj2vwLa14AM8raFSkyFTYMf0KVsquI5THGlhiki
         4GryITcjOljm7DFe43KipA0E3kPIPB/CQv2HkNld1DWprKOauxhYT0pyCyX2dxPUTb3+
         8oje0pK+KNGmIYKFJ8OOFJ5nsauV9GDDqxjCrbpKVugJiiGFG3RxmXiY7giA4ZK6Qn6H
         df/+Bd/GwIDPjkgmTzoPJHOFbag0eZy9BHMLN/zg97+lZGM3uv2CvWtA8kir7KlNP+3h
         Z3jbbRx0mwOJfxdSRsWpT1ywFdhsQ2Wxzmgf6L2UwRnIRclhwvT3vUdyOZXnp1F0N2Cf
         6ftg==
X-Gm-Message-State: AOJu0YxlYSzO/G5fOKgka27ULjzAR5nnsuBXrvrsvwdLVobxDxqz1VEe
	FjnEiutT++rMxAzOq3cVDJtujou1uFKNsQ9mc8w4lw+dmV9Ctl2hlEqI
X-Gm-Gg: ASbGnctpBW4cpwgiSysYHwSKw6FynaxnrIeFRhxBvjUgrCTO7BXzse9JZv8BXt6z5c4
	gTTr4/QEuTCPoBswA9w1/hX1X5dZjuaIi85uL5HNTUg/+HrZC09DKWX+LdnXL7jZaTSfkPMvWUr
	cExnePsZ/RWvjKl0CGhdq95K6OIlgAE3L9lSHYj3SSakJywbhfXZc3QeGhH2oGLCw+mb64pU4Vy
	L3K3JcIdlmON6J2Meb8V6aGg646MCDEAj3bWyZ/V+QmB+yQwVtA3lt8QG7sF2y0Xnymbny6UdaV
	YGlqLU6zO8R3f4BqBwN8G1vavRrI/k3ARPs0dhg+clzP2/9fj4db++8bDr2QgElTUv5izK2H/l6
	TR6K1jg78jLMxBMKhXB89p4RB3cBoSZGI3SU4r9s=
X-Google-Smtp-Source: AGHT+IE+tcQfHnYFaKmWd47rmhTss7NXps/DYQvVN6N8V1V10IBOauYxolgu59xxGZENAxABeXfsVw==
X-Received: by 2002:a05:6902:2509:b0:e7a:a7fd:87f2 with SMTP id 3f1490d57ef6-e7b6a0d2920mr5771163276.28.1747410119119;
        Fri, 16 May 2025 08:41:59 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:9ccc:beab:105c:f288? ([2600:1700:60ba:9810:9ccc:beab:105c:f288])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7b6acb1ed4sm627066276.30.2025.05.16.08.41.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 May 2025 08:41:58 -0700 (PDT)
Message-ID: <c849a4e1-b409-4a2e-ae32-b72f53137133@gmail.com>
Date: Fri, 16 May 2025 11:41:57 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] pack-objects: enable --path-walk via config
From: Derrick Stolee <stolee@gmail.com>
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, newren@gmail.com,
 peff@peff.net, ps@pks.im
References: <pull.1819.git.1741571455.gitgitgadget@gmail.com>
 <pull.1819.v2.git.1742829769.gitgitgadget@gmail.com>
 <dd66a5b46f2ef52eedea323df891a2e24fcd48c1.1742829770.git.gitgitgadget@gmail.com>
 <aBVYa9SzXk7eguIz@nand.local>
 <ea342443-2c71-476d-ab45-86cbe711fec7@gmail.com>
Content-Language: en-US
In-Reply-To: <ea342443-2c71-476d-ab45-86cbe711fec7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/6/25 3:46 PM, Derrick Stolee wrote:
> On 5/2/25 7:42 PM, Taylor Blau wrote:
>>>   pack.preferBitmapTips::
>>>       When selecting which commits will receive bitmaps, prefer a
>>>       commit at the tip of any reference that is a suffix of any value
>>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>>> index a6b8a78d42a..0ea85754c52 100644
>>> --- a/builtin/pack-objects.c
>>> +++ b/builtin/pack-objects.c
>>> @@ -4652,6 +4652,9 @@ int cmd_pack_objects(int argc,
>>>           if (use_bitmap_index > 0 ||
>>>               !use_internal_rev_list)
>>>               path_walk = 0;
>>> +        else if (the_repository->gitdir &&
>>> +             the_repository->settings.pack_use_path_walk)
>>> +            path_walk = 1;
>>>           else
>>>               path_walk = git_env_bool("GIT_TEST_PACK_PATH_WALK", 0);
>>>       }
>>
>> The limited diff context makes it hard for me to tell for sure, but this
>> takes place after git_config(), right? If so, I think we can avoid using
>> the repository settings machinery here and just use the config API
>> directly.
>>
>> (FWIW, I typically think of repository settings as a way to expose
>> config information to some part of the codebase that doesn't otherwise
>> have easy access to, e.g., a static field that was set by a git_config()
>> callback).

Rereading these comments, I didn't adequately reply to "why use the
repo settings?" and the reason comes due to the use of assigning the
value in feature.experimental=true. This provides a common place for
the logic around both path.usePathWalk and feature.experimental.

A similar behavior is already present for pack.useSparse, which was
in feature.experimental for a while before it became enabled by
default.

Thanks,
-Stolee

