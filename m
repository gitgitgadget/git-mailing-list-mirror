Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63785285C91
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770116290; cv=none; b=EEZIB3am8Ox5y1FVgi0a/8gJ/0L7TSzXAHdc3OTos8cCRDA/f+39do+U9WKeuiz5Amw/gCDUMk4zvS0clpbHKUJVszKz4WapNvw5IybeHVBPEOcqhOsYKEzOcM9m7dbK7ijL2wfjPik6v9KxrOMzKjpAw6t+QgKMJB1ZbMKKA3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770116290; c=relaxed/simple;
	bh=bkzA6YCJhJaMkMcwgLw0LyXff49+MeYgRkZcF/ss8Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eynU2rc8paV7zAFGAZimrlBoic58q6kwl9DwYutstE3axpLv8KrYxjo+7eSO7cuxFmVzd7nklByHDCA2p149BIB0x57MoXow1o79S+lJthpL193MaYjsIUWXCAM25mD9rVHzqPKfTjKJKz9HB3FMKfW0GdnlE0v68i5eF2wqGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd7n6dMT; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd7n6dMT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so43162245e9.0
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770116287; x=1770721087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X6k+BVpFG1D3ZiOifAUZQimvbbeKWQrYuJdGRGBqiOw=;
        b=Nd7n6dMTzfhUmRk/HhjidP7A/PbXzoo8TwSroCRaZls6RK/6Eaq1Eyerst1UqaGoXZ
         9ZOao/QN8KhzI0oNrYyC9cYEF9TyPXm/2iR2nLTCiBPGEAsZ5D4F78IbMzZtjPTCm6XK
         Yk64iNF+z1ChvafI6OxGircY31EWGg8xMG2yb+Qtg3+fyEfoShiGWCLqmeL6Q4ZMRxO5
         Up227z33d9MNbdaSX8S3XX7OTVTWX3JUfktBUwV89640bTofIIT+888Gk5boT6Czjcjg
         Or73RN/bl2QbF5ceUVGw5ucg3h3AN6HbSb/fKPN++9oQyw8L9IESyUE8gn87+dusQbc3
         3DJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770116287; x=1770721087;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6k+BVpFG1D3ZiOifAUZQimvbbeKWQrYuJdGRGBqiOw=;
        b=WhDnldnJ3HHfrNePhXzuKNvM9ShiBCO5HKWu//+rGKSYAMenQSY5UZ44XmaTM9Y1TG
         dYGTAtyJh8gssBGKynVFT1rR3WDo4bSgeD1kE/Cv6QQGOC/oH72hz/bYx7SB9kkewXIV
         R8ZKunHVlVVPFSAVPHmK48DxAYoxu08pP2WS3r0g0p0Pmreq0QWt2toYQS6C/jLpv4QT
         GQ4xTjF0CzHJNAtsNfJa1vcJCNYEkbE1UWEr9Bde1FpEtnR8gCNshItFUOeMqDWiIFs3
         Ej0xGfvHfjVPL5UF8maqdrB5pEwrVxgJRW1Cb6aVtHg6dqBUm8sXD5GWfOMRBhUKtm92
         GgSA==
X-Forwarded-Encrypted: i=1; AJvYcCUkzGY0rCidRLF2xbhhtigR1yWWbUncQ/CINHMnVxkmpqhf8rbyxXuwjvSlvq1jI0xdhpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydkNpeUvs6csMTHnqY9nWvXY6Ig1lcCgp/WrMZd+dfkwgjda+n
	zB0/LbkFdXchA7z3xc+iRg7Z8h7Hsg4GTSnLPA11zw+3lM54TfS9Sw/G
