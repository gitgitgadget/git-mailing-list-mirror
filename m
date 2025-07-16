Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF95194A60
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752676382; cv=none; b=LcR5eNjbxRVc71852Ip46oTPMj0FEuVwmHtqB0ycKFLNIp90L3pP8AzGZ665oZe5css7XHtja2ISB20yqsUtnyHDiJy7chA4dwtMEcQ6UMYlZ6bYjxHybEYBA40k8xJEP5PaGS38LDAVtkAhB+mMHvPF1jz1gh/ihCw9ppQloHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752676382; c=relaxed/simple;
	bh=o69odO5kJejE/RFLLNJfTswmgNLnMI0UGR6AdeIA37s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=udvudOKMZT0N+YOG+Cr5QtP6SXLID9PLaAkZ10A2V/8aoeTfCik8TSReTZNvbARuxC7rVP0uRwH8J9XWxzFg96WNpZ7RtAW1pMXsXhoXkQjhPU8UYPKe5Pzv71Q6/cffBPtMMdPLtxREZm1sCJHVvV3c70JEsS377nIrLluIREY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HH3hAnw2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HH3hAnw2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a53359dea5so3512722f8f.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752676378; x=1753281178; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmycmuDp3e6hXHKAvFJpcyjXiQ31OSo3hJGsNzo8qP0=;
        b=HH3hAnw2gUAOTJBvDjXCjtLKEk7t1gYSixMAiJ4a6cksbv2uZKN2DHQScQIZ5/IIMD
         DqCl3sQ4Vr80YB7v0aPy8VULyZvv9wCOE/3bAx9h7z7EwVq5YmMxi85orDRu6qnq6/1/
         wRqsDEcfzc6O2P12X86/FDhiuiz79WXdR6QcqEd7IyBtw0WhwVZODl10DyJNmwvY+fPQ
         CYFFEEOSqGc8J2+SNABT1osts5Ct8WRKBQN7svX6BC0jLBU9N5Xbzsu5nEXBRgS3MhZi
         BuRB+cv370oNiZsCJDGXbjjh5hVrezL8burRUS5ATx0SmdS22lx5vhBSvufbqn3EoUHQ
         1WIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752676378; x=1753281178;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmycmuDp3e6hXHKAvFJpcyjXiQ31OSo3hJGsNzo8qP0=;
        b=mB1q87alWOwBetHinGA44drrNLCKjFQ4/zT14BtKhUQQRTgwctyYS3saylIq4Au5Wm
         EbGBocrKbAyJPJHfnpEjcjI5bWk2nGfNkDd+lfzHBeJkVAp+NX0HoxlabSQ19LWrnllu
         5yeJIafGX6b0tYCZDaWVkjzoydvI+NUoVVxuY1niAX9UHCVDMUyKGNhpG+frGsRtARGs
         qBcCFjxmhby+rwFWtd3t6LdFADGpJWvyswySgHxX+X8vHSiEr3Z04uJcLsNKk3MBKmZa
         0toSAOgnPs4wpYRHOzCXH/T1fIzVPiNQ8NXZomwMfY/VWcyPun+xXgj7K3vVXcvC2fPl
         iISA==
X-Gm-Message-State: AOJu0YxfaEkg4lIEfxJcKL/xzsFpjB97EdsmoFsvZprFt0n/JHZ7mViz
	OSQh8DxCpLsCm6PyoF4LpXIliX28qMOZrajkOLGeNivaWwJyY5rA2Aps+R9Mgg==
X-Gm-Gg: ASbGncvG6FjjAOn2panNQtilF2ogFYfhPMKSkecDLZOWV4r5T48y10eA4J7tqgpiUvJ
	r8zlUUSAhoHkH/1T1+lTSfj3/kDAUY8OqX1omIlg1/L8k9BoediSBW7qVE3nX3E1nFSXT04n0H6
	QJgph90xjtK5dgI8tAbZT7ozTlnsgWHD4kA5bA5H7tUxj5uHcEnKioRb9K38/mpSvsnT+Knjvyj
	+ZbiXxKa42pk79Em64LoIw3EDmzJANwjSgC+808+GWGTykMEEUb/Zs+1Vi35CbKZxSIX/hfXDBh
	+PsDYB3pZlN/3xCpPEy75F6bQO5pBcK1QjT76oc1IVzWTe5+mqsZGrOLHAJZv7m/2eVyfAMWYAw
	JknfxlmHTEY9fwj39sG4EdTp5Kxk6KpcJB4s1Q9u8iDdEFA6jA1pOyOUmMygMkVykqJL146L1T/
	I2dLP/Zxko03A=
