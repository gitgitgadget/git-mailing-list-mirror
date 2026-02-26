Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D0355F27
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 18:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772129665; cv=none; b=hx2cVLFYpcbZUpGJ6W2kbJHfcNYB1Y98QcHFsYjatUC0vPeIObl9mdp+A7dQcQ9TAtmkuhVsE8ZagcqfPW3fA8aS/74bU1kC9imiRCHHRALEKT0nC9iWKKK1Tvi2xcoWU18AHO/6ut2tdmFMxDgJMW3C1l78YYW78JOTZQBWxtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772129665; c=relaxed/simple;
	bh=bNvf1jvmgvuW+sfGuC/ncUd/+8kIblf4NT9Sq1t2Q34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmVkvpM1a5oZaoAgNDqgPdLbFfCsAtsg3fnXQEFT9D4YAKXH8Jxwrlh1m01KVFTEnWaYAU2qUohy/vSkAZ7CyGaVnz3GXLPcs6nJdrdiZigQomGR4P7F/ITaqF3ySgyTb6Rc9cjfq79a8anIXAlYKhFrYAc35aMjYKrL7I7OyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Agc07u0l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agc07u0l"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48379a42f76so9374635e9.0
        for <git@vger.kernel.org>; Thu, 26 Feb 2026 10:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772129662; x=1772734462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uy9QPCgL4Ae2XHKaxe33J9DydR3AEWvtZsLt+WMepjQ=;
        b=Agc07u0l+Xxn63aQKqTph7wCaXEdOaZEmNG3QLsOkDjPbYihbxU6hOgUMszcAYyspf
         DYiXRYZolxHsW1cXOtd4n4aMxrQ3RaUhVFVnXZLYtOHCajcJTi+oPVF26gxi+YoK/63n
         7nsN69SB4jLmZr848tDel319E4b9uIeR63FUGoN6NXzlA8JtxP+HWdgItsHySRbfquOs
         41rbVO4vhiCTfJcWwg9+00MgzGSblOg5XH+FJOGjFiTLHph3D/c0MymS+nAmrnrdrUnv
         ZUyfToygwhzI6s8/FwsVgJcXJP2oJ0x5bKg0nbCVDSm9wRA6a14C6unfPhi/Gi6WJ3xp
         h4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772129662; x=1772734462;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uy9QPCgL4Ae2XHKaxe33J9DydR3AEWvtZsLt+WMepjQ=;
        b=JOsYQsIs8EvRFI1stza/AAWLPLX/OVcBSqtiBUP7y+bgYKvisjirhPm3RIcDkijlm/
         nKztvFD3eNSGwEOk+KVFx9bchGpMXS/9fhvYVJ0T+AedWbb6I8xYG8yOMgfDWRiMvL/v
         S7evTP28iXO5taQkAYuJPGZWegHU77bloO8CzE12KO6vDKnWS8zzdT6+um9+lgU0+ulj
         JGr3BHUL+7LjODZI4x2S12Z4mpD7pmOUurCAvTj/GXyXQ68GtZ+bA5eYcnIKR1vjRCTC
         7UQmysEh1Kb/4gx4aFU2HGTI1arGiB76AknkohNp+oBaqfsflQoGAu11x3iPEYnp9TV1
         bYdw==
X-Forwarded-Encrypted: i=1; AJvYcCVocEluV00fjOiAsvt2P7cF/0/jqn4FtzNdE1HDTq/EkMFgmGvcDhIu02Y1W5VJxpNDGR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81KlEIOr1eH/QHg1ojpcbCqH8NTD/Yka/htuhEJtMhTzTIaCv
	v2lbzrRGdG9u6WmfBgUqWZCIooZWxujfm/CtfjQsQtUC+2wDF0EskL6V
