Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0261C4742C
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8501F2224D
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 21:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee240hNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgKMVcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 16:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgKMVcQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 16:32:16 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3670C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:32:16 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id k19so3319344oic.12
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 13:32:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OOfq4C3646yo+VTxZztWl2NoQlr6/uBF4ykFdTlpqo=;
        b=ee240hNKQCZdhOnpcgZB1tEj26dPUzg99TUCNZuNXzdKgMObZNE7kO3pVwdyLF4leO
         FS62oZByHbD80ZLRJSEGRxQXRycory6tJIF5g63V74i45z7huYHuEp+fRN8NknVJpHa9
         og+WfOlv46StcDnvjjsSxIelF8tiS0TSbEWtHs9KffX9FhcqJ6eHYKVUh1ABy5iaepqN
         2z6APbzv23D+lzcgVlw0D6Zr9uEKB8DFqIgTznfJuWfHK4caxWsvOPXNki78KcmRso5G
         zyWOKC4PXPo5pa2Uyl8vRlmZ2qje5PJOKZHX94Ob1m6CY45xKxJmAdQJ1r0x07P9Y+se
         lfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OOfq4C3646yo+VTxZztWl2NoQlr6/uBF4ykFdTlpqo=;
        b=qIrEYExzWBjswfjPycoJIf1iBMKrqWAZgO9baACrsMI9m62LQwI7AFxDQeMvkvPS9s
         VE/UjcBU2ixzqR4S3XvDxt14A2ac03hWvBdY565GqRHUT1OBti29G9pWa7BlrS+HSpvG
         HTgmuikqGo0zlwyLVOLMor+amOR5D/CckAaq2kclpPQ+IT2Q0O399DTBBU8lpitxxXmZ
         6vgqS3F8hLVrCZexjwwRFkvBAo+Nk/p4yj660B5+357Q/j+e4S3AEebwjzbAFapmf7op
         SeLqleOxStEHQSWGMenj/aEb6+0SDpURNavA0HOH1hDkwGZPx09PcfDOd2KCAfl6RGNv
         nnAQ==
X-Gm-Message-State: AOAM530mWxBJqgZAxB8iWmKZUFVaCPHTpkEoUYiR+Aso6RgPHw2lh4mx
        iudunZSeNvuWCaxHdMXz6mE=
X-Google-Smtp-Source: ABdhPJxmGxUgk0JLGeRphcbEXGoWeFo43X6omMyWu63ONkaaINODE4Vf95VvdxXxd+WgSpUGki09LA==
X-Received: by 2002:aca:dac3:: with SMTP id r186mr2963398oig.147.1605303135946;
        Fri, 13 Nov 2020 13:32:15 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:7082:2419:51dc:d02a? ([2600:1700:e72:80a0:7082:2419:51dc:d02a])
        by smtp.gmail.com with UTF8SMTPSA id z126sm2192242oiz.41.2020.11.13.13.32.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 13:32:15 -0800 (PST)
Subject: Re: [PATCH v3 4/4] maintenance: use Windows scheduled tasks
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.v2.git.1604520368.gitgitgadget@gmail.com>
 <pull.776.v3.git.1605276024.gitgitgadget@gmail.com>
 <ed7a61978fe9dce26ca459b5a86490c15e470698.1605276024.git.gitgitgadget@gmail.com>
 <CAPig+cS3YXH=SmTsRTOa5Cdppt9L=MbFRT+LWn9QE7aEqRiDqQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <73c902db-40f5-2693-c350-9c04ba2751cf@gmail.com>
Date:   Fri, 13 Nov 2020 16:32:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cS3YXH=SmTsRTOa5Cdppt9L=MbFRT+LWn9QE7aEqRiDqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2020 3:44 PM, Eric Sunshine wrote:
> On Fri, Nov 13, 2020 at 9:00 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> Git's background maintenance uses cron by default, but this is not
>> available on Windows. Instead, integrate with Task Scheduler.
>> [...]
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -1684,6 +1684,190 @@ static int platform_update_schedule(int run_maintenance, int fd)
>> +static int schedule_task(const char *exec_path, enum schedule_priority schedule)
>> +{
>> +       char *xmlpath, *tempDir;
>> +       tempDir = xstrfmt("%s/temp", the_repository->objects->odb->path);
>> +       xmlpath =  xstrfmt("%s/schedule-%s.xml", tempDir, frequency);
> 
> When I wondered aloud in my previous review whether writing these
> throwaway files to a temporary directory would make sense, I was
> thinking more along the lines of /tmp or $TEMP. More specifically, we
> have xmkstemp() in wrapper.c which is good for this sort of thing (or
> one of the other temporary-file-making functions in there). We also
> have a more full-featured temporary-file API in tempfile.h which would
> ensure that these throwaway files actually get thrown away when the
> command finishes.
> 
> This is not necessarily worth a re-roll.
> 
>> +       if (start_command(&child))
>> +               die(_("failed to start schtasks"));
>> +       result = finish_command(&child);
>> +
>> +       unlink(xmlpath);
>> +       rmdir(tempDir);
> 
> Neither xmlpath and tempDir get cleaned up from the filesystem if the
> preceding die() is triggered (which may or may not make sense --
> perhaps you want to keep them around if it helps with the diagnosis of
> the failure). The functions in tempfile.h would ensure the temporary
> file is cleaned up even if the program die()s, or you could manually
> remove the temporary file before die()ing.

While I do like to have access to the data when trying to resolve
an issue, it's probably better to use the tempfile library.

>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> @@ -437,6 +437,33 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
>> +test_expect_success MINGW 'start and stop Windows maintenance' '
>> +       write_script print-args <<-\EOF &&
>> +       echo $* >>args
>> +       EOF
> 
> Using `>>` here makes it harder to reason about the test than using
> `>` would, especially since `>>` seems to be unnecessary in this case.

Since we execute the GIT_TEST_CRONTAB executable multiple times, we
need to use >> to log all three instances (and their order). Using ">args"
would only capture the final call for the weekly schedule.

On macOS, there are as many as six calls (three bootouts, three bootstraps).

>> +       rm -f args &&
>> +       GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
> 
> Is it a requirement on Windows to mention /bin/sh here? Specifically,
> I'm wondering why a simple ./print-args doesn't work. (It's especially
> unclear since write_script() is used heavily in the test suite and it
> seems to work well enough on Windows without specifying /bin/sh.)

I landed on this after trying several attempts to get this to work,
including "$(pwd)/print-args" and I'm not sure why it doesn't work
in the Windows case. It is something to do with how I am executing
the subcommand from within Git. I'm pretty sure this idea of "mocking"
an executable through Git is relatively new, or at least rare

Thanks,
-Stolee
