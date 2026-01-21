Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C924481AB6
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012892; cv=none; b=lKs7n9pB2HXbcFQjCzqu3THGNQSEz8934BrDE4ZFggrDqNMO/7CXQ61RegmhvsLrYGrPKVpDHvjjw9RxlGElE8cH9szkgsSelOBHJZKRnLzYUU/21ZGPFc2juqi8OD3FBwCMeURRvWrZJ+nXaBTcr3iAQxbyQNBn7yVwm7lfg9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012892; c=relaxed/simple;
	bh=PnhHu5NQHqKgFjAGUr4SxADmbjQHJh3xltQrMyGBgIA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aA8r/sYETx8sq+Mtg4wQzzun6yQ7QdjgfaMthloYbym+kTPGxcMVxtD8czi1ho6iviZv1tAoD2zbHN9zexKWB88PbnrHSTLB6EjHnO9F9nUJ61Qu8oTNfpgfOAWoUXzMBIfcugb3eMQseZjGhqqZC5GMwJ92QkjgsninBH1RMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8G0w8Aw; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8G0w8Aw"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c5386f1c9fso879785a.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 08:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769012887; x=1769617687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PnhHu5NQHqKgFjAGUr4SxADmbjQHJh3xltQrMyGBgIA=;
        b=J8G0w8AwLFzEvDT/jb9JR5k7Tf6wsXDonfAodMHrReMWg4L/VAk3gwYS6HMY8vAuGG
         tQMFn8hb0HTofq7xyx0YbhF3YHNTQRG1VouIik+FQG7oltriTx4vfLyYJupG8w9Z/oXP
         XSWYTNx6n2RJ5LOrkFV+g7qCPJAMrb+eVNuC6wIbFsuIKPkK1T7Ff41TMX83LL7yL5OE
         lE0bDtWWbqED2w8Q4b/HJgEsQ5Z4HHGDa9u7A3pO7DvBiQ2RGAo0JKe9zCUnic/fuzfw
         S7lupAnHHHKpmH8lopQFyvvTKsszT5k3ojroS3aSh4qhf0L4/9qJGXpyFnTxclL6Ji93
         Qp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769012887; x=1769617687;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnhHu5NQHqKgFjAGUr4SxADmbjQHJh3xltQrMyGBgIA=;
        b=ocxRxc9oD4a7M0sZt/UK4nPb7vtt7N9nlQr/bdPiEzlfg9ElHToHXm0ivOqFTP7V/+
         Z1rXKr/zBGe6oNHDdLJ/C1PrAItWiT8KiTcYkx0N4wva34ykEf0Lt2PwjcF+wRPK9QHj
         yF6kx9S+RGGnkE4w+oTqFQ7NIrCcraTVSXSTyq4rjB5mDVJbSgoc3U0woPQiCo2y9Lz/
         YnEqR/a8mH6Cbm45sOcwfJEW42tSnvugzEv2ijMpwIpj23DI9EHMZumK5BWFA1qm+Asi
         TUFJtEm3O5u57d4wL/7YwUAG7IBxtwz6tgq9Q1X5EbtHsLDfQ+O7b+RH4i2nhcJSIlmZ
         YDzA==
X-Forwarded-Encrypted: i=1; AJvYcCWMPzZZMz1gcedMAn0QMnD3ynXV7cx+IfEGa1HZgRkWskH+JDl6bUQ/2Mjtqgqd8rUQxMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpyO1WxVdLURmAzJEk3xoRZO/HrtOajIn100Uz06bHtWhkeoY1
	Jdl7rnAjXu33p+dCFfvIxR0DB1xMlo1clGBJ/imsBxkCpUEYrIuiYfT9HR9Urg==
X-Gm-Gg: AZuq6aKVZdb3pcIEzNXA2qo+CgPKyIxwI3054XhbKtoI2iW2JxOWruuPfCeVymS1aeS
	NC0b8iD76qDv2ga9qkSRhDuLDHBDQt4iTcOA5R2eYGT55GSIe7T0PtPQDtDAAhbInq9z/1tGl9W
	4Ix01vhg2ptYYyCzzq3rV084laBoJSvkT14LZd5VsqNrfsPZjepjQR76GVvFAGS5v74n5o8ERDs
	lawg6hWoitO+b2JTvuoeAnblyY6zT+6BMT8O7iVqCJ86DAsl8kHglvmR/zfoZLWvUv2+X7t1g83
	OuvusZ9/sKjU2vw7AOfS9wjkCqu/ynCwzdYPQ2vNilvB7ezqRqZWF/HnADGHsdctPDxz/qo28o+
	enM/g45RCivzxmXQMOJIFRJg2fxklC5EmkMHGMG2PukxX2QtcFrZG2J48WiowoGHucHFwOzP7DP
	d62CRiJg5D7bkqvLBKGsiRBHhuHq0GZ3al36l2TLDPnefzX3WpjSBo47ktnKITHY3nETO4
X-Received: by 2002:a05:620a:1a94:b0:8b2:e17a:37 with SMTP id af79cd13be357-8c6a6956532mr2377242685a.43.1769012887572;
        Wed, 21 Jan 2026 08:28:07 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a71ac960sm1246643785a.4.2026.01.21.08.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jan 2026 08:28:07 -0800 (PST)
Message-ID: <615b31c3-a47a-43bc-8dcf-7943ead101a7@gmail.com>
Date: Wed, 21 Jan 2026 11:28:06 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] sparse-checkout: optimize string_list construction and
 add tests to verify deduplication.
To: Amisha Chhajed <amishhhaaaa@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>
References: <20260120153829.48044-1-amishhhaaaa@gmail.com>
 <20260121130005.72375-1-amishhhaaaa@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260121130005.72375-1-amishhhaaaa@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/21/2026 8:00 AM, Amisha Chhajed wrote:
> Improve O(n^2) complexity to O(n log n) while building a sorted
> 'string_list' by constructing it unsorted then sorting it
> followed by removing duplicates.

Thanks for iterating on this. I think v7 is good to go.

Thanks,
-Stolee