X-Google-Smtp-Source: AGHT+IGYo9REgbsykWgl5DJYjlaXHoptGoT+7gGeIn1PzRCGKOHwpX4Lr3xoTHzqDjJhu1scDeeD9Q==
X-Received: by 2002:a05:6000:2087:b0:3a4:d994:be7d with SMTP id ffacd0b85a97d-3b60e4eef0bmr2247301f8f.23.1752676378139;
        Wed, 16 Jul 2025 07:32:58 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc201asm17865953f8f.22.2025.07.16.07.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 07:32:57 -0700 (PDT)
Message-ID: <9532e4de-1f19-43a0-bf9d-9f93ca0fafd5@gmail.com>
Date: Wed, 16 Jul 2025 15:32:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] strbuf: add compound literal test balloon
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <7ac55a5096c261b706f47ca239c381f71db2b67a.1752499653.git.phillip.wood@dunelm.org.uk>
 <xmqqa556x2z4.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqa556x2z4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/07/2025 15:26, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> A C99 compound literal creates an unnamed object whose value is given by
>> an initializer list. This allows us to simplify code where we cannot use
>> a designated initalizer because the values of some members of the object
>> need to be calculated first. For example this code from builtin/rebase.c
>>
>> 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
>> 	struct reset_head_opts ropts = { 0 };
>> 	int ret;
>>
>> 	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
>> 		    opts->reflog_action,
>> 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
>> 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
>> 		    opts->reflog_action, opts->head_name);
>> 	ropts.branch = opts->head_name;
>> 	ropts.flags = RESET_HEAD_REFS_ONLY;
>> 	ropts.branch_msg = branch_reflog.buf;
>> 	ropts.head_msg = head_reflog.buf;
>> 	ret = reset_head(the_repository, &ropts);
>>
>> can be be simplified to
>>
>> 	struct strbuf branch_reflog = STRBUF_INIT, head_reflog = STRBUF_INIT;
>> 	int ret;
>>
>> 	strbuf_addf(&branch_reflog, "%s (finish): %s onto %s",
>> 		    opts->reflog_action,
>> 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
>> 	strbuf_addf(&head_reflog, "%s (finish): returning to %s",
>> 		    opts->reflog_action, opts->head_name);
>>          ret = reset_head(the_repository, &(struct reset_head_opts) {
>>                  .branch = opts->head_name,
>>          	.flags = RESET_HEAD_REFS_ONLY,
>>          	.branch_msg = branch_reflog.buf,
>>          	.head_msg = head_reflog.buf,
>>          });
>>
> > One thing the above rewrite did is to make it clear to readers that
> the struct instance is used just once and then immediately got
> discarded.  As long as the object that gets passed this way does not
> hold resources that need to be discarded itself (in other words,
> does not require a call to reset_head_opts_release()), it makes the
> code easier to follow.

That's a good point - this example would not work if reset_head_opts() 
took ownership of `branch_msg` and `head_msg`.

> But once the struct gains members that need to be released, I am not
> sure if this construct does not make it harder to spot leaks.
> Somebody who adds a member to _release() to the struct presumably
> audits and find all places that need to call _release(), but among
> them they find this place---now what?  They need to first convert it
> to the old fashioned way and then call _release() after the
> reset_head() call returns, I guess.
Another possibility is to do something like

	struct reset_head_opts ropts;

	/* ... */

	ropts = (struct replay_head_opts) {
		...
	};

	ret = reset_head(the_repository, &ropts);

	reset_head_opts_release(&ropts);

which initializes all the members of `ropts` in one place though I'm not 
sure if it is really better in practice.
> I am not arguing against all uses of literals---I am just
> anticipating future fallouts of encouraging overuse of this pattern,
> and preparing what we would say when somebody adds a new use to
> inappropriate places.  Simple cases like the initialier should be
> fine.

Yes, we'd want to be careful where we use them. I like the way we use 
designated initializers and this gives us the opportunity to have a 
similar style of initialization in a few more places.

Thanks

Phillip

