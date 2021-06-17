Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F5CC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E5C610A1
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:27:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232453AbhFQO3R (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhFQO3N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:29:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE4AC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:27:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n35-20020a05600c3ba3b02901cdecb6bda8so6511895wms.5
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/R+a3bHAV5faBs43G0UESyGXY5QPpm6ZBN3eYmED0NQ=;
        b=fXxPlJpe1nPYYtUlTctzt+6a7P0SDo+qvJtnVYV+WHWaEnCrWe35yL9xok6hvTRXbz
         l4MetDrmSl86ESGI+ac4FsYXCDeS90SF8IgQOnKLFspL9zT83bQxt3ioAcj3BP64Bm8T
         8DgP51r9h0jItTS80LDAsufiINo23TyEe+It9+oFonB+ekFglXqqF4qlPS8Um/qpw4Vd
         ur8XX33A9SShv6Y97CC8D5cd0nYEMyE4/XlFuXhuX+tlqc9ANa0YQzIr1rFXKzfcqSFG
         maoXkADrZjS3DteHqgoYNNSiaImOWQYmObLqdClI+opJuzlGkzebvONg2zrk1FGpEHxl
         uK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/R+a3bHAV5faBs43G0UESyGXY5QPpm6ZBN3eYmED0NQ=;
        b=rM6wv8O2p57zb7j6Qt59IOGCXZEawwhgW4lLHZiAkpF03uVxCwDpPgCGn8+Bauk2cS
         Kx7H3EIcs+foTbjNiiFbbIGGjnzO7JEZSoLcZ31qeZcrysu90aFxfEjfXx8MI4sy9mkA
         VRqcFh//Om9zNXWw5vYzrWYO/jVjMLFn0wRRKwLhjayifBFHr5hDbipzhysTh+byf/GK
         46r1nndLeDljJKdcEhoN0AMneJeJULncP06crw7S+BUUAjnhX6gQXkKxue1sPJsBBY0/
         +xQ219bQrnTb6Y8xc02+n4dGUhWTlNMubmrBNEotPhbO0nlvEdtDXopeU6A6Ua1d2uhP
         pkhQ==
X-Gm-Message-State: AOAM532CP4a0X95/4fNfA1Bk6beDnJiWoFAEGOIVjDBxRjxuWzFhk7kX
        DkUvqiBNFCAoZv7SMvpxwjo=
X-Google-Smtp-Source: ABdhPJwn1y9Jsxs5xBDy/ccZ7VePDjhNkd2jYtHRc3pzmL0WC7L8jDbL+x6ZAsr6+muV+LQBtyGR2Q==
X-Received: by 2002:a05:600c:3ba2:: with SMTP id n34mr5442540wms.120.1623940022372;
        Thu, 17 Jun 2021 07:27:02 -0700 (PDT)
Received: from [192.168.1.240] (11.22.198.146.dyn.plus.net. [146.198.22.11])
        by smtp.gmail.com with ESMTPSA id u18sm4685934wmj.15.2021.06.17.07.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 07:27:01 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 2/3] maintenance: `git maintenance run` learned
 `--scheduler=<scheduler>`
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <20210608134000.663398-1-lenaic@lhuard.fr>
 <20210612165043.165579-1-lenaic@lhuard.fr>
 <20210612165043.165579-3-lenaic@lhuard.fr>
 <CAPig+cSLi7aN=6ahrHwy4fO-7JMBN3pmzfpWe5ZXOcC9j4+e+g@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <80d6050a-71d9-1278-e68f-91c3a1ca52e4@gmail.com>
