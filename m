Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E009C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 16:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376659AbiBDQvc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 11:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiBDQva (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 11:51:30 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E099C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 08:51:30 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id n8so4954052wmk.3
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 08:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3LF/KCIvOuIi5MsswgNZtGub7mSsqiklTSKE+YbItX0=;
        b=Qu4BRcHcsJfWTROG5RrrQ7PxAbn2wc+pAUFta6E8230kdn3PhWpvecn9hEGf7Y2dXI
         juCN6Op8/JY+9du/L0ijjRPpp7ya1d95Bfkd7J6UfHxRtbjOEucjAy+RSqD7RD7Mi0g/
         01rihlllT57EjriaqK6mMcwq7RsXMaG6SbgUnxJDJvs0Wo78AhhW5mJqWEBsvqHjA3XF
         +z6r9O3ZiG6FxQzrG+iiIr/aOL6CVahW0HH2+wuzA//lZaZrACjvifYd7kOMmJu63txV
         g7Ir6U2GlNVoorG3LWrHM8wrMzSoSt0Bi9GJFtK5K9w5v44RbICTOOufM+ULOI3+Je86
         Qx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3LF/KCIvOuIi5MsswgNZtGub7mSsqiklTSKE+YbItX0=;
        b=nDzRyfc1VJT83bvrVJE10HCXehvQ1KC7gtYcuoBnRa1qVNwNLj/GGyiJyndhjzlgC/
         nizzuosyUdBqfbpX2vKcJqmRQvoPMVauHUpeEbgwJ9grlo1/vndxKGFyPjb6W7AmU54Q
         /M9gGF/LQzDESVHmGaHXViqH79CBG5KXEekMUr1Y+T3SjEkbYWXuEyUU7DYMLK2ET71G
         qkPGYUQZ0SjctRRbPVNcwHZZZsnpauRNGLgk3qTc1+L00eB0N0SjUqKmeKpzwQWP8CPh
         hi2EOvF2SEgHvcePt9ZKSyLrbNk25n7SiWOhlQACR1JrOHKcYFWwkdmS21NqjmkV7fYH
         sETQ==
X-Gm-Message-State: AOAM532n/HGwImq5CQvAIT5OUtjahhzuZSZmBdcK0563QUSrzKWcyYH2
        B6P6ShMuAS8YkT0QFVRTpL0f3kGQ4q4=
X-Google-Smtp-Source: ABdhPJyzyISES4G32JsXFisbyKOUW6ZzxMu1Nq6+kKe6LJa28he07S6NQPMtW30ngbdBn+riVtB9pg==
X-Received: by 2002:a05:600c:3d06:: with SMTP id bh6mr2959810wmb.87.1643993488794;
        Fri, 04 Feb 2022 08:51:28 -0800 (PST)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id x18sm2253130wrw.17.2022.02.04.08.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 08:51:28 -0800 (PST)
Message-ID: <21e8af90-3217-782a-2ce5-3a99fd37cfbc@gmail.com>
Date:   Fri, 4 Feb 2022 16:51:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] catfile.c: add --batch-command mode
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, e@80x24.org,
        bagasdotme@gmail.com, gitster@pobox.com,
        John Cai <johncai86@gmail.com>
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
 <ebd2a1356017905245744babf32c5b78a0af1639.1643915286.git.gitgitgadget@gmail.com>
 <220204.86v8xu3jou.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220204.86v8xu3jou.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John/Ævar

