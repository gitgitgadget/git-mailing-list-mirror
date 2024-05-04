Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C441E492
	for <git@vger.kernel.org>; Sat,  4 May 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714835751; cv=none; b=tDoSjjobS/eUdyds6gNMmiSY/emlJKMKSrCd6bHpQ+mFYXGUQMLYjCFF5fXaKrkwYMmGiXnG2D+Yzl4denipi1u9coZq4QQcwLhV4aI3Fqqd6gtdLZ6UAPXeUfnZRk1yAHqVT/UdrCgi/ik0kwizx0c/I/fiAUKMNQ4eGWwgHvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714835751; c=relaxed/simple;
	bh=uFhQhKaw4e9CLIyC4U6Axt/icUbyS4lJ8g2W+SCClsQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=MH+rY0Rb8BJRzkhU62Dm6w0Ng7sAMd42JKYo6TcyUsIEJv+3idq+ga3ZC2velM1/FN2uwgvLKy9h9jIK7WISC0MoGf4rKz8cG4l0ydLAQzUCS9N65LLzZvAWrvb12s3XSZ66LF8HNYI9WkrfOSHYZ+ruMXspdDiFNl6KdsurBP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eaS0IdLm; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eaS0IdLm"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e1a02af4a5so8071601fa.2
        for <git@vger.kernel.org>; Sat, 04 May 2024 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714835747; x=1715440547; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cRsGkrAVTlnceOxvgjHlFcrS9nJEXUDAYNnQmTJoctM=;
        b=eaS0IdLminsIePnznqpP3j6z2kw0R6cnssFIgqu2AW9zS0qn7ycbU4YCYfPnOvgZDM
         hwzEcsZJ9koBY3L7TAvU3/OrqgiNPWLzQah0pDdrsoDUr18HNd1fbc74WTDsu0d+zwk/
         gkqBxTWdg9EaBJl3zgiItUuC3vaDFniM32pfb3asNzL32Iosd/7FdEwrtDR0XIov51km
         8Etncz7uz3bsfta6H78wkBGyMbQTNW7VY8oS0HtynlUoeF/jhIZj255HwLd5yERtUCJx
         VQtkXEpYr6fpJnV7MHgIxp7BfzXZWJ38+vWBvObBMsjXGkswmEKsAcKq9oRkXaFl7kHO
         hpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714835747; x=1715440547;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cRsGkrAVTlnceOxvgjHlFcrS9nJEXUDAYNnQmTJoctM=;
        b=hAeLRBZk3ks9zEQSZc2FDGmUq13DvfAzNR2dN7+rZZzMjUhNh3Vq4SUjAYp7WvCyQz
         8kJsR+RmOCFSQIPM0jLIuXPzqbjQM4dX/SJUJQ8IImxeoAHa4C/abDcIZCPB8v6CZA9p
         fVjZ/WbxjJ6KJunp3thmRFx6CGfFRhpc39rklrBTWcKREbRpoBfYpZMFSEoOfS6vMH7K
         Y+CKu48gjafxXgsZ6jgSkNvcskOye8zKvxERy1O4uE6tz98rnoB45rBxmxFzs/OPQCS9
         wEIKMAnnkqPNVGXspdCNnL3bidl9hA+zuOMh4HSY8f4RqYFYaEnCELr2XSGoVSh5OKrZ
         i07Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6VIdqdd3epAQxHeBiv1u7bF2ofzllGmrDpzBaGqesEr8O+AeOpgb4+WssBQ09qBuG3gwc+jGo8qOTIzAs/9BSyZ7z
X-Gm-Message-State: AOJu0YyAz9f0v5Rpx9cwF/tJig91kFWBHLCHfnJUWS7ADijlgZJoiIgX
	gtxBm/YKwdCYuT+THe8Rny1gMIp6yP/oSQK2m4Vf2i3LMhpyFZJT
