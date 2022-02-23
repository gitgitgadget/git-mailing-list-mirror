Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FD9C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 13:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240836AbiBWNUE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 08:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234560AbiBWNUD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 08:20:03 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCB06578F
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 05:19:36 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id q5so18207849oij.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 05:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u18nuo2gYGqooALw3gbyllJzk0WSQellUbKTViFMTb8=;
        b=i8DJpqMZb2fZUBWsZR5WedSzfRSA0pYs8WZ08q2c9vaYCJXo48ybxp2e17u4Wn0VYW
         YjCAyLlF9QbAZSAW2iBiE96eB/dGnphaCTeqkzDdJVDK0HHrLLRShsopFZWGmzy+5U8t
         8jV1AogOG3Hd2rOqPnVw6wnqsn+B3aIdzCZUQ4aJRrWM6rUTQs1DJHN8bzFZ/CO0GavU
         6MaxfK89r5WHofeuDzWbXI7Srj0MNS9fQmMcwngNJU1IYdhEfV6Tb8savmNy4Uc/57qX
         5bRZEXKyPu92PCEkIxsb70cAN2eDAe8nBWihGtKFcfMHY2DDPRixPSTKjQiacj+kiSV/
         uSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u18nuo2gYGqooALw3gbyllJzk0WSQellUbKTViFMTb8=;
        b=EaNWi2U3MdX0Ut7+c9w3uwNe9FejrFFsgEu0BYFljmA+9FR3NgXrC10SiJ0ZQ4Kr2j
         7RxyGHTbgbQIdXmPdmaLWgQkwyieGal3lfusjoNKk+4/3B6IkdDx0sjgneypJXc8m84o
         U89vI5IfuWCEkD/ldqYwEeuS1+EYggQS/cUH46YVmIOzxxTnbO2f4SQtdlC6Jy4kQenR
         pKKeRFnC3SXqP6/2H1irCrZuffdTieR+SYFUh3zdDyrx6n/CyQFppJ6vAiLQtrb6MuFV
         wD9rHdlBQuwH+150JknHx8lHo6TJ+dboq0GA3bbUMfw3tCiogxq/nqVBGsUl/s4bFw6w
         JETg==
X-Gm-Message-State: AOAM532fnusiJugWoz0O2AYIdkGP2YEx9Dw+H7lcrEeb4ijX98ndgMt6
        hyggwqUjZ160orrz1cl8iOT8U+TDxrwoJR3jFFNpKcHNe3Y=
X-Google-Smtp-Source: ABdhPJzE9W3Dsot9HXp8RwFjEITIoxbVb7CU4nomerV4Duwc2mQFpdFiw/uuKEAQSwSwWd1FM3D2mIBTSlygGv6irNc=
X-Received: by 2002:a05:6808:2107:b0:2d4:9bb8:d77f with SMTP id
 r7-20020a056808210700b002d49bb8d77fmr4344211oiw.109.1645622375577; Wed, 23
 Feb 2022 05:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20220222114313.14921-1-shivam828787@gmail.com>
 <20220223115347.3083-1-shivam828787@gmail.com> <CAC316V57tHux-+MWMJuP5wNtwYrc2AinZj+ffnoyy-aWQWDukg@mail.gmail.com>
In-Reply-To: <CAC316V57tHux-+MWMJuP5wNtwYrc2AinZj+ffnoyy-aWQWDukg@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 23 Feb 2022 21:19:23 +0800
Message-ID: <CAJyCBOTiWxAgkZPB6M5jPw=t=32zrnNH5tfnOc9Kdj9mKayrSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] avoid pipes with Git on LHS
To:     Shubham Mishra <shivam828787@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 8:42 PM Shubham Mishra <shivam828787@gmail.com> wrote:
>
> Hi,

Hi,

> I am using mails for code review for the first time, I have some
> doubts, Can someone please clarify them? -
> 1. It looks like the cover letter (Including "Range-diff" section) is
> only for context sharing with reviewers, nothing from it gets merged
> to the "seek" or any other branch.

The cover letter stands for an introduction/summary to your patches.
You can also put helpful context in it for better understanding. According
to my knowledge, it will not be in the commit messages.

> 2. I wanted to know how the merging process takes place. Once the
> patch is accepted, do we merge all previous versions of it one after
> another or every patch is independent so we have to just merge the
> last accepted patch?

Not so sure about this question. My two cents: generally the most agreed-upon
patch will be merged, but the exact merging process could vary based
on the circumstances. Probably Junio can have a better answer to this.

> 3. How does a particular patch set is linked to its previous version?

"--in-reply-to" will do.

> I added the flag "--in-reply-to" while sending this mail but I can't
> find any linking here on the mail. Not sure If I am missing something
> here.

Just by looking at the current thread, I think you are doing it right.

Adding "--in-reply-to" to the Message-ID of your previous patch can
give you a threaded view of the patch history on the public-inbox. For
instance, by always "--in-reply-to" the first patch version ("v1"), you can
line up your patches as they are threaded on the same level. You also
can choose to always reply to the previous patch's cover letter (just an
example), so that your patch history cascades. I think you always go
the way that best illustrates the history and helps reviewers.

I'm also new to the community, that's the best I can answer.
Inaccuracies may be found above.

-- 
Thanks & Regards,
Shaoxuan
