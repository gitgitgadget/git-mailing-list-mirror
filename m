Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5860AC433E0
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3142261574
	for <git@archiver.kernel.org>; Tue, 30 Mar 2021 19:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbhC3TiU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Mar 2021 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233226AbhC3TiE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Mar 2021 15:38:04 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E18C061574
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:38:04 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so16678140oto.2
        for <git@vger.kernel.org>; Tue, 30 Mar 2021 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DQSxP8zh5b1a67cdBKpDbwpPe27xJ5hPWC5fBTp7tCg=;
        b=U9XOtr0OfMzfu5tWahs8sS3fWFAobC1RaX2/Ek0FJC+xmgXa85G9YB2jBB0SXeCtFS
         WHiq/o+egXqNHNhDoFWt95b4T1d6ptH7I3CuqW+hB+o+3A7X4XMdGpkKtehZBjtWyYgE
         vElg9N4vrLLfPRdgR1nfR1SjeCsn+STzfgJlZJjXV+diHn0dbmtJ3GFl2kwxiv6XjYY6
         vVg2uX4QU9hoClCwawMCUK3tUGjaskzQpSO+XaIngxz4f9POExPCj6KgwzdZtej1Qpec
         9jUUvsyz07QiTXzjmvG241JJ3KtDhJ4kHCKNTqGMFhhKVf0bBx74wlg7Irxx8I2yTlX8
         rviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DQSxP8zh5b1a67cdBKpDbwpPe27xJ5hPWC5fBTp7tCg=;
        b=Q7WMtr9uqJfFXSixM4Zt8EWxiHPsxL5U+m7Q+J0Dl9HXW2Cf6hHHeReHPU5fJuYRQN
         HLydCC+XrI1d7AU2KPhfW2f+FKTxB+zJYhSYs+V9uJKQF3F0FwaBOfXaX65PfS/aPmyJ
         +Lw5eR04lNNFAFDz2yGUkjDVJ2Xjj9HkFFGKPP3t08xoYwQvU5Tdy4L8S2jGJ9aEP0OE
         k4BUjmJ2XkOM6C3E+PnLRGxOvc2NenWomBvMYcCfF5/y8qUM/l0uOEGuKo4maEB2H/2h
         yj9qkurQ8QV94lQYOcwwzBpn9SNjxZ1n+8Gg+tL5ko3YUr+5QI76vSEbKpvEeaK6fCaF
         yN9w==
X-Gm-Message-State: AOAM5330nUyOoOq6bIsAr/DAPHByhbYDeQ4VNUdj+a7kWY4vW5u7xKxq
        DiY6DMaiYE4f3ratusOdf8voFaiKQoDrdQ==
X-Google-Smtp-Source: ABdhPJzSzcdvtvdQKYasfNPhzTHeDRUyxN4XmA0o0NfLBS6djAaSGiq2Kh88KN3vuNXEhEVXkfJoLw==
X-Received: by 2002:a9d:624f:: with SMTP id i15mr28313563otk.6.1617133083472;
        Tue, 30 Mar 2021 12:38:03 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:51d7:1436:793b:b3c9? ([2600:1700:e72:80a0:51d7:1436:793b:b3c9])
        by smtp.gmail.com with ESMTPSA id c9sm4612061ooq.31.2021.03.30.12.38.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 12:38:03 -0700 (PDT)
Subject: Re: [PATCH] maintenance: specify explicit stdin for crontab
To:     Todd Zullinger <tmz@pobox.com>
Cc:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Kevin Daudt <me@ikke.info>,
        Git Mailing List <git@vger.kernel.org>
References: <20210329210928.561586-1-me@ikke.info>
 <CAN0heSrSNJhy33Wi9Yq8kfnkJEyvQoadyj8joLqHtV+SYPs1sw@mail.gmail.com>
 <25ea6f26-c829-f63f-77a1-11a28bbe7fc0@gmail.com>
 <20210330174333.GJ15354@pobox.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f876cbad-ec12-6ee0-ede2-8f439ad4ad34@gmail.com>
