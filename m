Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FC8C433DF
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:29:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A412067D
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 13:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCqSHGpE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgG3N3N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3N3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 09:29:13 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA16C061794
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:29:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id u64so25477868qka.12
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 06:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eUDx5RQaxwUpO47L6FRyj98Qan9xjB2xvY/v+dKfQ9M=;
        b=VCqSHGpEU86btGZCf3sCm8MvuUMFaLRu6urJwFEUNMh+He9iVysLO8LVh/sEjuTPPa
         2J7YKrdQtGvLcDd9OV1RbzXVfoZBicS0WOrSbvp2+ebFBO+H4Ifc6Ytn8qk8gDsqANhW
         sfiDfOKD9ZJdPBYs7xGuPnsu8PVNN9g+p4jhgCuKJ+4exrR6U48DGbfZeTVKqgyeLBYG
         t1TDXP6qhwmqhVWrzgrJBvZvclKhnMqIAk5yuR4+x+8s4CFv7hR/8xshQ6MiPoLcUO0I
         Ov4o7VMz9KdAmYcNpMSTVo3aJt8nLpEYAF2A4e1byVE58Qp0yy6Uw5cibqJTKUyaXLaO
         fsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eUDx5RQaxwUpO47L6FRyj98Qan9xjB2xvY/v+dKfQ9M=;
        b=FkcgWhIbXP8cjKHh2M408/8XpUtfsJfq6Jg05kAODaxZEwd+uDFt35N73UYLKGnYBD
         bkT8M0Kjg8E8Jh6HclHaXVURiUr38djw+5XOzPRECwzD5taYolpj28Bd9IPjtJqqMw2Q
         npsb0hrEZtzHCVfh3v+FxILBffN2MxtmKwBIg5rErOqRTv02+z0zrABevFRe+udA3c7m
         AQoCkIXRAcQdGygOQ+nXhPO8Glt6mOMXHFoG8md2pNm59+50Q9bGV5ijf2udJ2uWU3ad
         WZSJfMP8taDlhpXONUuu/Ryv3Uaw1VDfxul4fUYDg96oKBpBs8GsfC5dMT8bPGmp4BpH
         xeCA==
X-Gm-Message-State: AOAM530r3EowuVaHNLtgjbiGzo/Cut9Z1SQxcERcEzBORQDR0KAleOE2
        P5mu+lPN1lwxkNuF9zh0lrM=
X-Google-Smtp-Source: ABdhPJwNynR3Rb/dXkIyksxG3J7/2vwr0j/4D6pTCsQ2vaS7iGtn2wN33jkTa+OFmx1duJe4f5qdXg==
X-Received: by 2002:a37:4ccc:: with SMTP id z195mr37276356qka.270.1596115751742;
        Thu, 30 Jul 2020 06:29:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:7cc2:825e:4cec:e949? ([2600:1700:e72:80a0:7cc2:825e:4cec:e949])
        by smtp.gmail.com with ESMTPSA id a3sm4083283qkf.131.2020.07.30.06.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:29:11 -0700 (PDT)
Subject: Re: [PATCH v2 03/18] maintenance: replace run_auto_gc()
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <f164d1a0b4363eb6eb174e90e88211829f8a1d55.1595527000.git.gitgitgadget@gmail.com>
 <xmqqblk6q8ws.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9aadb889-007a-c973-c59c-a471436368bb@gmail.com>
Date:   Thu, 30 Jul 2020 09:29:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqqblk6q8ws.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 4:21 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +--[no-]maintenance::
>>  --[no-]auto-gc::
>> -	Run `git gc --auto` at the end to perform garbage collection
>> -	if needed. This is enabled by default.
>> +	Run `git maintenance run --auto` at the end to perform garbage
>> +	collection if needed. This is enabled by default.
> 
> Shouldn't the new synonym be called --auto-maintenance or an
> abbreviation thereof?  It is not like we will run the full
> maintenance suite when "--no-maintenance" is omitted, which
> certainly is not the impression we want to give our readers.

Adding "auto-" to the argument can be informative.

I would think that abbreviating the option may make understanding
the argument more difficult for users where English is not their
first language. Of course, I'm a bad judge of that.

