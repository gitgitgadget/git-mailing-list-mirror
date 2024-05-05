Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58548747F
	for <git@vger.kernel.org>; Sun,  5 May 2024 15:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714922384; cv=none; b=aaDslSrm2WgyjMy6UYv+5RPzNVMmnShSWB2rBxJ5SJcxfBiRZYfRrW5WR7H7VDWM7rzo5t55hvTYXgpLSsGuUAkrpHb6QqLxynlRXfYMHJBUmE7JBv0ReuOdgNV91d26Aaxzgp+sGboeJghOziSN96OkVNK4rikRLQyorjXRiNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714922384; c=relaxed/simple;
	bh=rMmtwBjFmm67sMvunQ+BfA9mNIcb4jP+RLXvx9d1HpE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=STtIrdAbKwWT/wAD8WQuMZKespJ7rhNYjigB/LKKENs4RJ/NfAeCPBsKtrnvi7xJbsijVV2fiQxBChF2e4p/W+M7e78x4uiuT4vwe/5dz4U3ZRt4Qk3NSI7fdHGdFOcELhhcTntg3kTnjU33LQG0BOzbABP78hlnu/Hv0GKd1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnEXZE7u; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnEXZE7u"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34ddc9fe4a1so870934f8f.0
        for <git@vger.kernel.org>; Sun, 05 May 2024 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714922381; x=1715527181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5z6tpyKjpncJ3C4xK74ICcYn9BB0e2mb/bDBf9fxho=;
        b=JnEXZE7uCXZNuBddHehFqHKSYU/eqaCNMqHN935jrLAFmrQ3sZd+6pspvWRP42LL/w
         NoEt1OswhOsRbsMapwSGrD+mVNZUhoMwJryE4k25uXmGN1/uDDAWWC5cMvZjFH8oP2HN
         4v+uz7K1o692dZtwqKROSzEofdFi+arzMMXOauh2IFxWTDyOk7GtoRbjm1yp38iFRdqN
         ZXoxJF+gKHEq16tvuxGyyMmeFE7JOEB2f13DWsIpBOUHb9vj23cJZNYML8DQnssZf/7i
         tik/52Ij5nCx0x+8BMJ2YA20iafVP1LHk9nHqRR2H0h34t8muyhvCcR2It9BAsIbwuPK
         qaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714922381; x=1715527181;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5z6tpyKjpncJ3C4xK74ICcYn9BB0e2mb/bDBf9fxho=;
        b=TUrBtsKbPB+8QI997RoMeu2unl0dG60+RmT9lPQyqnHoeqFccLLcrQBUHngZmKFd64
         gM/hYMA6WjJQ5OE5bZKXPzXOr8iVdaZvXoS/gw4W8TUqDm7XZ3kPEiEPnT9h67CN97mW
         yzA7ypCNEpLa55cFXbzvb3UNaZDK52KUhhCUNwO7yLKYHuIkhGckB6F0S0wRhmavabnq
         mXucs3H90WscfMiyzaQpHaWjVxybPERjltFOcDQ5PTF0AimuVK9yvgMdV8nQw67lUy1w
         Q4d+vkhK4e2rGRVvArhaW8GeO3jfbR6oL9z0DMpNeoGi1qdjuNd8dSCSJE5qoKLXbJhh
         Qz8w==
X-Forwarded-Encrypted: i=1; AJvYcCX2+DzdMS70DWsv5hit4ZLnlsGaQBn0ReOQe+xg78f3BkxtXq5E6BiEJJt5XC0HttMeRIb76cdLXS7JaZKhyInCRjsf
X-Gm-Message-State: AOJu0YxgfXtSpIYduJFwd5j0d9SeBnVPgLDAQiyNY+Qn9lVZ7y8JUk+E
	32rgY4EBa2Aw3SdtN9Cnnmll0DapwwZ550hFy4v40rJmhFjzffIT
X-Google-Smtp-Source: AGHT+IFPhzvMw3aQvbR9v5hSHhq8ONnWnR88j0atWskEfSYOBSf3VOV9lMYQ/3uUmaYYCu7cjfoEKQ==
X-Received: by 2002:a05:6000:1110:b0:34d:8bc0:3f58 with SMTP id z16-20020a056000111000b0034d8bc03f58mr5036674wrw.54.1714922380396;
        Sun, 05 May 2024 08:19:40 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1? ([2a0a:ef40:62f:f401:71a5:ff50:4738:e3b1])
        by smtp.gmail.com with ESMTPSA id d1-20020adfa341000000b0034c124b80f7sm8521193wrb.61.2024.05.05.08.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 May 2024 08:19:40 -0700 (PDT)
