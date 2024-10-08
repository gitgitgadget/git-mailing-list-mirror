Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9B1212EE2
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 18:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728412246; cv=none; b=Fv3wCJEn/cPd826ya+524KorKEso+ZrwsH6Mpi74oR3VZXU6B3w3KHqoyrPTOY8UfgQCBl7J68Ac3GciCdDXwjnL9H458A3OWtOSkUnjkBSQmMEMVMDAthcYPDz9JKLMdXHCxxhlyM2YNP4H6Pk0n+nUrBD1mc6R/2osYqCvgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728412246; c=relaxed/simple;
	bh=/mHuGHAB4GCvkhZofmqobdWj1e5aWoal2jcSCOluNLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FVFtER3vq/zpimF0Iwu7hqSSPrORPMulB1MZOUy1HiPyYOSyTe6hzs82+xSgB683cTJSfKbhVWdyJk70SrQoc/WfDjU5xqhyswMoxbmf0QXzcgBVTyiEieAT9w1gJ5on/X+NIEoHjEqDouavSmMSPxt2u0YqGveGSCNN77YB3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHde81Mm; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHde81Mm"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e25cc9e94eeso5174304276.3
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 11:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728412244; x=1729017044; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2QLoJaiQo4rgb6+IUD9qJl2lXz7m6f9vbcxYE/AY/Uw=;
        b=HHde81MmXLccWT2xKRpz3+zqioWWxXpvh4YMQsKKVit/N+E9xlmDxlMGpg5TFHV/b0
         vxOuHIZPTUHJfIOEecZwznUQkmATMAVa8Onz0MLT7M7P6e+XkXdWYw0p8rVVy6OhqIoK
         7o6Z/3FQSRtccBIVnmQ7A9XmA/c7hZyrVDWwvPtgwVDBHdcs4JsUUOyqj28FHHeTAsmS
         /apJTAubmHOgl8BpuFp8QTbjecpudkybD6Dwx/Msi6ajV4ndWYEEJTmf6KVGMG2NaoPW
         Lz87uKsKQazsSiopGAuJtohOPeH9RjT3B4nnsddxu62Hq62qujmrqAJwoaYDJHkIR5SF
         Tk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728412244; x=1729017044;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2QLoJaiQo4rgb6+IUD9qJl2lXz7m6f9vbcxYE/AY/Uw=;
        b=b+D1sbzqTprMUwxF66mWTJAkbxmFuWxfdCiogNWruCnT7so/vRIixH5rlwmjL9wVoI
         cWt4Dh5Pyx0rGaJr3evGuRLHHm5Yr6ngPgdjX3Lr7c0WYvHkREt6yWZ1K1iKkFnvtNjh
         REkwiScXUq0KM4ihnuD0HroSK3OZ/lU+thM9mKcLSldyQnj7nwNnJJpTYSBLPArVnDml
         XbaQ1uOm57AH4k9xy3fdJhb0jOdU8ZM9A9dbmivTdkeQr0sT5z4cGFYJnmCaVBdgu1B4
         YHccY4cgQ6BLuEuYk6DyuUbxClXRh3ERPGXtS/Wjvkttml+EIDksNdQXhKlkfJ2lrMQX
         xunA==
X-Forwarded-Encrypted: i=1; AJvYcCUy9WcBss0o9pvZ1xAN78iJ9luidLhl42XOD39c19rrsQGNmiiU1vvAHsX/qnU465/Kgaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycdKOWtLNi9EomnxIcgF/UhH06m3oDY5lVwzNH0ux5iNR0Fhf4
	Q9emhZFcGP51pRp7u+heCfc2bJo4ueBGES6YqGm67EVlt3+6zaeWzMPv1A==
X-Google-Smtp-Source: AGHT+IExtmefELKp9OndvqafhDqfIp/ruvXEYDmrHmwJKkGwmZztA0IQnDiTTBG+ze1UIl4/JokYQg==
X-Received: by 2002:a05:6902:a0a:b0:e26:1a02:e061 with SMTP id 3f1490d57ef6-e28fe3ab150mr42210276.34.1728412243703;
        Tue, 08 Oct 2024 11:30:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:799f:a786:d66d:649f? ([2600:1700:60ba:9810:799f:a786:d66d:649f])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28ee8c438csm319835276.47.2024.10.08.11.30.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 11:30:43 -0700 (PDT)
Message-ID: <c1271bf6-3648-4eca-916f-67a8518fe4e1@gmail.com>
Date: Tue, 8 Oct 2024 14:30:42 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/gc: fix crash when running `git maintenance
 start`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Shubham Kanodia <shubham.kanodia10@gmail.com>
References: <CAG=Um+0mJW-oAH+YLC3dWEU64JwS-zMkkTiFWYBe4g6HMbe-iA@mail.gmail.com>
 <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <976c97081af7c62960bd71d1b70039657e7cb711.1728389731.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 8:15 AM, Patrick Steinhardt wrote:
> It was reported on the mailing list that running `git maintenance start`
> immediately segfaults starting with b6c3f8e12c (builtin/maintenance: fix
> leak in `get_schedule_cmd()`, 2024-09-26). And indeed, this segfault is
> trivial to reproduce up to a point where one is scratching their head
> why we didn't catch this regression in our test suite.

> +test_expect_success 'start without GIT_TEST_MAINT_SCHEDULER' '
> +	test_when_finished "rm -rf crontab.log script repo" &&
> +	mkdir script &&
> +	write_script script/crontab <<-EOF &&
> +	echo "\$*" >>"$(pwd)"/crontab.log
> +	EOF
> +	git init repo &&
> +	(
> +		cd repo &&
> +		sane_unset GIT_TEST_MAINT_SCHEDULER &&
> +		PATH="$(pwd)/../script:$PATH" git maintenance start --scheduler=crontab
> +	) &&
> +	test_grep -- -l crontab.log &&
> +	test_grep -- git_cron_edit_tmp crontab.log
> +'
> +
I see why we didn't catch this immediately. This is a good way to work
around this issue of "mocking" the scheduler.

Thanks for the fast response.
-Stolee

