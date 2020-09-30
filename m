Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A467C4727C
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 474AE2074A
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 20:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uUcsa5+n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgI3UL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Sep 2020 16:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgI3ULw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Sep 2020 16:11:52 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEA7C061755
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:11:51 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id 4so839262ooh.11
        for <git@vger.kernel.org>; Wed, 30 Sep 2020 13:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2ARBhcwgCOi/lNnk12XADsvzNSLR8cPmZAWjdHo2qYw=;
        b=uUcsa5+nf9M9nusk6UjDHzFkTwNC59LV+cUhvDHDONij4Il6yt9SLqwSvBI4d0bIU0
         aVNgzJYmDHLHJqRGDFrUX1K/iBWetqBV4g+VQIhyn+kWu46NDUfZKZa9vYbyD1IZxtEe
         dI3MjZXWaTwQaZxMRgEC+VlD59rNldDH9GqBHyAo82cJWjKsNLBgbGyhx2hkl40fbgJ0
         oBghTC+WdToYyJKsHDiAhcEFOJRUyufZgcDidg68MJb34fX09aE91d9vAwoMfzTCgpa5
         JH2FTbUay4fnyDTNQlp6PHXpOEtmZCZTWrLrK+UCKxDlqfchGx19/xYG67M8qrD1Mtho
         LqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2ARBhcwgCOi/lNnk12XADsvzNSLR8cPmZAWjdHo2qYw=;
        b=Q27hNwzlZpp+UQZrAEcQBexmYhksku3hXoKbz+yT0iGwa96esLkuOUocYSbX5I5xaY
         ZNipb36LqnpzRl4RQ3X7cFV0TDpmap2Xg1wqhUiU4TAvi4hL/7XbLZ6CquZw7MXcHyY0
         VBuC3exBHw0ZdO37dFMgmRl2wisak6/8Nc4jwWy+h+7Jyqf/SC//dkyaj4vp+NkIZ1Iz
         9UplTkReCaSbhAfJMqEegnbIeEiJhVzRd/rIHqiTq2Ms5cIjFN9zesU+Woe09RbgpnGM
         2SR8CkKf70Q4qfY4hfAEFfeUMs/9GTAaLDBB/MHs4u7UgpEqVILX45s3HQ11bvLQt2qG
         ll0g==
X-Gm-Message-State: AOAM530rBedx6m6nw/vVwy04Emm/ZcWLmdfOcw+vUkBGe1MaATZdi771
        5fa/Foj+YCJq9ic86CRXdgQ=
X-Google-Smtp-Source: ABdhPJy1t5pzKbZtomyfpQHhleHa7vSw8KhpKnNVh13H+YrL+C+RfsrSvJqB2YWcraGmDWVkBytFIQ==
X-Received: by 2002:a4a:b3c9:: with SMTP id q9mr3151925ooo.84.1601496709651;
        Wed, 30 Sep 2020 13:11:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id b1sm673115oof.8.2020.09.30.13.11.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Sep 2020 13:11:48 -0700 (PDT)
Subject: Re: [PATCH v2 6/7] maintenance: recommended schedule in
 register/start
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>, sluongng@gmail.com,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.git.1599234126.gitgitgadget@gmail.com>
 <pull.724.v2.git.1599846560.gitgitgadget@gmail.com>
 <f609c1bde27558db2a9601ac34f8a51ce86f0e2c.1599846561.git.gitgitgadget@gmail.com>
 <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bb9cd08f-1e59-ae19-b184-545688451203@gmail.com>
Date:   Wed, 30 Sep 2020 16:11:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:82.0) Gecko/20100101
 Thunderbird/82.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqkJoqXKP5ccaGMA1_ppd0bcQ7G0ozUH+H7tBMonhcrjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/29/2020 3:48 PM, Martin Ågren wrote:
