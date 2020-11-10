Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD7DC388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37B4F20781
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 11:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B8XXAjAp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgKJLuF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 06:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJLuE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 06:50:04 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D5C0613CF
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 03:50:04 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id 10so7841959ybx.9
        for <git@vger.kernel.org>; Tue, 10 Nov 2020 03:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7oBNUUY7oFI2PrsidzpBu8085f/BbvukQ1cWI/rgENM=;
        b=B8XXAjApktHvg52y00YO2dFIcU+KQ3I6Q80tNooJK1hD7LRSWT1LEqp6qeaO96XmJM
         w8uCT1IhC8oAERH7ijyH9awlMk9pgUyIB4COYRPjHDKyWSFhHRg2NIMzBIV9qfmSSQSW
         8YnD6gIAdvwLfAL2ENu/9PQqrN1x4+DCiN+rUxwqkm3yFSwO3KOM3SMeqULNyqYYk+aS
         85Bjh+fUlnAU3eTZQG9SbysTKG7GcEuMSI+rRiufy0aGqEFTRBE+d3o120VXB0vChYkl
         zXRv3MRj9aA0TPyW3vprGmmOXr2eV67ggmqC051gZKcK7RY1vY9w3Il+Ey4rMePqptF/
         5QHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7oBNUUY7oFI2PrsidzpBu8085f/BbvukQ1cWI/rgENM=;
        b=G2TMCYxNU3mpiRep7ISgKano3Y9fT//3feuV0WflLbxpxqDm+qw/ZbKjlOTe+fhnTO
         S8XIp2HM8S8Vue4vfuyUVw87F4A0EYpgqRFCiq7PVh1OyQSGbdHGGKLVRYs/12WcxgLf
         mxmY+vtFIL3mBRaU4E0VOm3p6glhQncnq4Ou+a5fjFPnZM9N1ws5fmrBGhjCesZLS8QD
         qhmb9yuiSKZeBwxQqE8b8QrVs/Bt0hBIOe7FOb980cvQopu6tJfsH5XY0xGxnGLEZgZf
         6pEj/B/fpX623AOGLQHIJHsXnWrd1gfdru0SrqrqgEuUcxxu45+P4y4KU4NJCwUMfykq
         WeEA==
X-Gm-Message-State: AOAM531xsYF2DJPn1PqrAytBYmx2Pd0DkqDcFJgoADzIVOik4PZ+ZWLg
        PhKYOt18RM+ylC4h13RwWfLdWWsejD9J91djd1EHvfRRGhrprw==
X-Google-Smtp-Source: ABdhPJwKHLZ+Fs1eZW6vNJzlZFhCoQci7Dka3A+voWf0y6QpE5X6fLYanNQn7OjcI7NgfzicVlcs5nHf89Yp8be1l1I=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr26242066ybe.403.1605009003963;
 Tue, 10 Nov 2020 03:50:03 -0800 (PST)
MIME-Version: 1.0
References: <CANYiYbHQKshFg=1xAv8MFfSjmFfQ0uJRm3mQBnZMsTd1n7R-Ow@mail.gmail.com>
 <20201109105846.64303-1-zhiyou.jx@alibaba-inc.com> <xmqqh7pyb61f.fsf@gitster.c.googlers.com>
 <20201109231246.GA677345@coredump.intra.peff.net>
In-Reply-To: <20201109231246.GA677345@coredump.intra.peff.net>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 10 Nov 2020 19:49:53 +0800
Message-ID: <CANYiYbH-x6khgTkkFV29+7AjghOZmG69_6-sQcm2489WMHOWAA@mail.gmail.com>
Subject: Re: [PATCH v2] t5411: consistent result for proc-receive broken test
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> =E4=BA=8E2020=E5=B9=B411=E6=9C=8810=E6=97=A5=E5=
=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=887:12=E5=86=99=E9=81=93=EF=BC=9A
> > > @@ -52,8 +53,10 @@ static void proc_receive_verison(struct packet_rea=
der *reader) {
> > >             }
> > >     }
> > >
> > > -   if (server_version !=3D 1 || die_version)
> > > +   if (server_version !=3D 1)
> > >             die("bad protocol version: %d", server_version);
> > > +   if (die_version)
> > > +           die("die with the --die-version option");
> >
> > If any of these trigger, wouldn't we end up dying without consuming
> > what receive-pack said?
>
> Yeah, I think they would have the same race that the commit message
> describes (proc-receive hook writes to stderr and dies, receive-pack
> gets an error writing to now-closed hook pipe and never relays the
> stderr).
>
> But it seems like fixing this in the hook is the wrong place. The hook
> has failed and has nothing else to say. Adding a pump-the-stdin-to-eof
> loop to every die() is a lot of effort. Not to mention that the hook
> could fail for reasons outside its usual flow control (e.g., segfault,
> oom, etc, and receive-pack should be able to handle that gracefully,
> even if the hook doesn't appear to behave.
>
> I.e., I think the bug is in receive-pack's run_proc_receive_hook(). It
> cleverly ignores SIGPIPE exactly to avoid dying during the write phase,
> but then it proceeds to call packet_write_fmt(), etc, that will die on
> any error (going to extra effort to emulate sigpipe, no less!). So we
> die and take our sideband muxer with us.
>
> So instead of this hunk:
>
> > > @@ -79,9 +82,15 @@ static void proc_receive_read_commands(struct pack=
et_reader *reader,
> > >                 *p++ !=3D ' ' ||
> > >                 parse_oid_hex(p, &new_oid, &p) ||
> > >                 *p++ !=3D ' ' ||
> > > -               die_readline)
> > > +               die_readline) {
> > > +                   char *bad_line =3D xstrdup(reader->line);
> > > +                   while (packet_reader_read(reader) !=3D PACKET_REA=
D_EOF)
> > > +                           ; /* do nothing */
> > > +                   if (die_readline)
> > > +                           die("die with the --die-readline option")=
;
> > >                     die("protocol error: expected 'old new ref', got =
'%s'",
> > > -                       reader->line);
> > > +                       bad_line);
> > > +           }
> >
> > This part is different from the previous one in that it slurps all
> > the input before dying evein in die_readline case.
>
> I think the patch really ought to be in receive-pack, converting
> packet_write_fmt() and packet_flush() into their "gently" forms.

Thanks Peff for pointing the root cause. Will use the "gently" forms
of packet_write_fmt() and packet_flush() in patch v3.

--
Jiang Xin
