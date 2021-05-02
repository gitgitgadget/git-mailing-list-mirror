Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8EC433ED
	for <git@archiver.kernel.org>; Sun,  2 May 2021 14:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B9846102A
	for <git@archiver.kernel.org>; Sun,  2 May 2021 14:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbhEBOLt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 10:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234056AbhEBOLo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 10:11:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0CFC0611E8
        for <git@vger.kernel.org>; Sun,  2 May 2021 07:10:08 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 82-20020a1c01550000b0290142562ff7c9so1983859wmb.3
        for <git@vger.kernel.org>; Sun, 02 May 2021 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qhycOdD3MDauvkgYpckg/S5kOJyuOPdL82CSS0Rr2NE=;
        b=ZR8nrw6OFmSnVLpK/TFCcw5O07b/n6WbEjLJfu3/6yio06kP72X4Y3EdTBkRZN5SjH
         u1C9i92L19OqxIEvb/Z900yAcBEwhUYXkawBseppQ1zx42cI+OA9tPTptG+phWnoVgu5
         cmoPucxzUUho4+83nDo/LhXx7zspSqgM1spVKv9EHsGZMKQe29yd1WL+9U3D59ybEcG8
         92NSOAZyydZ+YVWJo+X2UsXBnUi1iPFpvRXV7aUlSY/LlWYCQv0py/oawi6q11jbgX98
         6OKBlBNDmNfizdVgncb/NOYhHYIhL6PwkeJZUVSjHAUqBLHV0nK6nSfagJvA6dSusFKN
         e1Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=qhycOdD3MDauvkgYpckg/S5kOJyuOPdL82CSS0Rr2NE=;
        b=LHCyVvZtJZHt+J6dOQHjCO3wawxZVHWzO2V/R5GRRSffnfaVfJd7wJdNs7Do6hcpGd
         WFFR0ncxVg4C0vdmMrcYfIX0B0WxGO7Y6Hjdkb4lZ3yEqeCpTxc8E6olI9eJ3UPoEBFV
         pZo2T7z8CY96VkL6eq0MMYJsvyuzdcYMqQjOtGyKxqVgW9yHOEFBpKkTwNl+cZg5+MdJ
         fgxCk851RlBUn8FLjWF21IfAuV1MIf8ml6SbAWTn+Dw6ZW52vpDPQCZXjf+KatnKh5RL
         K3iRYb/4xURclwzvpGWFnSFhWAezYdsl7Os5mpH1GmWmQqMXta/NLh4fI+g1Vqhhp/+G
         1DNA==
X-Gm-Message-State: AOAM531WyRzXJHdS6zmssZ1ZKR7hapJDJIGdWiqxO1FC8Y52R9c7+D/n
        9gFw6MuWY4/vaUP7NmPkP3k=
X-Google-Smtp-Source: ABdhPJwWfXHTuj1MOBJhmAZsccOX8PCXjlyxw5l1lMOo8YUVXpdmDkvbASkeZdA7MbnzKgiGrESsIw==
X-Received: by 2002:a1c:3587:: with SMTP id c129mr16153099wma.80.1619964607078;
        Sun, 02 May 2021 07:10:07 -0700 (PDT)
Received: from [192.168.1.240] (61.22.198.146.dyn.plus.net. [146.198.22.61])
        by smtp.gmail.com with ESMTPSA id j13sm12078647wrd.81.2021.05.02.07.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 07:10:06 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
References: <20210501145220.2082670-1-lenaic@lhuard.fr>
 <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <b1153c47-05cf-877c-587b-8205d8d32816@gmail.com>
Date:   Sun, 2 May 2021 15:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/05/2021 07:45, Eric Sunshine wrote:
> On Sat, May 1, 2021 at 10:59 AM Lénaïc Huard <lenaic@lhuard.fr> wrote:
>> The existing mechanism for scheduling background maintenance is done
>> through cron. On Linux systems managed by systemd, systemd provides an
>> alternative to schedule recurring tasks: systemd timers.
> 
> Thanks for working on this. While `cron` has been the go-to standard
> for decades, `systemd` is certainly widespread enough that it makes
> sense to support it, as well.

Yes, thank you for working on this, it will be very useful to users like 
me who use a linux distribution that does not install a cron daemon by 
default but relies on systemd instead.

>> The main motivations to implement systemd timers in addition to cron
>> are:
>> * cron is optional and Linux systems running systemd might not have it
>>    installed.
>> * The execution of `crontab -l` can tell us if cron is installed but not
>>    if the daemon is actually running.

Can we use systemctl to see if it is running (and enabled so we know it 
will be restarted after a reboot)?

>> * With systemd, each service is run in its own cgroup and its logs are
>>    tagged by the service inside journald. With cron, all scheduled tasks
>>    are running in the cron daemon cgroup and all the logs of the
>>    user-scheduled tasks are pretended to belong to the system cron
>>    service.
>>    Concretely, a user that doesn’t have access to the system logs won’t
>>    have access to the log of its own tasks scheduled by cron whereas he
>>    will have access to the log of its own tasks scheduled by systemd
>>    timer.
> 
> The last point is somewhat compelling. A potential counterargument is
> that `cron` does send email to the user by default if any output is
> generated by the cron job. However, it seems quite likely these days
> that many systems either won't have local mail service enabled or the
> user won't bother checking the local mailbox. It's a minor point, but
> if you re-roll it might make sense for the commit message to expand
> the last point by saying that although `cron` attempts to send email,
> that email may go unseen by the user.
> 
>> In order to schedule git maintenance, we need two unit template files:
>> * ~/.config/systemd/user/git-maintenance@.service
>>    to define the command to be started by systemd and
>> * ~/.config/systemd/user/git-maintenance@.timer
>>    to define the schedule at which the command should be run.
>> [...]
>> The timer unit contains `Persistent=true` so that, if the computer is
>> powered down when a maintenance task should run, the task will be run
>> when the computer is back powered on.
> 
> It would be nice for the commit message to also give some high-level
> information about how git-maintenance chooses between `cron` and
> `systemd` and whether the user can influence that decision. (I know
> the answer because I read the patch, but this is the sort of
> information which is good to have in the commit message; readers want
> to know why certain choices were made.)
> 
> Although I avoid Linux distros with `systemd`, my knee-jerk reaction,
> like brian's upthread, is that there should be some escape hatch or
> direct mechanism to allow the user to choose between `systemd` and
> `cron`.