Date:   Thu, 17 Jun 2021 15:26:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSLi7aN=6ahrHwy4fO-7JMBN3pmzfpWe5ZXOcC9j4+e+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/06/2021 05:36, Eric Sunshine wrote:
> On Sat, Jun 12, 2021 at 12:51 PM Lénaïc Huard <lenaic@lhuard.fr> wrote:
>> Depending on the system, different schedulers can be used to schedule
>> the hourly, daily and weekly executions of `git maintenance run`:
>> * `launchctl` for MacOS,
>> * `schtasks` for Windows and
>> * `crontab` for everything else.
>>
>> `git maintenance run` now has an option to let the end-user explicitly
>> choose which scheduler he wants to use:
>> `--scheduler=auto|crontab|launchctl|schtasks`.
>>
>> When `git maintenance start --scheduler=XXX` is run, it not only
>> registers `git maintenance run` tasks in the scheduler XXX, it also
>> removes the `git maintenance run` tasks from all the other schedulers to
>> ensure we cannot have two schedulers launching concurrent identical
>> tasks.
>>
>> The default value is `auto` which chooses a suitable scheduler for the
>> system.
>>
>> `git maintenance stop` doesn't have any `--scheduler` parameter because
>> this command will try to remove the `git maintenance run` tasks from all
>> the available schedulers.
>>
>> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
> 
> Thanks. Unfortunately, I haven't been following this series too
> closely since I reviewed v1, so I set aside time to review v6, which I
> have now done. The material in the cover letter and individual commit
> messages was helpful in understanding the nuances of the changes, and
> the series seems pretty well complete at this point. (If, however, you
> do happen to re-roll for some reason, please consider using the
> --range-diff option of git-format-patch as an aid to reviewers.)
> 
> I did leave a number of comments below regarding possible improvements
> to the code and documentation, however, they're probably mostly
> subjective and don't necessarily warrant a re-roll; I'd have no
> problem seeing this accepted as-is without the suggestions applied.
> (They can always be applied later on if someone considers them
> important enough.)
>
> I do, though, have one question (below) about is_crontab_available()
> for which I could not figure out the answer.

I think that is a bug

>> [...]
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -1529,6 +1529,59 @@ static const char *get_frequency(enum schedule_priority schedule)
>> +static int get_schedule_cmd(const char **cmd, int *is_available)
>> +{
>> +       char *item;
>> +       char *testing = xstrdup_or_null(getenv("GIT_TEST_MAINT_SCHEDULER"));
>> +
>> +       if (!testing)
>> +               return 0;
>> +
>> +       if (is_available)
>> +               *is_available = 0;
>> +
>> +       for (item = testing;;) {
>> +               char *sep;
>> +               char *end_item = strchr(item, ',');
>> +               if (end_item)
>> +                       *end_item = '\0';
>> +
>> +               sep = strchr(item, ':');
>> +               if (!sep)
>> +                       die("GIT_TEST_MAINT_SCHEDULER unparseable: %s", testing);
>> +               *sep = '\0';
>> +
>> +               if (!strcmp(*cmd, item)) {
>> +                       *cmd = sep + 1;
>> +                       if (is_available)
>> +                               *is_available = 1;
>> +                       UNLEAK(testing);
>> +                       return 1;
>> +               }
>> +
>> +               if (!end_item)
>> +                       break;
>> +               item = end_item + 1;
>> +       }
>> +
>> +       free(testing);
>> +       return 1;
>> +}
> 
> I ended up studying this implementation several times since I had to
> come back to it repeatedly after reading calling code in order to (I
> hope) fully understand all the different conditions represented by its
> three distinct return values (the function return value, and the
> values returned in **cmd and **is_available). That it required several
> readings might warrant a comment block explaining what the function
> does and what the various return conditions mean. As a bonus, an
> explanation of the value of GIT_TEST_MAINT_SCHEDULER -- a
> comma-separated list of colon-delimited tuples, and what those tuples
> represent -- could be helpful.

I agree documenting GIT_TEST_MAINT_SCHEDULER would be useful

>> +static int is_launchctl_available(void)
>> +{
>> +       const char *cmd = "launchctl";
>> +       int is_available;
>> +       if (get_schedule_cmd(&cmd, &is_available))
>> +               return is_available;
>> +
>> +#ifdef __APPLE__
>> +       return 1;
>> +#else
>> +       return 0;
>> +#endif
>> +}
> 
> On this project, we usually frown upon #if conditionals within
> functions since the code often can become unreadable. The usage in
> this function doesn't suffer from that problem, however,
> resolve_auto_scheduler() is somewhat ugly. An alternative would be to
> set up these values outside of all functions, perhaps like this:
> 
>      #ifdef __APPLE__
>      #define MAINT_SCHEDULER SCHEDULER_LAUNCHCTL
>      #elif GIT_WINDOWS_NATIVE
>      #define MAINT_SCHEDULER SCHEDULER_SCHTASKS
>      #else
>      #define MAINT_SCHEDULER SCHEDULER_CRON
>      #endif
> 
> and then:
> 
>      static int is_launchctl_available(void)
>      {
>          if (get_schedule_cmd(...))
>              return is_available;
>          return MAINT_SCHEDULER == SCHEDULER_LAUNCHCTL;
>      }
> 
>      static void resolve_auto_scheduler(enum scheduler *scheduler)
>      {
>          if (*scheduler == SCHEDULER_AUTO)
>              *scheduler = MAINT_SCHEDULER;
>      }
> 
>> +static int is_crontab_available(void)
>> +{
>> +       const char *cmd = "crontab";
>> +       int is_available;
>> +       struct child_process child = CHILD_PROCESS_INIT;
>> +
>> +       if (get_schedule_cmd(&cmd, &is_available) && !is_available)
>> +               return 0;
>> +
>> +       strvec_split(&child.args, cmd);
>> +       strvec_push(&child.args, "-l");
>> +       child.no_stdin = 1;
>> +       child.no_stdout = 1;
>> +       child.no_stderr = 1;
>> +       child.silent_exec_failure = 1;
>> +
>> +       if (start_command(&child))
>> +               return 0;
>> +       /* Ignore exit code, as an empty crontab will return error. */
>> +       finish_command(&child);
>> +       return 1;
>>   }
> 
> If I understand get_schedule_cmd() correctly, it will always return
> true if GIT_TEST_MAINT_SCHEDULER is present in the environment,
> however, it will only set `is_available` to true if
> GIT_TEST_MAINT_SCHEDULER contains a matching entry for `cmd` (which in
> this case is "crontab"). Assuming this understanding is correct, then
> I'm having trouble understanding why this:
> 
>      if (get_schedule_cmd(&cmd, &is_available) && !is_available)
>          return 0;
> 
> isn't instead written like this:
> 
>      if (get_schedule_cmd(&cmd, &is_available))
>          return is_available;
> 
> That is, why doesn't is_crontab_available() trust the result of
> get_schedule_cmd(), instead going ahead and trying to invoke `crontab`
> itself? Am I missing something which makes the `!is_available` case
> special?

