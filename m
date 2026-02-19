Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AA15C14F
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 05:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771477921; cv=none; b=B1Yjy2BOdrgGZERePGSW11zu7lcHQDjjNT3b2ApmMMokMU4MBZprmFyA/MhO7MZB0+RKdLUyLPUq/dHD+1DeFR/Zyk+fWHZIne8d4AvSpEgcX1yrlAvPF0ro4Px2Aqga6LRRMf53w4KU4ACnbIBTzj+gNFMDYrg5PCfQ2bYwhfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771477921; c=relaxed/simple;
	bh=JjrX8tJc3cJGJgmQUDu0gA2ZxqSpsKJD+iq0hDZOrmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gasQuBvABoaX0IfSXTXtG8jSaJ9dl7l8/oVNpnnVTuZWc3BYJTMi9pmMr4W8dZdIQe6VT9FkCvgYND9kyBuYWHN3+C+xj369QM8C94zQe1BThXFh8URTcB7GhSyeAJF39YheuLdY2HuahC/KDP/8bardKYrYTI0ynLlMD0a9Sbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL5ab3qV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL5ab3qV"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c6e18da0f82so45341a12.2
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 21:12:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771477919; x=1772082719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=81r1kLegmNT0HfgT0QtMxG8ylRZlNb1I39MxmtCjU60=;
        b=LL5ab3qViCgYx/k3ToTLhoFvsC307bs9NC3fmwymahOSHBJU3lPqq0oQTyV6a9cwCt
         9ysw/GKVAFSzM56jCo2R+EbtL8BJUDihrvaxBtHcxnutTv3PvfMGdz/BUOJa5EwU0+0F
         DWNt5GKuUpG1Mvd9zc5oOAz+vYJTloL0uxHjEpuVfEZpGR50VYcX8NIuqJmWEpD7U+tF
         bhekgjM1+IHyiW8y8Dh7jko3gEuNlXTre4WZby31VNUz9jjTussDUPu674q1xisdhlDM
         wqtS9LA8rgcqrbwxDjPLTQRvY1am0LX3R1qG6v46B8COVNEIPiDm05HYuZlQ74yGz5gr
         8GUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771477919; x=1772082719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81r1kLegmNT0HfgT0QtMxG8ylRZlNb1I39MxmtCjU60=;
        b=kPOnvmq9ZTcKfcCcQnj/buv/I0mkcIpI3fimrsgdMCSlQK+zPtqAFpY2PyltP9hXjh
         kjXNWzDhIqWZRlGOp49KawzanwTdorMEbreh4y0SSye39D/NsDT7TR68QfCxSnGH9pT3
         OWFaNlB5CcyBshlzC/P23slJ3ZUTAB3O50bJbl9zxzv7E2zxwX5MXtUvP/0Rkq1NjLYS
         BHAG01w+xES1wcF69owN9Ces4D9r6qVwAwn38gGbwWAc6wMdfn0TPnrrgJfAKVz/cucS
         xDTek3YI4O/1BQtDFXSpuhL0DrjSIwWu8spz1Fo/rxp2vWFIor7RADPaT3O5lZK0FjHB
         6f8Q==
X-Gm-Message-State: AOJu0YzFaBVzdefm+1NcZrEXLPqbVfAkK8tuiGPf9EgwLEZcpK04sTQE
	CM9sCzhhRIvRb3CyLzcluFvI98ywCoQNS+2oLtuhwC+fGBoo23Yx30Ma
X-Gm-Gg: AZuq6aIuL/mQv2tZGvXNlb7zGIJoJDGskFyh7I/fF7xGUJ/KjqGpM1Uruzt2ws+Es5Z
	54rkD7nY6UtJbh4Bzu8T7zUA9YaOtSqHuTpS+KLrJ99JxnlgpwcC7tTYzWKbQyotA0OxZQWIgkW
	MAxKRm6qKBtcdwzA7siPsA2KIQykQUDIH/ufTs3Niml+wz1DscWFCx9K3RsZh5fQCuhIJBAT6UW
	J9bVscbddoXmYqCq7Kc1prgkjVt82k439LGVmcPE3UzASqqUVA2epzAFd4X+ji4j+unRfIEkHBj
	InRk8U5Rj0ClA6DLSG6KDQgv9F+62xetaPT+NcUMzgaTIhVgBYssFMFmu8gb4UiNwm+3IMgvJ3y
	MjMDJ4GyRMuqAZjxanswZYwhxnvK52YRqsOEkVya/NPyvpys/FTX1D6EXu017M0zaAC8wgLkWzi
	+x2MheWxlTqZXjJ0XAQOQ/48hT6wXCHEMmHyi+KQ==
