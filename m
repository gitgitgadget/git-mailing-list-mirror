Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A8019538D
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368735; cv=none; b=GIdgOhPYzZgrIsxRk6Q5UnKmEFpd99Mh9wIR6NexyCitdJq2ICiTWm7SfeE2f0hXClSRJoaieuYtvyfjWk19nEA3jVKGeLDW9tdQCgqjIW8t1uFuoFh7vzvUF9u67cQMIIlo+C/YlHQ9rgW8Q2VmsNtar5NJZ6q0ChzlxVq3NnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368735; c=relaxed/simple;
	bh=0Y8P+D7qKFBshLHK0HiNdroMd8xBOqDsORj9bYCB0NI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j729liZF8geW+k+kk4No+YcWD9hTPcl6j14scnnI4amb5Q0+ch4faXMMmlBYbNjV11Vw4y7K/sJSp4jUCCe2JiaiwrcRBpyW/z2r7TRPEo2qQpzx9fPwG5C0syqR/qER2yhw8cZV4dcuEKACSGr/9WCclMOCcaF5ynZcLf0s5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CE9Ytq6l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CE9Ytq6l"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3807dd08cfcso578961f8f.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730368732; x=1730973532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0uKzorm28uAhaQsq5oJjHPX5z3tdU/SbPzQj8J/zVTQ=;
        b=CE9Ytq6lOZfr7ik+EUawwwVYwpmWnznKavO6Bp8YmrZk3bV04y2mDPGvNFe/aXrtp/
         STmIlZiIXFu2RctQuk21VU1sdUs/4biFptncM/NUbFqjesvzGd4LCh0cuHBOXi6tgm1d
         TrlizmiIAqopmcBKBhZazMZGeOFhz8U+BtUjrtLnZ2zjy0bk3Ccxhhr79Dj1XCt+6v14
         G5T5VX5BcjZ4uNMlTDsqg/r6JQHFvvsvKl+Z41JLfrJDZLAL7fnyBMfkxuRqc+38mj3y
         l5nnINnfOqhGowKRnxxqS2pm316bgpXicWZuwdd1xamZzGhEgvRCE+2PYhe2oGNlcKLO
         jxLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730368732; x=1730973532;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0uKzorm28uAhaQsq5oJjHPX5z3tdU/SbPzQj8J/zVTQ=;
        b=J3oNiKKyZOEZp2Kfggxrr6itNDr/tsbq8NNSXYL08bs+P5snjtUrMuJhhARUJmQ8Jt
         NDGZG2ZN2z+0Iput+u+PMLoe8KnbjQ5dbH2yKuC7CTUMU4Mz3pLPiX6V/VY5XX14iP2G
         pAU17k6Vpd+SuHdapKarnupgPxjA1FsdRu3Ju/jUU9PAagTyF5gkS5qEUXffacQ85qfK
         vx4dm6DvKion3W9lghzx5kHxQQWM15k482dURFJ7AHG8ou43lEHFYMfM3ziigBaHzdTV
         jNdxKEr/kpVvjLT/hk5n/b/zPRRAKYeCBeD7p4N5syOYJBr4B7v0r//A9YYkQB7WcRmq
         kGnA==
X-Gm-Message-State: AOJu0Yy7xpY5N2ujwXhteI8I4jW4vJK2aFlvNeTtGL0lJ665xfTLoX5K
	Vv71U9r+sDsfXkSdqLcG0fVDWmRFSqdRrPB/0DaqANI4UXFeXD4YIfxIfA==
X-Google-Smtp-Source: AGHT+IHPijJGO/g/JmY7HHiPOkln5nIvO00zPz/4IvKwmUpB3EfzIBZMs7Aot4sqa82Fe7kCeRPoQA==
X-Received: by 2002:a05:6000:48:b0:37d:4eeb:7370 with SMTP id ffacd0b85a97d-38061247a93mr16730224f8f.56.1730368731441;
        Thu, 31 Oct 2024 02:58:51 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e74casm1620237f8f.65.2024.10.31.02.58.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 02:58:51 -0700 (PDT)
Message-ID: <c05e603f-1fd4-4ad2-ba03-21269f464ed2@gmail.com>
Date: Thu, 31 Oct 2024 09:58:50 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
To: Taylor Blau <me@ttaylorr.com>, kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
 stolee@gmail.com
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlEJ+44M8z03VOj@nand.local>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <ZxlEJ+44M8z03VOj@nand.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2024 19:44, Taylor Blau wrote:
> On Wed, Oct 23, 2024 at 07:27:58PM +0200, kristofferhaugsbakk@fastmail.com wrote:
>> @@ -6382,8 +6382,9 @@ static int add_decorations_to_list(const struct commit *commit,
>>   		/* If the branch is checked out, then leave a comment instead. */
>>   		if ((path = branch_checked_out(decoration->name))) {
>>   			item->command = TODO_COMMENT;
>> -			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
>> -				    decoration->name, path);
>> +			strbuf_commented_addf(ctx->buf, comment_line_str,
>> +					      "Ref %s checked out at '%s'\n",
>> +					      decoration->name, path);
> 
> Makes sense, but the following command turns up a couple more results
> even after applying:
> 
>      $ git grep -p 'strbuf_addf([^,]*, "#'
>      sequencer.c=static void update_squash_message_for_fixup(struct strbuf *msg)
>      sequencer.c:    strbuf_addf(&buf1, "# %s\n", _(first_commit_msg_str));
>      sequencer.c:    strbuf_addf(&buf2, "# %s\n", _(skip_first_commit_msg_str));

Good find - it's surprising that those have survived so long without 
anyone complaining. There is also

	"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***",

in do_pick_commit()

Best Wishes

Phillip

>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index 09f230eefb2..f61a717b190 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -456,4 +456,20 @@ test_expect_success 'rebase when inside worktree subdirectory' '
>>   	)
>>   '
>>
>> +test_expect_success 'git rebase --update-ref with core.commentChar and branch on worktree' '
>> +	test_when_finished git branch -D base topic2 &&
>> +	test_when_finished git checkout main &&
>> +	test_when_finished git branch -D wt-topic &&
>> +	test_when_finished git worktree remove wt-topic &&
>> +	git checkout main &&
>> +	git checkout -b base &&
>> +	git checkout -b topic2 &&
>> +	test_commit msg2 &&
>> +	git worktree add wt-topic &&
>> +	git checkout base &&
>> +	test_commit msg3 &&
>> +	git checkout topic2 &&
>> +	git -c core.commentChar=% rebase --update-refs base
>> +'
>> +
> 
> Seems quite reasonable.
> 
> Thanks,
> Taylor
> 

