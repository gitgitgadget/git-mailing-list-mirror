Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C3268C5D
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741876222; cv=none; b=afbS0UbzuWerFFXko/bGQqB3Fp3Jj0EU3q7+bcxEEh/qa+NkB63lmDwXhWYttgsyRWttTKq6ZN2rKZ2pADKxQAjx2Pn4qBebgm/d06Z6t6b11aVJo0FtpJpxqc1R9lbHFm3A1y+F8TPDeJw2/BQv8wRwWTIuYMTnI1oSFClraAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741876222; c=relaxed/simple;
	bh=5EoCNUTJiJjXi7CRfmnCjj9ghGVAauDBckwEC0HGD4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prPN4aFzQBtAhns6Kf7qX2tfxAgJSeV/kds2BGWK63tzXqK7I40xH9xyOVnmPri5//FsnA5KDB21OSqUDizS4WMk3JUZ4T1liLIZLYgSjkwq3MRGHb3OHWHF7Q/fCGiiyZ6lbipEH7/d2+OvIdWRB+niHg7cldhB7Bkg9hjX4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dv7rP3YC; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dv7rP3YC"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fd89d036so21054015ad.1
        for <git@vger.kernel.org>; Thu, 13 Mar 2025 07:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741876219; x=1742481019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9xMoO6sFEygSI0vmpVgC++vlCHPB7gxnyYNjMkj6Bh8=;
        b=dv7rP3YCe8bh+q2wMjpnNP2vFctE+2hprinw8kqU5P964d+cSzY+Z8Tdv0wGluVChj
         pcZhqKU5aRACM8WGZyTFCtz5vgNBTPjtFPnatHKMTgsDvDY5w35mtryGtAlQmbbuc4x3
         QBo8NounULLh8/0spwz94uP9zsGeT72vEnpXh87ao5zMJXOmUrIUYYXrOs0lCBgfWwHv
         u9mVWyN6oqin+N9Hp8uGIsK6xtV8LGWbOoKHwXEJkTk70MC7bfjqGHVSd0BvIdWENK4Z
         pXfd0G0T9sh24huzk6AC8JSBpY7OcD7V/EmXVUY00Vx3cBZkHZN0JHiXagU9cxA5Fsj2
         937A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741876219; x=1742481019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9xMoO6sFEygSI0vmpVgC++vlCHPB7gxnyYNjMkj6Bh8=;
        b=WpKfAZ+KGcAG+HMqy6hP/dX5PaTZU0Iu5L2CpIM4WxRLXJ2uInVzWhjiwqq4Y3EILN
         dwbgXW800XucBrJ9k/nmrO6h5B3DYGk/nIJWlVLbA9pqlFqQ9SYfA0uiQ+52OEfuPD2V
         +vqNIXx1pJPjYLBUigRK/kv0Wqb5ZadN6HdhcVeuwmYUQY3WfKzvu8s/ZedXKs3kvYmT
         wfKe/64WwlQHUtLw7OxmsFW5oYIqX1TLsE1QlOHNGdjVXChTvuPqSfMxEx37OhT/wrTq
         HdzATuMNJY0DP6up2NEtOkahplqE0ATrHIPw1q86rbwO3jbn+GIdksgccIZC+BFDVy21
         ZnSQ==
X-Gm-Message-State: AOJu0Yy9b49V1/fATObkrIE8Kd0GLUSd+Mz69FXZ4YlLnch3B3ZI3ETt
	+PLorZfX4k4GY8yxLEVxf96iwQo97LREZB5jt3YG99HMKqj2izvEfpbVx+o4
X-Gm-Gg: ASbGnctmWdeIqUy16qS/Wu0IyrhU13KBRepvrrF7RK1LXnRCCq946VQQbrEf9zwQbyi
	vcJ6g9NCsC8oTpjqtqf4iNL56v4shgzvWViG2Z/Y6p7ztnsCQzCpFo5axJQ6o7OK9nkMaz1u8dI
	jY3KqHniZoiDSxJ8NlVkPqQusVudtGbPDWJ5JweTZR0EDDbVldPRZzepm4pmmy5i6Np/NsQr0XX
	wucSrzx9neZrvokn3567j8diARFEwQg90h8QUZeOt8BwFZpWqOb9WjTHk0FhskkLrRFmZ50jGxq
	KHD/2U+c0cmcQMH1reYHAOjJiwuAihRUMnxdt3WCvQskIwofF1EwRsjKLkzeTk0zE016
