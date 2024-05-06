Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E35142621
	for <git@vger.kernel.org>; Mon,  6 May 2024 09:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714988145; cv=none; b=jvKtn4CegKkRJCXfBIiV3wZ8UEkw6udP5/1wWbOAOOrr4b33KSlCj1vOM+2hyeoXQLGEgQ/gSNi3DoNt9Z8oDSQ9Bv8uh4TqHC1kob0Dbeh7RVJrSPtUqzBNig7SLDPUDVZoIV1vPWl8M1hCfOudQQxViVx4BnIHWS85Fy5zbxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714988145; c=relaxed/simple;
	bh=u3uDkVHz7BLUrQtM0uSHmIOLvTTkWdBppgh8TX3YNFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A73FGjrGQ5vMroVgfxxiVtiOFALDGJ3i6mprdkN3LEMWEN8Bsweb8yP5iYNofPHbLKG/NoSjJ7kUmkDdAFb+7L8K2sOXOBvDQTPgwBc2DvT3D8yLK5wPZ6N1Tm9IvM1EEJq1rZX4yzoi4Iu/9t3Q49lnQgcQbWRSlQkXyVEMWKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/I8XVrr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/I8XVrr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41c7ac73fddso18104725e9.3
        for <git@vger.kernel.org>; Mon, 06 May 2024 02:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714988142; x=1715592942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iSOMtjCIn6UZsjF6g7InF6g1YX/f/w2WRfwphbchG0Q=;
        b=k/I8XVrrvMf8GQAASePR8x/3MwD/aMWDmf/5M5PfR3Xaz1tsMUvjAZzlVIZu96gFxA
         tLBAVXNviYcHs+tm8g3zf2F1EEJuDjHoPhfLTJ05GdR8ntZnwIG31jp0pWKyWKUBuxQ7
         QYfa9oYNlH2ErSrQ8b+N4hYIEMpDH4gdEyHM4pBvb9NFqy4GlrkOZKImLwiI7EF2sAuu
         8TmRRVbZv/d6Za6QxlUbTASJ7zT8+gz3w1s2o3GPesyPawFBJIGbhc3V5UJlEHm1lV32
         lGRehVVcozGlwH4HeomD64kTBGY9tfbJlyYhS6wUEn0KH9+g00mHWQAy5LbUE2Itu94G
         M9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714988142; x=1715592942;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iSOMtjCIn6UZsjF6g7InF6g1YX/f/w2WRfwphbchG0Q=;
        b=VCMbiyRF5TggZVoAIEP12XaFpJLNMR1IMzTSSqCcur1YXgT79pdFZumoo0/rAxNEmm
         8FjP/fPxGZjvAfsbtQi0WpoHvjIv7GCdZLGLcN7a4sJ0k5yknvvEPekrifOR41lxOUMf
         dSp25++7dhBWReN63b1W38O619VQNyRUcu6beK6L+k/ro2Gr2gEmFk+dyvCPUfxMCxSO
         lcBia0LMei0qRFbPih1zLHWuAGe1KDEBEtKD+pjtttv9FE+00kB6NYeM+BWwJku6fZkx
         DbTEl+7ajYLa5oiZE1GTDTMepZ5sQq5o2LgNJ42u3SJHkVxCH5DJa0c3gF89cnsO2Pz5
         YxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4q8WROIz8/xr544V4MWd9TdwF1PoWSOKb7IDLpnqLUvkS5q1QiTrS/+/wBW/04oOggBplfZCg9GpNWO4g/QrILOPR
X-Gm-Message-State: AOJu0YxKFXfdDrq0kHCqqDdKhg88HdMdqcsjQac4weOPXPa+0INu2LPI
	UyMcGUd169NSluDRlJFN44rNf6SkuQjX21/6LZtJbo4WnYZVkFf0
X-Google-Smtp-Source: AGHT+IF4VJmVRhdR1kCHoWvgPBg5uL/EMzORpUQeIt8G3GC4EDlXFlvE2Q6d9hZzdOErPvWdbyzDqg==
X-Received: by 2002:a05:600c:1553:b0:41b:e94f:1e88 with SMTP id f19-20020a05600c155300b0041be94f1e88mr9974707wmg.24.1714988141426;
        Mon, 06 May 2024 02:35:41 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0041bb11ff5a7sm19229687wmq.8.2024.05.06.02.35.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 02:35:41 -0700 (PDT)
Message-ID: <6e1f09fc-747c-4704-87b5-a7b2ba18d78e@gmail.com>
Date: Mon, 6 May 2024 10:35:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 4/7] refs: add support for transactional symref updates
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-5-knayak@gitlab.com>
 <17c71b18-20b4-4bbd-b52c-c29ef8d3860e@gmail.com>
 <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZR5a0Tj1abM4z4SAVm5cw5+EA0qyoOMs8QH8MoS6eJGiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 05/05/2024 17:09, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> On 03/05/2024 13:41, Karthik Nayak wrote:
>>> --- a/refs/reftable-backend.c
>>> +++ b/refs/reftable-backend.c
>>> @@ -938,7 +940,22 @@ static int reftable_be_transaction_prepare(struct ref_store *ref_store,
>>>    		 * individual refs. But the error messages match what the files
>>>    		 * backend returns, which keeps our tests happy.
>>>    		 */
>>> -		if (u->flags & REF_HAVE_OLD && !oideq(&current_oid, &u->old_oid)) {
>>> +		if (u->old_target) {
>>> +			if (strcmp(referent.buf, u->old_target)) {
>>> +				if (!strcmp(referent.buf, ""))
>>> +					strbuf_addf(err, "verifying symref target: '%s': "
>>> +						    "reference is missing but expected %s",
>>> +						    original_update_refname(u),
>>> +						    u->old_target);
>>> +				else
>>> +					strbuf_addf(err, "verifying symref target: '%s': "
>>> +						    "is at %s but expected %s",
>>> +						    original_update_refname(u),
>>> +						    referent.buf, u->old_target);
>>
>> The messages in this function differ from the equivalent messages in
>> check_old_target() from the files backend above. This is potentially
>> confusing to users, creates more work for translators and makes it hard
>> to write tests that are independent of the backend. Can we export
>> check_old_target() so it can be reused here. If not we should reword
>> these messages to match the other messages all of which talk about not
>> being able to lock the ref.
>>
> 
> This is very intentional, the way the backends work at this point are
> quite different and while in the files backend, we talk about locking a
> particular ref.

I agree that the existing messages could be improved - these messages 
are returned when checking the old value of the ref so talking about 
being unable to lock the ref is not helpful as the important information 
is that the old value does not match the expected value. However that is 
not dependent on the backend or on whether the expected value is a 
symref or an oid so it feels a bit random to make these two messages 
different.

> In the reftable backend we do not lock single refs. We
> lock tables. So keeping it consistent doesn't make sense here.

Where an update is prevented by another process holding a lock I think 
that the granularity of the lock that prevents the ref from being 
updated is not particularly relevant as far as the user is concerned. As 
far as I can see the existing error messages in the reftable backend try 
to be consistent with the messages in the files backend.

> However, we could make the files backend similar to this one, I would be
> okay doing that.

I would be very happy to see the messages improved for both backends 
when the old value does not match the expected (oid or symref) value. I 
do think we should have consistent error messages in this case that are 
essentially independent of the backend and type of the expected value.

Best Wishes

Phillip
