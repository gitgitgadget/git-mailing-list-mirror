Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0D604A9
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 11:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426895; cv=none; b=otc5jNJ186FwReZKlZ8v9qdSX2bLD2XybzJV9MaTgF51bfS8BbZWr8RjnYtYYXYvSDFTH4Jg06D1d7larecB4fzCnhrmMGW+bhbDPDNhA/Hh6V6CIIpv03irGx19YghFoc5Cnu3+XJUCt256YAcUojb4hXat4GQB1udVNNJwn9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426895; c=relaxed/simple;
	bh=Jo09QBMbl/vCu8xh/mPCQ0AHz4g0kT0UmDKVfKTUjQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b9OR8Gk83RnIv96SwCQwy26DnEYrqB1Y7UbLxi6wT6mB+95T2PhQyzItR3qjTF+iFRP4MWe7oMvPNC8fX4/JvcO63lxzIjYqIzNtgJRG/RCxF8mgh81+y6NobcK3sISk3sJW0WU55g+DYLC5GWRqvs5DVyhSAcj/G8a/FdePIsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IftbfnDL; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IftbfnDL"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d241ff062cso20018871fa.3
        for <git@vger.kernel.org>; Tue, 20 Feb 2024 03:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426891; x=1709031691; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q/ZXVPQTM0VvLTITjdHKxD8ri7oF0c8f0JwKRp9zpw=;
        b=IftbfnDLSinsM/oz3O6dGa7ITM+lC/1H+ngnkmvbxS1oR8OH0A5IP69w3FUyJIb2/j
         RPU1SnWGdWX/JOVCnR8eWBvhazBe0ITOlaZXEACud4Gnf7laaLWq1VlweM9jgxteBQ7i
         nKrN70N+yzxDlZcTR2BJWNyUazdZ64C4IGNGjCuVgHgyAvjWG6lSDIjs3Y4aVAQtYwwt
         nQXJ0DzBCKaxjR2wzJjnZ/30P6whIJ96T6yRI1J3hpPgv10GzwIAKJnBhX1C5sMQd/tY
         E4uiIUqZ9eTWINcPVlqOAjNuluqq4HYFsZWlIoPzm9SuxT+2Yr6pPFL6WzJeUKoVQ2Y6
         Y38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426891; x=1709031691;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Q/ZXVPQTM0VvLTITjdHKxD8ri7oF0c8f0JwKRp9zpw=;
        b=tS3CdqCFCJuk1xjl+dQv+RUuqCOEs+qfl3EZ6T6b5qvGdVvI3Z7+hlmsbqQCIpTbGB
         aUM7HaYEU42y/Wu+ryRn59CEEIRLqFIglVY4YIHGz9blkz+t0zqstf+0vJjFOCrfWkAS
         dy5Jv3vK+cJTQLH8tO9+cQ5hAr58DhUE3Wn2NPL3StgVyfTyZyRO9QHNH+exhNV2AxNP
         Pnc42Ae4fVrTg5vI4okBYFcNPq7F3D5Qxx2QeXGZJOug2mOLtLtcJC3o1J6afYTG99zD
         ShLZOiaSGpj4tfcXIgaNDogkwxS90y/wucmMKJ2MiLfRPc5F6f4UgMaZvyzwYLokJWiF
         LlmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn3pMLRhtATHk1aRNO/8lPZD5LSBFS7fcbhlaOHQQ8Rf5VgJr2v6DpokfXMh7h1/45bYNcUk6RxIWA5botjIwMKkH9
X-Gm-Message-State: AOJu0Yw5FlLHEoVdT61JZeCPLdP6nRNp4C8kf812lvmp3NoiWn8Dwm2g
	DuwsfB/iibV27yadlTPfHay77MTCHD8twY9l+u17gab94KBzBzFWGfIWpx/8
X-Google-Smtp-Source: AGHT+IHb7sTQZ9tG+48l85hbG6BWC9hZ2DHaAZl0WnI1wiAfkj2lA6IIxUQtvPS7ozkmhJsgKKLUMA==
X-Received: by 2002:a2e:8416:0:b0:2d2:199b:58c4 with SMTP id z22-20020a2e8416000000b002d2199b58c4mr7855547ljg.18.1708426891248;
        Tue, 20 Feb 2024 03:01:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1? ([2a0a:ef40:69d:3501:d2c6:37ff:fef6:7b1])
        by smtp.googlemail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm13080179wrx.47.2024.02.20.03.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 03:01:30 -0800 (PST)
Message-ID: <78a8733b-c74a-4017-8905-d29b2e05adb1@gmail.com>
Date: Tue, 20 Feb 2024 11:01:30 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Language: en-US
To: Ricardo C <rpc01234@gmail.com>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <99346639-5a36-4c2e-a5d7-035c3c1fda8b@gmail.com>
 <df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <df020dcc-afe8-4dd8-b476-4ca032206214@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ricardo

On 18/02/2024 17:54, Ricardo C wrote:
> Hi Phillip,
> 
> On 2/18/24 05:32, Phillip Wood wrote:
>> How does "stash.keepIndex" interact with "git rebase --autostash" and 
>> "git merge --autostash"? I think both those commands expect a clean 
>> index after running "git stash". They could just override the config 
>> setting but it might get a bit confusing if some commands respect the 
>> config and others don't.
> 
> Both `git rebase --autostash` and `git merge --autostash` seem to be 
> hardcoded to clean the index, regardless of the configuration or CLI 
> flags. They do not use regular `git stash` to do so, but rather `git 
> stash create`. This is unaffected by my changes, since it follows a 
> different code path and does not accept `--keep-index` nor 
> `--include-untracked`.

Ah, I'd forgotten that we hand "git stash create" as well as "git stash 
push". It's good that these changes do not affect "git stash create" but 
I think Junio is right to be concerned about the effect on tools  that 
are using "git stash push" where they arguably ought to be using "git 
stash create".

> I'll add some tests for `git rebase --autostash` 
> and `git merge --autostash`, just in case this behavior is changed in 
> the future and causes breakage.

That's a good idea but I think it would be better to test that "git 
stash create" is not affected by the config as we don't want to change 
the behavior of its behavior.

>> I've only given the patch a very quick scan, but it looked sensible. 
>> The only thing that jumped out at me was that quite a few tests seem 
>> to do
>>
>>      git init repo &&
>>      (
>>          cd repo &&
>>          # test things
>>      ) &&
>>
>> Our normal practice is to run all the tests in the same file in the 
>> same repository rather than setting up a new one each time.
> 
> I was doing this because it makes comparing different commands easier, 
> but looking through other tests again, it seems like I should be 
> comparing the outputs to hardcoded files anyway.

Yes, that is our usual practice.

Best Wishes

Phillip