X-Google-Smtp-Source: AGHT+IGpTL34TuSHDND44jErdzDiK+02fkDt1O3U5wTUq9W9Xxr74fiCy4yremlJaonWzPK63KmZPQ==
X-Received: by 2002:a05:6512:4008:b0:51d:96be:b50 with SMTP id br8-20020a056512400800b0051d96be0b50mr4144426lfb.31.1714835747307;
        Sat, 04 May 2024 08:15:47 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b0041bf5b9fb93sm9586967wmq.5.2024.05.04.08.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 08:15:46 -0700 (PDT)
Message-ID: <7ca8c2c4-a9cc-4bec-b13c-95d7854b664b@gmail.com>
Date: Sat, 4 May 2024 16:15:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk
Cc: chris.torek@gmail.com, git@vger.kernel.org, gitster@pobox.com, ps@pks.im
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240412095908.1134387-1-knayak@gitlab.com>
 <20240412095908.1134387-2-knayak@gitlab.com>
 <c182c68c-77f6-422a-81ed-f6199c6b8a6b@gmail.com>
 <CAOLa=ZSwtOQXwbgregzKMtVA30wUCH8R=8D7u1+KGnsGEDD1oA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZSwtOQXwbgregzKMtVA30wUCH8R=8D7u1+KGnsGEDD1oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

Sorry for the slow response on this

On 19/04/2024 16:47, Karthik Nayak wrote:
>> either way it would be helpful to add some assertions to detect mistakes
>>
>> 	if (old_oid && old_ref)
>> 		BUG("Only one of old_oid and old_ref should be non NULL");
>> 	if (new_oid && new_ref)
>> 		BUG("Only one of new_oid and new_ref should be non NULL");
>>
> 
> I have slightly modified it to:
> 
>   	if (old_oid && !is_null_oid(old_oid) && old_ref)
>   		BUG("Only one of old_oid and old_ref should be non NULL");
>   	if (new_oid && !is_null_oid(new_oid) && new_ref)
>   		BUG("Only one of new_oid and new_ref should be non NULL");
> 
> But I agree, this is needed and have added it.

I'm confused as to why we want to allow old_ref in conjunction with 
old_oid being the null oid. Reading the documentation a null oid means 
"this ref must not exist" and NULL means "I don't care about the current 
state of the ref" so NULL and the null oid are not equivalent.

Best Wishes

Phillip

> 
>>> diff --git a/refs.h b/refs.h
>>> index d278775e08..645fe9fdb8 100644
>>> --- a/refs.h
>>> +++ b/refs.h
>>> @@ -696,13 +696,19 @@ struct ref_transaction *ref_transaction_begin(struct strbuf *err);
>>>     */
>>>    #define REF_SKIP_REFNAME_VERIFICATION (1 << 11)
>>>
>>> +/*
>>> + * The reference update is considered to be done on a symbolic reference. This
>>> + * ensures that we verify, delete, create and update the ref correspondingly.
>>> + */
>>> +#define REF_SYMREF_UPDATE (1 << 12)
>>
>> I'm confused as to why we need this as I assumed that we could use the
>> presence of old_ref/new_ref to determine that the caller wants to update
>> symbolic ref. Having this flag means that there are more possibilities
>> to misuse the new API setting this flag but providing NULL for old_ref
>> and new_ref.
>>
> 
> I think I started with this flag but as the direction of the series
> changed and I moved using zero_oid values for deletion or for using the
> verify command, this is not really needed anymore. I just tried removing
> all the code around the flags and fixing up things and all the tests
> still pass. Thanks for brining this up.
> 
> Patrick Steinhardt <ps@pks.im> writes:
>>> I'm confused as to why we need this as I assumed that we could use the
>>> presence of old_ref/new_ref to determine that the caller wants to update
>>> symbolic ref. Having this flag means that there are more possibilities to
>>> misuse the new API setting this flag but providing NULL for old_ref and
>>> new_ref.
>>
>> In my opinion the same comment applies to `REF_HAVE_NEW` and
>> `REF_HAVE_OLD`, which I found to be redundant, as well. Those may make
>> sense in the internals when the object IDs are stored as non-pointers,
>> but queueing ref updates only accepts pointers anyway.
>>
> 
> Yeah like you mentioned, since we're dealing with pointers, checking the
> if its set is enough indication, which doesn't work with the static OID
> values.
