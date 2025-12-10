Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAF32ED148
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765376741; cv=none; b=s1YM5bz4l73osYWJBW/s/AvIE2eCezXaZYfGbo7KgKj6PzcCIZ3ZaRDRRJSNpC7k/3j4hw4E2GYPzdK1kosCEftAC9J+9D/nSY3nHIIMgai6GTLsJ+oeos5R78EfVFSMzkZ0oqB5RXp42CTRO4v8Nyeqfz2wH5HhLhyCmFczAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765376741; c=relaxed/simple;
	bh=46bW3qn1g6vAl9/aYrZdTcM971g+0MRtuEoJnRqFIQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=lgvO78ATpMafKynydpToenxlKGpF6oJEKHgIG2sTw9qOn8zS97MZFwzetd7N6VH4MwgrtfR06UaS2P8k/DnxYPaYF+FKuqQW6747do9508ILwC3m26Jeo+LmR7CxcSwDQLKVYJnINPYi1mESWk4zrIBQ/hXPeV7jp8K1XEFeyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5HvHKfb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5HvHKfb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47118259fd8so57837905e9.3
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 06:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765376738; x=1765981538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iJ0aLk2Hw5crXebpcjiq80PNQ0Oa5JbYURT4nw+HVNc=;
        b=V5HvHKfbM7QvJG0axuvZlibMccTastfTSQPWt1PsV7LOeNdg7ZevmkdZLzkLMN/Wy4
         BxjQQxZZQz2KQWq7XtPHck44McffzwGJO9Fxloez+uR2PQ/9jRV94aKXrrU8e9snwzZr
         gLlhetmD0epNIdEDMvANDj5BSAx1MEzjp16cUb4lzeXC0Ti2RZitcblKVHZipTMp8eX0
         l9sgeWgLLn+e5kZvUi6TmhZe9vqMneg03+F4bEjULXgBNqmJkKu6rhYiHmXI5PdksgVD
         qrnKwENb5UvGW0ONeCDuiBkc7HGnSRBJZrxzgKqOidQpHrCKcstQolqSrCPbHZ0iNYj2
         /JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765376738; x=1765981538;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iJ0aLk2Hw5crXebpcjiq80PNQ0Oa5JbYURT4nw+HVNc=;
        b=p7Yz+Ag8ubpE+QqcJokLiJIuAmPBMaRqMGV0lE9ptEklDs58Tsj4fIvLznkqeVm75O
         8RDFiZhwiD7CHjQ8+M9zK9aSmS8RJPpykZabpawdnrgYFcG7wleSjAlu8JXIAA9oOP8L
         RbQlzOTHXloxRCgEtNdYAWaROMmABzTCS7rxJWSREJ1KvOR1tFL7AwU10yn2C7Cpuuc7
         4M/zznv7vYdPYDxq/DJ/v50GfUuxD9F47jV8ltWKjU5xI33Xw1BPBSlOpy7Gfdb/QM1/
         cgHN3fmmCqU/zKEG1VQdU/JfzuNoUde4TGeHuXRDSlFIDm8aa9WR7740doVkOyg+F43b
         6n0A==
X-Forwarded-Encrypted: i=1; AJvYcCW6BPYZ5UOqna7ClE885RdRThGyWDgDiq0C97lS5kWqppnWGjwvsDJD6BoUiIDnrpKd+i4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1zWf02K4Elr7lhMPwh5yQvSf1mYM4w+tDeopu3sY3qc/fUkKQ
	C82+el7JSonQ35FPg+VwaymehDvFRE5z5jGp4M32usvzih3nP1ZKBEydXK57wA==
X-Gm-Gg: ASbGncuOrDOaotZhwT11HvUMFArgUaJeOBdgPsUXmnQfeDFlStfz4tKLviUfEQiNjrJ
	0AuxmB+n0ytnd5uFZLABZ0914Ze++/3r5dN1/eoEkkSlsfFt7FoUXk63gePNwtcvTRsgCbUCl6N
	SMkbAaCnhFAZ26bI0sweAvYOplf5wU9D5fYGvUqJNdx6GSKdo53sjDR3huPHb6F8jc8FqRwGA/E
	xMLS77O49haLQestgXqSUPCucQMbUrkRygch6/ZIJ2qZ7PKgBIi766MZZ7FtoOFkGrd8JuUmSxo
	tZPKQykRwZ5AXVT14AFkihQbbn/EseR1Jp+Tohh3yRUmr9rDUUr0Xa/ZpVWjL41pf2Fm4+4Z+Fk
	H7U6FYhUJIZ+/ZDiaKglJHNj5ibf146LP+fWdP5xqkEwX1D5YNwKmwuPjQCkm7UNY2VjRgeIyub
	XMMZHok1oA86YoZD/3tGt7ATRbvZ5+gjJvlqmcOX+a1FqT7afdNOfFSzyaPWv+9xg=
X-Google-Smtp-Source: AGHT+IE/vdyYoTdCbvx/uZ2WzFFAt0/Q4YHFSBl6kvwS02O3kWKE+I3OnTVD/YYb9CWZ/YRT/hClow==
X-Received: by 2002:a05:600c:3489:b0:477:7658:572a with SMTP id 5b1f17b1804b1-47a837ac5f8mr25969585e9.20.1765376737910;
        Wed, 10 Dec 2025 06:25:37 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a82d149ebsm44529395e9.2.2025.12.10.06.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 06:25:37 -0800 (PST)
Message-ID: <61f61218-1945-4efe-961a-e6cb4ac8c6a9@gmail.com>
Date: Wed, 10 Dec 2025 14:25:32 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug: `git pull --rebase` breaks in the presence of pushurls
To: Junio C Hamano <gitster@pobox.com>
Cc: Kartik Agaram <ak@akkartik.com>, git@vger.kernel.org
References: <896e4e13-5d2f-4c5c-ac32-2927dbff91a0@app.fastmail.com>
 <04cc0cc0-155e-422e-b723-b1115c918087@gmail.com> <xmqqa4zsliim.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa4zsliim.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 08/12/2025 22:24, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> "git push" updates refs/remotes/origin/master when pushing to "mirror".
>>
>>> 8. Try to fix the problem:
>>>
>>>     git pull --rebase
>>
>> "git pull" tries to find the fork point between origin/master and master
>> which is the tip of master because "git push" just updated origin/master
>> to point to the same commit as master.
>>
>> Unfortunately I'm not sure there is an easy way to fix this. For now I'd
>> recommend doing
>>
>> 	git fetch && git rebase --no-fork-point
>>
>> instead of running "git pull --rebase".
> 
> Yeah, it is an integral part of "fetch" to update the
> remote-tracking branches, so this is harder to fix.
> 
> It may be possible to stop doing the fork-point computation in the
> "git rebase" phase, and instead do it _before_ we run "git fetch",
> to figure out what part of our history needs to be transplanted on
> top of the upstream, run "git fetch" (to let the tracking branches
> updated), and then run "git rebase", telling it exactly what range
> should be transplanted onto which commit to update the branch
> currently checked out.  That would be a much larger change.

"git pull" already runs "git merge-base --fork-point" before it runs 
"git fetch". The problematic reflog entry comes from a previous push 
which pushes to a different server due to remote.<remote>.pushurl. 
Because we've just successfully pushed the local branch the fork point 
calculation thinks the remote tracking branch matches the local branch 
and so excludes all the local commits when we rebase but we didn't push 
it to the same server that we're fetching from. I wonder if we should 
disable the fork point calculation when there is a pushurl set.

Thanks

Phillip

