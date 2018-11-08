Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24D21F453
	for <e@80x24.org>; Thu,  8 Nov 2018 00:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbeKHJtd (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 04:49:33 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45919 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbeKHJtc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Nov 2018 04:49:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id k15-v6so16326021wre.12
        for <git@vger.kernel.org>; Wed, 07 Nov 2018 16:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LLiFaf9mRcfR3kuom1SwlU7dgFgqNr98t1FfVOPx3X0=;
        b=Hk0FcvkcP3pBGf0M+5N4qzLY3KJ1ZRivTgQ3KwMnnBH/lSW7O9raMpoyhPutjezui8
         siwufzOkzeIPJOd7bM1AefDWIqufAe7t3OZVo3UxTI+7IhnCeL5wDfwajmOWbEzaUE7E
         zPoPStokY09DPGjoGY30AVTIj8KOJruNwpgIpMnjeZHl1Sr2LM3vh7wMk0Tw6rjdxaTP
         Owkm4dIXWkJ+px5QNgja4r4jr65Qmr/Yhswehm4KvRTs43Ntp3cDYuuE2DE0PN/cnHE8
         LETh0UBhfXoFhR1LGK37dpCIUaK0H3qzH4Ftw9aRWINCynyTsFWlI3+Hsz9K/l4qLJy3
         Iu9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LLiFaf9mRcfR3kuom1SwlU7dgFgqNr98t1FfVOPx3X0=;
        b=KmcEirZElH1N6V0a6gTV67oq3YiCyUvKw8UgFm7W4JiAbWaOwEk7z5elAlzX3/NvkI
         k9Tvcs1+XeNHYFnxWHtUv6d2zXAwtyaF1T3OGMl7qyEfDVsasj+7F9BNAb3G9R6EE70T
         9v+bvjcJ6346Z9tjrz2zuqIYni0X7wEzwXRT14vUAn3bZtIg5QZGglzC2DjMmvXDzwfU
         I6VcxebW8/h7rFHWx8vpbRtk/BxegiVhKadeKZq6dU6JoNqcqmCM+uU7VULoZQImSFLG
         CtC3tSzrqaNRKRROHjZKEIG5wfbfiB3D05VUKJAnm+6rP/Srr0BjEd0n88g3q30b566p
         3V9g==
X-Gm-Message-State: AGRZ1gJe/kpbjyTZ+edcGadESuOKn7AlCEDvQYlXETKaIAbg6CrAsnXb
        TmTYSmA7/uVyzsN9hn5F2f8=
X-Google-Smtp-Source: AJdET5dkh9NlU7HMESidt18Q7gCrc37Ld2bRwBTc8t32JODykbFnKjvk/3+Crf7vrh5ETiv4r+NfLg==
X-Received: by 2002:adf:a109:: with SMTP id o9-v6mr2024034wro.169.1541636203143;
        Wed, 07 Nov 2018 16:16:43 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 109-v6sm1789272wrb.81.2018.11.07.16.16.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 16:16:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
References: <pull.66.git.gitgitgadget@gmail.com>
        <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
        <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
        <xmqqo9b1d6na.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1811071217280.39@tvgsbejvaqbjf.bet>
        <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com>
Date:   Thu, 08 Nov 2018 09:16:39 +0900
In-Reply-To: <d7a70226-3441-76c4-df6a-e8fb32249f27@ramsayjones.plus.com>
        (Ramsay Jones's message of "Wed, 7 Nov 2018 17:42:00 +0000")
Message-ID: <xmqqr2fwa0ew.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> The cute thing is: your absolute paths would not be moved because we are
>> talking about Windows. Therefore your absolute paths would not start with
>> a forward slash.
>
> Ah, sorry, I must have misunderstood a comment in your cover letter:
>
>     The reason is this: something like this (make paths specified e.g. via 
>     http.sslCAInfo relative to the runtime prefix) is potentially useful
>     also in the non-Windows context, as long as Git was built with the
>     runtime prefix feature.
>
> ... so I thought you meant to add this code for POSIX systems as well.
>
> My mistake. :(

Well, I do not think you should feel so bad about it, as you are not
alone.

It wasn't clear to me either that it was to introduce a new syntax
that users would not have otherwise used before (i.e. avoids
negatively affecting existing settings---because the users would
have used a path that begins with a backslash if they meant "full
path down from the top of the current drive") to mean a new thing
(i.e. "relative to the runtime prefix") that the patch wanted to do.

If that is the motivation, then it does make sense to extend this
function, and possibly rename it, like this patch does, as we would
want this new syntax available in anywhere we take a pathname to an
untracked thing. And for such a pathname, we should be consistently
using expand_user_path() *anyway* even without this new "now we know
how to spell 'relative to the runtime prefix'" feature.

So I agree with the patch that the issue it wants to address is
worth addressing, and the function to enhance is this one.

I am still unsure about the solution, though.

I suspect that any build that uses runtime prefix would want access
to this feature, regardless of the platform.  The new syntax that is
"a pathname that begins with a slash is not an absolute path but is
relative to the runtime prefix" cannot avoid ambiguity with users'
existing settings on platforms other than Windows, which means this
feature cannot be made platform neutral in its posted form.  The
documentation must say "On windows, the way to spell runtime prefix
relative paths is this; on macs, you must spell it differently like
this." etc.  Which is rather unfortunate.

Perhaps we need to make an effort to find a syntax that is
universally unambiguous and use it consistently across platforms?

I am tempted to say "//<token>/<the remainder>" might also be such a
way, even in the POSIX world, but am not brave enough to do so, as I
suspect that may have a fallout in the Windows world X-<.

An earlier suggestion by Duy in [*1*] to pretend as if we take
$VARIABLE and define special variables might be a better direction.

Are there security implications if we started allowing references to
environment varibables in strings we pass expand_user_path()?  If we
cannot convince ourselves that it is safe to allow access to any and
all environment variables, then we probably can start by specific
"pseudo variables" under our control, like GIT_EXEC_PATH and
GIT_INSTALL_ROOT, that do not even have to be tied to environment
variables, perhaps with further restriction to allow it only at the
beginning of the string, or something like that, if necessary.

[References]

*1* <CACsJy8DmyU_Kn4yytu_PQdpppXO8wLcuuzQ-fjwnyjA0ntB2Dw@mail.gmail.com>
