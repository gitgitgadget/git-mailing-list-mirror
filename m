Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C5A4AD4A5
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 14:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346815; cv=none; b=luAAt8DTe8Qy/8NZzsXSgdDO4RQEmVF5AhCo9lv9cnR+7KyCYv2l2NP9tgMFEJFf6vkjlioxM5Zu4FOzvXVeq1EbOsPjhbxWSltdhvBaIS5dPbBzDE4XJ44vYtTGjR+eS5MA+72SotNkalJVDoGnRnksGborom5WffwSbuvN2Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346815; c=relaxed/simple;
	bh=cWKOVHqrHX3j/Sqs2YPQ/fONQc444Ay3QJj4FKRmXM0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAd4qLmgkjOwGeMNsN/e/zJ9Gwf9EyvfHkC3PBBLYKzZ2hPx0E31PwU/NrXV+p8YJsomwySuM+Wzc/ktqFKuHa2J3VgGty2UM8juJ+uMfARBzxD11E49xtjy/GPuOHb32tWOpGhYBrjPPg/vJ6nxLFf8ps0QfpbrulmmtRHoSH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8haOxNC; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8haOxNC"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532c7643bc4so11478061cf.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790346810; x=1790951610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s4l2bWOCRt3Pgm/knKW33MGMIO/05UXbm3AC3As+wtc=;
        b=f8haOxNCcmTuWgvbZFrvaZu8uqRlbksqTjncERCVpV36KfLPxnn2YpYfnrzxAK2OIF
         HnZGDBiYPgZR0SQKENLruUwCoiK47ZRqpBvENmPLhG0Q/3sp+1npU3bszx1Q0uly8ACn
         4FdTisq1inz6HRtdeS+Rk/IuO+KZk24yVcnGUFKfGSSe5LB6kPOYsAVMmBQR2xF3pOnU
         swYCFwejdgFv7hENtave8TWZky5seV/Uze3DgY7fl4lc2Sa1BNyZZgxa4j96hR9m2yG6
         Dlqyae7AkNk26XYLLj0KlbtpUuxCWl+xJJ86QZsC1skXJ3WAvhYoU/I6RCoaeT61FuGA
         ZbiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790346810; x=1790951610;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s4l2bWOCRt3Pgm/knKW33MGMIO/05UXbm3AC3As+wtc=;
        b=MSUwqD7CLlIGEb0V7CJEtMccuLDRhF7naZE49SnbE8/K1fPLWtXBEYZic9w5Vhv/G6
         2zbSC+rD8vzhwxUQ3q6rJR8kpiqkEhFVsLmAMX9KxjIlWL2mWR7xEV7Nw2QCX6NBO8Yt
         j7QnbuNK9BYBR1mhzSPOSY/wz/lmIH8DGcb5I2LXeqiFTD30L4Ql1gOpni06GphXaTlx
         gD08qgaT5sejH31Nz+Ydas+t+Jb17/KG4piWIh08wL87YVhNS2jCG+4wINyqyMLR9gBl
         vyL0M8HYPvVYX7yo8UZcRevbx4t6viQUM9aqoWTU9fymYhn+knTT/Ul7uca6/1+IPIP+
         ZmFw==
X-Gm-Message-State: AFuF++mkNna1M58WZhJgBra0toeGU+9DTRrm51QSJXxooDhSamb/hjwF
	6istSiKseUE3zH5kBmPJ7C1GcoKTvRs0r0fbELUL3TCC+ytj9uOLKQJx
X-Gm-Gg: AYBFou22gQDXTRrDmRz1UUCaSxfLGqqPnQ5HIPQSbt+VNkCsyewApa1nvoKbfIa8g0x
	lXa/U3J2KtCUKemuu1FODS3U5zMPIfX9rQplVmem5cGK5KGGd4dDqnJ9kwA736CtxDvZM+GjOl1
	aQ4G0sicW9NY7LoveUYKL2y7DHeW34NJP5l78qeofrjSme5xJHTdlpJpneTuL8Q94gPJhBNV2RG
	iC1HKtOPm2UfU3gxTnPtaboeblWMhUnv6s1mS4IxG5e+irb20niuMRrj/iaWtn/5xWsQAryLnAI
	ClZZV+56+HebTqtC4wwD3wxFdKcU6ZUCfzSJIF/5yLA7O+6Jqm0mFyZXGUwAYLdqWWwozgdZsOJ
	j0/4gUwUDZl+isdz+6GBv4rczeF3gffGNMacud13P5s7BCeew0zOAv5JBBar6W5ckPcgMAwfEit
	JmZxVU2Le5H/FRCUIeHER/MzPWKKsZh7uPu1W8bjhWx/DO6syph/1C8vfmxVisJ99/zRlgYQKaV
	oCf/a8bO6t6AA==
X-Received: by 2002:ac8:690d:0:b0:532:b08b:45cd with SMTP id d75a77b69052e-5330b64deefmr43577971cf.31.1790346809663;
        Fri, 25 Sep 2026 07:33:29 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5330beeceefsm16295871cf.13.2026.09.25.07.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2026 07:33:29 -0700 (PDT)
Message-ID: <b27162ed-0c62-4ef0-b125-4340517e0d50@gmail.com>
Date: Fri, 25 Sep 2026 20:03:24 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] setup: communicate why a directory is not a valid
 git directory
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>,
 Karthik Nayak <karthik.188@gmail.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260924120502.2642141-4-kaartic.sivaraam@gmail.com>
 <xmqq7bkaz45e.fsf@gitster.g>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <xmqq7bkaz45e.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/26 03:46, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> +		strbuf_addf(&die_msg, _("not a git repository: '%s'"), gitdirenv);
>> +		strbuf_addch(&die_msg, '\n');
>> +		strbuf_addf(&die_msg, _("reason: %s"), invalid_gitdir_reason.buf);
>> +		die("%s", die_msg.buf);
>> +
>> +		strbuf_release(&die_msg);
> 
> You just called die(); nobody will execute this strbuf_release() for
> you, and because die() is marked with NORETURN, smart enough compilers
> would scold you for introducing dead code.
>

Oops. It should indeed warn me. I did a quick check and seems gcc (which 
I was using) lost its ability to report this long ago[1]. Sad. Clang 
clearly reports this.

[1]: https://gcc.gnu.org/legacy-ml/gcc-help/2011-05/msg00360.html

> Why are you lego-assembling localized message yourself, instead of
> doing something like ...
> 
> 	die(_("not a git repository: '%s'\nreason: %s"),
> 	    gitdirenv, invalid_gitdir_reason.buf);
> 
> ... which is what is usually done?
> 

That was my attempt at trying to save translators some work of 
translating the "not a git repository" part. I was thinking this lego 
was not a problem as it was not so complex. If we just want to avoid 
legos totally, I'm cool with doing it the usual way.

-- 
Sivaraam

