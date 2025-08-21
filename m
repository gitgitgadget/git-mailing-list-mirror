Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FF31353B
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808406; cv=none; b=Jrz8Vq6eTX0rbv+WZxNZCXi8mCVAN5n36Se3R4bt7G43K08OWfD2hlaNdywHYOvzNU9eaNQl3C+fdcOPrmdnzlcywMb6/RrAAWEt5/hp6B7BeDdMjst4cYEe65Cmr73mRuQSrOrv3tK/LmBdtiPdgAqC3hHIbLHf+zsvVMFTiXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808406; c=relaxed/simple;
	bh=s8gC8f8+kstBLBtc9POa7n5EyTtWyntlDKfsYXQS95A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n75EJJlltUgc1/egERIMpux2ApPe2QQkrWKShZieDSCFRELq//RCYQWwdTRxkzDhbhW37Nei3yIFcQw9S6CyvSZgav/AYF9iPSAw6R5WPdsXmbNx08xomTUa3oIH0oUsfC1za2P/OwrhpVIVcQr0Qh/B5ndQkm25fjwTSmjlNJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j46svySW; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j46svySW"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-70d7c7e9693so9148206d6.3
        for <git@vger.kernel.org>; Thu, 21 Aug 2025 13:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755808403; x=1756413203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WToyTsXpB6lNQ94s4eLF8jwpZMqyOoBWtHjT5L6GbQw=;
        b=j46svySWAzA67U6XD3CGFxnleiG76+tBfQ523Lk1qYV9QwiSEhn1PufOUH0R1p3+n2
         GnR+D0oFoZVZefNl5hHrAC1pdqozADoUzhTVs/19iYBwmBZEHwDzEdKeya1rpjybEhId
         WdTBClBFwSQkwI89sMr3+S3snaGH/AfQfzt8LWBU6GArx21aUR2f1VHEOAYNMG1e9X+t
         /bwKYUz45UbgyUgDAVvHliZb4uOAWj6KMt1dfuK8QNyVOb/MFIAFgq4vuP597+cyZXNU
         fRgm0xG9G2WIvP8GlrwhUX10ZJQd1AR+OImaxmevfx4l7X1S+D7d33fM3CZSojjwEWKC
         3svw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755808403; x=1756413203;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WToyTsXpB6lNQ94s4eLF8jwpZMqyOoBWtHjT5L6GbQw=;
        b=UrGJC7qBtsknI2WE6OwGrfJUA1CoCbKJr0d1/yPoUi5gzpjxB3vuvj0QyjXS4toBoc
         65kp0tWERMkCjjAuH5APeIBML+5Plap4Uh47EcGMziVbhC0CxQyk3MsU60uZjgeQyBD6
         y0e3jm5ySJvz34WJuKnGaec0dt0dsLefUUqnHEBE7Apu1EmI6n/NlMVDw3eFYgZ5fJvE
         COTCMwi87CDmXZZG4czbk46PGWqjmzBQ0doqrztvKG4jr1D7+wpdkwUvSKF0nvdoGCK/
         asygHKManQBs9u6OuLsST7wQgDiO1Y/QSoROuhMwKFOKHwb2Jd+LMAg2vy6Wnu5tECPz
         6T4w==
X-Gm-Message-State: AOJu0Yw/YEf3+fW0N0u9zQ6YQLJQLBB+KJRj2OhsNGyALQpoDjI6S2KF
	uC3GCFti8s2zWIllf3pSR+Y5ec/y0XyXKYw8Cb50JxX6yvRjRzuqu4yo
X-Gm-Gg: ASbGncvGhFoh/nOBWwfg1Mp2ANj5JsbkFv5i7IQSuvhIHyxqKU6FhNSJ/q/NEuRrcf+
	qkpiH+gKmPG+m/cWW6yQireWd4ubDboJtIQ9y0lkhaxYR7mOWhsBlZQjGYjnyt/9IPq6MCzQzAH
	Kv0ogyW1En0ESxKmy6Yy+J3RNxubd6TkyEPiwKDuBoAa7rRVxY9Q35SXKTY8pvz9gAqj7yyCRkH
	yFHm8ES5oJdcscCFbzhT+M6/5V6X4tWIN9JuoRMev3o0L+BjXJlwYrDGOItSV9ckEzmnMEiD+Py
	zLacmF7k24nmEks/1OGhexnbFvoCuuiZIV8WG+v68oOmoTLi2QV5NABKO9xYgKy+7E0/pHOsIEW
	/fIzj2Sp4esu35KO9hzr1sA4biIWWxXJKGY4=
