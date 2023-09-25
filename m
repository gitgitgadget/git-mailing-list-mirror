Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C857CE7A99
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 00:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjIYAZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Sep 2023 20:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjIYAZb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2023 20:25:31 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D925AC4
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 17:25:24 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59f4db9e11eso33258927b3.0
        for <git@vger.kernel.org>; Sun, 24 Sep 2023 17:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695601524; x=1696206324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtYaD53chqE4/Q3/Um9VixiZ1A5g89ABvEj+ukcNwXE=;
        b=kEce4w7uQHTCR2gAb4C4SHm2N8krAV89//Bbs5eBC6gRq8YtAa08tFgbJR9U49DslJ
         JxIX/7Ca8UA+Una8PUDt8f796XtoIu18RW1ZPzjKmktDgl9tgADVEyNOXuPOQhsnIj7G
         q34+Yj+jVST9kFj6iuomxleej7s79XhC1UQSa/sHPyZK7fzCoBI5RBuX8mo1meTJf+/h
         crXUxkqMwCG5BlaUBnB1yABkvfWSqLWdUJI9IUhxRoltWTJ/MSenZvGHyEe3qPf9yCEh
         pWEOG1/M11qR3pqp6eH/t/cYQ0oOW57hfwdIUU9+oca0NwMB5gur5NFyWkVD33mwBh7B
         BTzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695601524; x=1696206324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtYaD53chqE4/Q3/Um9VixiZ1A5g89ABvEj+ukcNwXE=;
        b=qLHeAweIi5W5j/3EV4GGcZMkikYMi9vzUTM+m4Zhf4S/+68AE5QPb0UBa8dUFh8/Ck
         R4PxroSyxmExdKqQI2ri6nTRQRFNQgVF7DvZtXWRqorSZoMmRnijoSFcz86YTfBO9vZ2
         UAuTXUPR7Hou5iVvuzP8V0l8Pd4qdqdDjt8Wb6DsQX23a8zlqGwZ5Xf9H6SgTsG51bb6
         XosicmjzXvECn3DGHKueLHqCf/dVHVllIYyaL4bQlrA2WdDl5HDREWAd720DjWf2WuQ+
         7SnBuHcy0I5NqnH584m7OteXlgNOMFcKU0dF/W1g5MjCCJBbIyT+RvN0xE8t1SQBjcOd
         j37A==
X-Gm-Message-State: AOJu0YyJ0vpF+wAoothlT29tYEX/Gcd+1+8PxpaPM7Op1w74N6Wy1nQr
        wu6qTLFy/hKvg+xQxvzIN1QLkxwnxhj+BrbmUAE=
X-Google-Smtp-Source: AGHT+IGQpr3f0f8tW7b0jWWki+kv+Eb6n6FkOb9Kk8TA8GmZwtbV645dh4OVqUzlwMcYN74memWSlA8ld3/Fej9a9Po=
X-Received: by 2002:a0d:f2c7:0:b0:58c:b845:e4d6 with SMTP id
 b190-20020a0df2c7000000b0058cb845e4d6mr4702153ywf.4.1695601523971; Sun, 24
 Sep 2023 17:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230919071956.14015-1-worldhello.net@gmail.com> <20230920210832.2305886-1-jonathantanmy@google.com>
In-Reply-To: <20230920210832.2305886-1-jonathantanmy@google.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Mon, 25 Sep 2023 08:25:12 +0800
Message-ID: <CANYiYbF+Xmk4rCNLMJe+i_CFafg8=QU5vbXWNUZbOVsDLTe5QQ@mail.gmail.com>
Subject: Re: [PATCH] pkt-line: do not chomp EOL for sideband progress info
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 21, 2023 at 5:08=E2=80=AFAM Jonathan Tan <jonathantanmy@google.=
com> wrote:
>
> Jiang Xin <worldhello.net@gmail.com> writes:
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > In the protocol negotiation stage, we need to turn on the flag
> > "PACKET_READ_CHOMP_NEWLINE" to chomp EOL for each packet line from
> > client or server. But when receiving data and progress information
> > using sideband, we will turn off the flag "PACKET_READ_CHOMP_NEWLINE"
> > to prevent mangling EOLs from data and progress information.
> >
> > When both the server and the client support "sideband-all" capability,
> > we have a dilemma that EOLs in negotiation packets should be trimmed,
> > but EOLs in progress infomation should be leaved as is.
> >
> > Move the logic of chomping EOLs from "packet_read_with_status()" to
> > "packet_reader_read()" can resolve this dilemma.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> I think the summary is that when we use the struct packet_reader with
> sideband and newline chomping, we want the chomping to occur only on
> sideband 1, but the current code also chomps on sidebands 2 and 3 (3
> is for fatal errors so it doesn't matter as much, but for 2, it really
> matters).
>
> This makes sense to fix.
>
> As for how this is fixed, one issue is that we now have 2 places in
> which newlines can be chomped (in packet_read_with_status() and with
> this patch, packet_reader_read()). The issue is that we need to check
> the sideband indicator before we chomp, and packet_read_with_status()
> only knows how to chomp. So we either teach packet_read_with_status()
> how to sideband, or tell packet_read_with_status() not to chomp and
> chomp it ourselves (like in this patch).
>
> Of the two, I would prefer it if packet_read_with_status() was taught
> how to sideband - as it is, packet_read_with_status() is used 3 times
> in pkt-line.c and 1 time in remote-curl.c, and 2 of those times (in
> pkt-line.c) are used with sideband. Doing this does not only solve the
> problem here, but reduces code duplication.

Yes, there are two places we can choose to fix. My first instinct is
that changes on packet_reader_read will have less impact. I will new
implementation in next reroll.

> > @@ -624,12 +630,19 @@ enum packet_read_status packet_reader_read(struct=
 packet_reader *reader)
> >                       break;
> >       }
> >
> > -     if (reader->status =3D=3D PACKET_READ_NORMAL)
> > +     if (reader->status =3D=3D PACKET_READ_NORMAL) {
> >               /* Skip the sideband designator if sideband is used */
> >               reader->line =3D reader->use_sideband ?
> >                       reader->buffer + 1 : reader->buffer;
> > -     else
> > +
> > +             if ((reader->options & PACKET_READ_CHOMP_NEWLINE) &&
> > +                 reader->buffer[reader->pktlen - 1] =3D=3D '\n') {
> > +                     reader->buffer[reader->pktlen - 1] =3D 0;
> > +                     reader->pktlen--;
> > +             }
>
> When we reach here, we have skipped all sideband-2 pkt-lines, so
> unconditionally chomping it here is good. Might be better if there was
> also a check that use_sideband is set, just for symmetry with the code
> near the start of this function.
>

You find my bug. Without checking the use_sideband flag, two
consecutive EOLwill be removed.

BTW, the new reroll is not coming as fast as I planned, because when I
adding new test cases, I find another issue in pkt-line. I will fix
these two issues in this series.

--
Jiang Xin