Message-ID: <d774f2dc-eeae-4542-852f-674bb4fd0497@gmail.com>
Date: Sun, 5 May 2024 16:19:39 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 1/7] refs: accept symref values in
 `ref_transaction_update()`
To: Karthik Nayak <karthik.188@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 ps@pks.im
References: <20240501202229.2695774-1-knayak@gitlab.com>
 <20240503124115.252413-1-knayak@gitlab.com>
 <20240503124115.252413-2-knayak@gitlab.com>
 <37875fc1-19d5-40bf-9d92-bf6356e2049d@gmail.com>
 <CAOLa=ZTRg+eg+ExWYvcxkHEiX=W7BJ-tW8Ssq+ViHaUh7P8CKQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZTRg+eg+ExWYvcxkHEiX=W7BJ-tW8Ssq+ViHaUh7P8CKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 05/05/2024 16:10, Karthik Nayak wrote:
> Hey Phillip,
> 
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Hi Karthik
>>
>> On 03/05/2024 13:41, Karthik Nayak wrote:
>>> From: Karthik Nayak <karthik.188@gmail.com>
>>>
>>> The function `ref_transaction_update()` obtains ref information and
>>> flags to create a `ref_update` and add them to the transaction at hand.
>>>
>>> To extend symref support in transactions, we need to also accept the
>>> old and new ref targets and process it. This commit adds the required
>>> parameters to the function and modifies all call sites.
>>>
>>> The two parameters added are `new_target` and `old_target`. The
>>> `new_target` is used to denote what the reference should point to when
>>> the transaction is applied. Some functions allow this parameter to be
>>> NULL, meaning that the reference is not changed.
>>>
>>> The `old_target` denotes the value the reference must have before the
>>> update. Some functions allow this parameter to be NULL, meaning that the
>>> old value of the reference is not checked.
>>>
>>> We also update the internal function `ref_transaction_add_update()`
>>> similarly to take the two new parameters.
>>
>> The documentation for the new parameters looks good to me now - thanks
>> for updating it. I'm confused about the assertions though as I mentioned
>> in my other message [1].
>>
>> Best Wishes
>>
>> Phillip
>>
>> [1]
>> https://www.lore.kernel.org/git/7ca8c2c4-a9cc-4bec-b13c-95d7854b664b@gmail.com
>>
> 
> Responding here since this is a newer thread.
> 
> This is done because in files-backend we split symref updates (see
> `split_symref_update`) and add a new one for the target reference. Here
> we pass along the update struct. This update struct is memset to 0 and
> this is after the checks we do. So the 'new_oid' here would be set to 0
> (null oid) even if the 'new_target' value is set. This made more sense
> in the earlier set of patches, but probably a diff like this should work
> for this series and can be amended later as needed (in the series which
> adds the symref-* commands).

Thanks for the explanation - it would be good to fix this because the 
assertions don't catch misuses of ref_transaction_update() at the moment 
when old_oid points to the null oid and old_target is also set.

Best Wishes

Phillip

> diff --git a/refs.c b/refs.c
> index 3645b805c1..20d26da372 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1238,9 +1238,9 @@ struct ref_update *ref_transaction_add_update(
>   	if (transaction->state != REF_TRANSACTION_OPEN)
>   		BUG("update called for transaction that is not open");
> 
> -	if (old_oid && !is_null_oid(old_oid) && old_target)
> +	if (old_oid && old_target)
>   		BUG("only one of old_oid and old_target should be non NULL");
> -	if (new_oid && !is_null_oid(new_oid) && new_target)
> +	if (new_oid && new_target)
>   		BUG("only one of new_oid and new_target should be non NULL");
> 
>   	FLEX_ALLOC_STR(update, refname, refname);
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3ce260d07d..a718164798 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2328,8 +2328,9 @@ static int split_symref_update(struct ref_update *update,
> 
>   	new_update = ref_transaction_add_update(
>   			transaction, referent, new_flags,
> -			&update->new_oid, &update->old_oid,
> -			NULL, NULL, update->msg);
> +			update->new_target ? NULL : &update->new_oid,
> +			update->old_target ? NULL : &update->old_oid,
> +			update->new_target, update->old_target, update->msg);
> 
>   	new_update->parent_update = update;
> 
> I think it makes sense to make it fool proof and add this, I'll wait for
> more reviews and re-roll in a day or so.
> 
> Thanks for following through.
> 
> [snip]
