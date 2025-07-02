Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2216AA7
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 09:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446898; cv=none; b=ntuWabp8Mj4B7f0Ag9A+4FJX83wfF4sNsQTs1s2kySs5DEDxWQkBXnabQJ10KwB/7kPOUIDlntnq9vS0VB77RZT/9yM5+XJD297svNR5rGtjT7xQZmoyJhFlQ/JgRWN5BMYzwzgypLiblHl4ZxLF+87Rh47oZTC3vgTFHyep3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446898; c=relaxed/simple;
	bh=H9rHi5zUg6AmQto08GuD99i71jxKqtWZk4Sa9oE1hBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ri+d56dWJjuQ+r8TrWAS0mzyFoAYAPmJe6UVo8UTblPukVUu2cq+oiq6mO+fcN3UB3YNeezHdncRclD54+fvo7keKpWe5q6Y9ouy/0rKH6vmYubx2585pFKsDBwEc8l5TTEcrf7pKJ+FOZSnp3LvneSvRR63WMvno/0UIi56ef4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMDnOA0A; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMDnOA0A"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a588da60dfso2640203f8f.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 02:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751446894; x=1752051694; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ltG+4tADFpnnnfDwqTHW0ItZeWDGyROZEIqzYyl8dKc=;
        b=IMDnOA0Akup25uUS4YdccifgLRceMs4lO/M9oEIBLOV0glJcLjtTk+ejEx7/w0DClB
         8hE5Vuu3AtCDPHNKXd8FOhUGjxmjsrXQQvZ2Px4UfECeBHAFqPUUi1/ho60kOa6dUM33
         iqy3gQmE/tVaMZVbHOqr6rbMpDq7UPNrhGYoXFSHQwheSlvSHoZr5qYkW8xwAmfqTUrS
         CHKFNnBq+yfoGAhIwPdw9x5KeBPSZBo+Cje1S8138Mrav+dYRgd/5ipaG9emenEiKyZy
         Tf0AfIXwxXn8CdoNnDfe6PGcTxLya2Q22zxaUaZBz31uJ9coEpBFirq63tt8GDhXFJQU
         VcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751446894; x=1752051694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ltG+4tADFpnnnfDwqTHW0ItZeWDGyROZEIqzYyl8dKc=;
        b=ApqROVUkd0A7ITuxhlZLqNo5D7+Jm3MuGvrh3UeKqawqlYb/b1dTBuRuHrzQq1vx4e
         AxylbXwBxKoCZacYelqeO5xdA95pgc94H3butSDtu/aG6SsnIQlXsd8xj+lNx+JaYUEa
         b6cT9oZc4umoYB2mxnNo9hL+ha394Lze6ffAKLT4r4RJjkmNtoG9xtL1AR1fN5DT7tzC
         wXQC3upW16aN98Y9sL8svz+VpGyVJIE5Y9aktIaVWEUEabXNby9GRJ+ptBL6Vvhkpyus
         BeS2xa4PrERKOUkjj258OyvqlMrEbPQ5gWYClND3q5JrHgj1u2x2mq+8TA41PoAA71/q
         OvvA==
X-Forwarded-Encrypted: i=1; AJvYcCUW92kMVag2oQywjC8Zre85RF9Ca8OMLy/C0pX0bQQFB7tGL2zsXWODyYmjRzLxDr+DYWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi/8eAAUP9KGANlnd2t1AVrVB/6jKHd5Cdcf2krCHBkT9azsoF
	ah8DHbNB1a7ydOtrPahscUzACdRDkNDNHD4bm3IvJJ93qD5U++uQQWpx
X-Gm-Gg: ASbGnctL93HGJZK/VcAOTylXJyDStN0wprk8pw6hne6qjtwBvq8OpmIzLwwKcBHfo44
	1GtJl+CG41G86FX3jK//HTJ4gd+iDVw9dt8mTHYZtYTCTv6hoiFUNYEasV4NcQCHP2CI9nBw83N
	6PSp9IOnRhG+CQ4jXX6dZFhWRKzCOVGLP2b4f7Dzs6EGt9Y3p0MJJ8MF2Uz5SvX2jNHen7tbfBU
	g6PgwYyJqs1JLHkreagi2KMg0OiZzxfDDfGt6cdSmefKU2zYhcCvgEXbkOucTFwIhzvKwFS0ThK
	MPEDy+O0EkX3gc8l9mXHyu7Zrr1zgK3ENHvauP28+jzKG8iAidZJNityRcx3TKWPi9A84ZmO/2s
	ekG0mK1EYZbXfEcwxUmU2f/g15JARmnEU8OUisQ==
