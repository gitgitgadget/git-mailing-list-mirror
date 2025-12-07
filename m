Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8B45BE3
	for <git@vger.kernel.org>; Sun,  7 Dec 2025 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765148591; cv=none; b=N11GD6M5GWStztJ3HtwY8RFBhCU4RXecFdAw0Z0rIv2KjPWqH76acGM7BC7esuD6iOvhFbewZUNZqOZ7tL508vldHGNDweV0LB6BI6L2r6NvbJeZuovJ3jXoKcHKqGZvqCzkWW/s+gyUOYkJiS4PMOaks4BzaIrrQLgPTwshNYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765148591; c=relaxed/simple;
	bh=8lbF5vHC3yRuykiYnHh1xZRQvaqEHJUIkp9yHMXjdw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZgusIUxAoWtIyUp48M3+IiiUEmPSW8rV/XvHRi6HmMOktPRQJtp2DFuU1yLpXixxW5myj2Vu/rlQadbB2yFAHb1yREepqG5jGG8FPB7+nFdQ2cHkVZWPSQthac2/A9xOBJwBl1Hc1f4mqQTM+Xa3hZq33F6E/mYlHqLyH9KdTMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NS97Ceb0; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NS97Ceb0"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7aab7623f42so4486913b3a.2
        for <git@vger.kernel.org>; Sun, 07 Dec 2025 15:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765148589; x=1765753389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EQ6OtOTRWNZUIExgukkyL9NpImjy1agBfvOjs/o2cQk=;
        b=NS97Ceb0mSC0vOhgl+P59UPX8tMumekkLLVJzPbEcqCKdCMxM8J7W+Py4Ms5MfeAuw
         sPv+LZIiKaOohViiGb6v+yosczyo067kHLLRskYx41bmkKrzWL9VI1HNNkXSIO2LdQdU
         rHYaCtLIMZ3GNbmECIUlk/fScWChrrzTAih2EB9z17Yot17GxXpQzKq/aL5Ym6nAgPB2
         zKgguJ7kq948pFaIumUvXkuemWE9LOoIVEZTBIhRVY9n3DBjiobI7BD5dHzrIqGWJZJO
         FG+qCg9I6uOCl+mkDJIkOBf7fN5JmFsH7JdDdLLgQPjz9/6OakWDMSSz789ED+8MC1R7
         umOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765148589; x=1765753389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQ6OtOTRWNZUIExgukkyL9NpImjy1agBfvOjs/o2cQk=;
        b=tq384YfUoFIsSjJKYylJESytkS4lbTlJ1aB5BuePCxVUpnRqSaPJHxEd7CORFAxqqX
         7Q+nUemAv8Pb7A4a9DC6FFgovcWUPT/JPevFSLavJjIT7Lg3cclpIIzGyNAQhWFomCSS
         MjB4cjSzgghbDUFjDeKO/qHwvxYCw56ASQxNzNEqOSIkuXvM692lZZr1s5uylMIUQSM9
         uIzPPgu4AKKdEgl/r1DhrASxzCWPLMD6IuyeFuErIq5QzU+ZB1/K2de3SBq6/PmsRxU4
         jyaBYlEt1/D2oM5CahNZKJHSEHJZKrMxNI24rYCC/GIRKSwRgjXMJDOdem7xtjebnBS8
         zyYA==
X-Gm-Message-State: AOJu0YyiepvRmUPYvG1SSbmepP+I8AmXtaLscnt10QKvcWOOAuh+MZdl
	zzb4HqMxhevM62i3QP2ATRVNsMNHr8GRzFYCb/DMOdWTPs4P3em+Xk0h
X-Gm-Gg: ASbGncuhhQuA3O3JqhwZE/wnFwqpIQi2g+uLsCLQYT1rLjYAuz27lcwKMx5ffvJJVRU
	6cGimzhvuK51qSFxIcmdtuGUjaE7hgnBno06QV3cuRiQ3+Q+qVgDOR1YLD8KOIDatEiOfFWc3ec
	IgEKWtSB3N2/0aZYKsk1sRjQIZ+oJfw+fceuUGGywlfVg5R9f5R9OjPaLKV1MRfSrEcIB2z8zsy
	Ka52rpwz7WxLayFpPZWmbCNF/ciitcyN/qlb9CJkLpjMgZILq8x0nQ7A8IkfU9DOQF0AWl9PXbm
	SBL6hLV+xim/koF+0sKQWc1c+w5YgNGbvlMxxQqgPcLxCNkm8Yoz+4wAmB2FId/R0g4SXvXJWCp
	8zg8qD5vVyGp+gro/eqsysAIn6j5jVB551zooxJfMIp5+avUvZIcnQTITp8/K31ZDfG0ucFnyup
	8YZPtv1b+onEaF+bLovJnQRQLclSb4W3Xq+65Gj4+6UylFamPoDfR0ynLDx2l5Im4K95f2cXg74
	60mZR/rkZBI7ImSvUcgoVw=
