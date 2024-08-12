Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1641F16E87A
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723473194; cv=none; b=UbXc7E0/ifNZeWkcOzb7nJl/wToOymBZxY1zPTm0nN2lx0RvnaYPDBDEBisZ82kaeLiFmQQ9yuxxAIEFP5GYF4YQNBffjbFXmSKvvb3/nvoiV0XSNhXd6nOuSqX2N/JKmEHUcs6NbfnEbOmlzoW9uZKFJnA0hiOQjK54GnMkMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723473194; c=relaxed/simple;
	bh=/6mo5B1lviURu+Vt8oEdDrTcGkewfU7ocQMcBP5Jkb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rajVzzOsMmLlUdNbszXT689m3Uxw30BsdjKpqhMKxXRgGsh8OXJbGbFrSbHhjPXPdWQExoT6xndZYNNcGey/pgrTrC2VGme6d2ySiCw80A3f9BY7EO3ptPSUyuQ6ZFmJl29pEErtzzFtex5IIHQHDc2wgOTNCmzvqMGrWbX+/zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJDHr33c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJDHr33c"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4280c55e488so25824175e9.0
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 07:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723473191; x=1724077991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mu55G1iy4Du1aVU9KNMuOP2DV+9frfqPy2dZLGhZAX4=;
        b=hJDHr33c1CmkGPeSODXR6vUnpHI7PSKMLJCcsH+6NR25T/Pvtz56Ah8pIgvgn/UblP
         FLUrw94yT0pkIIDaUSx9oRcNIsNOi+QYO+bGq5eX9lQFAjuf5fKpy8ilE+EmPQWRdss8
         4ODPRU0YCMCtc7oMeiV6DGm4SRQCc2w1/9Sgzeqxyc/jCwkqmlJ2iOeroG9k8cPAOvHF
         pO5IsZLPRBodUQarF7K73uHYcc9wFkzwR2C7FJqUY21vCWV7adCMr2UMEENPr4N5SyQN
         a+P4JZLi2mXwVqDUszwyEEr4P0xNMPk2NM6uiIQVT+7QLrORjvq13CQJhKlQ9tO2IFKG
         kkPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723473191; x=1724077991;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mu55G1iy4Du1aVU9KNMuOP2DV+9frfqPy2dZLGhZAX4=;
        b=DZlU4u+59xapTcCm5WsWcKe1OjpbdC+H7Oj5bNvjr9OIU3KRrQCk3OmlFoukKUyxC6
         p8NnHLddRMQDZ/1elqt8cMliEU1tFGzADxJZ4QsRBAF7PkAhxi5sZmWIq98OM94M5Hf2
         XvaY8MzgAi76CgHtLUM1LGZR8LrEftVVU9oJ8BSwMMQTgWX1EhtKE0+XK11Q5Hrgqo5Y
         hwLta4Vsv5gE7zDeWxu42fYnBWp1V7LdaIPMqUwAWw4r9PNzv4Dj7HYo1tSoAEPFsYoK
         q7DKAHpCOqJNgDxrj5eqTtEPo1NU9Eibt5BqD1O4jhLJe2VAv+R0eQk3IMSHvip31Tkh
         7zuQ==
X-Gm-Message-State: AOJu0YzdHTeB0q5RuyqWagR2EItSM09WyInEO1L2ZW7o8z7QoxsQezZ6
	I86gmf8tPYY61iLAQPPaRRkkof6IH2MhDcxvlATE0hSwPrDNc5SB
X-Google-Smtp-Source: AGHT+IHoeD/4WiGzV7uQOaMmOCP4GOssxMSyQsChaKhqzGYU/VWcKsJJ5IT3sUry4/mj3m6U+MW2/w==
X-Received: by 2002:a05:600c:1f82:b0:428:9c0:2ad with SMTP id 5b1f17b1804b1-429d4d74eccmr2382255e9.18.1723473190573;
        Mon, 12 Aug 2024 07:33:10 -0700 (PDT)
Received: from [192.168.1.9] ([197.40.69.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c7a357bsm190829195e9.43.2024.08.12.07.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Aug 2024 07:33:10 -0700 (PDT)
Message-ID: <2553ac83-70b2-4019-b6fb-0c0562e887c8@gmail.com>
Date: Mon, 12 Aug 2024 17:33:08 +0300
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BNewcomer=5D_Introducing_myself_and_expressing_in?=
 =?UTF-8?Q?terest_in_=60Implement_support_for_reftables_in_=E2=80=9Cdumb?=
 =?UTF-8?Q?=E2=80=9D_HTTP_transport=60_project?=
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <31efb040-57cd-46a7-80f1-62a9ce9efb52@gmail.com>
 <ZroQ8-7SUmli2SOC@tanuki>
Content-Language: en-US
From: AbdAlRahman Gad <abdobngad@gmail.com>
In-Reply-To: <ZroQ8-7SUmli2SOC@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/12/24 16:41, Patrick Steinhardt wrote:
> On Sat, Aug 10, 2024 at 11:11:30PM +0300, AbdAlRahman Gad wrote:
>> Hi,
>>
>> My name is AbdAlRahman, I'm a senior computer science student.
>> I'm interested in working on the `Implement support for reftables in “dumb”
>> HTTP transport` project with the help of a mentor, I'm aware that the
>> project is not being worked on in GSOC but I was wondering if the project is
>> still not taken in general, and whether I can work on it outside of GSOC?
> 
> The project wasn't picked up by any of the students, so it certainly is
> fair game to be implemented for any interested party. But...
> 
>> If the project is not taken, what should I do next?
>>
>> I'm also aware that the mentors are busy with GSOC and might not have time
>> now.
>> I'm OK with starting whenever mentors are available, but hopefully, guide me
>> on what to do until then.
> 
> ... that being said, I probably do not have the capacity to mentor you
> on it until the next GSoC. So you would ultimately have to figure out
> most of the parts yourself, unless you are willing to wait until next
> year's GSoC (or somebody else wants to mentor).
> 
> Of course, you are free to send specific questions to the Git mailing
> list, and we try to do our best to answer such questions and help folks
> get their work landed. But the interaction would likely be way more
> limited compared to how mentoring looks like during the GSoC.
> 
>> Steps I've taken so far:
>>
>> For git:
>>
>> I worked on one of the micro-projects, modernizing a test script, The patch
>> series is now merged in the `next` branch, there are still a few
>> modernizations left in the file which I will work on after the first series
>> is merged.
>>
>> This taught me git contribution workflow and to expect to do multiple
>> iterations of the patch.
> 
> This is a good first step indeed.
> 
>> For the project:
>>
>> I've read the resources provided in the project description for GSOC [1] in
>> addition to a video [2] and an article [3] by one of the possible mentors.
>>
>> This gave me a high-level overview of the ref-table backend.
> 
> I'd point you into the direction of git-update-server-info(1). It
> updates auxiliary info for the dumb transport helper for the object
> and ref databases such that plain HTTP clients can figure out which
> files they need to fetch.
> 
> The realization to have is that this is not required for the reftable
> backend anymore because the information is already encoded as part of
> the "tables.list" file. You will have to think about how to figure out
> the ref storage format of a remote and then fetch the correct set of
> files.
> 
> So understanding that code as well as how the dumb HTTP transport is
> working will be the most important first steps.
> 
> Patrick

Thanks for your time! I'll begin by doing what you've suggested.