X-Received: by 2002:a17:90a:c883:b0:356:22ef:57aa with SMTP id 98e67ed59e1d1-356a788a5c8mr15152385a91.2.1771477919304;
        Wed, 18 Feb 2026 21:11:59 -0800 (PST)
Received: from [192.168.0.106] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662f8cc57sm27723688a91.13.2026.02.18.21.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 21:11:58 -0800 (PST)
Message-ID: <e370cace-1a43-444a-a3d1-5ea35dd22e60@gmail.com>
Date: Thu, 19 Feb 2026 13:11:55 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] setup: allow cwd/.git to be a symlink to a
 directory
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
References: <20260217084124.150366-1-a3205153416@gmail.com>
 <20260218051850.164972-1-a3205153416@gmail.com>
 <20260218051850.164972-3-a3205153416@gmail.com> <xmqqtsvd7vu6.fsf@gitster.g>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <xmqqtsvd7vu6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/19/26 02:25, Junio C Hamano wrote:
> Tian Yuchen <a3205153416@gmail.com> writes:
> 
>> Strictly enforcing 'lstat()' prevents valid '.git' symlinks.
> 
> But nobody sane would propose running one more lstat() anyway, so
> how is that relevant?
> 
>>   		if (!gitdirenv) {
>> -			if (die_on_error ||
>> -			    error_code == READ_GITFILE_ERR_NOT_A_FILE) {
>> -				/* NEEDSWORK: fail if .git is not file nor dir */
>> -				if (is_git_directory(dir->buf)) {
>> -					gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>> -					gitdir_path = xstrdup(dir->buf);
>> -				}
>> -			} else if (error_code != READ_GITFILE_ERR_STAT_FAILED)
>> -				return GIT_DIR_INVALID_GITFILE;
> 
> The _intent_ of the original code was to
> 
>      * do is_git_directory() thing to deal with a plain vanilla
>        ".git" directory when read_gitfile_gently thing said "we found
>        a directory" (NOT_A_FILE is overly coarse, which is what we
>        are correcting in this topic, but the _intent_ was to do the
>        is_git_directory() thing when we know it is a directory).
> 
>      * return INVALID_GITFILE on any error, but do not return when
>        the reason why read_gitfile_gently thing failed was because
>        there is no ".git" there (again, STAT_FAILED is overly coarse,
>        which is what we are correcting in this topic, but the
>        _intent_ was to return INVALID thing when we not the failure
>        is not due to ENOENT).  Note that returning INVALID_GITFILE is
>        done when die_on_error is not set.
> 
>> -		} else
>> +			if (error_code)
>> +				read_gitfile_error_die(error_code, dir->buf, NULL);
> 
> Should this be unconditional?  If our caller did not ask us to die
> upon an error with die_on_error, what happens?  The original I think
> returned INVALID_GITFILE for the caller to deal with.
> 
>> +			if (is_git_directory(dir->buf)) {
> 
> Should this be unconditional?  If the thing is a directory, the
> original would have given us NOT_A_FILE but now it would give us
> IS_A_DIR.  And that is the only case original wanted to call
> is_git_directory() no?
> 
>> +				gitdirenv = DEFAULT_GIT_DIR_ENVIRONMENT;
>> +				gitdir_path = xstrdup(dir->buf);
>> +			}
>> +		} else {
>>   			gitfile = xstrdup(dir->buf);
>> +		}
>>   		/*
>>   		 * Earlier, we tentatively added DEFAULT_GIT_DIR_ENVIRONMENT
>>   		 * to check that directory for a repository.


Thanks for the review.

I have already sent out v6 yesterday. Here is the link:

https://lore.kernel.org/git/20260218124638.176936-1-a3205153416@gmail.com/

Based on your feedback and the changes that have been made on v6, it 
seems that the tasks that need to be completed are as follows:

  - Conditional 'is_git_directory' check: restrict the 
'is_git_directory()' check to only run when we explicitly get 
'READ_GITFILE_ERR_IS_A_DIR'. It makes no sense to check it for other 
error types.

  - Squash two patches into one single commit, as you suggested. 
(Actually, I'm a bit confused—are you saying to “make both patches 
standalone executable” or to “merge the two patches directly”? Either 
way, I'll go ahead and send the v7 patches first.)

  - Rephrase the commit message to describe the lstat() limitation, 
rather than saying 'we switch to stat()'

The holiday is over, and my efficiency in sending patches and replying 
to emails may be somewhat reduced. Please bear with me.

Regards,

Yuchen