> Hi Stolee,
> 
> On Fri, 11 Sep 2020 at 19:53, Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> If a user sets any 'maintenance.<task>.schedule' config value, then
>> they have chosen a specific schedule for themselves and Git should
>> respect that.
>>
>> However, in an effort to recommend a good schedule for repositories of
>> all sizes, set new config values for recommended tasks that are safe to
>> run in the background while users run foreground Git commands. These
>> commands are generally everything but the 'gc' task.
> 
> If there aren't any "schedule" configurations, we'll go ahead and
> sprinkle in quite a few of them. I suppose that another approach would
> be that later, much later, when we go look for these configuration
> items, we could go "there is not a single one set, let's act as if
> *these* were configured".

I do like this alternative.

> The advantage there would be that we can tweak those defaults over time.
> Whereas with the approach of this patch, v2.29.0 will give the user a
> snapshot of 2020's best practices. If they want to catch up, they will
> need to drop all their "schedule" config and re-"register", or use a
> future `git maintenance reregister`. ;-)

This is a significant advantage! Great idea.

It might be a bit difficult to slide this in, but I bet it would work
out OK if we have a "initialize_schedule()" option that is only run
when the "--schedule=<...>" option is given? The trickiest part is
actually setting the ".enabled" configs to "true" as well. The condition
for using the "default" schedule might get a bit complicated. I do think
it is worth some effort to do, as adjusting defaults in code is certainly
easier than modifying config values.

> Anyway, this is a convenience thing. There's a chance that "convenience"
> interferes with "perfect" and "optimal". I guess that's to be expected.
> 
>> +If your repository has no 'maintenance.<task>.schedule' configuration
> 
> Thank you for going above and beyond with marking config items et cetera
> for rendering in `monospace`. I just noticed that this is slightly
> mis-marked-upped. If you end up rerolling this patch series for some
> reason, you might want to switch from 'single quotes' to `backticks` in
> this particular instance.

Thanks! Yeah that was a mis-type.

> While I'm commenting anyway...
> 
>> +static int has_schedule_config(void)
>> +{
>> +       int i, found = 0;
>> +       struct strbuf config_name = STRBUF_INIT;
>> +       size_t prefix;
>> +
>> +       strbuf_addstr(&config_name, "maintenance.");
>> +       prefix = config_name.len;
>> +
>> +       for (i = 0; !found && i < TASK__COUNT; i++) {
>> +               char *value;
>> +
>> +               strbuf_setlen(&config_name, prefix);
>> +               strbuf_addf(&config_name, "%s.schedule", tasks[i].name);
>> +
>> +               if (!git_config_get_string(config_name.buf, &value)) {
>> +                       found = 1;
>> +                       FREE_AND_NULL(value);
>> +               }
>> +       }
>> +
>> +       strbuf_release(&config_name);
>> +       return found;
>> +}
> 
> That `FREE_AND_NULL()` caught me off-guard. The pointer is on the stack.
> I suppose it doesn't *hurt*, but being careful to set it to NULL made me
> go "huh".
> 
> I suppose you could drop the `!found` check in favour of `break`-ing
> precisely when you get a hit.
> 
> And I do wonder how much the reuse of the "maintenance." part of the
> buffer helps performance.

All valid points.

> In the end, you could use something like the following (not compiled):
> 
>   static int has_schedule_config(void)
>   {
>          int i, found = 0;
>          struct strbuf config_name = STRBUF_INIT;
> 
>          for (i = 0; i < TASK__COUNT; i++) {
>                  const char *value;
> 
>                  strbuf_reset(&config_name);
>                  strbuf_addf(&config_name, "maintenance.%s.schedule",
> tasks[i].name);
> 
>                  if (!git_config_get_value(config_name.buf, &value)) {
>                          found = 1;
>                          break;
>                  }
>          }
> 
>          strbuf_release(&config_name);
>          return found;
>   }
> 
> Anyway, that's just microniting, obviously, but maybe in the sum it has
> some value.

Sounds good to me. I'll work on a new version that makes your
recommendations.

Thanks,
-Stolee