X-Google-Smtp-Source: AGHT+IEGfGQotsHG635rO3esPV+Un+hqSuB6Im6I9UKyyQN0WKL6OD/CFLkKPz/cvRZUl57zx//b3Q==
X-Received: by 2002:a17:902:e80a:b0:223:f408:c3f8 with SMTP id d9443c01a7336-22428897491mr434333645ad.14.1741876219263;
        Thu, 13 Mar 2025 07:30:19 -0700 (PDT)
Received: from [192.168.1.6] ([182.48.215.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a7528sm13757735ad.78.2025.03.13.07.30.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 07:30:18 -0700 (PDT)
Message-ID: <69d10d0a-35ac-4543-a699-b3237ae4ccfd@gmail.com>
Date: Thu, 13 Mar 2025 20:00:16 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH] rm: fix sign comparison warnings
To: Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <38de63ce-6d4e-4f1f-95b1-049df78d9cfc@gmail.com>
 <xmqqy0x9s8mg.fsf@gitster.g>
 <CAOLa=ZTia95Lib6bkz_nWi2BYEteAaOxsrrX9DqLTEz1t02ggA@mail.gmail.com>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <CAOLa=ZTia95Lib6bkz_nWi2BYEteAaOxsrrX9DqLTEz1t02ggA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Arnav Bhate <bhatearnav@gmail.com> writes:
>>
>>>  static int get_ours_cache_pos(const char *path, int pos)
>>>  {
>>> -	int i = -pos - 1;
>>> +	/*
>>> +	 * This function is only called when pos < 0, so -pos - 1 is
>>> +	 * greater than or equal to 0, so it can be safely be stored in
>>> +	 * an unsigned int.
>>> +	 */
>>> +	unsigned int i = -pos - 1;
>>
>> "Can be safely stored", sure.
>>
>> But so is "int i" perfectly adequate to hold such a value, no?
>>
>> This is one of the many instances that demonstrate why the
>> "-Wsign-compare" warning is of dubious value, and invites worse code
>> than necessary.
> 
> I have to agree. I think it would a bit cleaner to actually change the
> functions argument type itself. Perhaps, something like:
> 
> -- >8 --
> 
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 12ae086a55..79e47d6e9e 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -40,10 +40,8 @@ static struct {
>  	} *entry;
>  } list;
> 
> -static int get_ours_cache_pos(const char *path, int pos)
> +static int get_ours_cache_pos(const char *path, unsigned int i)
>  {
> -	int i = -pos - 1;
> -
>  	while ((i < the_repository->index->cache_nr) &&
> !strcmp(the_repository->index->cache[i]->name, path)) {
>  		if (ce_stage(the_repository->index->cache[i]) == 2)
>  			return i;
> @@ -83,7 +81,7 @@ static void submodules_absorb_gitdir_if_needed(void)
> 
>  		pos = index_name_pos(the_repository->index, name, strlen(name));
>  		if (pos < 0) {
> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;
>  		}
> @@ -131,7 +129,7 @@ static int check_local_mod(struct object_id *head,
> int index_only)
>  			 * Skip unmerged entries except for populated submodules
>  			 * that could lose history when removed.
>  			 */
> -			pos = get_ours_cache_pos(name, pos);
> +			pos = get_ours_cache_pos(name, -pos - 1);
>  			if (pos < 0)
>  				continue;

This is a good option, I think, but perhaps 'i' should be renamed to
something more descriptive.

>>> @@ -58,7 +62,7 @@ static void print_error_files(struct string_list *files_list,
>>>  			      int *errs)
>>>  {
>>>  	if (files_list->nr) {
>>> -		int i;
>>> +		unsigned int i;
>>>  		struct strbuf err_msg = STRBUF_INIT;
>>>
>>>  		strbuf_addstr(&err_msg, main_msg);
>>> @@ -271,6 +275,7 @@ int cmd_rm(int argc,
>>>  {
>>>  	struct lock_file lock_file = LOCK_INIT;
>>>  	int i, ret = 0;
>>> +	unsigned int j;
>>>  	struct pathspec pathspec;
>>>  	char *seen;
>>>
>>> @@ -314,8 +319,8 @@ int cmd_rm(int argc,
>>>  	if (pathspec_needs_expanded_index(the_repository->index, &pathspec))
>>>  		ensure_full_index(the_repository->index);
>>>
>>> -	for (i = 0; i < the_repository->index->cache_nr; i++) {
>>> -		const struct cache_entry *ce = the_repository->index->cache[i];
>>> +	for (j = 0; j < the_repository->index->cache_nr; j++) {
>>> +		const struct cache_entry *ce = the_repository->index->cache[j];
>>>
>>>  		if (!include_sparse &&
>>>  		    (ce_skip_worktree(ce) ||

-- 
Regards,
Arnav Bhate
(He/Him)