On 04/02/2022 12:11, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Feb 03 2022, John Cai via GitGitGadget wrote:
> 
>> From: John Cai <johncai86@gmail.com>
>> +		if (state == BATCH_STATE_INPUT && !cmd){
>> +			string_list_append(&revs, input.buf);
> 
> Nit: You can save yourself some malloc() churn here with:
> 
>      string_list_append_nodup(..., strbuf_detach(&input, NULL));
> 
> I.e. we're looping over the input, here we're done, so we might as well
> steal the already alloc'd string....

If we do that then the strbuf will have to reallocate its buffer when it 
reads the next input line on the next iteration of the loop. As the 
strbuf will have likely over allocated the buffer using the 
string_list_append_nodup() + strbuf_detach() will will be less efficient 
overall than using string_list_append().

Best Wishes

Phillip

>> +			continue;
>> +		}
>> +
>> +		if (!cmd)
>> +			die("unknown command: %s", input.buf);
>> +
>> +		state = cmd->next_state;
>> +		cmd->fn(opt, p, output, data, revs);
>> +	}
>> +	strbuf_release(&input);
>> +	string_list_clear(&revs, 0);
> 
> ...and these will do the right thing, as strbuf will notice the string
> is stolen (it'll be the slopbuf again), and due to the combination of
> *_DUP and *_nodup() we'll properly free it here too.
> 
>> +}
>> +
>>   static int batch_objects(struct batch_options *opt)
>>   {
>>   	struct strbuf input = STRBUF_INIT;
>> @@ -519,6 +665,7 @@ static int batch_objects(struct batch_options *opt)
>>   	struct expand_data data;
>>   	int save_warning;
>>   	int retval = 0;
>> +	const int command = opt->command;
>>   
>>   	if (!opt->format)
>>   		opt->format = "%(objectname) %(objecttype) %(objectsize)";
>> @@ -594,22 +741,25 @@ static int batch_objects(struct batch_options *opt)
>>   	save_warning = warn_on_object_refname_ambiguity;
>>   	warn_on_object_refname_ambiguity = 0;
>>   
>> -	while (strbuf_getline(&input, stdin) != EOF) {
>> -		if (data.split_on_whitespace) {
>> -			/*
>> -			 * Split at first whitespace, tying off the beginning
>> -			 * of the string and saving the remainder (or NULL) in
>> -			 * data.rest.
>> -			 */
>> -			char *p = strpbrk(input.buf, " \t");
>> -			if (p) {
>> -				while (*p && strchr(" \t", *p))
>> -					*p++ = '\0';
>> +	if (command)
>> +		batch_objects_command(opt, &output, &data);
>> +	else {
> 
> Style: {} braces for all arms if one requires it.
> 
>> +		while (strbuf_getline(&input, stdin) != EOF) {
>> +			if (data.split_on_whitespace) {
> 
> diff nit: maybe we can find some way to not require re-indenting the existing code. E.g.:
> 	
> 	if (command) {
> 		batch_objects_command(...);
> 	        goto cleanup;
> 	}
> 
> ...
> 
>> +				/*
>> +				 * Split at first whitespace, tying off the beginning
>> +				 * of the string and saving the remainder (or NULL) in
>> +				 * data.rest.
>> +				 */
>> +				char *p = strpbrk(input.buf, " \t");
>> +				if (p) {
>> +					while (*p && strchr(" \t", *p))
>> +						*p++ = '\0';
>> +				}
>> +				data.rest = p;
>>   			}
>> -			data.rest = p;
>> +			batch_one_object(input.buf, &output, opt, &data);
>>   		}
>> -
>> -		batch_one_object(input.buf, &output, opt, &data);
>>   	}
>>   
> 
> ...and then just add a "cleanup:" label here.
> 
>>   	strbuf_release(&input);
>> @@ -646,6 +796,7 @@ static int batch_option_callback(const struct option *opt,
>>   
>>   	bo->enabled = 1;
>>   	bo->print_contents = !strcmp(opt->long_name, "batch");
>> +	bo->command = !strcmp(opt->long_name, "batch-command");
>>   	bo->format = arg;
>>   
>>   	return 0;
>> @@ -682,6 +833,11 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>>   			N_("show info about objects fed from the standard input"),
>>   			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>>   			batch_option_callback),
>> +		OPT_CALLBACK_F(0, "batch-command", &batch, N_(""),
> 
> You're either missing a string here in "", or we don't need N_() to mark
> it for translation.
> 
>> +			 N_("enters batch mode that accepts commands"),
>> +			 PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
>> +			 batch_option_callback),
>> +
>>   		OPT_BOOL(0, "follow-symlinks", &batch.follow_symlinks,
>>   			 N_("follow in-tree symlinks (used with --batch or --batch-check)")),
>>   		OPT_BOOL(0, "batch-all-objects", &batch.all_objects,
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index 39382fa1958..7360d049113 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -85,6 +85,34 @@ $content"
>>   	test_cmp expect actual
>>       '
>>   
>> +    test -z "$content" ||
>> +    test_expect_success "--batch-command output of $type content is correct" '
>> +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
>> +	maybe_remove_timestamp "$(echo contents $sha1 | git cat-file --batch-command)" $no_ts >actual &&
>> +	test_cmp expect actual
>> +    '
>> +
>> +    test -z "$content" ||
>> +    test_expect_success "--batch-command session for $type content is correct" '
>> +	maybe_remove_timestamp "$batch_output" $no_ts >expect &&
>> +	maybe_remove_timestamp \
>> +		"$(test_write_lines "begin" "$sha1" "get contents" | git cat-file --batch-command)" \
>> +		$no_ts >actual &&
>> +	test_cmp expect actual
>> +    '
>> +
>> +    test_expect_success "--batch-command output of $type info is correct" '
>> +	echo "$sha1 $type $size" >expect &&
>> +	echo "info $sha1" | git cat-file --batch-command >actual &&
>> +	test_cmp expect actual
>> +    '
>> +
>> +    test_expect_success "--batch-command session for $type info is correct" '
>> +	echo "$sha1 $type $size" >expect &&
>> +	test_write_lines "begin" "$sha1" "get info" | git cat-file --batch-command >actual &&
>> +	test_cmp expect actual
>> +    '
>> +
>>       test_expect_success "custom --batch-check format" '
>>   	echo "$type $sha1" >expect &&
>>   	echo $sha1 | git cat-file --batch-check="%(objecttype) %(objectname)" >actual &&
>> @@ -141,6 +169,7 @@ test_expect_success '--batch-check without %(rest) considers whole line' '
>>   '
>>   
>>   tree_sha1=$(git write-tree)
>> +
> 
> stray newline addition.
> 
>>   tree_size=$(($(test_oid rawsz) + 13))
>>   tree_pretty_content="100644 blob $hello_sha1	hello"
>>   
>> @@ -175,7 +204,7 @@ test_expect_success \
>>       "Reach a blob from a tag pointing to it" \
>>       "test '$hello_content' = \"\$(git cat-file blob $tag_sha1)\""
>>   
>> -for batch in batch batch-check
>> +for batch in batch batch-check batch-command
>>   do
>>       for opt in t s e p
>>       do
>> @@ -281,6 +310,15 @@ test_expect_success "--batch-check with multiple sha1s gives correct format" '
>>       "$(echo_without_newline "$batch_check_input" | git cat-file --batch-check)"
>>   '
>>   
>> +test_expect_success "--batch-command with multiple sha1s gives correct format" '
>> +    echo "$batch_check_output" >expect &&
>> +    echo begin >input &&
>> +    echo_without_newline "$batch_check_input" >>input &&
>> +    echo "get info" >>input &&
>> +    git cat-file --batch-command <input >actual &&
>> +    test_cmp expect actual
>> +'
> 
> indentation with spaces, \t correctly used for the rest.