I agree, I think we should be returning is_available irrespective of its 
value if get_schedule_cmd() returns true. This is what 
is_systemd_timer_available() does in the next patch. Well spotted.

Best Wishes

Phillip

>> +static void resolve_auto_scheduler(enum scheduler *scheduler)
>> +{
>> +       if (*scheduler != SCHEDULER_AUTO)
>> +               return;
>> +
>>   #if defined(__APPLE__)
>> +       *scheduler = SCHEDULER_LAUNCHCTL;
>> +       return;
>> +
>>   #elif defined(GIT_WINDOWS_NATIVE)
>> +       *scheduler = SCHEDULER_SCHTASKS;
>> +       return;
>> +
>>   #else
>> +       *scheduler = SCHEDULER_CRON;
>> +       return;
>>   #endif
>> +}
> 
> (See above for a way to simplify this implementation.)
> 
> Is there a strong reason which I'm missing that this function alters
> its argument rather than simply returning the resolved scheduler?
> 
>      static enum scheduler resolve_scheduler(enum scheduler x) {...}
> 
> Or is it just personal preference?
>
> (Minor: I took the liberty of shortening the function name since it
> doesn't feel like the longer name adds much value.)
> 
>> +static int maintenance_start(int argc, const char **argv, const char *prefix)
>>   {
>> +       struct maintenance_start_opts opts = { 0 };
>> +       struct option options[] = {
>> +               OPT_CALLBACK_F(
>> +                       0, "scheduler", &opts.scheduler, N_("scheduler"),
>> +                       N_("scheduler to use to trigger git maintenance run"),
> 
> Dropping "to use" would make this more concise without losing clarity:
> 
>      "scheduler to trigger git maintenance run"
> 
>> +                       PARSE_OPT_NONEG, maintenance_opt_scheduler),
>> +               OPT_END()
>> +       };
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> @@ -494,8 +494,21 @@ test_expect_success !MINGW 'register and unregister with regex metacharacters' '
>> +test_expect_success 'start --scheduler=<scheduler>' '
>> +       test_expect_code 129 git maintenance start --scheduler=foo 2>err &&
>> +       test_i18ngrep "unrecognized --scheduler argument" err &&
>> +
>> +       test_expect_code 129 git maintenance start --no-scheduler 2>err &&
>> +       test_i18ngrep "unknown option" err &&
>> +
>> +       test_expect_code 128 \
>> +               env GIT_TEST_MAINT_SCHEDULER="launchctl:true,schtasks:true" \
>> +               git maintenance start --scheduler=crontab 2>err &&
>> +       test_i18ngrep "fatal: crontab scheduler is not available" err
>> +'
> 
> Why does this test care about the exact exit codes rather than simply
> using test_must_fail() as is typically done elsewhere in the test
> suite, especially since we're also checking the error message itself?
> Am I missing some non-obvious property of the error codes?
> 
> I don't see `auto` being tested anywhere. Do we want such a test? (It
> seems like it should be doable, though perhaps the complexity is too
> high -- I haven't thought it through fully.)
> 
