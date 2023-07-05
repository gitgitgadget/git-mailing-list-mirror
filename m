Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070ADEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjGEGT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGEGTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:19:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D0110CF
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:19:54 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fbc244d307so74606145e9.1
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537993; x=1691129993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98qU2G1Y/cM0XCtxbRCUOW6wnbMp0Gt6b4o1DihHkyY=;
        b=Tg4rb/HdM2WQxyxWaOkWmVZxJh3wTvPmRDW9bYwa5B0bYfw0hwxSW5xvfUJc8MfrZ+
         OxRRlsNWr9m2kVGn9pJupjTFYejqjQsmx9oNrdagsGmYaapwaE2uRCX/02o6RuyuPwWw
         rqha3MJmcRYo0YXVzJ1nM1uAIMe585oWjkkA8BCSS/vXhU6cbwMCbXIDRmLIKWZj6kXR
         FruCw/5C1P3DUj1B9cs7FyQpG9NA/RuH/XVR19ApNjc3YF+El6SSIiy+xIOrZLtW2mmT
         jeWvgyw3rfpDM0ka6HIMqA2By10PStvImj3o3sSCQygLX6f+0ZHVMHv+TijUgPKZPiKE
         xdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537993; x=1691129993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98qU2G1Y/cM0XCtxbRCUOW6wnbMp0Gt6b4o1DihHkyY=;
        b=HhSl5lt/cg5fTB4JOf9NfMQ8y23tIwWBS1PND5YOQf077feQkHj8k/KNCnsjAFKc/k
         V6SbdLtpVdxnqHehpo0Sb7F3YfBX2FdpTp2TkV87FyZ3u1i7KlNboQNjKgTWQMCddW0x
         fZJ9lOYB8rkedL7uaNdBwMcAThmF5vYIGkJAqqLeacBqIZT0eXB1oBlTMiysfa8/CEIn
         xInpHK/mJ9bK5HgWf2iANfFVBKFkLfoO52qwLXUzSk8fczNs/lnHtP5tz1vW0rlGyQYM
         1WAdCuYbqRBitJR51vIM9+Bnr/V2jzTz+hLb4mfG9CYh8IJ9RdISomhQZvS1m54Oz6Dt
         /ZXw==
X-Gm-Message-State: AC+VfDxJJPy8/d5QOSei5QFj48Wt751jHIfGpWRmgd5YrUj3gVZ9J7qH
        gy7qNCKyAWVM8sKmq3WzUmwuHw7mXU7BZ0BS5+8=
X-Google-Smtp-Source: ACHHUZ6D4cwuJYGSJuUcfPtguPL6KikSjiyLq+eXnOb3cN152tALo38xKEBWAl1z0+anSIcvpbTPffJCM5GgwmU3sqo=
X-Received: by 2002:a1c:ed12:0:b0:3fb:b5c0:a079 with SMTP id
 l18-20020a1ced12000000b003fbb5c0a079mr14447096wmh.21.1688537992838; Tue, 04
 Jul 2023 23:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-9-christian.couder@gmail.com> <ZJLjvhnh0lSRCVzG@nand.local>
In-Reply-To: <ZJLjvhnh0lSRCVzG@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 5 Jul 2023 08:19:40 +0200
Message-ID: <CAP8UFD2W8fC=h=s7x04hdNS5KPcVdya0UM1Ozsr26CdHU+NrKw@mail.gmail.com>
Subject: Re: [PATCH 8/9] repack: implement `--filter-to` for storing filtered
 out objects
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 1:49=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Wed, Jun 14, 2023 at 09:25:40PM +0200, Christian Couder wrote:
> > diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.tx=
t
> > index aa29c7e648..070dd22610 100644
> > --- a/Documentation/git-repack.txt
> > +++ b/Documentation/git-repack.txt
> > @@ -148,6 +148,12 @@ depth is 4095.
> >       resulting packfile and put them into a separate packfile. See
> >       linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
> >
> > +--filter-to=3D<dir>::
> > +     Write the pack containing filtered out objects to the
> > +     directory `<dir>`. This can be used for putting the pack on a
> > +     separate object directory that is accessed through the Git
> > +     alternates mechanism. Only useful with `--filter`.
>
> Here you say "only useful with --filter", but...
>
> > @@ -1073,8 +1077,11 @@ int cmd_repack(int argc, const char **argv, cons=
t char *prefix)
> >               strvec_push(&cmd.args, "--incremental");
> >       }
> >
> > -     if (po_args.filter)
> > -             prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, p=
acktmp);
> > +     if (po_args.filter) {
> > +             if (!filter_to)
> > +                     filter_to =3D packtmp;
> > +             prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, f=
ilter_to);
> > +     }
>
> Would you want an "} else if (filter_to)" here to die and show the usage
> message, since --filter-to needs --filter? Or maybe it should imply
> --filter-to.

I have added such a check in the version 2 I just sent. We now die()
if --filter-to is used without --filter.
