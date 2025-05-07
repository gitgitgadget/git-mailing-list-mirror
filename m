Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101FA376
	for <git@vger.kernel.org>; Wed,  7 May 2025 01:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580358; cv=none; b=b0qEiCJ+/vhntC/KcDIVDUQEj/hH+gZEtUBdpCnwjXXMvPXjRTFkMcHM1phhGZWo3yMJ7T5V77mXA8JfHuL1Xge7q/dotmYndDBC5QQh/tvzntldsfmS7leH078N0U4SIOYpOR7b5YAi/T1LyzumfeGQRAhWPv414DqOI08HAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580358; c=relaxed/simple;
	bh=R/xnpHsb+JdY3f8ggiF15IQjb7kN8D9zNmSjWTBcNR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HUHWCgvZbZVAWPmktNqblaJpbilEe0rrc8zRSBpWpExJ2TxkP4QQVSaMsJDAS+atSgmKT0STlLEtr5kwApwZG5JZS0dxVPTjY2sxP0qyM+QbFGdPLmxymLgv4YVFAAb6xgoIU7HA+FObXClbKT3to6zYuZheXf9kKO003cSHWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7Vx3uGA; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7Vx3uGA"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6fead015247so58027487b3.2
        for <git@vger.kernel.org>; Tue, 06 May 2025 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746580356; x=1747185156; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wbr0n1ntHZrq2IK7vVo5NsPwx2RgzoHYUaImnwOUcGM=;
        b=i7Vx3uGAgXCK7TkfRqoKKeTXItot8PJoAljB/fCaztPaFPom2XV6mI2dGhrPj9w4w4
         uUxtms/0NXnXv9sNIAK9FwXG72E7rqHTIRShtybqcFuZH00cPw2tlU0Nj6QdIFPrwT7L
         sIsHIz1tgKLQg3j1s7Deml2GehnmulZ4+vy+iViufem0FnMHm+sbO+/cqlycxcDhAbC0
         r3sjDCK2kHv5UyWunQS6h4uTtPY7vsufqh4rMcwIGGmfofyVrq1W7WORbQBwFyYqQKRi
         K85spm921saB0C50mmx9sFeZUd5Qq9gdhBYDrt66CjO9Ti7jTnMrtz6FoBlrFSnA2paj
         TazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746580356; x=1747185156;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wbr0n1ntHZrq2IK7vVo5NsPwx2RgzoHYUaImnwOUcGM=;
        b=Cm1zjz2UZn2eazXcp7c2IKWWMviOO+soBQB5/MZE9hHTbJFWM4lsyAWZ514SrKP0uV
         24vwj2HoIXiUUiPaEaRh/h9SJDmyeybiLQL1KcLg2OFVXaqMBPMn1SVxqo9aRu2R20Ip
         LhwrdodNVCbhV5mRrSb4MxREdiLOHjbYB4L6GHlPv9qMdX7/3IMEcaGI7URkZqA4KOql
         aYmzHk+1Giz9VH2v4lJNGkGbc/+cJg1rSHQ09ptU9mFTp7bdOS2w8qiUo6vh2eU0Xcay
         f03UOETBZWus3sXz0YImcfFrRm2uIKK67pAeU6z2itYyiCUteGpocmw1t0sfhWD295wY
         hzmg==
X-Forwarded-Encrypted: i=1; AJvYcCXEtcreqasn/GiD+drUZ0n/ghaXm5i+la9wOxAU+g/S1YWNZCa1w+B280gwZQZm8hg8FZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu24/iR2zKOiOOTobZIjVchSUAuIZtrAUq49+z5+7rkCGrBHRJ
	45Fz782VIDAgpoRV/ZDDKZ43/sVMRGKAbHpzmitpeDq4OkykRtYsLAISYw==
X-Gm-Gg: ASbGncuug+giFfJXStY/cD6LNlnVCowEWyLhsybfhtT8AET/57X9IKuFgFM4wCRKlWM
	BzDpwPiUg0Hde3HZZ7FfA3n1cf2EOLDT1CW/o5mHlPzc7IWrr2gduiIb46AYljk5OdzUTN9oe3E
	sT+HZan68skdpERDf+xnv7msCM3mm4YGvgcA6S3MBkUqKFVnOzm8vBMadZm3P9i6+BX0b6+/QhW
	s1lvZes6c10bnugDoSRmfhkQsPTgIChBtdgNiH3ek/EGVAEl6dtSuafLLvZAxJdhfflXMf1Z/jc
	YDuqNo3bpkWz/PZwrlJ5Nhb+31P/gObCCGm0244coAwBqLnWXlICzp8Ax9nW8+iF54F//u5H+fX
	hGkKPsbYIZgmaGOY44Hi8PPkyvKkb
X-Google-Smtp-Source: AGHT+IFJXRv+8oambZJDd+2OfBOudgODlkt/P+IXj9ucayOMNXJlP5X45Zno8sHhljw+VPVaBxWfUw==
X-Received: by 2002:a05:690c:6a86:b0:708:2c19:bb4f with SMTP id 00721157ae682-70a1da10dddmr22667067b3.17.1746580355877;
        Tue, 06 May 2025 18:12:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:cc2e:477b:d336:3346? ([2600:1700:60ba:9810:cc2e:477b:d336:3346])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-708c46c6760sm30012247b3.114.2025.05.06.18.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 18:12:35 -0700 (PDT)
Message-ID: <9cd68129-1166-4f80-9b89-8f12c9d118c7@gmail.com>
Date: Tue, 6 May 2025 21:12:34 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/17] odb: get rid of `the_repository` in
 `assert_oid_type()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-7-c05b82e7b126@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20250506-pks-object-store-wo-the-repository-v1-7-c05b82e7b126@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> Get rid of our dependency on `the_repository` in `assert_oid_type()` by
> passing in the object database as a parameter and adjusting all callers.

Oops! This patch has the same message as patch 6 but is actually a
different change, removing the_repository from odb_mkstemp():

> -	pack_fd = odb_mkstemp(&tmp_file, "pack/tmp_pack_XXXXXX");
> +	pack_fd = odb_mkstemp(the_repository->objects, &tmp_file,
> +			      "pack/tmp_pack_XXXXXX");
...
>   /*
> - * Create a temporary file rooted in the object database directory, or
> - * die on failure. The filename is taken from "pattern", which should have the
> - * usual "XXXXXX" trailer, and the resulting filename is written into the
> - * "template" buffer. Returns the open descriptor.
> + * Create a temporary file rooted in the primary object database backend's
> + * directory, or die on failure. The filename is taken from "pattern", which
> + * should have the usual "XXXXXX" trailer, and the resulting filename is
> + * written into the "template" buffer. Returns the open descriptor.
>    */
> -int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
> +int odb_mkstemp(struct object_database *odb,
> +		struct strbuf *temp_filename, const char *pattern);

I'm happy with the code change, though.

Thanks,
-Stolee