X-Google-Smtp-Source: AGHT+IFA6giFJELPt4PTq7aTbrmlyOqH36suwbB+rxPAJaORMm5CIiEdd+pmJDPUi81LrFN+6RYxWw==
X-Received: by 2002:ad4:5b81:0:b0:70d:6df3:9a8b with SMTP id 6a1803df08f44-70d9740c09fmr10622986d6.59.1755808402970;
        Thu, 21 Aug 2025 13:33:22 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.70.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70d946fbb79sm8388346d6.75.2025.08.21.13.33.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 13:33:22 -0700 (PDT)
Message-ID: <b37e2690-fe6a-4fde-ab7e-58368c2914c3@gmail.com>
Date: Thu, 21 Aug 2025 16:33:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] path-walk: fix setup of pending objects
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
 johannes.schindelin@gmx.de, johncai86@gmail.com, jonathantanmy@google.com,
 karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com, me@ttaylorr.com,
 newren@gmail.com, peff@peff.net
References: <pull.1956.git.1755715196.gitgitgadget@gmail.com>
 <0dc4a6323e66598070b403d286ee1918e6a9b791.1755715196.git.gitgitgadget@gmail.com>
 <aKbSRQJCPh3Lsew8@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aKbSRQJCPh3Lsew8@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/2025 4:01 AM, Patrick Steinhardt wrote:
> On Wed, Aug 20, 2025 at 06:39:55PM +0000, Derrick Stolee via GitGitGadget wrote:
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The previous change established a buggy instance of 'git repack -adf
>> --path-walk' when there exist paths that are tracked in the index and
>> that is the only instance of those paths in the history of the
>> repository. This change fixes that bug.
>>
>> The core problem here is that the "maybe_interesting" member of 'struct
>> type_and_oid_list' is not initialized to '1'. This member was added in
>> 6333e7ae0b (path-walk: mark trees and blobs as UNINTERESTING,
>> 2024-12-20) in a way to help when creating packfiles for a small commit
>> range using the sparse path algorithm (enabled by pack.useSparse=true).
>>
>> The idea here is that the list is marked as "maybe_interesting" if an
>> object is added that does not have the UNINITERSTING flag on it. Later,
> 
> s/UNINITERSTING/UNINTERESTING/

Thanks!

>> this is checked again in case all objects in the list were marked
>> UNINTERESTING after that point in time. In this case, the algorithm
>> skips the list as there is no reason to visit it.
>>
>> This leads to the problem where the "maybe_interesting" member was not
>> appropriately initialized when the list is created from pending objects.
>> This is the fix for now.
>>
>> To help avoid this from happening in the future, a follow-up change will
>> make initializing lists use a shared method instead of allowing for an
>> update to this initialization process to miss some existing copies.
> 
> Yeah, I wanted to say that this feels quite fragile to me and very easy
> to miss. Does this mechanism buy us a lot of performance in the first
> place? Because if not we might as well just remove it entirely.

The details for the space savings and moderate time cost are listed in
e5394794a5 (pack-objects: thread the path-based compression, 2025-05-16).
These improvements are on top of those from --name-hash-version=2 by
using a different way to focus delta calculations.

A larger, internal example for this can be seen in this table (based on
testing today):

Mode      |  Size    | Time
----------+----------+------
version 1 |  16.0 GB | 83min
version 2 |   9.9 GB | 77min
path walk |   6.4 GB | 74min

> But if the answer is "yes" then adding APIs around it feels like a good
> alternative.
Making the code less brittle to changes is good, but also I'm interested
in ways to improve our test infrastructure or adding defensive features.
I mentioned a couple of ideas in an earlier message.

Thanks,
-Stolee
