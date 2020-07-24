Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDFC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DB32074A
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 13:09:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUg0i3Il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgGXNJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbgGXNJa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 09:09:30 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F925C0619D3
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:09:29 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g37so6900457otb.9
        for <git@vger.kernel.org>; Fri, 24 Jul 2020 06:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ijiN7SAT7rvwXUdZrfUJfz5BroaFGrxgo/NAUvf56So=;
        b=GUg0i3IllhNPfEqhMWnbguh4A4n6niLzBRAmHfUUUzTFY4SafpV91Uce7dNIEy2nzq
         3SpLqjEjfy81ryuLYZht4ymgjbhRBM1BSzAz55I7LIH941zzjGxce+7cAl8vfj26+g6Z
         wvg0WF81YtC64yjQQvK/9HCbiD7BaUcUVa4Y9Mkji6/yZ1DSuaDu+LZ1hxMGp41IAfHl
         MpX+tzHTzYL2GaCDuZ4nTTUxEgo+oeCfTHENbHgFjySORK1iuG1sAldgKW3pZKkLS5AK
         qCCE4llnGN3IqfBx8oHMy/1d954rTiLHkR0DDXce7kYU7two3Wgfol6Nu5kV0MP59IuL
         jNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijiN7SAT7rvwXUdZrfUJfz5BroaFGrxgo/NAUvf56So=;
        b=qWFag88JyiePFAEZvM+5iCOwm8/6TUl335Dty/2EPd7r+e71c+RpzLMBlwfF6aDLdJ
         FTlE4z7/Z0c/eXUec+UEYUYX0rDFaZ+tF43YoJHIastDdZFiU6U0s9uGYXCTs3S2m2Si
         YSR6/q+k+inS0swbmCA7opFfq+qbM7/3JL88CaHzL0OrtCYGB1a4O7YEQbz4TXI6o4lR
         EGcL9uetrJWMl4kKVqejrlCgFTrCGPISsKhp4TtXhrFqTBC192hjttVjhLmlFbKX+RGn
         mSmrlOJ7j6i94MzfVaRN081V7ALCNcJ42FyrxFQ33PZL/RCYGc7175ofH+r+CnB5Yte4
         svoA==
X-Gm-Message-State: AOAM531+EIN5TpYUP7GfvkcLnJryW7k/fZdGz4koD/akV1MMUxh2NPsE
        0rsDIbRc5Cor39xKdjjbef0=
X-Google-Smtp-Source: ABdhPJzncphvl+iwN/PVxAVJycpQBC5lPd1nEj1rxI8t/BKKE9AOVPDRkSFSpTmgr83fVKh9v4Q1sg==
X-Received: by 2002:a05:6830:4a6:: with SMTP id l6mr7764248otd.229.1595596168449;
        Fri, 24 Jul 2020 06:09:28 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:44af:70e9:4b5b:8d7f? ([2600:1700:e72:80a0:44af:70e9:4b5b:8d7f])
        by smtp.gmail.com with ESMTPSA id k2sm1281810otn.56.2020.07.24.06.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jul 2020 06:09:27 -0700 (PDT)
Subject: Re: [PATCH v2 05/18] maintenance: add commit-graph task
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
 <04552b1d2ed751a11eb7c50f6898cbc078b552b4.1595527000.git.gitgitgadget@gmail.com>
 <xmqq4kpyq8wh.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b0bc5d89-52fa-e0f4-e3af-5eb6c76d312e@gmail.com>
Date:   Fri, 24 Jul 2020 09:09:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:79.0) Gecko/20100101
 Thunderbird/79.0
MIME-Version: 1.0
In-Reply-To: <xmqq4kpyq8wh.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/23/2020 4:22 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +static int maintenance_task_commit_graph(void)
>> +{
>> +	struct repository *r = the_repository;
>> +	char *chain_path;
>> +
>> +	/* Skip commit-graph when --auto is specified. */
>> +	if (opts.auto_flag)
>> +		return 0;

Now that you point this out, this is actually a stray condition
from an earlier version. We now have the ".enabled" config and
the auto condition function pointer. That handles all of that
"should we run this when --auto is specified?" logic outside of
the task itself.
 
> Stepping back a bit, back in "git gc" days, "--auto" had two
> distinct meanings rolled into one.  Check if it even needs to be
> done, and perform only the lightweight variant if needed.
> 
> For this task, there is no "lightweight variant" is possible, so
> returning without checking the need to do a lightweight one makes
> perfect sense here.
> 
> But wouldn't it suggest perhaps we could name "auto" field of the
> options struct in a more meaningful way?  Perhaps "quick" (i.e. only
> the quicker-variant of the maintenance job) or something?

But you are discussing here how the _behavior_ can change when
--auto is specified. And specifically, "git gc --auto" really
meant "This is running after a foreground command, so only do
work if necessary and do it quickly to minimize blocking time."

I'd be happy to replace "--auto" with "--quick" in the
maintenance builtin.

This opens up some extra design space for how the individual
tasks perform depending on "--quick" being specified or not.
My intention was to create tasks that are already in "quick"
mode:

* loose-objects have a maximum batch size.
* incremental-repack is capped in size.
* commit-graph uses the --split option.

But this "quick" distinction might be important for some of
the tasks we intend to extract from the gc builtin.

>> +	close_object_store(r->objects);
>> +	if (run_write_commit_graph()) {
>> +		error(_("failed to write commit-graph"));
>> +		return 1;
>> +	}
>> +
>> +	if (!run_verify_commit_graph())
>> +		return 0;
>> +
>> +	warning(_("commit-graph verify caught error, rewriting"));
>> +
>> +	chain_path = get_commit_graph_chain_filename(r->objects->odb);
>> +	if (unlink(chain_path)) {
>> +		UNLEAK(chain_path);
>> +		die(_("failed to remove commit-graph at %s"), chain_path);
> 
> OK.
> 
>> +	}
>> +	free(chain_path);
>> +
>> +	if (!run_write_commit_graph())
>> +		return 0;
>> +
>> +	error(_("failed to rewrite commit-graph"));
>> +	return 1;
>> +}
> 
> Error convention is "positive for error, zero for success?"  That is
> a bit unusual for our internal API.

Since the tasks are frequently running subcommands, returning
0 for success and non-zero for error matches the error codes
returned by those subcommands.

Should I instead change the behavior and clearly document that
task functions matching maintenance_task_fn follow this error
pattern?

>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> index e4e4036e50..216ac0b19e 100755
>> --- a/t/t7900-maintenance.sh
>> +++ b/t/t7900-maintenance.sh
>> @@ -12,7 +12,7 @@ test_expect_success 'help text' '
>>  	test_i18ngrep "usage: git maintenance run" err
>>  '
>>  
>> -test_expect_success 'gc [--auto|--quiet]' '
>> +test_expect_success 'run [--auto|--quiet]' '
> 
> It does not look like this change belongs here.  If "run" is
> appropriate title for this test at this step, it must have been so
> in the previous step.

Thanks. Will fix.

-Stolee
