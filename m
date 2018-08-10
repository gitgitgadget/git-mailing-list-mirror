Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE2A1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 20:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeHJW7E (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 18:59:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54454 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeHJW7E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 18:59:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so3106566wmb.4
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 13:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=n6IwMg3T/O8qBqR/NSNaiOEGnuIQQ1VUz4iH+dBI6jY=;
        b=uqMdOXXhxW7I5Xjb8IKN1IyQaicwFI93ViGDVSp7y/KylDol1qIUk5irh0sUh+cO/K
         AxLfFhC9xK4iLmfELJVVnmK8VgisZUtJNLo1fzAZpA5WXTmPX6gh+EBaOBj0rGDaeQYB
         apZs4hX8MhpOi46SIYp7NBxoT6XtOzGK5axKPy75P4y23TIwDz/7AN73PZLq4dLnvc6l
         2Kk+rYGBbHFwP87NoEc0CgTlUVk3VlghfLnT4OR6EEvc1U9Pw1mcFCfL1x2q03EnOr/p
         VSoOs/+wKGxUN6iRlyhIyfBuOqfPhWJkIAeD5h0ajnE3ojvjVasuTnRmQiNDNA1r5QFO
         gHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=n6IwMg3T/O8qBqR/NSNaiOEGnuIQQ1VUz4iH+dBI6jY=;
        b=GQJXv7MIsi7gpBexrcX7L3skQSHRoU9stf7Px01fzJgK5Aio1ddKa5U3LSAS8CoKhr
         /4FdynNmC32TEl6mmFeB15Vhz/vTt6/LvaAWk//OD4/1SmArDLxXTSfdDga0jC+OLHhk
         iq1rmHXUJcaOzfQX+dZVSpMIyvQJsxFRKhlB6YW2LHHfYJ8Ei3Xw76jecT3H03rQEQi0
         2LM/tc4kWCGJ9BMmyOwWq8eHk2k7zQ2zFzV5sbu7p6xanQGVPYOJPZeHlsoBrbX9QW0s
         iQgwxWbHNPlSyoxFijNfWY6hgezPr6+sQPk+dY8kZ1MW4TULCUGiKXyhSv279t0OCwO5
         IXSg==
X-Gm-Message-State: AOUpUlGIJJbS0xBuwzCh6WppfLaxrHi4z6SQQSiY+YAv/0NKWwFgfJjy
        p+Hu4BmWt616KL7am49+xoY=
X-Google-Smtp-Source: AA+uWPxDGtW3mQGusrCUML0EBlewD56/5QstVoBvwIKlcb/UM5a6yCk8l0mE/HOmgfPRmsKRgWXe8w==
X-Received: by 2002:a1c:3b05:: with SMTP id i5-v6mr2530240wma.57.1533932857827;
        Fri, 10 Aug 2018 13:27:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r12-v6sm2111647wmh.0.2018.08.10.13.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 13:27:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v6 11/20] rebase -i: rewrite complete_action() in C
References: <20180731180003.5421-1-alban.gruin@gmail.com>
        <20180810165147.4779-1-alban.gruin@gmail.com>
        <20180810165147.4779-12-alban.gruin@gmail.com>
        <xmqq4lg281ms.fsf@gitster-ct.c.googlers.com>
        <453e3f0c-6c68-71e1-0338-185f129bb778@gmail.com>
Date:   Fri, 10 Aug 2018 13:27:36 -0700
In-Reply-To: <453e3f0c-6c68-71e1-0338-185f129bb778@gmail.com> (Alban Gruin's
        message of "Fri, 10 Aug 2018 21:36:48 +0200")
Message-ID: <xmqqva8i6k7b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

>> Hmph.  It is easy enough to do the clean-up ourselves in this code,
>> instead of asking the caller to do so.  On the other hand, stashing
>> of local changes is done by the caller, so it feels a bit strange
>> way to divide the labor between the two parts.
>> 
>> Other than that design choice, the patch itself looks reasonable and
>> a fairly faithful reimplementation of what the scripted one did.
>> 
>
> This was the behaviour of the old complete_action().  The new one cleans
> up by itself; this is the
> apply_autostash()/sequencer_remove_state()/todo_list_release() dance
> done at three places inside complete_action(), and has not changed since
> v3[0].
>
> Maybe I misunderstood what you said?

I am not all that interested in comparing your previous attempts; I
am more focused on the end result of applying these proposed
changes.

In the end result, IIUC, stashing away the local modification before
rebasing happens is done in the caller (i.e. "git rebase" proper)
and the caller is still prepared to do the clean-up of applying that
local modification back.  If "rebase -i" did the stashing away at
the beginning, and cleaning up before it gives back control, that
would have been one coherent division of labor.  Or if "rebase -i"
did neither and let "rebase" proper do both, that also would have
been another coherent division of labor.  Making the caller,
"rebase" proper, responsible for preparing the data necessary to
later come back (i.e. stashing away the local mods) while letting
the callee, "rebase -i", consume that data by applying the stash,
felt a strange way to divide the labor between the two parts.

That is what I meant.

If we are planning to make all the backend responsible for stashing
away before they run and applying the stash after they are done,
then it might make sense to have the application side on the backend
as the first step.  But if what you need to do to stash away local
changes and what you need to do to reapply the stash is the same for
all backends, wouldn't it make more sense to have the logic in the
caller side?


