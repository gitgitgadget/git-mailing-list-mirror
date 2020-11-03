Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF83C388F9
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:23:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B928206E3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 21:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khNbB3gJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732341AbgKCVX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 16:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388273AbgKCVX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 16:23:56 -0500
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02C5C0613D1
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 13:23:55 -0800 (PST)
Received: by mail-qv1-xf44.google.com with SMTP id ed14so5119212qvb.4
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 13:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pg8D5sNfZtSYeLgmgxI69gb9WCJzW9Sx27oOPFzNogM=;
        b=khNbB3gJFSVN6yNg8Oxy1PiWVV1ExsLM8eS6wmeNFp7+YMw2FXC/SJPX3x2o4bjgdq
         Y/W8sU80QMTn85uz1sJAcXEt/6tFoz6zDXBH/FUosnAkysCpDQ0LjNaj7kAZ9f0yabl0
         LAHod1v1AMx/ouLsvs2yDpB7W4OqY1cFoP3Gh0KARJ7DXwGjDkFYypRX4SCQwDkfUdyc
         oJQRnuvWa+LYLmJPI7tX280JhQOTP6B1o2qSz+aYNCp4NunUiUn4E9xISICIEL7IkX7b
         PW1JXl5fj+I171MqD0a9Dxxiqsagrz6EU8wnVqdm+fj4vbwUstIkHLKrXBK4cFH0E3YN
         HPNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pg8D5sNfZtSYeLgmgxI69gb9WCJzW9Sx27oOPFzNogM=;
        b=nJXLpTNMMzv8fGOrdQqEv1WG6CW6htfmLrjtSpskDVJ2Phine1S4mnhaksYM8ju9qy
         WVZ3296Xyj6rffEt8A8A+p+WK4xlvOOZkP9Ee4HXRD2dWMqsvvk4mC74+MFYbBPu2y8q
         Ck+WDJWXXf2y7Ngvxd87OWgTttKFBjI6lpGI6zbotl2jd8BrSDI018SR89AdKYsPTLBf
         kjmu6ous8yWTmQ90KtqdI8mzFth4jMTcFC96TuX/vnoakvvGePNwFmXp8yK/TCDY9191
         tkAXvwxvIxc+xHYw5apCALfJa7NYDtY9Ibw7MHU31G379SUCn4EU+IggTAyIRQgSLIGr
         aVlw==
X-Gm-Message-State: AOAM532hlFddKebrjs7aYzIPXI7D0MpzcpC/2byOnPFL/vsvu98g4zqs
        2KtR2SqDXCMY/PiiL9d/txU=
X-Google-Smtp-Source: ABdhPJyJU8cNXSmdkzgO6cwzWDwaA65Yl7fUUZ6p4/AbGrhoqvotuV8HIEKIObRzTuxES9JGdpCwdA==
X-Received: by 2002:a0c:9b91:: with SMTP id o17mr15736100qve.8.1604438634955;
        Tue, 03 Nov 2020 13:23:54 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id x21sm12236015qkb.78.2020.11.03.13.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 13:23:54 -0800 (PST)
Subject: Re: [PATCH 3/3] maintenance: use Windows scheduled tasks
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Son Luong Ngoc <sluongng@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.776.git.1604412196.gitgitgadget@gmail.com>
 <a9221cc4aa12192e9a691f8e1b77a3cc2d7e4952.1604412197.git.gitgitgadget@gmail.com>
 <CAPig+cRE3RNkUCrmmTvVC4mm1crT+1OEU5zSwu80pjXmDdAkfg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3268cfb4-22b4-301d-abbc-bb36fa737a2a@gmail.com>
Date:   Tue, 3 Nov 2020 16:23:52 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRE3RNkUCrmmTvVC4mm1crT+1OEU5zSwu80pjXmDdAkfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/3/2020 2:06 PM, Eric Sunshine wrote:
> On Tue, Nov 3, 2020 at 9:05 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> There is a deficiency in the current design. Windows has two kinds of
>> applications: GUI applications that start by "winmain()" and console
>> applications that start by "main()". Console applications are attached
>> to a new Console window if they are not already associated with a GUI
>> application. This means that every hour the scheudled task launches a
>> command window for the scheduled tasks. Not only is this visually
>> obtrusive, but it also takes focus from whatever else the user is
>> doing!
> 
> I wonder if you could use the technique explained in [1] to prevent
> the console window from popping up.
> 
> [1]: https://pureinfotech.com/prevent-command-window-appearing-scheduled-tasks-windows-10/

The critical part of that strategy is the "Run whether the user is
logged in or not". The resulting option that triggers causes the
schtasks command to require a password prompt (or a password passed
as a command-line argument). I found that interaction to be too
disruptive.

>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
>> @@ -441,6 +441,40 @@ test_expect_success MACOS_MAINTENANCE 'start and stop macOS maintenance' '
>> +test_expect_success MINGW 'start and stop Windows maintenance' '
>> +       echo "echo \$@ >>args" >print-args &&
>> +       chmod a+x print-args &&
> 
> Same comments as my review of [2/3] regarding $@ and write_script().

Noted!

>> +       rm -f args &&
>> +       GIT_TEST_CRONTAB="/bin/sh print-args" git maintenance start &&
>> +       cat args &&
> 
> Is this 'cat' leftover debugging gunk?

Yes. Thanks.

>> +       # start registers the repo
>> +       git config --get --global maintenance.repo "$(pwd)" &&
>> +
>> +       rm expect &&
>> +       for frequency in hourly daily weekly
>> +       do
>> +               echo "/create /tn Git Maintenance ($frequency) /f /xml .git/objects/schedule-$frequency.xml" >>expect \
>> +                       || return 1
>> +       done &&
> 
> Rather than using >> within the loop, it's often simpler to capture
> the output of the for-loop in its entirety:
> 
>     for frequency in hourly daily weekly
>     do
>         echo "/create ..." || return 1
>     done >expect &&
> 
> However, in this case 'printf' may be even simpler:
> 
>     printf "/create /tn ... .git/objects/schedule-%s.xml\n" \
>         hourly daily weekly >expect &&

Excellent.

>> +       GIT_TEST_CRONTAB="/bin/sh print-args"  git maintenance stop &&
> 
> Too many spaces before the 'git' command.

Thanks!
-Stolee

