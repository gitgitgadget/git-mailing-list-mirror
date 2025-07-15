Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE1619DF4F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547718; cv=none; b=UHUsfgnHL1gw56Jqs/5YGadsK9XpsVT4MvbiCyuM4NYNd9LDQRGRQ2pesgTSeeOruqacWaXXpCt7R3szoQQ3xblVGd4x9f/1hH3SNxMjF4e/owvbXE62lzxId46vS6B5zUSHjS7+MuzRlP2tbCjzF4VcqtLndvWIXs/i9oByRzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547718; c=relaxed/simple;
	bh=Up6DUx7PnezLjPOd1HoBzV8qeCc080yYDnCAvoArtu4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0q5EKk1BDftxRKxaXjZ1nkRw0zok+oQ1Lk2EOyWl+vUhCYLH01jKzXJTqoFcUZqsz9K/16Ism3JjN7AC2OlexDH6K8C91/chjx+wSqU1ARppZ7s1cEzeVFoWnbxuu+w7AbZrKZvb0zwgTBdV4ByPP9UlmEX5LLdtbypMj6eRiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhTTIPA1; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhTTIPA1"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e8986a25cbfso3492497276.0
        for <git@vger.kernel.org>; Mon, 14 Jul 2025 19:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752547714; x=1753152514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dVcPf3uyk3n117grt7Juq/mZLO8a941LQI9l00KDa30=;
        b=jhTTIPA1aqFy/UwcUlITLI+T/HZ6Tn8APsmZJ3UYTsO9Rk28P8MKcU8dWkHBE1lKft
         utYRcrsRF33lZEM3nTrlQB96iRphcMLh8k1hre9243igoNar+ZgppX92j3r3aPra5dwH
         mJgc2iSdS3qPaiW9TP29cKRD0OAP00Mv/HRGGg5gZmmBVlhJJL+ZgpZqhd55bKytZP2g
         so1haYbXn4izBonbNmYeFyqVB+vYBNjqIBqQ3W1ucugaUkQxbRN0GEVfbtI+aF/DwCb/
         KDlAxzn+dKbi6idR6Vna2kbkDiGxnPd+6XRfFWedgWyNQ3I9lKHWbxs0HssV+JV6uVcD
         Z4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752547714; x=1753152514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVcPf3uyk3n117grt7Juq/mZLO8a941LQI9l00KDa30=;
        b=ow3+zsXIh5PFyDTMO9KARzpNrjsaT1Ed+0uR+8ND3MXWSUxrM1sAHM3Z6VOyWwPGCp
         7brzpXX+IjgQt5vlL9GvNmJiitb4epZs+f3h69JNo1GH/YFaESo+i9txI/DS0ZiiZXXK
         4S4zseVxhDjDrQvOn7f1K1SL8TU6UPqkr5y1VxikeDJmEJa2fW9m7dlGpkJuELlg/N7L
         BeHtv7Z1DoT3hZCRNL6tkCLCrzPLsFu+E6hKE4/lLQgTK7qzbusn3qQnEMNqMqNZrIBC
         81YyZs8ic4Yk8zt0PO0/gzzhAETFoMfqdACVUFStVW8Ipmst/2d0AKccWGKU5mNFP2HB
         U0VA==
X-Gm-Message-State: AOJu0YwLKYsBYTga/6UHZ2L1jYPDno9hQwJJkPF89zQFnndGk9f0Ra9s
	j0Qk20WjkzTW/LvDcLi7OS9EYt2sNkY9rGHU0ItJZG6Qz+Lg7nIPULadXeUsucTi
X-Gm-Gg: ASbGncvXVXOoSZiT9gSXX5QgkPctPzxrm9D2Y24OXmcL+Iwcd5wSJqB9/J7I95Nvq7a
	JsajnaAx4yHbOcRtzRyvBUqneNWvuL4camh4z9J7sGjjFAPCviHLJf5y9iUMb2WI1KKPSbDN86k
	IjBY+t/ITHLRSdWQKnIcBfjgOmA2aOOi4QpeAOp3EvnvAOuTDzBfiAWnNDGsgtNSRkhj/Esc+U5
	zTDfL8aqAuy6rD3BRnUoPvPZOHh3/qRE19fBLsxXkRX379R/t6kHA012ej/a+tmLB2p2NTrn0SX
	FPK6GhDlQUxEvDC57FUDaZV8asTOTAUhqCH+nCuhybgUSB1NNBNLuzzcYrievBA0dGzeQoslIkX
	VK4ofAzKRlc1L4Kb0KM/YY/9qOkfhO/ZoQUqDVpoKpyWOi9mx+XQ3Ld1pZVPDZNDTbGvsfrHpRw
	==
X-Google-Smtp-Source: AGHT+IEUYgc0qnvohFjECaIohDYTHMJ2nnRrVyHmAcyMEL/oF2qi+ziDfzHN0TGwy3pNOIKBq5ihaA==
X-Received: by 2002:a05:690c:6486:b0:70e:1bd8:a9c8 with SMTP id 00721157ae682-717d5dab2f2mr243117707b3.23.1752547714352;
        Mon, 14 Jul 2025 19:48:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:ad86:8f48:e4d2:eade? ([2600:1700:60ba:9810:ad86:8f48:e4d2:eade])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d73ae5sm22199347b3.46.2025.07.14.19.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 19:48:33 -0700 (PDT)
Message-ID: <bab82a6f-e704-45a5-b422-75dec2b86d90@gmail.com>
Date: Mon, 14 Jul 2025 22:48:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/5] bloom: enable bloom filter optimization for
 multiple pathspec elements in revision traversal
To: Lidong Yan <502024330056@smail.nju.edu.cn>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com
References: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250712093517.17907-1-yldhome2d2@gmail.com>
 <0969e176-b9c7-464d-8e97-cf5cd4a06347@gmail.com>
 <B090DCBA-7306-4BA9-A5BA-DA81D1ABB29C@smail.nju.edu.cn>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <B090DCBA-7306-4BA9-A5BA-DA81D1ABB29C@smail.nju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/14/2025 9:34 PM, Lidong Yan wrote:
> Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 7/12/2025 5:35 AM, Lidong Yan wrote:
>>
>>> The difference from v5 is:
>>>  - extract convert pathspec item to bloom_keyvec logic to
>>>    a separate function, which simplifies the prepare_to_use_bloom_filter()
>>>    function.
>>>  - fix few bugs in v5.
>>
>> Thanks for making these changes. Including your fixed patch 5, this
>> version looks ready to me.
>>
>> I wouldn't say "fix a few bugs" but instead "fix some compile-time
>> linting complaints when using DEVELOPER=1" to be clear that the
>> functionality hasn't changed but the code is cleaner.
> 
> I just learned that `make DEVELOPER=1` treats warnings as errors.
> Since this is just a cover letter issue, I feel it might not be worth rerolling
> the patch again.

No need to reroll anything, I think. Junio's got the right
fixups in place.

This was just a comment to help you next time.

Thanks,
-Stolee

