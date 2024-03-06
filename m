Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D17C1B94B
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 21:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709762255; cv=none; b=DuLA35/MmjexVcBoCqWY5Pe8zFI/J7CLpoEu1CqtFML0utJHf+FJtY7BYKn4Ij4ScqznVRaeFnS9C4msS3MVIfUwObXffFU+/bwlU0XX9eTMrwjXN3Y573qFQXQMTR2pYM014V3Ffp+wjvYBuJ5nFbUqF+yd6d6wS58kA8SeKW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709762255; c=relaxed/simple;
	bh=c/RM3dB16M13ZE0aBPDs8w6AFq4YdZf/cxXfNsKEiWE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEFs7w/gDfq4EmxDivOE8TAUgyKCFqUAt943uoe9ps4xgJi3c3wy6pprhCu8zRYMtYV4ONq4DFvh3dkiawfYdFNr158bhtnRl+AcZ+yxvrQxk0MMK2QhNDo5QoXrkmAQA/E2nX8SuyskzuoeNhgV2FyzEiOOmvmPXeMPAcdQa+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=X7VWJIsd; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X7VWJIsd"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 171661DB436;
	Wed,  6 Mar 2024 16:57:33 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=c/RM3dB16M13ZE0aBPDs8w6AFq4YdZf/cxXfNs
	KEiWE=; b=X7VWJIsd+L6V7RjCazKM7JkWSlvK6azRAL7JPYZJMD6X/1GhRIfWmK
	h6SvwpZ+/t5+N5ybQgMu1h+/vO6SSK82MxmrQjXrmBSifbMFz0hjW8UDasJ9JI4D
	g201U/njkWc1olMAeJxiZmyi/GqJMJ3EaIKSHG5V9XjGWZbNwjOlc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C7BC1DB435;
	Wed,  6 Mar 2024 16:57:33 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 680AC1DB434;
	Wed,  6 Mar 2024 16:57:32 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 4/4] trace2: remove unneeded calls to generate
 'def_param' set
In-Reply-To: <ZejkVOVQBZhLVfHW@google.com> (Josh Steadmon's message of "Wed, 6
	Mar 2024 13:47:00 -0800")
References: <pull.1679.git.1709566808.gitgitgadget@gmail.com>
	<e8528715ebf97c12622c2e73f914ab4228a0927c.1709566808.git.gitgitgadget@gmail.com>
	<ZejkVOVQBZhLVfHW@google.com>
Date: Wed, 06 Mar 2024 13:57:31 -0800
Message-ID: <xmqqwmqfowfo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 889406A2-DC04-11EE-AB41-25B3960A682E-77302942!pb-smtp2.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> On 2024.03.04 15:40, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhostetler@github.com>
>> 
>> Now that "trace2_cmd_name()" implicitly calls "trace2_cmd_list_config()"
>> and "trace2_cmd_list_env_vars()", we don't need to explicitly call them.
>> 
>> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
>> ---
>>  git.c | 6 ------
>>  1 file changed, 6 deletions(-)
>> 
>> diff --git a/git.c b/git.c
>> index 7068a184b0a..a769d72ab8f 100644
>> --- a/git.c
>> +++ b/git.c
>> @@ -373,8 +373,6 @@ static int handle_alias(int *argcp, const char ***argv)
>>  			strvec_pushv(&child.args, (*argv) + 1);
>>  
>>  			trace2_cmd_alias(alias_command, child.args.v);
>> -			trace2_cmd_list_config();
>> -			trace2_cmd_list_env_vars();
>>  			trace2_cmd_name("_run_shell_alias_");
>>  
>>  			ret = run_command(&child);
>> @@ -411,8 +409,6 @@ static int handle_alias(int *argcp, const char ***argv)
>>  		COPY_ARRAY(new_argv + count, *argv + 1, *argcp);
>>  
>>  		trace2_cmd_alias(alias_command, new_argv);
>> -		trace2_cmd_list_config();
>> -		trace2_cmd_list_env_vars();
>>  
>>  		*argv = new_argv;
>>  		*argcp += count - 1;
>> @@ -462,8 +458,6 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
>>  
>>  	trace_argv_printf(argv, "trace: built-in: git");
>>  	trace2_cmd_name(p->cmd);
>> -	trace2_cmd_list_config();
>> -	trace2_cmd_list_env_vars();
>>  
>>  	validate_cache_entries(the_repository->index);
>>  	status = p->fn(argc, argv, prefix);
>> -- 
>> gitgitgadget
>> 
>
> I'd personally prefer to see this squashed into Patch 3, but I don't
> feel too strongly about it. Either way, the series LGTM.
>
> Reviewed-by: Josh Steadmon <steadmon@google.com>

Let's see what JeffH says about this.  I agree with you that making
some stuff redundant in [Patch 3/4] and fixing the redundancy in
this step does feel somewhat roundabout way of doing this.

Thanks.
