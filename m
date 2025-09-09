Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B91192B66
	for <git@vger.kernel.org>; Tue,  9 Sep 2025 19:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445624; cv=none; b=HEWz6uwMhr5471QpozE4qyWbkkyCkFhPoOcwQfE2xRXEJqnzv7mS3Ccq8xFVZAc/fwB79NtH3DOfSNcieBXKY3xvOF5YxldHOVLL+oQWCXMAo4B14pJd6qCEnaoZIBzoSMWJyWh93Cdzumv8JzE49I2mbMcVRUG7fjhxX3U/Zws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445624; c=relaxed/simple;
	bh=Ic+rbQeT0ZfkVZ508KNa6nZgbLKXeKIud+afIczDLTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBV7vYOtdPn6OygLmNlb+p+VFG5KWJ0lOKNcRThJHnx5n+pAq1VNDFfPRxUozpvZ402cSBph1/mwAD7mt7Hm20u2WFmzZ6bKWa8fw1K0P7ZfvP2qRbS+ieTnmI1UfPAaASjYK+xV+PIZK8qdtnKF9NKczae7Qa2O61Zo7iJ/0Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEolxzK9; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEolxzK9"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3d44d734cabso4234976f8f.3
        for <git@vger.kernel.org>; Tue, 09 Sep 2025 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757445621; x=1758050421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GKAjdyev2Q9CbP2DlT3lXVb3WYFCUbiQhIEnwnLeu5o=;
        b=UEolxzK9M0ryKm7BZJmZxbUvKVwlxmMiXKz6nVAqJReRP5faH7rjssW3/C54N9fY1y
         Jfhl7aNp916cwNhfEmmzJeguhygTh0h8faZlBA4+JOstELndAvOYh3W9wotCaXxkp2uC
         WvIL9h9oj8nkQhAkH+DKIZ3CPny5I2ZU8JjxD/1Ugm8wbqnxDp6LEGjRYiEM40S9IDIM
         zDI/lJSUH5WnXvoFKh0np+HIP6Qub9PMnX/6w+27/cklEMhrNCG6S3X4+4MMnRJGSuo0
         QYvZ2xqCT8PwBIjoOYr1KknX9gDm6G/p1Y63b5KZI2H6PTRkiZOA1LQOWv9P34phU3Jv
         WPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445621; x=1758050421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GKAjdyev2Q9CbP2DlT3lXVb3WYFCUbiQhIEnwnLeu5o=;
        b=IgI2Q2ZGLDedqk3Nu8E+OO+Ro4sjlnW8i7IVTeQZ3oCwysJH62dguVkMyVyRYEfXGq
         QozQmUMSzOnP7/TEFPw1OWjmHW55vVHQnI7a9dSSZpMI7r1HlsRrp9f1sLG2xd9Q+8ET
         lHEzpDvqDXdAgejlw+bIfnX4RZ9sDFh8DY18o5GVHcGeAO87KVpBi3K84RFQz6SCv3c2
         SJif0qd9Z7/L3OSNoG2xU10GpNtK16W9ZBLwl0yJszSa6tef9JHTP0vj3J8IUAJ59Soq
         xu9dGi7tWi6H33iG64Qng6y/fZYVUckvQOdY8DU/0swhDRpM9crUW5FFBIIPiv+I+v+4
         Dsdw==
X-Forwarded-Encrypted: i=1; AJvYcCWmUzn9++6Cr/EQY1V/OEBp4i0DhF7xi04BOWIs1xhhIpFrPpHLLdJTi32xDFtWvgVu7vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwffXlKrgbTmMpNkkk4MOGV2DO7m2rhnM5oSsg2IQPe1x1YKip3
	jBz5OqqhgTQiZu1X+xoeuMhiIpvqMDr+HYF69FmL/tfelpEkNE/0tglB
X-Gm-Gg: ASbGncuBcSRyc1+VUW7CEZ69CsqHuS2JOdM2aAL2JgIxCIwDYcmh9Mj+JTdb30PcW7G
	Xs6Rq0XqnRxYte+dMC/U+/UfMA+4V0qktDD46qTVufazvWSWwEcJQyo66jSQu3hxabUEzBEJKnl
	/pB4CmrGmi/EO0EMdSohGgVWAm2i3VGKErVRYTbgfPjAAqSTDQgWsLckUMTVIHF6lnY8GCD04Lg
	svOGdGUAqABTd9ho0tRgKhL0pUcwpHzVxmP14T7Mz4eciw2O0VLsBgZukTiZljhP8cT/1jsywjR
	s4oK/usQYiur4l7SZjy5XBXrdznZ/JQuPk38Tqc+/v8aLmSKDY3oU7QxWe0bSD0slpYx8HKRLJa
	dq4sLnhuzTtMYJBWBVtKquo2WyEGci1Im
X-Google-Smtp-Source: AGHT+IGmno5WtKDW8js9nyRt6DRn3ORlT2VP1baC/bVKUFOJK5l52kqWRjtETXMrrHvElYtggIEM+g==
X-Received: by 2002:a05:6000:2489:b0:3e5:2082:8941 with SMTP id ffacd0b85a97d-3e642f9050amr10804438f8f.23.1757445621223;
        Tue, 09 Sep 2025 12:20:21 -0700 (PDT)
Received: from [10.12.11.8] ([212.102.39.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238901sm3701521f8f.38.2025.09.09.12.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:20:20 -0700 (PDT)
Message-ID: <0683661d-3e70-40e7-9f14-c1702d17fb80@gmail.com>
Date: Tue, 9 Sep 2025 21:20:17 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] replay: document --update-refs and --batch options
To: Siddharth Asthana <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Toon Claes <toon@iotcl.com>, John Cai <johncai86@gmail.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20250908043620.57848-1-siddharthasthana31@gmail.com>
 <20250908043620.57848-3-siddharthasthana31@gmail.com>
Content-Language: en-US
From: Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <20250908043620.57848-3-siddharthasthana31@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

hello, Siddharth Asthana

On 08/09/2025 06:36, Siddharth Asthana wrote:
> @@ -91,6 +120,27 @@ $ git replay --advance target origin/main..mybranch
>   update refs/heads/target ${NEW_target_HASH} ${OLD_target_HASH}
>   ------------
>   
> +To rebase `mybranch` onto `target` and update the ref directly:
> +
> +------------
> +$ git replay --update --onto target origin/main..mybranch
> +# No output; mybranch is updated directly
> +------------
> +
> +To rebase `mybranch` onto `target` using atomic ref transactions:
> +
> +------------
> +$ git replay --update-refs --onto target origin/main..mybranch
> +# No output; mybranch is updated atomically
> +------------
> +
> +To rebase multiple branches with partial failure tolerance:
> +
> +------------
> +$ git replay --update-refs --batch --contained --onto origin/main origin/main..tipbranch
> +# No output; refs updated in batch mode, warnings for any failures
> +------------
> +
>   Note that the first two examples replay the exact same commits and on
>   top of the exact same new base, they only differ in that the first
>   provides instructions to make mybranch point at the new commits and

Adding new examples above this paragraph separates it from the existing 
examples it refers to.
