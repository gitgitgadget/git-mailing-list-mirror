Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714B6C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F12B61261
	for <git@archiver.kernel.org>; Tue, 18 May 2021 06:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbhERGll (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 02:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239757AbhERGlk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 02:41:40 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C058C061573
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:40:22 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z24so8349037ioi.3
        for <git@vger.kernel.org>; Mon, 17 May 2021 23:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=X0ztf0g0xSo0lrYyzobxQ6o2Dr5iTeEt0wiPeALjbaM=;
        b=RTSvexvswU9Yk6LybiX7hmKpiCwrlwnnQV+358Qz6NwJb/vWAKopsbTQyoDIEN6NEC
         O052fUJ1QgjIqr3Mg20bniUnf/Ua5XXJ9Y7D+iGMzlzO90uszYWGPb/HiTW5bWaNjdOD
         i5RsZFLoWwTqwOu2oc4ZSXA/g3PVSfNrPpvXUT0HOkLxLgboB/JkVSo3jvZ8El0hSkr8
         YLRGrbzm/Mn/m3ZnprCyKjEpf6Och5qFb5ww7y8tSq9Z6R78sX5pD+D4/4BTL/Mw6FyO
         mLLKoZFbaae+k396vMOChz/H7QLNaDFk6Nwh8IaR64CMO5kERpKT7OhFdbfZuEBCd4Vc
         Nt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=X0ztf0g0xSo0lrYyzobxQ6o2Dr5iTeEt0wiPeALjbaM=;
        b=CdVIzyZZjkQyYcSBqRndRCJ9rFYW1X0cDniiQ8tb/sz1UN38g2nj1aZm0QDyy1n8rc
         2I7nIjC2Qk6baZkrmS0+fzM0E9O7V2C/fdb6bL7kX/u6TMzCcoV7QZ103JFBTgzynxl0
         RmXINsDGd15Qx7l+qaP4gC7gbdDLowJ6pIR9ndpHHl9Fs2Sdr76oYQ+GtkzactSG2c+T
         yCMDwuPbvqzGSA/IB09Zlls3un5XXpu2yJa4hBrHx3hX3gq5lWU+nJ6jRjSO7wRFW7b+
         9Hjf/Rl90HdjlX6G05lpJhWkWtPoFX5y8GHEquLWdWevJSuNWmq31sxYEj4VAi4H5jjc
         wHGQ==
X-Gm-Message-State: AOAM533HdXvrHV3GZpexYlpavVWFhyWPtbEUiPJ+8JSHIe+VnT/8zYwE
        utnwPaRwGbRkRbS8QaavIWQJNNi0iUrTx/oDT9IwnIYXX3PhYqUB4DE=
X-Google-Smtp-Source: ABdhPJx+BZmMq3Fdy8TBUCNh3s0iMb4J2J1cuS0cK0qutICOaai9ytkKT+rV650kTl7h0umJQZa5LCnS6AoWH8n3S0s=
X-Received: by 2002:a5d:848a:: with SMTP id t10mr3141560iom.68.1621320021680;
 Mon, 17 May 2021 23:40:21 -0700 (PDT)
MIME-Version: 1.0
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Tue, 18 May 2021 14:40:05 +0800
Message-ID: <CAOLTT8SHE-ok3D+oLNSWFi7KPU==VQnTMDmC4YxUyNBJKmBD8A@mail.gmail.com>
Subject: [GSoC] Hello Git
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jiang Xin <worldhello.net@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello=EF=BC=8CGit!

### Self introduction

I'm ZheNing Hu, I am very lucky to participate in the GSoC
git project this year. Many people in the git community already
have given me a lot of help in the past few months.
Junio, Christian, Peff, Eric, Denton..., it's great to get along with
you guys! Your review and guidance have greatly benefited
my growth.

In these days before GSoC, I learned some simple command
implementation and data structures of git, learned strict coding
standards and learned how to test, More importantly, I learned how
to communicate with these kind-hearted reviewers.

Of course, there are still many difficulties for me:
* My poor English sometimes can=E2=80=99t express the meaning clearly.
* The Git architecture is very large, even a small command may
require very complex logic to implement, I often feel very difficult
to find clues.

Therefore, during GSoC, I hope to overcome these difficulties and
learn more in-depth knowledge in git.

### How to complete my GSoC project

I don=E2=80=99t want to be rejected by Git after I have completed a lot of
content, as Olga once did, Therefore, I think it is best to move in
the right direction step by step under everyone's supervision.

Current condition:
1. In order to use a unified interface containing both short-named
and full-named atoms, inspired by the short name option and long name
option of "OPT_*" in `parse-options.h`,  I thought I should add a new short
name atom to `struct valid_atom` for expansion in `ref-filter.c`, In [1]:
Junio thinks that `--format` with two-letters short atoms should not be
implemented in `ref-filter.c`
and provided for the `for-each-ref` family. Instead, let the "log" family
learn the full-named atom. To ensure the consistency of `log --format`
and `for-each-ref --format`. But for now, It seems that the parsing of
full-named atoms in `pretty.c` is not very elegant.
E.g.

   if (skip_prefix(placeholder, "(describe", &arg)) {
   ...
   }

       if (skip_prefix(placeholder, "(trailers", &arg)) {
   ...
   }

We should have an atom table like `valid_atom` in `ref-filter.c`,
but this is missing in `pretty.c`. So how do we complete the
unification of the two types of atoms now?

2. "50cfe1f([GSOC] ref-filter: introduce enum atom_type)" has
been merged into the `next` branch, should we focus on the
performance optimization of `ref-filter.c`? Finally, we can build a
`format_cat_file_item()` similar to `format_ref_array_item()`,
which should not be difficult. And we have to make sure that the
performance of `cat-file --batch` is not lower than before.

### The connection between Git and the file system

I am currently studying operating system course, git as a
file system on top of the file system.
There are many differences and similarities with ordinary
file systems. I am very curious about this knowledge, do
not know if there are any relevant reading materials?

### Motto

I remember I saw an interview about Junio and Dan Kogai before [2]:

Dan: What do you think is a "good engineer"?

Junio: When I took over the maintainer of Git, Linus told me that star
engineers have three qualities. The most important thing is to be able
to keep doing one thing all the time. In that sense, you can't be an
alpha geek. It's sharp and you can jump to a new one right away,
but don't get bored right away.

In other words, it=E2=80=99s one thing to have enthusiasm, but it=E2=80=99s=
 more
important to persevere.

When I read the Git source code, I can see the code written by Peff
15 years ago and the code written by Peff a few months ago, which
is very touching. It's as if you guys can travel through time and space.

So, I hope I can also persevere and fight for interest. After 15 years,
let=E2=80=99s take a look at the code I wrote today :)

[1]:https://lore.kernel.org/git/xmqqk0nz72on.fsf@gitster.g/
[2]:https://gihyo.jp/dev/serial/01/alpha-geek/0040?page=3D2
