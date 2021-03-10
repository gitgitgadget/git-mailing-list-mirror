Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFECC433DB
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 15:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC79464F95
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 15:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233216AbhCJPm0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 10:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhCJPmI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 10:42:08 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF83C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 07:42:08 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y20so56264iot.4
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=technoplaza.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H0p977snu4wbxTNumHjCGiSQHzZLJ09quXFRlnmjxqs=;
        b=BXE8rxp2YJlahG1n9q7sRSBiroiB3Zzz3uqdm5SqPaHIw35/YdWpPHhd+LwVQrBp2H
         Fkn+zffyH1zh2BgtWzVL9xP4bsY25SVRijYi0GvPQ3lYvDBNwfNH/WpBsMosUnLiY5Mg
         DDyQhx52Q1zL+1V5YQLYuCew4dBgL3EhPrQ6tkH4NZPN3LgVMykKlfTZC1qhTqOnXZkO
         digSn2KC91rVYoXEfqy1VckkitjxbQnpOFe8E5CzamgsH9u84i7ROtFSEhGVKEVsdGca
         /THgOSXbws1ay0ArzOP7seHZPVptcWhGXCOhdwwhTe3UK/cEVEGEoczmco/yMMzNabdt
         bQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H0p977snu4wbxTNumHjCGiSQHzZLJ09quXFRlnmjxqs=;
        b=sFtMYjQUVKK63Qj4RpjiXh0uabSbhPaROWbDrbvVaZJHFKy7RpAyqIKrw86YShWOW1
         ix0FzKhATDvqCvXJgxxBs5VX33+VZvS1wUuXRwB+BSZQTXzB/Z1GEuhUXo9D+D6IgzZe
         WQKrtU/DfhPvaWEFuhSy5rfmYSdlIghoOocmTsSFbPm8/lO0COcdY5TVghEVIEyTLmp0
         c80ovUr7iA7rpI7zCDyGdLJV7GSnQyDD35upupotFf+u987++0jl7GPGaWIf1nO03FX8
         uFcSWUT1W3qETxpeEDA0a7284AfLIjNQ0WPb766l/BWVV9DJgbkijtrH4qq9t6R5uz2e
         WxmA==
X-Gm-Message-State: AOAM532PMdQBfZm4Gu3swrMaD+u1rHSceXngrrqCbHeqXuYTbuXluGqu
        34mTmGRkoH75500BNBF43Vu/NYETnB/mfzPHqfpUtw==
X-Google-Smtp-Source: ABdhPJxCB6lBcYcvDgNluq7w4Ao8uDMWrsEr/zjBSFyyoQzwsLp14Q0cOF2B/JmpfmqIgeaDpSECcdkn69p1J6NMER4=
X-Received: by 2002:a6b:7302:: with SMTP id e2mr2702614ioh.106.1615390927380;
 Wed, 10 Mar 2021 07:42:07 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UukiL0niGSm3o7uYNBzL3FP-UEgfOuq-Tu=fksWJkerT5fg@mail.gmail.com>
 <YC/vqJBSnDHoLIdJ@coredump.intra.peff.net>
In-Reply-To: <YC/vqJBSnDHoLIdJ@coredump.intra.peff.net>
From:   John Ratliff <john@technoplaza.net>
Date:   Wed, 10 Mar 2021 10:41:56 -0500
Message-ID: <CAP8UukgvnxtMLa00jNn-T_sATNMz2qDo6bCVBnWhqqLmqA42Xw@mail.gmail.com>
Subject: Re: git credential cache timeout questions
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks. Now that I know it is a rolling timeout, I was able to narrow
my search for anything that might be causing the timer to extend.

There is a git helper program I use that has a background refresh that
I think I must leave open overnight sometimes. I think this was
causing my timeout to be extended. I disabled the background refresh
task and the timeout seems to be expiring like I expect now.

--John

On Fri, Feb 19, 2021 at 12:04 PM Jeff King <peff@peff.net> wrote:
>
> On Fri, Feb 19, 2021 at 10:46:48AM -0500, John Ratliff wrote:
>
> > I have configured my git to cache my credentials for 12 hours using
> > this section in my .gitconfig
> >
> > [credential "https://mygithub.example.edu"]
> >     username =3D myuser
> >     helper =3D cache --timeout 43200
> >
> > However, the credentials don=E2=80=99t always seem to expire after 12 h=
ours.
> > Sometimes I come back the next morning and the credentials still work.
> > This is generally after leaving at 5:00 PM and coming back in the next
> > day at 9:00 AM, well past the 12 hour timeout.
> >
> > Is there any way to see the current timeout value? Is it a rolling
> > timeout (i.e. any git action resets the timeout)?
>
> It's the "rolling" thing, though the source is a bit subtle. The
> credential-cache helper sets an absolute expiration when the value is
> stored, and it doesn't update it on a "get" request.
>
> However, Git's interaction with the helpers is generally:
>
>   - when we need a credential ask for one
>
>   - when a credential is rejected by a server, tell helpers to erase it
>
>   - when a credential is accepted by a server, tell helpers to store it
>
> And it's that last one that provides the rolling timeout, because we do
> it even if the credential came from a helper in the first place!
>
> I actually wrote a patch long ago to switch this behavior:
>
>   https://lore.kernel.org/git/20120407033417.GA13914@sigill.intra.peff.ne=
t/
>
> But it turned out some people actually rely on it. :)
>
> There's some discussion in that thread about paths forward, and I think
> I even played around with it back then. But then it sat on my todo list,
> and now it has been 9 years, so I don't remember if there were good
> reasons not to push it forward, or if I simply never got around to it (I
> suspect the latter; nobody had a pressing use case that was solved by
> avoiding the rolling timeouts, it just seemed to me to be a bit less
> surprising). I'd be happy if somebody wanted to revisit the topic.
>
> (To your other question, "is there a way to see the timeout value", the
> answer is "not really, without running it under gdb". I wouldn't be
> opposed to adding more diagnostic output to the daemon. But you can also
> see some of what's going on by setting GIT_TRACE=3D1 in the environment,
> which will show the extra "store" operation being done by Git).
>
> -Peff