X-Gm-Gg: ATEYQzw6Qal4De66or2+4+RQaMF/dca48GH8b/snIEQvekdCSfEXTGxAfBTmhhL2HGD
	rMJzC28GtzvijD80HE+EUfpEf1kRfS6j6v/w/QUiqtH46hVTghIU6ZNLRTFSV/XrgDNiZXpuBHx
	9ibjsixkj2sG6qeHglMgUT4YPyab4ExzYPP/ZR/G8ByoRjmfbcm2J7NRtlymjcaFC/ScNjRnJTi
	lT5XqoAH3F8T4sTTuIK8X74jxwztWX8AUN1ePT7u4T1nSU3dN8/HRaeVWYiX9ks16BPwCwZ+4Sx
	XU4ebbSTlyQej7G/Sj6+f0+PFHD5AUxT2Lu20fTC/TA12lIZfognuRQORCeDpQSkPdKonJNckXF
	/Mtf5yZNLkkAJYJRIiSMifB0qn+94OqjFM/HzGEfzjiIdLx2G8jBIhpDpoE8Q39x44xp8a3vw6p
	Ig8EeGV9NkbCyp+/Z29wVrKEQlVXWeS9NGjojSsse3GkBw5ur0Q37FpKqKCJzcSfHyA+ZYPOhGC
	vWIv/IKBTA=
X-Received: by 2002:a05:600c:4750:b0:477:a978:3a7b with SMTP id 5b1f17b1804b1-483c219eba1mr82970935e9.22.1772129662005;
        Thu, 26 Feb 2026 10:14:22 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:888:3d40:be1d:6b29? ([2a0a:ef40:1785:c801:888:3d40:be1d:6b29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b4410bsm63849245e9.6.2026.02.26.10.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Feb 2026 10:14:21 -0800 (PST)
Message-ID: <1ee5927a-c90d-4a4b-a468-5be3644481bc@gmail.com>
Date: Thu, 26 Feb 2026 18:14:28 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] for-each-repo: work correctly in a worktree
To: Junio C Hamano <gitster@pobox.com>, Derrick Stolee <stolee@gmail.com>
Cc: Jeff King <peff@peff.net>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, fastcat@gmail.com,
 Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <pull.2056.v2.git.1771968924.gitgitgadget@gmail.com>
 <4e3f4aa6cd36f779c6c1d6b4f30bb68ed807b9da.1771968924.git.gitgitgadget@gmail.com>
 <xmqqv7flervq.fsf@gitster.g> <eeebc30a-40bf-40ac-a16b-ca5e128c3c01@gmail.com>
 <20260225131344.GA2139176@coredump.intra.peff.net>
 <08c6e203-3444-45c7-9bc9-cc2590be30c3@gmail.com> <xmqqsean4gsc.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqsean4gsc.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/02/2026 16:21, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> static int run_command_on_repo(const char *path, int argc, const char ** argv)
>> {
>> 	int i = 0;
>> 	struct child_process child = CHILD_PROCESS_INIT;
>> 	char *abspath = interpolate_path(path, 0);
>>
>> 	while (local_repo_env[i]) {
>> 		/*
>> 		 * Preserve pre-builtin options:
>> 		 * - CONFIG_ENVIRONMENT, CONFIG_DATA_ENVIRONMENT, and
>> 		 *   CONFIG_COUNT_ENVIRONMENT persist -c <name>=<value>
>> 		 *   and --config-env=<name>=<envvar> options.
>> 		 * - NO_REPLACE_OBJECTS_ENVIRONMENT persists the
>> 		 *   --no-replace-objects option.
>> 		 *
>> 		 * Note that the following options are not in local_repo_env:
>> 		 * - EXEC_PATH_ENVIRONMENT persists --exec-path option.
>> 		 */
>> 		if (strncmp(local_repo_env[i], "CONFIG_", 7) &&
> 
> Minor nit: !starts_with() lets you avoid counting bytes yourself and
> hardcoding "7" here.

More seriously it should be looking for strings starting with 
"GIT_CONFIG_", not the name of the preprocessor definitions.

Thanks

Phillip