X-Google-Smtp-Source: AGHT+IE+T9aH+r7RzZhvAd0v6mBqyr+wlXV35GAjCVPj+H9isyEV5FH/gpQEp+dkMnLB3zrkqgLK9A==
X-Received: by 2002:a05:6000:4710:b0:3a4:f00b:69b6 with SMTP id ffacd0b85a97d-3b202443b86mr1129270f8f.54.1751446893556;
        Wed, 02 Jul 2025 02:01:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823b6e9esm226052365e9.28.2025.07.02.02.01.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 02:01:32 -0700 (PDT)
Message-ID: <70a10ec5-9fb7-4b7e-b4e3-3d04fb44c23e@gmail.com>
Date: Wed, 2 Jul 2025 10:01:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH v5 3/3] environment: remove the global variable
 'sparse_expect_files_outside_of_patterns'
To: Ayush Chandekar <ayu.chandekar@gmail.com>, phillip.wood@dunelm.org.uk
Cc: christian.couder@gmail.com, git@vger.kernel.org,
 shyamthakkar001@gmail.com, gitster@pobox.com, ps@pks.im, ben.knoble@gmail.com
References: <cover.1751309770.git.ayu.chandekar@gmail.com>
 <45c84a6615aa15f19b34b7f3d73a6e418c178427.1751309770.git.ayu.chandekar@gmail.com>
 <17b7f51c-0c3d-4d63-a501-47ce829f7345@gmail.com>
 <CAE7as+YeTuQh_BzZSLuVTimrddp5-OBtpMa81KFhd+3zDqDiMg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAE7as+YeTuQh_BzZSLuVTimrddp5-OBtpMa81KFhd+3zDqDiMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ayush

On 02/07/2025 00:53, Ayush Chandekar wrote:
> On Tue, Jul 1, 2025 at 6:48 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 30/06/2025 20:27, Ayush Chandekar wrote:
>>>
>>>    void clear_skip_worktree_from_present_files(struct index_state *istate)
>>>    {
>>> +     int sparse_expect_files_outside_of_patterns = 0;
>>> +     repo_config_get_bool(istate->repo, "sparse.expectfilesoutsideofpatterns",
>>> +             &sparse_expect_files_outside_of_patterns);
>>
>> This changes the user facing behavior if
>> sparse.expectfilesoutsideofpatterns is not a valid boolean value.
>> Currently git will error out when it first starts because that config
>> value is parsed by git_default_config() which is called by almost all
>> git commands. This means that if someone sets an invalid value they get
>> timely feedback that the value is invalid and git dies before doing
>> anything. Now, if the value is invalid, git will only die if this
>> function is called and it is likely to die in the middle of a command.
> 
> Yes, I get your point. However, if we look at settings which are
> shifted to `struct repo_settings`, the behaviour is to set a
> fallback/default value in case of an invalid input, instead of
> throwing an error. This is done inside the `prepare_repo_settings()`
> function, which is often called in the middle of a process.

I'm a bit confused by this and I'm not quite sure what you're saying for 
a couple of reasons. Firstly this patch is not adding a new member to 
struct repo_settings, it is parsing the config directly and will die() 
in git_config_bool() if the config value is invalid. Secondly 
prepare_repo_settings() ends up calling git_config_bool() and so will 
also die if the config value is invalid rather than setting a default 
value. In the case of prepare_repo_settings() commands that do not want 
to die in the middle of an operation can call that function early on 
before they start doing any real work. Looking at the output of "git 
grep prepare_repo_settings()" many do exactly that. Here there is no 
option for a command to die() early on invalid config values if it wants to.

Thanks

Phillip

