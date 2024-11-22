Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AB61DE2CB
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 12:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732277390; cv=none; b=iN3yfm0Dnd9Jp8FecSLKrHX4q+5qMOAKFWiq872elzWcjTuo/fQuam9A+liF+O0P27NOZtb7G+DW1I4/s4Cp4EH85gUuu988PxkJEgV3LTkuNpRduRkBIHEvsZDMQhdII7nJbj8GbRPJXMmHBQ0qVaT680+87vsJ6suMRyVDwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732277390; c=relaxed/simple;
	bh=spAveTxox5OFodZbjlHd4gWD68VaR/sdOboV1WlqYmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o7hnhp/DML94U5pX3xBsb6Ja4Ib8ZO4eaVrspUWYWsKcueC36vabWShHx2vWjk87S95kVWPyFKqghjQ21m/HFLG+M9EuFM+gk3hgGXwCUCa54++OGpjc3NWqLl/sHDBwXqvYtIIt3ICiZGGXS2t5V3v92c1FJPNdIm+6rnXjYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3Pc57B2; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3Pc57B2"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e333af0f528so1866304276.3
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 04:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732277387; x=1732882187; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ORUABEpIUpsJQO6/ls7BduQScX9r/C4nRJqZKw4aoM=;
        b=P3Pc57B2j9G6A/Zd/mPHHO+fXKnkhU3C/IDgz3qChUdf6zPx0RMD2WDivV+ho5fHy3
         f//gR8u4rReePCOWRg8nEX1FeGZ6Ejfm1K7N/X4WTIuXWB/9HFZW5fvXSDO+AvwSZszE
         ujOkUM/oKLj3bC/WCaGxuQvHMTfwyw/yt8ObITkJAcW1EJJ+eEqLj3dlyeu5ViaWTnh3
         K5497toGfY1PgG9enHjIsJfY1jSf2CVfeuu+w5pXJNnproumW8Ri8Er6ZHSV3B305B8n
         UVrVrIWBqOXZeJBiYEwDiFJDFL8UoVxKF+bL2Y1M/aBnyThf90Q1hM8Ha7RFumoWHdYp
         LQsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732277387; x=1732882187;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ORUABEpIUpsJQO6/ls7BduQScX9r/C4nRJqZKw4aoM=;
        b=iDUfgltKJR048cfXMi1WV9jg8NX+BKCQJV5QiYDgjnroxQfodu7wAEb/b46gV65AjP
         MAax9K83vZf8rIAiyuYurd0Vz7vYuqvp0CnfOl9imySE2p2b6ekYyYDVTNptFc2Ia9EI
         GKCcw1eb2a1bGcntGArpJQWoyEpiMTz2IF2Ibe9zISS+89KNURWtLRaCmnRWmTArnGom
         i3GPFC41tU9MXrV0yV056myizfmBsckysZgMwuKt25vVGfsNU45f8v3SKQE/Fb+rycCu
         bqNLp4GgRIvndyyXvdZomJiNpGzqWSApK5fbhMG2wpcHXqYU9pkPH2W0wRbTAjOPB8IK
         h3ww==
X-Gm-Message-State: AOJu0YzVrXug0fhowamY5Cnup/x1sBElDcKQlqct0gE1I7p8dtZHAc6j
	pBmRw7CNjIC+EA0O7iTE611vSNWV/wcZpuqKxqd9pdnZ1IamHbiJ
X-Gm-Gg: ASbGncsZYD4N9DOwo3Vi0ginF/Fm7KfckByPt05zu+ETYklCoIk8WgqSOYz7NtXRBtJ
	mLi3H+6Xqg3EYA3OfBGdkRLcI9Uq3qzrTn0cMTGd9wB1pkD6KCmNT3s2aLQXehLwo8TNzf6pSKP
	YnqGDjzRyIn6Uule6YFJjKihia5W2NwbIegSpVDZb1vRLVkf9oA+CdfOX4RNai/5sUEGD7rrNdT
	EwwRdp9b9gVUlRGiFD2Yd1Y7iBa+4WZ683OkgXZp95MJ3ahpQ9cJ41px9M8VhslLZB33xaQKoWA
	SL4NXgPiJMVNttK3q4ZxYuk3EazUeQkJjDFwhQ==
X-Google-Smtp-Source: AGHT+IGPbwotE6pSD2Yx/4PZi3SMKpGkIDmwGXrz32J4FY4C+K0SRBNC8/zHDebYAipyuzexb5TgGA==
X-Received: by 2002:a05:6902:18c2:b0:e38:8fdf:ffdc with SMTP id 3f1490d57ef6-e38f8b34560mr2464716276.22.1732277386745;
        Fri, 22 Nov 2024 04:09:46 -0800 (PST)
Received: from ?IPV6:2600:1700:60ba:9810:79a7:3ea7:43e7:e05a? ([2600:1700:60ba:9810:79a7:3ea7:43e7:e05a])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e38f5e5b218sm562526276.0.2024.11.22.04.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:09:46 -0800 (PST)
Message-ID: <4c314b69-46b4-402e-a590-78e4f4e0200e@gmail.com>
Date: Fri, 22 Nov 2024 07:09:45 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] pack-objects: add GIT_TEST_FULL_NAME_HASH
To: Taylor Blau <me@ttaylorr.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
 peff@peff.net, ps@pks.im, johncai86@gmail.com, newren@gmail.com
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <259734e0bcea952c2c09b0fb3a017e139922b975.1730775908.git.gitgitgadget@gmail.com>
 <Zz+U8IyHqBNRIn6m@nand.local>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <Zz+U8IyHqBNRIn6m@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/21/24 3:15 PM, Taylor Blau wrote:
> On Tue, Nov 05, 2024 at 03:05:03AM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
>> index 2e28d02b20f..75b40f07bbd 100755
>> --- a/ci/run-build-and-tests.sh
>> +++ b/ci/run-build-and-tests.sh
>> @@ -30,6 +30,7 @@ linux-TEST-vars)
>>   	export GIT_TEST_NO_WRITE_REV_INDEX=1
>>   	export GIT_TEST_CHECKOUT_WORKERS=2
>>   	export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1
>> +	export GIT_TEST_FULL_NAME_HASH=1
>>   	;;
>>   linux-clang)
>>   	export GIT_TEST_DEFAULT_HASH=sha1
> 
> Hmm. I appreciate what this new GIT_TEST_ variable is trying to do, but
> I am somewhat saddened to see this list in linux-TEST-vars growing
> rather than shrinking.
You make good points that this does not need to be here.

It's enough that someone could manually check the test suite
with this test variable to make sure that enough of the other
options are tested with this feature.

Thanks,
-Stolee