I agree that if both are present the user should be able to choose one. 
I'm not sure what the default should be in that case - before I read the 
commit message and Eric's comments I was inclined to say that if the 
user has cron installed we should take that as a sign they preferred 
cron over systemd timers and use that. However, given the arguments 
above about not knowing if cron is running and the user not necessarily 
getting emails from cron or being able to read the logs than maybe 
defaulting to systemd timers makes sense.

> The patch itself is straightforward enough and nicely follows the
> pattern established for already-implemented schedulers, so I don't
> have a lot to say about it. I did leave a few comments below, most of
> which are subjective nits and minor observations, though there are two
> or three actionable items.
> 
>> Signed-off-by: Lénaïc Huard <lenaic@lhuard.fr>
>> ---
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> @@ -279,6 +279,55 @@ schedule to ensure you are executing the correct binaries in your
>> +BACKGROUND MAINTENANCE ON LINUX SYSTEMD SYSTEMD
>> +-----------------------------------------------
> 
> Is there a reason for the duplicated "SYSTEMD" that I'm missing? I
> suppose you probably mean "SYSTEMD SYSTEMS".
> 
>> +In this case, `git maintenance start` will create user systemd timer units
>> +and start the timers. The current list of user-scheduled tasks can be found
>> +by running `systemctl --user list-timers`. The timers written by `git
>> +maintenance start` are similar to this:
>> +
>> +-----------------------------------------------------------------------
>> +$ systemctl --user list-timers
>> +NEXT                         LEFT          LAST                         PASSED     UNIT                         ACTIVATES
>> +Thu 2021-04-29 19:00:00 CEST 42min left    Thu 2021-04-29 18:00:11 CEST 17min ago  git-maintenance@hourly.timer git-maintenance@hourly.service
>> +Fri 2021-04-30 00:00:00 CEST 5h 42min left Thu 2021-04-29 00:00:11 CEST 18h ago    git-maintenance@daily.timer  git-maintenance@daily.service
>> +Mon 2021-05-03 00:00:00 CEST 3 days left   Mon 2021-04-26 00:00:11 CEST 3 days ago git-maintenance@weekly.timer git-maintenance@weekly.service
>> +
>> +3 timers listed.
>> +Pass --all to see loaded but inactive timers, too.
>> +-----------------------------------------------------------------------
> 
> I suspect that the "3 timers listed" and "Pass --all" lines don't add
> value and can be dropped without hurting the example.

If the idea is to show the output of `systemctl --user list-timers` then 
I don't think we should be editing it. I also think having the column 
headers helps as it shows what the fields are.

>> +`git maintenance start` will overwrite these files and start the timer
>> +again with `systemctl --user`, so any customization should be done by
>> +creating a drop-in file
>> +`~/.config/systemd/user/git-maintenance@.service.d/*.conf`.
> 
> Will `systemd` users generally understand what filename to create in
> the "...@.service.d/" directory, and will they know what to populate
> the file with? (Genuine question; I've never dealt with that.)

I think it would be helpful to explicitly mention the file names (I 
don't think I could tell you what they are without reading the relevant 
systemd man page)

>> diff --git a/builtin/gc.c b/builtin/gc.c
>> @@ -1872,6 +1872,25 @@ static int schtasks_update_schedule(int run_maintenance, int fd, const char *cmd
>> +static int is_crontab_available(const char *cmd)
>> +{
>> +       struct child_process child = CHILD_PROCESS_INIT;
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
>> +
>> +       return 1;
>> +}
> 
> Ignoring the error from `crontab -l` is an already-established idiom
> in this file. Okay.
> 
> Nit: There doesn't seem to be a need for the blank line before `return
> 1`, and other maintenance-related functions don't have such a blank
> line. The same comment about blank lines before `return` applies to
> other newly-added functions, as well. But it's subjective, and not
> necessarily worth changing.
> 
>> +static char *systemd_timer_timer_filename()
>> +{
>> +       const char *filename = "~/.config/systemd/user/git-maintenance@.timer";
>> +       char *expanded = expand_user_path(filename, 0);
>> +       if (!expanded)
>> +               die(_("failed to expand path '%s'"), filename);
>> +
>> +       return expanded;
>> +}
> 
> I was curious whether this would fail if `.config/systemd/user/`
> didn't already exist, but looking at the implementation of
> expand_user_path() , I see that it doesn't require the path to already
> exist if you pass 0 for the second argument as you do here. Okay.

Do we need to worry about $XDG_CONFIG_HOME rather than hard coding 
"~/.config/". There is a function xdg_config_home() that takes care of this.

Thanks again for working on this

Best Wishes

Phillip
