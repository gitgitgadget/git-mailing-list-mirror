Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F04BC433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 23:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbiBIXKa (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 18:10:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236886AbiBIXK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 18:10:27 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C4EE018E6E
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 15:10:29 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id s7so8043533edd.3
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 15:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version;
        bh=q73c2+Di/e0506JQqG5onG+TBwAOoHf6EQstq+MKIdE=;
        b=RLCGUqLJt+ifFsfqzxR7Stk5A05jOEdT5n2hzEn8lUf24GtbZ9wC296fiAbfKiNBz5
         jTmLUbVKiRRpO8MzNAM5Ll+rMro2E0ad3HJnRDY8m5PLIYkjMP2qMdWm6GcAdiemWtDd
         BMouiiW+rKJwfej6pxA6LtHiEndN6NUryCl10Xqo/VqgZTQgS6TyM1rJpxvvSO6Z6XdH
         S1JVA/RXIfiekdhdYvCy8rk7t6kjXWAE/ff43nQ5sY9n4jlN0+SeNC7Yt5U4CVezqKPU
         97snLt6rbQjCn9FMlY4UjC/Nr7rSxFuPVfXITbLO0jPOFHVmhHDnUemc+stIdP5yuXuy
         S1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version;
        bh=q73c2+Di/e0506JQqG5onG+TBwAOoHf6EQstq+MKIdE=;
        b=0OLAPzR44eW44bswAhqTebDZDu8+s4L5538o6X+xNkF6PLivYGGJH05eFmMuItCC37
         +AdAsiuEoNP26pCngUC3YX36sF7OjpxkOAg55yaJm3Le9b5gFrmz27KOKUt3xJ4xMYph
         OXoU71QeIpClu+jFOusdXZ6bXS10jFy+szZJl3YSPYdynTkMJ/Gm+8NqLRlHB9e6Tl82
         ia34C2L3mfitI+3pRP0qBv3cQKbRfkZ0e0K9p+gtas7kiG93PV3+0FXMF45uxWvJtJL0
         IpTGMz7pjtrWqiup6lBz8eAzRXYEJvwFxY4cX0E9oQtWUHb1KXJFCRUm9DPz71dktj/p
         GU0g==
X-Gm-Message-State: AOAM530zi4hS/IS7Jyu6R/mhUaU+UTsk/VXlTSohnFwesSacdDjj7GXQ
        Z5m90KZo38Hd2N0rNyRM/UFxF4+RLXA=
X-Google-Smtp-Source: ABdhPJxVICWJxMfrsOXalLXPJrF21igLdS7UxNlZDCm1ihLxzGMNAI1Y7L84Vj7DM1KHsPXpgvLt/w==
X-Received: by 2002:a05:6402:7ce:: with SMTP id u14mr5349849edy.35.1644448227565;
        Wed, 09 Feb 2022 15:10:27 -0800 (PST)
Received: from [10.200.48.220] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id r22sm8756354edt.51.2022.02.09.15.10.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Feb 2022 15:10:27 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 0/3] Add cat-file --batch-command flag
Date:   Wed, 09 Feb 2022 18:10:24 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <A1234067-820F-4828-B3A1-17BE6944E18F@gmail.com>
In-Reply-To: <691561CD-A3CF-457F-ACD0-E45153EBB829@gmail.com>
References: <pull.1212.v2.git.git.1644251611.gitgitgadget@gmail.com>
 <pull.1212.v3.git.git.1644353884.gitgitgadget@gmail.com>
 <xmqqa6ez7m6t.fsf@gitster.g> <691561CD-A3CF-457F-ACD0-E45153EBB829@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 Feb 2022, at 17:22, John Cai wrote:

> Hi Junio
>
> On 9 Feb 2022, at 16:40, Junio C Hamano wrote:
>
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> John Cai (3):
>>>   cat-file: rename cmdmode to transform_mode
>>>   cat-file: introduce batch_command enum to replace print_contents
>>>   cat-file: add --batch-command mode
>>>
>>>  Documentation/git-cat-file.txt |  24 ++++
>>>  builtin/cat-file.c             | 154 ++++++++++++++++++++++--
>>>  t/t1006-cat-file.sh            | 207 ++++++++++++++++++++++++++++++++-
>>>  3 files changed, 373 insertions(+), 12 deletions(-)
>>
>> Does t1006-cat-file.sh pass the --stress test?  I have no time to
>> test it for you but I've seen "make test" got stuck and this is the
>> only cat-file related change in flight.
>
> Yes it looks like there are some failures. Thanks for pointing this out. It
> looks like the flush test is getting stuck. I can actually reproduce it on my
> end when I do a make clean in t/ and then run the test. Will investigate.

I believe this was the culprit, as the stress tests that failed passed once I
removed this:

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 9428a04482..a20c8dae85 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -237,7 +237,7 @@ run_buffer_test_flush () {
        size=$3

        mkfifo input &&
-       test_when_finished 'rm input; exec 8<&-' &&
+       test_when_finished 'rm input' &&
        mkfifo output &&
        exec 9<>output &&
        test_when_finished 'rm output; exec 9<&-'

I was closing a file descriptor 8 that was never opened. But, I don't fully
understand why that would create problems.

>
> thanks!
