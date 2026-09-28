Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10B845FFDF
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587273; cv=none; b=FmafMkYq/5m8kpUlUElBk4cMNaW68KLArKl557fuLYUj0UQqKeN+cTWwBkKdzp6bD5K1kKVHmqkYRmHCFO2CAV27BcFtnwHJVrHmvat0DcE36zD/QJYRZtcVjS/JxVH8yCoCYA+MN5jExZDnd42HZZh9Lc4Tqkn86SdGOscZTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587273; c=relaxed/simple;
	bh=IBaqwIu7FF+w3Y2gskJSGlkX4yIrIYzRMLhDPVzgaHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dw4wEjzoiNMhW+goQXptZDjGIgSrAfVkUZecO4bCV1/quzuHmR8ytUPbtm6qXqO7Iebq4JNmHHXVNQgWwzX/tMC4N12BqP/r7YEjs19G6RSkP5iZTH6TKYsXGee2OTHKmidIggAwfeQKTHIEbeWUywBgKVyo2JFPFiLQqjoihtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEMOZHZi; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEMOZHZi"
Received: by mail-pz2-f40.google.com with SMTP id d2e1a72fcca58-87fd84c0bfeso995187b3a.3
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 02:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790587271; x=1791192071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s39u3I9EhOd/UwXn3eW6/iP4cUUQSm5+xXFm3RKZm1M=;
        b=JEMOZHZiTGih193s/QdbxwLiFatnGQP/FGHMc/hG05NcYwMqSEY2GGaFzTSW55Q9ao
         UUzQ3of6PdYakTvEpc3QkaIjvbac5r44m8hbdQCfvrCCv+6UhoCa6qOB+kPTIVCvHAeV
         Uv9tuY3kiFZ8zB2L12myXQEi00zEuyFMSQx7Nqci52qniSmgGu8VmWMu88EWFKdcFBA5
         R/k4w9Jv9DHdF3p6W7XUqzkq+Lnd1XfLHFIBIgISDVZAWPHJFLSQgS2FoxzPgb1r1Y7r
         cwmbIQpijr42nrnocJnIERjbrFPx6pLCLI8g1oIa6hw7nMpWqlKtFaZKZrwICDvQNbiI
         ezpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790587271; x=1791192071;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s39u3I9EhOd/UwXn3eW6/iP4cUUQSm5+xXFm3RKZm1M=;
        b=p4MmwiWLZ3jAWD3FC4KTOnsK//Jze9DXM2P1ZTOCwiqNF8iHuRS0MznNKUGpEVPw9A
         BVhDXDgM3fVb0Mojn7h6m+5VboDbnxqwewqXz305OcJMpI0nWd8rMhnKsOmajUFkFOcR
         lO1BGP22wR75cy/M/+e0BIB/ORZ00SLZ8l9eFyWtAbokBLxw8q9V4xI1jwP4EXKZUspv
         WOSf5cqyMfXtsXeOiQMS65NU5FDnqv6igJQXccch1vaq+fWVGfaX6MhJ+Lk6Lx4pgCG4
         O+N1NSlWIRe7UUPobL/AHevDhMNalfvZI9lW2QiWlRb7cX6643TTZfv8BdRWXsUiZ19o
         d42g==
X-Gm-Message-State: AFuF++ldKPew4Hmw6kYCB6sei4w2X7TA2ENNQFj7TWzCbqPEcZnM3RBm
	WD0ogXbFzHvg6AIdZ4rrpcAOdrCneyDujuuKimNr3/pyptZeocwT6vcd
X-Gm-Gg: AYBFou2qN5djLwyK7al67EuS0ac3p1bNGI7tt8bg2IaxRt03fcCznEOd+JHesO8n83D
	9WIuNmlnn1Q+zQMizPRUbfhCHxg0T8Q0MvmAx4ZWQ/xKw0liarb68kb9tUeHfaLdvxtBo6yEhDN
	tz5MLCrxg7f0yQcsCT7lgfORdlIoyER2lLyB6+LDtrTzJ0QikEwOmP87Bp/HmA5TlBu5duM6x5v
	CILHMCQGCdYZEOHF7/J5zaeDoVxjgUilhucAzLMrs/daS4kA7PXHvzR1mCVQoe0NaXenlWXvZHX
	9U8LxjJuNAv3jwPYvfQCqd5ggCYVTjbLffGvbJlquaRUlIpQ5BhrPy/NsEZ6w9Qp2nyJzHCPfxr
	PeMnPHQz5Mhd0B4Ede/ed4jlfalX9LT76Hgou8LsSpIh4SEjtKx0FlGTUG4rLT3krqGtDRxeoFD
	8GtPQMZ+yPqioc89xoBWYXtJmWrASRdcwWnnl6BTyLxIaKUlShjcdTTjXizgRtsy1KOprwv9ieZ
	Rj7YPMYCKdb5hwedN5kjr+1VtBnZOYLMD4LJ9f6ir/V08TJ7WDxhUFymg==
X-Received: by 2002:a05:6a00:950f:b0:881:c881:96e8 with SMTP id d2e1a72fcca58-881c8819a45mr3505586b3a.23.1790587270872;
        Mon, 28 Sep 2026 02:21:10 -0700 (PDT)
Received: from ?IPV6:2401:4900:88e4:1a00:6c4d:e299:e430:9822? ([2401:4900:88e4:1a00:6c4d:e299:e430:9822])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87fea8894d7sm3776211b3a.26.2026.09.28.02.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 02:21:10 -0700 (PDT)
Message-ID: <557ab7b2-a1b6-4064-997c-d0dc50126df6@gmail.com>
Date: Mon, 28 Sep 2026 14:51:08 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] path: introduce
 `safe_create_leading_directories_no_share_const()`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260924-pks-create-repository-stateless-v1-0-11499557cf31@pks.im>
 <20260924-pks-create-repository-stateless-v1-2-11499557cf31@pks.im>
 <4770b19f-9a8d-4a4c-8cc6-745aa2868b94@gmail.com> <aroULK79T-UkwkoM@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <aroULK79T-UkwkoM@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/26 12:45, Patrick Steinhardt wrote:
> On Sat, Sep 26, 2026 at 01:19:42AM +0530, Kaartic Sivaraam wrote:
>>
>> nit: All other variants are mentioned in the documentation blurb just above
>> the declarations. Would it also be worth mentioning this new one there?
> 
> That's fair. I find the comment to be somewhat unwieldy overall. How
> about this diff?
> 
> diff --git a/path.h b/path.h
> index 7e7408dd05..922bd6e377 100644
> --- a/path.h
> +++ b/path.h
> @@ -234,14 +234,11 @@ int safe_create_dir_in_gitdir(struct repository *repo, const char *path);
>    * race, callers might want to try invoking the function again when it
>    * returns SCLD_VANISHED.
>    *
> - * safe_create_leading_directories() temporarily changes path while it
> - * is working but restores it before returning.
> - * safe_create_leading_directories_const() doesn't modify path, even
> - * temporarily. Both these variants adjust the permissions of the
> - * created directories to honor core.sharedRepository, so they are best
> - * suited for files inside the git dir. For working tree files, use
> - * safe_create_leading_directories_no_share() instead, as it ignores
> - * the core.sharedRepository setting.
> + * The default variants honor "core.sharedRepository" and temporarily modify
> + * `path`. Note that this configuration should be honored for all files in the
> + * git directory. The `no_share()` variants ignore "core.sharedRepository",
> + * and should be used for working tree files. The `const()` variants do not
> + * modify `path`.
>    */

Reads much better to me. Thanks.

-- 
Sivaraam