X-Google-Smtp-Source: AGHT+IFbD7zgAQmKD1fO9wd9XsNdxhVEVL2TctM5wCsKR9604cgYKo5a0mEe/CST2Uxg2WJBsWieGA==
X-Received: by 2002:a05:6a21:6d83:b0:366:14ac:e1fc with SMTP id adf61e73a8af0-36618159251mr6366005637.78.1765148589162;
        Sun, 07 Dec 2025 15:03:09 -0800 (PST)
Received: from ?IPV6:2409:40e3:30a4:b776:2d5f:847f:53c0:cfd7? ([2409:40e3:30a4:b776:2d5f:847f:53c0:cfd7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3494f398f8bsm9963352a91.7.2025.12.07.15.03.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Dec 2025 15:03:08 -0800 (PST)
Message-ID: <3f3dd1f1-3127-45a2-9afc-7c452d0418d9@gmail.com>
Date: Mon, 8 Dec 2025 04:33:02 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] replay: add --revert mode to reverse commit
 changes
Content-Language: en-GB
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk,
 karthik.188@gmail.com, johannes.schindelin@gmx.de, toon@iotcl.com
References: <20251125170056.34489-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-1-siddharthasthana31@gmail.com>
 <20251202201611.22137-3-siddharthasthana31@gmail.com>
 <aTLDEgGzVnvU45va@pks.im>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <aTLDEgGzVnvU45va@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 05/12/25 17:03, Patrick Steinhardt wrote:
> On Wed, Dec 03, 2025 at 01:46:11AM +0530, Siddharth Asthana wrote:
>> diff --git a/builtin/replay.c b/builtin/replay.c
>> index 6606a2c94b..7660f7412f 100644
>> --- a/builtin/replay.c
>> +++ b/builtin/replay.c
>> @@ -77,9 +105,14 @@ static struct commit *create_commit(struct repository *repo,
>>   
>>   	commit_list_insert(parent, &parents);
>>   	extra = read_commit_extra_headers(based_on, exclude_gpgsig);
>> -	find_commit_subject(message, &orig_message);
>> -	strbuf_addstr(&msg, orig_message);
>> -	author = get_author(message);
>> +	if (action == REPLAY_REVERT) {
>> +		generate_revert_message(&msg, based_on, repo);
>> +		author = xstrdup(git_author_info(IDENT_STRICT));
>> +	} else {
>> +		find_commit_subject(message, &orig_message);
>> +		strbuf_addstr(&msg, orig_message);
>> +		author = get_author(message);
>> +	}
>>   	reset_ident_date();
>>   	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
>>   				 &ret, author, NULL, sign_commit, extra)) {
> Do we want to be defensive in those if-chains and verify that `action ==
> REPLAY_PICK` in the other case, and `BUG()` if it's not?


Good idea. I will add BUG() for unexpected action values to catch any 
future additions that aren't properly handled.


>
>> @@ -273,21 +322,39 @@ static struct commit *pick_regular_commit(struct repository *repo,
>>   	pickme_tree = repo_get_commit_tree(repo, pickme);
>>   	base_tree = repo_get_commit_tree(repo, base);
>>   
>> -	merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> -	merge_opt->branch2 = short_commit_name(repo, pickme);
>> -	merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
>> +	if (action == REPLAY_PICK) {
>> +		/* Cherry-pick: normal order */
>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> +		merge_opt->branch2 = short_commit_name(repo, pickme);
>> +		merge_opt->ancestor = xstrfmt("parent of %s", merge_opt->branch2);
>>   
>> -	merge_incore_nonrecursive(merge_opt,
>> -				  base_tree,
>> -				  result->tree,
>> -				  pickme_tree,
>> -				  result);
>> +		merge_incore_nonrecursive(merge_opt,
>> +					  base_tree,
>> +					  result->tree,
>> +					  pickme_tree,
>> +					  result);
>>   
>> -	free((char*)merge_opt->ancestor);
>> +		free((char *)merge_opt->ancestor);
>> +	} else {
>> +		/* Revert: swap base and pickme to reverse the diff */
>> +		const char *pickme_name = short_commit_name(repo, pickme);
>> +		merge_opt->branch1 = short_commit_name(repo, replayed_base);
>> +		merge_opt->branch2 = xstrfmt("parent of %s", pickme_name);
>> +		merge_opt->ancestor = pickme_name;
>> +
>> +		merge_incore_nonrecursive(merge_opt,
>> +					  pickme_tree,
>> +					  result->tree,
>> +					  base_tree,
>> +					  result);
>> +
>> +		free((char *)merge_opt->branch2);
>> +	}
>>   	merge_opt->ancestor = NULL;
>> +	merge_opt->branch2 = NULL;
> We can `FREE_AND_NULL()` instead of manually unsetting these.


Will use FREE_AND_NULL() - cleaner and clearer intent.


>
>> @@ -387,18 +460,28 @@ int cmd_replay(int argc,
>>   	argc = parse_options(argc, argv, prefix, replay_options, replay_usage,
>>   			     PARSE_OPT_KEEP_ARGV0 | PARSE_OPT_KEEP_UNKNOWN_OPT);
>>   
>> -	if (!onto_name && !advance_name_opt) {
>> -		error(_("option --onto or --advance is mandatory"));
>> +	/* Exactly one mode must be specified */
>> +	if (!onto_name && !advance_name_opt && !revert_name_opt) {
>> +		error(_("exactly one of --onto, --advance, or --revert is required"));
>>   		usage_with_options(replay_usage, replay_options);
>>   	}
>>   
>>   	die_for_incompatible_opt2(!!advance_name_opt, "--advance",
>> -				  contained, "--contained");
>> +				  !!onto_name, "--onto");
>> +	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
>> +				  !!onto_name, "--onto");
>> +	die_for_incompatible_opt2(!!revert_name_opt, "--revert",
>> +				  !!advance_name_opt, "--advance");
>> +	die_for_incompatible_opt2(contained, "--contained",
>> +				  !onto_name, "requires --onto");
> We have `die_for_incompatible_opt3()` that can be used here to check for
> mutual exclusivity of "--revert", "--advance" and "--onto".


Nice, I wasn't aware of this helper. Will use 
die_for_incompatible_opt3() for the three-way mutual exclusivity check.


>
>> @@ -508,7 +594,7 @@ int cmd_replay(int argc,
>>   		kh_value(replayed_commits, pos) = last_commit;
>>   
>>   		/* Update any necessary branches */
>> -		if (advance_name)
>> +		if (advance_name || revert_name)
>>   			continue;
>>   		decoration = get_name_decoration(&commit->object);
>>   		if (!decoration)
>> @@ -532,7 +618,7 @@ int cmd_replay(int argc,
>>   		}
>>   	}
>>   
>> -	/* In --advance mode, advance the target ref */
>> +	/* In --advance or --revert mode, update the target ref */
>>   	if (result.clean == 1 && advance_name) {
>>   		if (handle_ref_update(ref_mode, transaction, advance_name,
>>   				      &last_commit->object.oid,
>> @@ -544,6 +630,17 @@ int cmd_replay(int argc,
>>   			goto cleanup;
>>   		}
>>   	}
>> +	if (result.clean == 1 && revert_name) {
>> +		if (handle_ref_update(ref_mode, transaction, revert_name,
>> +				      &last_commit->object.oid,
>> +				      &onto->object.oid,
>> +				      reflog_msg.buf,
>> +				      &transaction_err) < 0) {
>> +			ret = error(_("failed to update ref '%s': %s"),
>> +				    revert_name, transaction_err.buf);
>> +			goto cleanup;
>> +		}
>> +	}
> This conditional and the one beforehand are the exact same, except that
> we use either `revert_name` or `advance_name`. Let's merge them:
>
>      if (result.clean == 1 && (revert_name || advance_name)) {
>          const char *ref = revert_name ? revert_name : advance_name;
>          if (handle_ref_update(ref_mode, transaction, ref,
>                        &last_commit->object.oid,
>                        &onto->object.oid,
>                        reflog_msg.buf,
>                        &transaction_err) < 0) {
>              ret = error(_("failed to update ref '%s': %s"),
>                      revert_name, transaction_err.buf);
>              goto cleanup;
>          }
>      }


Agreed, this is much cleaner. Will merge the conditionals as you 
suggest. Will incorporate all changes in v3.

Thanks for the thorough review!

Siddharth


>
> Patrick