I also don't think this option is called often by users at the
command-line and instead is done by scripts and third-party tools.
Abbreviating the word may have less value there.

(This reminds me that is would be good to have a config option that
prevents running this process _at all_. Sure, gc.auto=0 prevents the
command from doing anything, but there is still an extra cost of
starting a process. This is more of a problem on Windows. Making a
note to self here.)

>>  These objects may be removed by normal Git operations (such as `git commit`)
>> -which automatically call `git gc --auto`. (See linkgit:git-gc[1].)
>> -If these objects are removed and were referenced by the cloned repository,
>> -then the cloned repository will become corrupt.
>> +which automatically call `git maintenance run --auto` and `git gc --auto`.
> 
> Hmph.  Perhaps the picture may change in the end of the series but I
> got an impression that "gc --auto" would eventually become just part
> of "maintenance --auto" and the users won't have to be even aware of
> its existence?  Wouldn't we rather want to say something like
> 
> 	--[no-]auto-maintenance::
> 	--[no-]auto-gc::
>                 Run `git maintenance run --auto` at the end to perform
>                 garbage collection if needed (`--[no-]auto-gc` is a
>                 synonym).  This is enabled by default.

I don't completely eliminate 'git gc' at the end of this series, but
instead hope that we can peel it apart slowly in follow-up series.
However, you are correct that I should be more careful to obliterate
it from the documentation instead of keeping references around.

>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 82ac4be8a5..49a4d727d4 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -196,8 +196,10 @@ static struct option builtin_fetch_options[] = {
>>  	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
>>  			N_("report that we have only objects reachable from this object")),
>>  	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
> 
>> +	OPT_BOOL(0, "maintenance", &enable_auto_gc,
>> +		 N_("run 'maintenance --auto' after fetching")),
>>  	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
>> +		 N_("run 'maintenance --auto' after fetching")),
> 
> OK, so this is truly a backward-compatible synonym at this point.
> 
>> diff --git a/run-command.c b/run-command.c
>> index 9b3a57d1e3..82ad241638 100644
>> --- a/run-command.c
>> +++ b/run-command.c
>> @@ -1865,14 +1865,17 @@ int run_processes_parallel_tr2(int n, get_next_task_fn get_next_task,
>>  	return result;
>>  }
>>  
>> -int run_auto_gc(int quiet)
>> +int run_auto_maintenance(int quiet)
>>  {
>>  	struct argv_array argv_gc_auto = ARGV_ARRAY_INIT;
>>  	int status;
>>  
>> -	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
>> +	argv_array_pushl(&argv_gc_auto, "maintenance", "run", "--auto", NULL);
>>  	if (quiet)
>>  		argv_array_push(&argv_gc_auto, "--quiet");
>> +	else
>> +		argv_array_push(&argv_gc_auto, "--no-quiet");
>> +
>>  	status = run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
>>  	argv_array_clear(&argv_gc_auto);
>>  	return status;
> 
> Don't we want to replace all _gc_ with _maintenance_ in this
> function?  I think the first business before we can do so would be
> to rethink if spelling out "maintenance" fully in code is a good
> idea in the first space.  It would make names for variables,
> structures and fields unnecessarily long without contributing to
> ease of understanding an iota, and a easy-to-remember short-form or
> an abbreviation may be needed.  Using a short-form/abbreviation
> wouldn't worsen the end-user experience, and not the developer
> experience for that matter.
> 
> If we choose "gc" as the short-hand, most of the change in this step
> would become unnecessary.  I also do not mind if we some other words
> or word-fragment (perhaps "maint"???) is chosen.

Yes, I should have noticed that. Also, with Peff's feedback from
another thread, the method can look a bit simpler this way:

int run_auto_maintenance(int quiet)
{
	struct child_process maint = CHILD_PROCESS_INIT;
	maint.git_cmd = 1;

	argv_array_pushl(&maint.argv, "maintenance", "run", "--auto", NULL);
	if (quiet)
		argv_array_push(&maint.argv, "--quiet");
	else
		argv_array_push(&maint.argv, "--no-quiet");

	return run_command(&maint.argv);
}

(I will update it again to work on Peff's argv_array work, but
hopefully it is clear how this is simpler.)

Thanks,
-Stolee
