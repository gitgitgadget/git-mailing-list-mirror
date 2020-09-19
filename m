Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614DDC43464
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 09:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F420121582
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 09:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oiySVz1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgISJNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 05:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgISJNF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 05:13:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B9DC0613CE
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 02:13:05 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id g128so9659809iof.11
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 02:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1tTPA78t/0thiimcUN9sRUnIqUbF6Dh+T7wRqILMjyU=;
        b=oiySVz1VhCZUwptQegJN3l9JgagxwbhIoSVdAD8ToDnj7Uy046AXI/VgraSLAzOjAq
         jdNggQV+0Fkbsh+kYHTQKP5wNxlOBU3a3QTiNrfmSZxaEcBWSTtobC3uxKMRn9IF3qvF
         yjbgPeVuaPBiJPx3mCSZyf2zW1QWwMpKGUEppSRdAbsvFyHLL3bVH2YKmkYIGDSFFa9p
         14N0n6XwR0IVtv4NKzihEtgnePqlLab8dxjGwf4a/7s4rimQgsk6A9u4Nonpcl3xPnSu
         SFpO0aT3TwgU8EhzOOvdpMTo3o589FJxZAqF/ts+Q+0NqlH9ZCzFuJsh5rGeUVu0uvgR
         PNHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1tTPA78t/0thiimcUN9sRUnIqUbF6Dh+T7wRqILMjyU=;
        b=QM4ub+xjCYCsxuW5sVYGqKI7zbdGhZN59bxkMlYi0XWzLEiJsP/ZJuETrShL7vMIz8
         qSANYSagHDkwXmXBzc+kMk0mC9MEwobU6ua8WAq+TZ5Q0rH0lMPlMz+ScyV9Z6TMbUPZ
         DyXyPxy7kC9JgefA1kjUNskBIyYisxDPbFE6hB76BjlZU8ihj8ViWJNjAxP8rOLQl67C
         gztxtKXItLwJCVWSzw6DX/lvtM0zLogx9HIPsO/q47wwYbt45/qcrucLBsu2BW9KSUQk
         W608c1mlIaDS86bWvpI3beKl6SEvEEtBT0VJVeDkOTtN3Z0sY66qoiUhVKj6IEstAodn
         j6vQ==
X-Gm-Message-State: AOAM532ycP8Gbgv2ROqlYo+w6Tf6BOV76H+SjKpHjzOnO8EQSnR05ktf
        haBcyJuIiZDIORE4aHRZGUGICso1DU9kAvuec5o=
X-Google-Smtp-Source: ABdhPJwj8cIEJvF4IvaKtS4BVZ7jGLEkzGoVxdZvnyJLGSrpyOthrNf2R/8l4w7hCdla21ftzr8YV0ccig8uutuYifw=
X-Received: by 2002:a02:9a0e:: with SMTP id b14mr34153924jal.22.1600506784892;
 Sat, 19 Sep 2020 02:13:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200918222103.GA3352870@google.com>
In-Reply-To: <20200918222103.GA3352870@google.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Sat, 19 Sep 2020 19:12:53 +1000
Message-ID: <CAN05THSUN4YToYRqWUxZ0r2=wVxJU0V2iWumx1jjx=eTQ7rAYw@mail.gmail.com>
Subject: Re: Joint project with Git for outreachy
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Developer support list for Wireshark 
        <wireshark-dev@wireshark.org>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,
Hi Emily

Emily, you want to contribute to wireshark? That is awesome. I think I
speak for everyone to send a HUGE welcome
your way and hope your experience working on and with wireshark be excellent!

I think a git dissector would be really awesome.
We do have a packet-git.c already in wireshark, but looking at it it
is very barebones (understatement of the year:-)
but getting a real full blown git protocol implementation would be
totally awesome.

I am more than happy to provide feedback and advice for Emily. We do
have pretty good development documentation so it should be pretty easy
to get started and get a development environment up and running.


(
Jonathan, remember that smb2 client I was working on, libamb2?  I got
it to run on PlayStation2 now. It is totally awesome being able to use
SMB3.1.1 and full encryption to copy file between the PS2 memory card
and Azure cloud file server :-)
)

best regards
Ronnie Sahlberg




On Sat, Sep 19, 2020 at 8:21 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi wiresharkers,
>
> Outreachy <https://www.outreachy.org/> is a program similar to the
> Google Summer of Code, providing internships to work on open source
> projects.
>
> Emily (cc-ed) and I would be interested in mentoring an outreachy
> intern on adding support for the Git protocol to wireshark.  We think
> this would be helpful for documenting the spec better, for making
> debugging easier for future Git developers, and for helping people
> working on systems involving Git (e.g. CI systems) to understand the
> behavior of the systems they oversee.  We think that a co-mentor
> within wireshark would be helpful for making sure an intern is set up
> for success (helping them find pointers, making sure their approach is
> on the right track, etc).
>
> This would be a project under the Git umbrella
> <https://www.outreachy.org/communities/cfp/git/>.
>
> What do you think?  Does this sound interesting to you?
>
> Thanks,
> Jonathan
