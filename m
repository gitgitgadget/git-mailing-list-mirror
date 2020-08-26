Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13014C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1FD52075E
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 16:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VztXTTQS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgHZQDm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727881AbgHZQDY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 12:03:24 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86D8C061757
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 09:03:23 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id cs12so950778qvb.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 09:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X0OjuTZT9TrhvhxiO1Uz4TlVYlg/QDbohBfpIUzeWdo=;
        b=VztXTTQSCL3XED41hrriMBRllmcZtyNwkucZ4fr8UM63tgBa8DTOrcyzq8btBfb1rN
         fs7QkSwlVGgB1Dzzur7gW9kDfLzoZYgX8P9tQcfwPbLX+iw8kDA0wWeCeLxK7ak9aF82
         wNJis30U70euYpGSGROSV7bHYMacpLUNBXCDfXTuKehfZSG8a7Zu2zAsgP6bTPM8qCdn
         9viYUfJ7rGOUNK0l02OvQLdTJiIF743shkbRK34j1K9t7Acv5oj8apK2lG+kvjlaO99h
         lgXNAfAAzpbbiJj5Rm7CzGgtLWPJFFE4NsW2JRc9jwM2lTFKPXoyzPAkFncxs1yF1X/I
         2HuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X0OjuTZT9TrhvhxiO1Uz4TlVYlg/QDbohBfpIUzeWdo=;
        b=LdviHE1GHkbfy0ofCa/DLYWDzquUV/g/CgogoM/F7qCw5DKQu3l+IKHgzoZN4UUtbv
         enSs2ySbtO82baAHCy4fKbUwqEezkoR4y7xAjB0otitv34cr8E/Lkzbnz+zmHHzqHF0w
         Rm4ARD6tSi9f44GgaHQxG/2d1yhh3fIgb1fkg4Lm19eOz7gIwWV6yAEsy1WPMQd67ViY
         uq4LeZXVSGXDCJuDAKuRPbjyaeOFbNsiOfiEQEqj88hV09/ti/phNKjDFgWAv0WuWCB6
         Hp4y7hT4Kyam5pBa/vtHTD/zJiiFQfGL2yX3qTc/Xm5jeATL+IJVPR7AWFwDx1tDsSGk
         y1+g==
X-Gm-Message-State: AOAM533KkMRiE9W1UjG3C+JwH0YUb1OtVWFOb4bLmgIjyVFE28sXZtEg
        kxfALRGwEo8o2ybDJlBHlvo=
X-Google-Smtp-Source: ABdhPJynmU5YrfivJCf9wf0xRqdqcH31VsbjZr6uLOlFcQ+04O9RCSdBtR3J4Ju2eyObxQ3bZVqMlA==
X-Received: by 2002:ad4:444e:: with SMTP id l14mr14373476qvt.111.1598457802810;
        Wed, 26 Aug 2020 09:03:22 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id 103sm2270340qta.31.2020.08.26.09.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 09:03:22 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] for-each-repo: run subcommands on configured repos
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.680.git.1597857408.gitgitgadget@gmail.com>
 <pull.680.v2.git.1598380805.gitgitgadget@gmail.com>
 <0314258c5cbb8fd771c35e433bf6be95297c4597.1598380805.git.gitgitgadget@gmail.com>
 <xmqq8se2z7uh.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <30cadb74-924e-09bc-1ca4-352de3e629f3@gmail.com>
Date:   Wed, 26 Aug 2020 12:03:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqq8se2z7uh.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 6:19 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +SYNOPSIS
>> +--------
>> +[verse]
>> +'git for-each-repo' --config=<config> [--] <arguments>
>> + ...
>> +--config=<config>::
>> +	Use the given config variable as a multi-valued list storing
>> +	absolute path names.
> 
> Would it make sense to allow this config to be read from the current
> repository, I wonder.  It is probably designed to be written to
> either ~/.gitconfig or /etc/gitconfig because it is probably a need
> that is not per-repository to list repositories for various purposes
> specified by the config key, but I suspect there _might_ be a good
> use case for storing some custom list of repositories in the
> configuration file local to a repository, but it is not quite
> obvious what it is.
> 
> If we have a good example, we may want to spell it out---that would
> help future readers who wonder about this (just like I am doing now).
> 
> Also, if we do read from local config, should there be a way to say
> "ah, you may have read values from /etc/gitconfig and ~/.gitconfig,
> but please forget them---I have a full list I care when you are
> running in this repository", i.e. clear the list.  It is purely a
> convention and there is no built-in mechanism for this in the config
> API, but often it is signalled by giving an empty string as a value.

I guess I should test this, but if I ask for a multi-valued config,
will I not get _all_ of the results from /etc/gitconfig, ~/.gitconfig,
AND .git/config? That was my expectation, which is why I don't specify
"local" or "global" config anywhere in the discussion.

> By the way, I do not have a good concrete suggestion, but can we use
> something better than <config> as the placeholder?  I first thought
> this was naming the name of a file that lists repositories, not the
> config variable name in our usual config namespace.
Sure. How about "<key>"?

>> +static int run_command_on_repo(const char *path,
>> +			       void *cbdata)
> 
> Is that on repo or in repo?  When I saw "-C" on the command line, I
> immediately thought of "in repo".

"in" is better.

>> +{
>> +	int i;
>> +	struct child_process child = CHILD_PROCESS_INIT;
>> +	struct strvec *args = (struct strvec *)cbdata;
>> +
>> +	child.git_cmd = 1;
>> +	strvec_pushl(&child.args, "-C", path, NULL);
>> +
>> +	for (i = 0; i < args->nr; i++)
>> +		strvec_push(&child.args, args->v[i]);
> 
> Would strvec_pushv() work, or is args->v[] not NULL terminated?

Yeah, pushv should work.

>> +	return run_command(&child);
>> +}
> 
> 
>> +	values = repo_config_get_value_multi(the_repository,
>> +					     config_key);
> 
> Not your fault, but it is a bit unsatisfactory that we do not have
> special "type" meant for paths in the config API, unlike the
> parse-options API where there is a "filename" type that is a bit
> richer than a vanilla "string" type by allowing "prefix" handling.
> For the purposes of this, as the values are limited to absolute/full
> pathnames, it does not hurt as much, though.

Interesting. Noted.

Thanks,
-Stolee
