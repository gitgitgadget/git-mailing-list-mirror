Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A66C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 13:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01236208E4
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 13:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hELws1W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgHZNeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730264AbgHZNen (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 09:34:43 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FDFC061757
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 06:34:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id w10so1491216oti.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2020 06:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oMKEqbMEI3AYcBhTpoEqajjgPT4pdPEpr41pL0/SKQA=;
        b=hELws1W96f7gmLg+oKs1MUMQ/ZmBGfc3wU6ESCjvU8/ChqncNNyU/6a1cEO2Qibpu+
         onfT61ISrc4EJWIvDD9ekchIJJsr2I0/CncYxbiUbHz5FmZR/YDVd2C/seeHq/4V06B4
         jsesqCC0W8iM1AHVVG4Cdm7Q6r5t9+9WoARAYlUqJNeNC+OBG4YpLiSeB/GfjRHG/+b8
         DRQw1m+XprQJoQiQyobt3wISOtOTaKzoYEBL37hEDDquHqdxD+oQFfCjCFeEfgsTy2Pm
         r2OLpkY9zcibsQTfwcz2oUIgyKwCpNPjveTgII0mHelnZRjMvp2Fdjsvhx/OLy0Rl0Mn
         ZgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oMKEqbMEI3AYcBhTpoEqajjgPT4pdPEpr41pL0/SKQA=;
        b=OayLSmzs76zdPTsnW6+Sp938dJYBg4DabeZ2h55vk/UnHe369omsVoe2Lc9GD2KrTR
         YgUwi1N0WOv9SoAc7XguTWjHZfhRdUBvwS/kNIdQ81VUGoAXSSrM3yChRMqk87ILEx51
         AcrkRzC8Jw0iCuysUjP2Bi3adVt+lcrvEmZopb/siuTkT37K0z36f+xi4xSoz6FlcSj2
         ehkzG8qVHHbW/6CyRoaZRIBaR8hOq2L5qLSPbtqTrMC/Ht//jUj/F1MIl8flv03EUZk6
         gXzDYb9C/ezwon8QSHcpvKkmQr9jn6UF/58mYsm4g05EM/b/2nxL36XyibWvZk1N3oVD
         h8Ug==
X-Gm-Message-State: AOAM533Hp6Yg1J6qbuuxJaw1T0qGyEaHqMd3JadXnqmBQ4dZE9NZ/dvA
        qqCHC7cjjGKSX3/+CvcgRjWtYyp+WiTxSjVc
X-Google-Smtp-Source: ABdhPJxhm5N/xKDHUGp7aajn3TBQZo4HaVnamWyC2/qe25XE/y94nvVQhctrxCi93TEM7rAg5NiC7Q==
X-Received: by 2002:a9d:768d:: with SMTP id j13mr4050298otl.214.1598448882723;
        Wed, 26 Aug 2020 06:34:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:718c:9432:b85d:1e88? ([2600:1700:e72:80a0:718c:9432:b85d:1e88])
        by smtp.gmail.com with ESMTPSA id p9sm497355oti.22.2020.08.26.06.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 06:34:42 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] maintenance: store the "last run" time in config
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
 <e3ef0b9bea4a31c72ce88841639e88355408f0c1.1598380805.git.gitgitgadget@gmail.com>
 <xmqqh7sqz93k.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4fe41132-c8f5-6b85-414f-5a1e5fcccdc9@gmail.com>
Date:   Wed, 26 Aug 2020 09:34:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <xmqqh7sqz93k.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/25/2020 5:52 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> I selected the timestamp before the task, as opposed to after the task,
>> for a couple reasons:
>>
>>  1. The time the task takes to execute should not contribute to the
>>     interval between running the tasks.
> 
> ... as long as the run time is sufficiently shorter than the
> interval, that is.  If a task takes 10-30 minutes depending on how
> dirty the repository is, it does not make sense to even try to run
> it every 15 minutes.

Definitely. The lock on the object database from earlier prevents these
longer-than-anticipated tasks from stacking.

>> If a daily task takes 10 minutes
>>     to run, then every day the execution will drift by at least 10
>>     minutes.
> 
> That is not incorrect per-se, but it does not tell us why drifting
> by 10 minutes is a bad thing.

True.

>>  2. If the task fails for some unforseen reason, it would be good to
>>     indicate that we _attempted_ the task at a certain timestamp. This
>>     will avoid spamming a repository that is in a bad state.
> 
> Absolutely.
> 
>> +static void update_last_run(struct maintenance_task *task)
>> +{
>> +	timestamp_t now = approxidate("now");
>> +	struct strbuf config = STRBUF_INIT;
>> +	struct strbuf value = STRBUF_INIT;
>> +	strbuf_addf(&config, "maintenance.%s.lastrun", task->name);
>> +	strbuf_addf(&value, "%"PRItime"", now);
> 
> So is this essentially meant as a human-unreadable opaque value,
> like we have in the commit object header lines?  I do not have a
> strong opinion, but it would be nice to allow curious to casually
> read it.  Perhaps "git config --type=timestamp maintenance.lastrun"
> can be taught to pretty print its value?

Good idea. I will think on this. Of course, we already have
--type=expiry-date, which does the opposite. Perhaps this config
value should be a human-readable date and then be parsed into a
timestamp in-process using git_config_expiry_date()?

I have mixed feelings on using that format, because it can store
both a fixed or relative datetime. The *.lastRun config really
wants a _fixed_ datetime, but the *.schedule config (in the next
patch) would want a _relative_ datetime. This also allows things
like "now" or "never", so it presents a lot of flexibility for
users. A nightmare to test, but perhaps that flexibility is
useful.

(Of course, in another thread you mentioned multiple `crontab`
lines, which might make this entire discussion irrelevant. I'll
follow up there.)

Thanks,
-Stolee
