Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B528F5B
	for <git@vger.kernel.org>; Sun, 23 Jun 2024 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719160495; cv=none; b=fMWpYsEjl5C0BkUdSmw4olcvKwcbzWWCvtihWa7XZmr6oBD883BnzsYmDUq81ds4sj2HKpVqLux7GtlFLBeRKDSX7JDaIFLHVnhl4LkQIOZDvdCSCq1QHlc7wCc7r7w8j/q3PoAMO8AJg6xejZdau3sB22ZtafKvHCoCdJODO88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719160495; c=relaxed/simple;
	bh=gOC5ENW1QVA40IL1hziqE65e7cd6SJ8PmjeC75xrfdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eAHYsXVeiNbaYhADbb7dlJ1dDfQmnVrbTQYHBmm0H0jHw9/O13fJqzoOA3Yc7BpMi0u/Pq7hxrTB77dHezg0d2uwPy344y47zjqFsgCn2rBs9+0Jnz9QXT9jvgvAKH4Rc+afniEAGdBTPU7F433eZ7SMZhTYCKK8ayZJwzomaaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDtLzKu7; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDtLzKu7"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d541d93127so434949b6e.2
        for <git@vger.kernel.org>; Sun, 23 Jun 2024 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719160492; x=1719765292; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MAsX8thl7q2uBYUUp1tN4wBoKfOIlSK495mhFs6okv8=;
        b=nDtLzKu7sNkygejUej/lHDo32QC3L+dZYFCfU4+rxqUCofdxO+suEtGuydBbJqJn3d
         tdL0w4wO/RG1dxuYmQ5TTnmTfHyZbAu9DeVy2bAXaGT+DW07+NnawyMZn6vLbrQ1FJgD
         RIZYldm3JSaJMsnupblPm6bNC5Yq2FC/KgusSwia30nfLgdLKLbStawi694EWmWDvGuE
         gcv7TVwr4Hko7UF3Ej09LO/IPIQT+tTA27nAzfrfcVGljpVn5fWYbQ0FvUtnw0EQN0WP
         y9HWb4KSxc7vwNJ03HRPqeO+/j+GGmUOGZKgmFkewQgqLuvzb4z2J4erouU3tOqag6m2
         JkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719160492; x=1719765292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAsX8thl7q2uBYUUp1tN4wBoKfOIlSK495mhFs6okv8=;
        b=Ik76kHrYakEObEEG8ju2rPYykkBoo0faw4RhNUC/zWzVFuy0ChIEoaWxkHt0ECwvc8
         T2HIBbIBmfxAxamc9uB5X3ih2QLPKVBs1WDIjyYIg/lSqPkmvFdbl6AwWTHqQP+zbY9z
         LJPgUC5o3JbGus5GdmOfr7PwC3/8iRgZM7iq9MCvZHtmNJcNAijxx1nH3LtwaBshVJQU
         8rmMUoYxzTEA+5pL5aePnr1Y6Y3yFdOudIlCfdxHYjzr4ySFYWIhrByUAs0xrAwTYFbb
         XzmOT15qaBnmPpZ6cMAVqEMSjEGqgTrXnKgKUptc/MWBMxRvWf1NF2YHjTqCqqQyNl2C
         g2fA==
X-Forwarded-Encrypted: i=1; AJvYcCUphY27ShoTnXrA+4YkGBIu5Qzqiu3jz+kDsxfimakgtNWCKM7iBxwn+vwZ/jmwvfsgGkuepJA4xCd+oVgVnS9sX4Fp
X-Gm-Message-State: AOJu0Yw/lYVO04Bx+heH6x/3waqPR+v5gHNDUQhZvB3m0cvBXvo4PAcv
	zzLuZhkwpXhzSzRenqSVQzv9Ux5zNzjCd2rSBeNnDBvSN/ws7xbb0bY1eA==
X-Google-Smtp-Source: AGHT+IGx4dZbDJtpzm55SAn1bbe3Uh4Hc0rKNQSUlK0w7tKPzR9MovWxQP60PZ7vpHI9iSGg6N9WXQ==
X-Received: by 2002:a05:6808:2207:b0:3d2:2749:6a8a with SMTP id 5614622812f47-3d54596378dmr3402902b6e.4.1719160492416;
        Sun, 23 Jun 2024 09:34:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:f89a:27cf:b0be:798a? ([2600:1700:60ba:9810:f89a:27cf:b0be:798a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d5345a54eesm1112386b6e.43.2024.06.23.09.34.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 09:34:51 -0700 (PDT)
Message-ID: <1f536f91-1dce-4156-98f2-4059cd5235ff@gmail.com>
Date: Sun, 23 Jun 2024 12:34:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] object-file: fix leak on conversion failure
To: Eric Wong <e@80x24.org>, "Eric W. Biederman" <ebiederm@xmission.com>,
 git@vger.kernel.org
References: <20240622043648.M78681@dcvr>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20240622043648.M78681@dcvr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/22/24 12:36 AM, Eric Wong wrote:
> I'm not sure exactly how to trigger the leak, but it seems fairly
> obvious that the `content' buffer should be freed even if
> convert_object_file() fails.  Noticed while working in this area
> on unrelated things.

Definitely a good thing to include, even if it is unlikely to
be hit frequently in common scenarios.

>   			ret = convert_object_file(&outbuf,
>   						  the_hash_algo, input_algo,
>   						  content, size, type, !do_die);
> +			free(content);
>   			if (ret == -1)
>   				return -1;
> -			free(content);

I looked at the context of this function to see that 'content'
was local to the method, so was not "owned" by something outside
of the method that might expect to reuse the buffer on failure.

Thanks,
-Stolee
