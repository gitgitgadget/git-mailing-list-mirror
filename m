Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84886221DA2
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748872208; cv=none; b=DaCG9tSxekWr7UOU3+IsWkfixaGbtwp1CZM/X6uqHYPRn0BP7i1awGo52bWvbmfoklasOgFSyCj1yMcPtMJD6MurSiQYtmY2LZwI+cJrNKBqIw27erhIcjbatriq2jDJMYsEupu9VwW8hDjXhL9tXsAbKBH4MbWOUJ+EgXsnOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748872208; c=relaxed/simple;
	bh=fnVMaF3YynS2Z/dZcKERsXTr56/gxXK97DX9cG/JwQE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PSX4SdrGydB+xWLX/vTf4QHyXU+VcjSboW1CZHZcAdgA1+1ZoCRyXWecnbvYhpxy1xIMcJWxFko/RwiKiMNqusFFVMS+fa9mPDpvYCLQ06DqVwdARyspzadfmYfyBFkDeYlRV6/9vF5U63Xd5CQeOr2J9SX0B9jq8RaVLfZFDZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnnHdOzD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnnHdOzD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ede096d73so32057705e9.2
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748872204; x=1749477004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ysQPhpxzKALXLIIvjpQOA6docjlbjvZTrUSMMTqd/aA=;
        b=HnnHdOzDAHMspbhW2otDkMmJv3v7myU5XltgZygz6fI3BHMzKXLDp+XN8iy1N6PHw/
         DsqPYI1t8hcbguVKftE4msRoP3MWGW8bajL02uSYYlqnBBSu+T4a82rJ5GkkgIutJa9q
         iDNYsZvUtHsRCdpLSZLzfwb/BPVtBZKeRQ8znuntU+vPnpcNek0wKDhNPA8n80Ci7d+s
         hYFnCswyhvy70xB7u+NDQCPkPbaj3f1rqvlCyU6amgVPKB845pl5UpQrhgIyf6j3g1R/
         mVXzmwXGsxna25Ps0LWY/xkAcn9Cv8lugWlAX99ZhZebWf0i69wbLqiUze95LJnHtyYY
         h9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748872204; x=1749477004;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ysQPhpxzKALXLIIvjpQOA6docjlbjvZTrUSMMTqd/aA=;
        b=TJgqX2wPEMWhHrxtIkA09JuN4x5aHTwsydatpEvWRQIyDynkFopuIfhR9XaGPuhUn8
         FF6I0GnPZEKk5wD1RcvPdzhg/3PPAjaHdTYkFD7egISTt9CSk52bEW8TllG2ie37e3ps
         gk9UCTnKyP/xg4RbJqGCPKiaiExdLPYIYnyG6ZUhDAKI33UFY5nEz+q0vWhwo09TjJuw
         dqNsae6Nz3iUn9Lrww1/l2LEJLIwYgNYRg60pO7MXUJcTR7YykiBa85XLoW0ncP4Ffsh
         MSkOBmV7q/neI5X5niFMpi2OweNHxNsxE9oPAIyC+rM0benuZJmF/EgNRn+IOIT4d1CC
         ydyg==
X-Forwarded-Encrypted: i=1; AJvYcCXwBW/aljNjSt1WVF6fkDL9AN7OOYZVHqEUZx2DFnnCk5Uz8H14wo2CDz1YeSREKmSACw8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyeigdxf4oXRlE2tICPsCh9jx0FX6yKTMLn89gzuaQQbzyPwSXL
	eFPkSMsoHU4o6xA1sRpm0a2fb4FVFP7EyrTZ1idPodRC8FM6L7+11sof
X-Gm-Gg: ASbGncus9c7JR9sKQSC5eYB2KlWmOf7bd23QaGZfslQCpQMN+lGzb3C71Mc2UsUS5bI
	XasAb2K+cp0TQVIGMU0p7YSrWDj+LpNz/cePaOXV+haYFFkgoqwSn/J6e759ns4pNhSDtBakthS
	4DM9z4b7Gul+FkpZFSVyPNLy9piZUWjBzW74UgC9CeyeksWtCuntkOxvRTxEObQdyoIrHHsJKGn
	bw+F0HqPKAjTW6WoCUImZb6b5is2i6TSenS+5X9oApTINyBDdOwrun3LIrvrV6qdKg4hD67Psfo
	gektpnjtvSuKBiGy3om7QQTJ9kR97OJMow+qBuEN9gUqUKhyihXHSZqLZIegf4JfSu/7Q8l9JXF
	3zfAz+5nrhXVcjxveSFHouFj6GuE=
X-Google-Smtp-Source: AGHT+IHeVaYnW0xEKycmD/aLsHJEFRwq4u371FdbicoXhT/bhpKnZOrmam6+Emh51IsBT3aXqXII8A==
X-Received: by 2002:a05:600c:3b08:b0:450:d568:909b with SMTP id 5b1f17b1804b1-4511ec9f86emr71959145e9.14.1748872203445;
        Mon, 02 Jun 2025 06:50:03 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d7fc1a84sm125585325e9.35.2025.06.02.06.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 06:50:02 -0700 (PDT)
Message-ID: <f5c517b6-955c-49d8-9f05-d47c24925eb8@gmail.com>
Date: Mon, 2 Jun 2025 14:50:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] fsck: ignore missing "refs" directory for linked
 worktrees
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org,
 Kristoffer Haugsbakk <code@khaugsbakk.name>,
 Karthik Nayak <karthik.188@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
References: <1d8f471b6dcb7e952afea834490be195189492a7.1748629208.git.code@khaugsbakk.name>
 <aDp55upE6AhYunz7@ArchLinux> <b92b5d93-7f7f-4370-ac79-7d9767bb0db5@gmail.com>
 <aD176UYWKEbmhiaw@pks.im>
Content-Language: en-US
In-Reply-To: <aD176UYWKEbmhiaw@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/06/2025 11:24, Patrick Steinhardt wrote:
> On Mon, Jun 02, 2025 at 10:53:50AM +0100, Phillip Wood wrote:
>> Hi Shejialuo
>>
>> On 31/05/2025 04:39, shejialuo wrote:
>>> diff --git a/refs/files-backend.c b/refs/files-backend.c
>>> index 4d1f65a57a..bf6f89b1d1 100644
>>> --- a/refs/files-backend.c
>>> +++ b/refs/files-backend.c
>>> @@ -3762,6 +3762,9 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>>>    	iter = dir_iterator_begin(sb.buf, 0);
>>>    	if (!iter) {
>>> +		if (errno == ENOENT && !is_main_worktree(wt))
>>> +			goto out;
>>> +
>>>    		ret = error_errno(_("cannot open directory %s"), sb.buf);
>>>    		goto out;
>>>    	}
>>
>> I think it would be clearer to write this as
>>
>> 	if (is_main_worktree(wt) || errno != ENOENT)
>> 		ret = error_errno(_("cannot open directory %s"), sb.buf);
>> 	goto out;
>>
>> so that the condition that triggers the error message is explicit rather
>> than having to mentally invert the condition to figure out when we return an
>> error
> 
> The downside though is that this mandates that `is_main_worktree()` must
> never set `errno` itself. So while it may be clearer, the original
> version feels safer to me.

Oh good point. We could save errno and then check the saved version but 
it maybe it is not worth changing it.

Best Wishes

Phillip>
> Patrick