Date:   Tue, 30 Mar 2021 15:38:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210330174333.GJ15354@pobox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/30/2021 1:43 PM, Todd Zullinger wrote:
> Hi,
> 
> Derrick Stolee wrote:
>> On 3/30/2021 1:41 AM, Martin Ågren wrote:
>>> On Mon, 29 Mar 2021 at 23:23, Kevin Daudt <me@ikke.info> wrote:
>>>>
>>>> There are multiple crontab implementations that require stdin for
>>>> editing a crontab to be explicitly specified as '-'.
> 
> Amusingly, I wrote the exact same patch 2 weeks ago
> (including not dropping the `argc == 2` which Martin
> mentioned).  That was in response to a report in the Fedora
> bugzilla:
> 
>     https://bugzilla.redhat.com/1939930
> 
> I thought cronie might be rather rare with it's non-POSIX
> handling of crontab without arguments.

Thanks for this link! I appreciate the context.
 
> In the end, the cronie folks upstream adjusted things so
> that crontab behaves as defined by POSIX if stdin is not a
> TTY:
> 
>     https://github.com/cronie-crond/cronie/commit/8b0241f
>> That allows cronie to behave more sensibly for interactive
> use without breaking tools like git maintenance.  And it let
> me sidestep proposing a patch to git (or worse, maintaining
> it in the Fedora packages).

Nice!
 
> But I didn't dig in to find out whether or how many other
> crontab implemntations had also eschewed the (rather poor)
> POSIX-confirming behavior.  Knowing there are several among
> popular OS's makes it easy to see something like this patch
> being generally useful.
> 
> Though, as Derrick notes below, we would break systems which
> implement crontab strictly per the POSIX spec.  I don't know
> how many crontab's don't accept `-`.
> 
> At the time, I checked on an older OmniOS system I had
> access to (based on Illumos/OpenSolaris) and it did not
> accept `-`.  So my quick sample size of 3 (Fedora, CentOS,
> and OmniOS) I had a 1/3 failure rate.
> 
>> Thank you for reporting this, especially with a patch!
>>
>> However, I'm not sure about this adding of '-' being something that
>> crontab ignores so commonly. My Ubuntu machine reports this:
>>
>> $ crontab -e -
>> crontab: usage error: no arguments permitted after this option
>> usage:  crontab [-u user] file
>>         crontab [ -u user ] [ -i ] { -e | -l | -r }
>>                 (default operation is replace, per 1003.2)
>>         -e      (edit user's crontab)
>>         -l      (list user's crontab)
>>         -r      (delete user's crontab)
>>         -i      (prompt before deleting user's crontab)
>>
>> Is there a way we could attempt writing over stdin, notice the
>> failure, then retry with the '-' option?
> 
> You'd skip the `-e` there, no?  Running `crontab -` in a
> current ubuntu container with the cron package installed
> (what looks like vixie-cron-3.0pl1) works as expected.

Yes, this is my mistake. My machine supports "crontab -".

> Perhaps a Makefile knob to allow systems with such a crontab
> to adjust the behavior would be an alternative to detecting
> and retrying?
> 
> NEEDS_CRONTAB_STDIN_OPT or something like that, with
> config.mak.uname to override whichever default is chosen.
> Whether that's a better option really depends on how much
> effort it is to add and maintain the detection in the code
> weighed against how many systems would need to have the
> default changed.
> 
> Mildy related, I wonder whether we'll eventually see a patch
> to use systemd timers instead of cron (optionally, of
> course).  Fedora, for example, doesn't install crond by
> default anymore.  (Though, warts and all, I still prefer
> crond myself.)

Perhaps the best way to approach this is to try adding '-'
by default, and remove it and try again on a failure. If the
usage is actually a problem, that first command should fail
quickly. I'm not sure if we could rely upon a specific
category of error codes or if we should just say "non-zero
exit means retry".

Thanks!
-Stolee
