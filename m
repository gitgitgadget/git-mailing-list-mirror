Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FF3C433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF04611BE
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 09:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbhDDJxe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 05:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhDDJxd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 05:53:33 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA564C061756
        for <git@vger.kernel.org>; Sun,  4 Apr 2021 02:53:27 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id k8so7004847iop.12
        for <git@vger.kernel.org>; Sun, 04 Apr 2021 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tKwQhOLBpNjarltx/f7nOl/vzQr+LOwlXxx2qP5G/uo=;
        b=nsBA6baiTAmB9RAvvKlNP/gH0WVFGQTT107Y2Yg6ChLEoUU9geEUePCT2QesJXysi1
         JqcFV+ZyhorPRqIKkRYa6T64mbZ+nGc+jOy03AauNgUR55q0Wa04RA85cvJ5N1aboc6O
         fz9AdGnpLlsHlUM8smsHsHLccf6z1Bp0Dh7tb/GzaPgue+nWLUStjQ6kUtKrgrgrgOIe
         YoFdmmKb1LwDhqwbKsIbbSotzcWe2oWbCKF0ImxyV58y+E3IuVfRXglf13HVrkXZlaKZ
         p3Qj0pQSVIyc0QselHpI8wpQb2n42JHzWUvaN3xrfddPHmsGqHtzNNRwX6hNdRHAI1cT
         IHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tKwQhOLBpNjarltx/f7nOl/vzQr+LOwlXxx2qP5G/uo=;
        b=UvR9JhFr/Dv8WOoVBi4s5XcsYw/eYkdXF8vci6j/wufuhOjZSOVNds3BJh1WSnmNwM
         RX4XsG52UgRs+OR9P4z2/DXTvMggM2f2Hrxl7nGo0zBd8yz/zrBv8hkd/b/sXDIhqLpv
         UqJFwc2u98m1MZfTftEcWIMM5yJ7oBc9Wl5828ggEUAnIT9gdqK8ccbEprPmnNCX/g7D
         dLiPQ9pE6p2rk+egfn3qKKRSmz67o68fYfkfsF/5XJBW0nPHlP9xcvdcOexv+iT/6KA4
         Rb49j+C0VpOlZ44rj/6AsGJWitAxOV0E31GqNhqjQYuh6y8TFxR5a/0PBngXpeB75wRq
         AuNA==
X-Gm-Message-State: AOAM531Bn5qTgqL75Sle4db0ctA46w0zh619jHuOjeeaCJ0KNcXbN7LH
        8CsXxmqeIglswKkjhxpwzEnq3hwoounbSkKNQ4I=
X-Google-Smtp-Source: ABdhPJxTF23GEhgdifA4wq7SBtQyn7SgIf6QaQxU4oxRgAaK/OtgekCf0qj4m154HOz0R3wse8Qu/sT6yDOlk0f3kQ8=
X-Received: by 2002:a02:94a9:: with SMTP id x38mr19475704jah.50.1617530006505;
 Sun, 04 Apr 2021 02:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
 <CAOLTT8QvPPJ4jYXjch+RhdHDnvDT6Woh2oQoX2LcoiVX_t7jZQ@mail.gmail.com> <CAP8UFD1=v_dfjKT2zY2=DFhZO1RWh9-++m5gAOn5WmwuV2pJXg@mail.gmail.com>
In-Reply-To: <CAP8UFD1=v_dfjKT2zY2=DFhZO1RWh9-++m5gAOn5WmwuV2pJXg@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 4 Apr 2021 17:53:10 +0800
Message-ID: <CAOLTT8TpDBmXgTNuV_bS6sYfv6QCh9ZznMq7vUmVDP7PzGmRRQ@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> =E4=BA=8E2021=E5=B9=B44=E6=9C=
=884=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=884:52=E5=86=99=E9=81=93=EF=
=BC=9A
>
> On Sun, Apr 4, 2021 at 7:44 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> > This may be an off-topic question:
> > I wanted to use `shortlog -s` instead of the document example,
> > But I found a very strange place:
> > Here we have two shell scripts:
> >
> > $ cat ~/bin/gcount
> > #!/bin/sh
> > if test "$1" !=3D ""
>
> It's better to use `test -n "$1"` instead of `test "$1" !=3D ""`.
>
> > then
> > git log -1 --author=3D"$1"
> > else
> > echo "hello there"
> > fi
> >
> > cat ~/bin/gcount2
> > #!/bin/sh
> > if test "$1" !=3D ""
> > then
> > git shortlog -1 --author=3D"$1"
> > else
> > echo "hello there"
> > fi
> >
> > If I use them in the terminal, there is no problem with them,
> >
> > $ ~/bin/gcount gitster
> > commit 142430338477d9d1bb25be66267225fb58498d92
> > (interpret-trailers-command-arg, abc5b)
> > Author: Junio C Hamano <gitster@pobox.com>
> > Date:   Mon Mar 22 14:00:00 2021 -0700
> >
> >     The second batch
> >
> >     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> > $ ~/bin/gcount2 gitster
> > Junio C Hamano (1):
> >       The second batch
> >
> > if I use .cmd to run these scripts, the situation is totally different:
> >
> > $ git config -l | grep trailer
> > trailer.cnt.ifexists=3Dadd
> > trailer.cnt.key=3DCnt:
> > trailer.cnt.cmd=3D~/bin/gcount
>
> The script/command used in ".cmd" or ".command" should really return a
> short string with no newline or line feed char in it. Here your script
> can return multiple lines which could mess things up and be difficult
> to understand.
>

Yes, it's just a small test, I want use `git shortlog -s --author=3D"$1"` t=
o show
commit count of one author.

> > $ git interpret-trailers --trailer=3D"cnt:gitster" <<EOF
> > EOF
> >
> > Cnt: hello there
> > Cnt: commit 142430338477d9d1bb25be66267225fb58498d92
> > Author: Junio C Hamano <gitster@pobox.com>
> > Date:   Mon Mar 22 14:00:00 2021 -0700
> >
> >     The second batch
> >
> >     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >
> > And if I turn to use gcount2:
> > $ git config trailer.cnt.cmd "~/bin/gcount2"
> > $ git interpret-trailers --trailer=3D"cnt:gitster" <<EOF
> > EOF
> >
> > Cnt: hello there
> > Cnt:
> >
> > It looks like `shortlog` does not write to standard output.
>
> In shortlog's doc there is:
>
> "If no revisions are passed on the command line and either standard
> input is not a terminal or there is no current branch, git shortlog
> will output a summary of the log read from standard input, without
> reference to the current repository."
>
> I guess that's what's happening here.
>

This solved my confusion ;-)

> > Note that in `short_log.c`, log will be output to `log->file`.
> > Does it make the above behavior different?
> > Is there a good solution?
>
> I would try to pass a revision on the command line.

Thanks, Christian.
--
ZheNing Hu