X-Gm-Gg: AZuq6aK2uJnCz+Ljk1ups0cB/wJremzMzAtPY57O9pt8gQ6tPAbJYk6kN84zcovk+Cg
	SKDkJ9snmqI6exO4YwBstOcAC32OiP/PPtjTyPiD3ImjxI+LWCy/1YI8PzqlVzL4+9R5OtNBxLE
	WFd/uNW4DoP4vfHbzELLGpVekDMRAAQFxxGwK6I0Ka00w8xUEj1bG9FVmynD7CVrXXhyw9ZNtYt
	6yTBYXRwEqgswE5q1t+4dAqzxVYnTtubx1Ccd/dvTqKX210pUxj5v50i4oCt77uWfYCP6WgQ5f5
	Xbgp3TXyQoED5GjmFKczVGXFN7cNyUj42L4lCiZWM3YD+kZ6pwfZ8LmZr8RFkce58Wfr6CW2oPZ
	oPsMCzA7wg86g6+PNN2N4eXhQ6KVd9s4sijhRj0rdpsFk6IXXrqHRVJLmEosYJ+oH5jewdf/i7y
	A/5eriIeCLPO8Tp1foS3wkikYzc3b48uYhiwVPloXs7sPsu556mfh4RUnvWJ4bzkE2tGW3f3s=
X-Received: by 2002:a05:600c:45ca:b0:475:dd9a:f791 with SMTP id 5b1f17b1804b1-482db4e7d09mr189770765e9.28.1770116286499;
        Tue, 03 Feb 2026 02:58:06 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:d511:bcf2:b462:9060? ([2a0a:ef40:627:1f01:d511:bcf2:b462:9060])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-482e04a082dsm118820815e9.3.2026.02.03.02.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Feb 2026 02:58:05 -0800 (PST)
Message-ID: <50791aed-c64b-48fe-8cc7-8cacaec9d295@gmail.com>
Date: Tue, 3 Feb 2026 10:58:05 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with local
 repository instances
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, karthik.188@gmail.com
References: <CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
 <20260202190155.79896-1-shreyanshpaliwalcmsmn@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20260202190155.79896-1-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/02/2026 18:57, Shreyansh Paliwal wrote:
>>> Many instances of the_repository are used in wt-status.c even when a
>>> local repository is already available via struct wt_status or struct
>>> worktree.
>>>
>>
>> One missing information is why is it safe to make this change? If is a
>> repository field, is it holding the same information, is it always
>> defined?
> 
> Yes I should have included explanation as well.
> I have explained below, let me know if this thought process
> is valid or not.
> 
> The replacement of all the_repository with s->repo in this patch are mostly
> to cases where a repository instance is already available via struct wt_status.
> 
> In the current flow, all functions operating on struct wt_status *s
> are called via commit.c. There, status_init_config() calls
> wt_status_prepare(), which initializes the struct wt_status and
> assigns s->repo from the repository instance passed in by the caller.
> As a result, s->repo is guaranteed to be initialized whenever these
> functions are invoked.
> 
> And commit.c itself still relies on the_repository, within wt-status.c,
> the local repository pointer refers to the same underlying
> repository object that the_repository would have pointed to, indirectly
> until we make commit.c also free of the_repository.

Good explanation, that would be a very useful addition to the commit message

>>> diff --git a/wt-status.c b/wt-status.c
>>> index e12adb26b9..9f4d8fda7f 100644
>>> --- a/wt-status.c
>>> +++ b/wt-status.c
>>> @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
>>> 	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
>>> 	s->use_color = GIT_COLOR_UNKNOWN;
>>> 	s->relative_paths = 1;
>>> -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
>>> +	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
>>> 					"HEAD", 0, NULL, NULL);
>>
>> Wouldn't it make more sense to use the function argument 'r' here?
> 
> In wt_status_prepare(), s->repo is initialized to r at the top of
> the function, so both refer to the same repository instance. However,
> using r directly is more explicit and avoids indirect use.
> will change this in V2.

Yes, a few more context lines makes it is clear that either is safe.

>>> @@ -1723,18 +1723,18 @@ int wt_status_check_rebase(const struct worktree *wt,
>>>   {
>>> 	struct stat st;
>>>
>>> -	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
>>> -		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
>>> +	if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply"), &st)) {
>>> +		if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/applying"), &st)) {
>>
>> In the same file we make a call 'wt_status_check_rebase(NULL, state)',
>> so wouldn't this break?
> 
> Yes my bad, it would throw a segfault error.
> I think the best way to handle this is to explicitly check for the
> wt to be valid like this,
> 
>      if (wt==NULL)
>          return 0;

That would change the behavior of the function though as it will no 
longer check if the rebase directories exist. You should pass the 
repository down from the caller.

Thanks for working on this

Phillip

> Falling back to the_repository in this case, would probably
> defeat the purpose.
> 

