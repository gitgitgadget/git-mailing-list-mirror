Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C707543AD0
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 22:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709679503; cv=none; b=qkL12A1m/laEQoZ9pBJFbsZh0Gj3ihT8X7axwu1UfJSDQiZSHwJ3e0NyFRpcmV+cIjqaThNizZjVIIzKdvaFyYCbP8PkcGl2BiKHnqz3V9BPMjC7NIhCuYXT7GkFYl/17O9Jn94lqfjEd5uKBIeVgFNmf8NvfrmxFIOcWANdUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709679503; c=relaxed/simple;
	bh=kSCAMffYOL1D+jUWHr/uw9i1Jzbz9B1eZNmlgHlZkt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/8DwUWXfoqU5+U+m/zvdlYPQhoX3shccVTwqch7eHbK6M7o1c/s0GY4wgXvZNiPoRn6X0xXmTG+SNvk6zqE5b0IO2jbVrWqss1gg+w9nSp8T4UJHPDE8MTDG/Cj2aQzWblcBxmdIYU4vABHxikljl+5YbVNEcOSQ9q40KA8lPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfiRVSWa; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfiRVSWa"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412f56ffe3bso230915e9.2
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 14:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709679500; x=1710284300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p744Gm0pnoiTv5N15xgIL0TQOXR+mQl2Ak8fnsKcQBA=;
        b=UfiRVSWa0vpEphywt1XTz6kVksNjNM/udlk09wrIKRWcHVyczmf0FuyIEF8OUAYAFt
         x0/dAgqZopHW7v4F+4a1FwP//7ml4DI6Iw6Wbczxg86P5/8uBkTdygmqoa1FBZwCoxZd
         Us9YIrxNODGH5yq+u4p/ARUgoCBRxs2iJEKC4JpcCrtaSUNcD35GD6VH2wEIkYRkT5gQ
         S8QP95B3lzAPb5PZAumwB1S/XAqSYTTF2trvWcovExJWieq5egt1WuTRFPb9ZTcdCPCM
         IVFwyEefpDakoIOAFPehv+A0bM/PBsbzc5Ak8MC2ogY/o0ABeGI/hTE2LsdVmBpjfNP4
         /Q3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709679500; x=1710284300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p744Gm0pnoiTv5N15xgIL0TQOXR+mQl2Ak8fnsKcQBA=;
        b=gUQirw1Wfb8rdDK9ZxrMz3qVPjHRAGkGQUZid8tlMejZqlK93Bm7kt9KFufh5tZkhK
         Z2wsEXGxf99SyMpfpnFec5XpXTWFz8xBklVyaGf0/md5ELnPgQ6Gp3dXc4tRHSPvK5LY
         z8Aa1dZ1dV8/IOrcWPoNiTZURCPBdBHUC1/O+ta5rPdw8XJb/7+9lQAHIj5VXuzI/pdL
         6eImoNSDUxjgPuB7Dos+1uqSwCDgw3v1VffaypZHERD469uSrubvKDG2n9EcF9DORuTH
         q1la7t5Dyc1/kPA1UUibjkbJ1R/lGk/P6Q2v+wOpTKxXqJQtg2rsJfJr5pYlCdooQikE
         pOeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUyidno+3o7v5BpeUpKxy8Tpg4DZjVCif4w/kysNae1WLf7BCEXpVPK74KaIPGJdkZHLxLi5UH198tWx3fVO4rxVjy
X-Gm-Message-State: AOJu0Yw8AEJNqWR0c635Xn/hpOTcI5IybBKV2Gpr2XQ5PPHUHn2deeMW
	MddlQaquuXiJ+3CBu8YG86yNnIc/C4NWBYq7JpjoQsCTEnBsu6BeC55YTsXD9Rs=
X-Google-Smtp-Source: AGHT+IE1d5OiIC/bfIkCvFM1YsZDHieMjiKBsIT8+PBkthLI72cclU2KPQse+8B1T+Vjyyv7zcgjfQ==
X-Received: by 2002:a05:600c:34ce:b0:412:f1ff:52a with SMTP id d14-20020a05600c34ce00b00412f1ff052amr536248wmq.24.1709679499858;
        Tue, 05 Mar 2024 14:58:19 -0800 (PST)
Received: from gmail.com (59.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.59])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b00412ed9b621bsm3002017wmn.5.2024.03.05.14.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 14:58:19 -0800 (PST)
Message-ID: <0fbe2b2e-448d-4611-8183-ce706d5848ae@gmail.com>
Date: Tue, 5 Mar 2024 23:58:04 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/22] avoid redundant pipelines
Content-Language: en-US
To: Beat Bolli <bb@drbeat.li>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Beat Bolli <dev+git@drbeat.li>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Elijah Newren <newren@gmail.com>,
 Philippe Blain <levraiphilippeblain@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20240305212533.12947-1-dev+git@drbeat.li>
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <20240305212533.12947-1-dev+git@drbeat.li>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, Mar 05, 2024 at 10:24:59PM +0100, Beat Bolli wrote:
> As follow-up to [1], here's a series that eliminates redundant
> pipelines, mostly under t/.
> 
> Spawning a process is notoriously slow on Windows, so this will improve
> test performance.
> 
> 1/22 to 14/22 remove redundant uses of "cat" where the shell handles
> input redirection from a file or the command can take a file argument.
> 
> 15/22 to 20/22 merge redundant uses of "grep" into the following "sed"
> or "awk" command. Both of these are capable of filtering themselves. I'm
> a bit on the fence about this part because readability suffers in some
> cases. It was a fun exercise, though :-)
> 
> 21/22 merges multiple "sed" calls into one and replaces a whole "cat |
> grep | awk" construct with a single "awk" call and uses "sort -u"
> instead of "sort | uniq".
> 
> 22/22 finally is a bit of an outlier in that it replaces a subshell with
> a shell compound command.

I have given it a cursory read and it looks a very good improvement.

I've left a couple of nits, none of them deserve a re-roll.

Thank you!
