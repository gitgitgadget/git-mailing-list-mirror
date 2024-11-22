Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A951DF73B
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732293889; cv=none; b=h87y1jdrhkF4Q7b4VW/sOLMU25lva6vAaKhFq2W9GTD6nb2fDno9KlLh29YoJbBdCkf0f6MaCqPOYanhippNK5xcifZ2Yj/PNdt8vAAXhTYHJnezqCypCktOOOi0D7s7Flrp7oY2hHCAx2a5p796/aVvLUG5ARtp7hHY8s3XcfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732293889; c=relaxed/simple;
	bh=dUbSVbE2+e5M3ENcbAgd2rX8wEviM3txwTbFreIIihA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Hn5ZpXTUqptp9WIAcNSOoxzIzKqL8iE0vPFT9oV7zXNOwvQKHLKYhSXduH9A48f6X3OFnLgMAVzRNvBm4fxU4gzJvEiOK9RTi+UKvjdd9fHdl6iWwHq7EyeCRK20cQGx7b+GNDQejJGvpZAfzxJb+jxU320TK3XxzEM6P0q0Zfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJYzVmFl; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJYzVmFl"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3822ec43fb0so1759572f8f.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 08:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732293886; x=1732898686; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyEzRW+uulhatUiXgGZdO1NXsJciM0exxF1XM23MHhI=;
        b=TJYzVmFlapIcvg1jDp3Wejh/2jDXWmCTtYH35wYEKZAxhIAa0BZ/Z7WrGHumzVyimu
         b7DLL8drGVMGD7K+X6RQYlH8tYvGq7RBGtn3X80aCeINi0PsqIJqCXFSFsI74dnEM4nb
         Sa70EmihhIVAh0PdP+yggdVPexMIMmHxUoo2vcdhVA4VaQ1uNYS1znceMyj2OyT+aMP7
         X0iXiIiUBr192ZNS8BBrgA3sfHU2ouItAfSCjvYEw/WH0hfjWoynh5xk0l1IoqFTxWLz
         sD6G86/R11rGlCe7FegqRsvkAuhXvJuHMiNR+K8P+YAd3NmDD48i/jWfuTfS173jYLVU
         B7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732293886; x=1732898686;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyEzRW+uulhatUiXgGZdO1NXsJciM0exxF1XM23MHhI=;
        b=MV57atTP7hPD8Q5cXp0q6x4djy/e3L0adEmWydmOemyxnU6tahz1QJkl9jbRgNokq/
         PAIPRrhYbuYTVd6nAZf6SQujwpJjKCJIOt/gI+jYlr2Q9CRaYw9ghEFBP3fwKVStkqrX
         QHjUdF6CS4EJcTdZ+SSu1QngTkOx7l00rQ6/OEwKMFdhRD/46kT3rbXXNwliFcvvk72j
         oLKvFRbOiGKKw7Oqoks9ep2dFbCQrF1UQjRMXwb0Kyj916GaVnZ6RjkHoqfwVhPzRKSb
         fumz3nj6MT2WocJRIoNQuskpPVHlWC98ZWgizSGH688JTb4tO5FnoD4Z+uT/uZ3PMWl8
         Zs9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJnpHBq642s2KITbxZMVl90TgW/abU3auTdGAeH4UNCE1rOYj8WfAq2htm+7aXiMK20ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw68WaWyWfnAy5Q9rJkmKsuo0yzVqf/zhNJuA2nWJwNPEOzify3
	oJiv3CVn08MqJNrJHaUqT+VprxJVQ7KegLkA6UkZWfCTkZYeKM1N
X-Gm-Gg: ASbGncvJGc6ibHEkrbsdZ+lk9mYwy+Nk1uGDqDSOHShFZeojB3Ps/4fpjjuNo5hROyj
	J1SuIm2jvamaHNx2SVShnqUEWDNkiqZ2LpPMpCRO4YvENls5xLjUsXyt/hW6w3mjRY2dJRGvDV2
	oKhAnf25FPn0nyHQfXH7aiSAsrOszO9F+f8UP/6XRjgPG8QpMPocq+BLbpvzqJUrJlcwZCL7mcJ
	MjbJ7Og2/3j0K/Nu6fJ3yjHM2uN0qx7j2ouYnWFfw3dneRjx0TEa1i9sOgPf4y29IHZBFwcjI36
	dVksZqORHiKSN3/keVOKNVz1lQ==
X-Google-Smtp-Source: AGHT+IFOquWUXh5V1RJVTfkKrMib0oLdvRdvvYElgXZuA/4w18qkq2eg+d3nckU/BJO2W3ybmclB+g==
X-Received: by 2002:a05:6000:2cf:b0:382:4b63:96b5 with SMTP id ffacd0b85a97d-38260beb1efmr3076517f8f.57.1732293886436;
        Fri, 22 Nov 2024 08:44:46 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:6a8:b801:610:d596:f87c:e591? ([2a0a:ef40:6a8:b801:610:d596:f87c:e591])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe91a6sm2892369f8f.86.2024.11.22.08.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 08:44:46 -0800 (PST)
Message-ID: <18dd2d59-aa12-4921-bd2a-2bbc0027c63c@gmail.com>
Date: Fri, 22 Nov 2024 16:44:45 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 3/8] worktree: refactor infer_backlink return
To: Caleb White <cdwhite3@pm.me>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me>
 <20241031-wt_relative_options-v4-3-07a3dc0f02a3@pm.me>
 <977c1e75-1fef-4827-91ae-cc1a6ce7508e@gmail.com>
 <D5QR4BHKBZH9.231NGDY7RCV0L@pm.me>
Content-Language: en-US
In-Reply-To: <D5QR4BHKBZH9.231NGDY7RCV0L@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2024 05:20, Caleb White wrote:
> On Tue Nov 19, 2024 at 9:08 AM CST, Phillip Wood wrote:
>>>    	strbuf_release(&actual);
>>> -	return 1;
>>> -
>>> +	return inferred->len;
>>>    error:
>>>    	strbuf_release(&actual);
>>>    	strbuf_reset(inferred); /* clear invalid path */
>>> -	return 0;
>>> +	return -1;
>>
>> Why don't we need to update the callers of this function to account for
>> the new return value?
> 
> Originally this function was called inside an `if` statement, however,
> another topic extracted the call to a separate line and so this return
> was no longer used. I decided to keep the return anyway in case it was
> useful in the future.

If we don't use the return value I'd be inclined to leave it as is.

Best Wishes

Phillip

> 
> Best,
> 
> Caleb
> 

