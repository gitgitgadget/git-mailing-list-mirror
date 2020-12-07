Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7817C4361B
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BCA8221EC
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 07:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgLGH3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 02:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgLGH3P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 02:29:15 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B09C0613D0
        for <git@vger.kernel.org>; Sun,  6 Dec 2020 23:28:34 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id ce23so14251915ejb.8
        for <git@vger.kernel.org>; Sun, 06 Dec 2020 23:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jXd4YlYRGHHC1ELVpJUTq+uOJKFXVwsWL1MYZzcYxgA=;
        b=cJhec/9w33TE9g28nQi9ScnL7xWGBmsOLvdumBTjY9Ltfg3S8R5N5CdLfXv9R6rSVd
         6zSa1wfRMtuDA9iRqzr+cCoiG+arDmElOmZsSZ7vQEkZ05xxs4uT+xOG44W6Po/IkASA
         d/kS09dCI1BjN0pWoLdalVD5wskywoe//+vFcOpsfjV9kehUtM0c0pr8/gxHWqT7X4Z4
         AkdcCbdEG6fOMdK+iMoUffbALjGmuEC5zmOBWpW+VLYTVn1fIg1JMxuuYxKwijWfjYik
         7K5eAu2Ruo5g0ch4WEvfZYRYhHwRimReOPpkGjP+0L1eFv28KBNbhk3JmyWSUG2sNS5o
         bhww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jXd4YlYRGHHC1ELVpJUTq+uOJKFXVwsWL1MYZzcYxgA=;
        b=I17/1hhtH7ol+FB+uA2LXYp4z7koG2u/AsTdWPmzBM9gGiQlirNh3I6FrZj7muCK4X
         gEYft9ve0DmrXJuqxvIqjQJpYvSoY3IcSDN/l2ptv5JRAgE8wV00g6wEDZRKbWJjmcJc
         tj/SzTh6tYCXklvWr2A3g7yCC4qQgAzdmWTr6xCJTyCoxoL3pme1LVMnjnTLS4dqXbcf
         6pp1kjlJ79qDJrvNoEOp3khUTH3sRq7IpC4beHaLp3pMm0qn6qyV053q0H/Jhto8q3GC
         S6wwjuLjyjkwHQ2fu+jZx35EKq2Nsvgu/JQiJ/htPcU0HxIK/xL7Rzueup5WQmuQKoOO
         vZlg==
X-Gm-Message-State: AOAM530ZAMrF1KyRnhqLHGRTTdqKL9qourWjWZZE1QmdFtteMG8w0NR0
        X2ylYpBayRkY3v9z8mtj5codGr0f4w==
X-Google-Smtp-Source: ABdhPJzJ3369GJUIe/EIZ6labcuzHF4fTZzw5hjqA2H6vSM0GKtJDSYsvw+YpzI5CgqLYdixX70fcw==
X-Received: by 2002:a17:906:cec3:: with SMTP id si3mr17568270ejb.277.1607326113433;
        Sun, 06 Dec 2020 23:28:33 -0800 (PST)
Received: from [10.81.83.87] ([83.137.6.189])
        by smtp.gmail.com with ESMTPSA id u23sm11058477ejc.46.2020.12.06.23.28.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Dec 2020 23:28:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: GIT_DIR output from git worktree list
From:   =?utf-8?Q?Ganriel_N=C3=BCtzi?= <gnuetzi@gmail.com>
X-Mailer: iPhone Mail (16G192)
In-Reply-To: <CAPig+cTsEx-puHn1N2=fBVAgdvc7cutCDTC7vBJuLm5utObfJg@mail.gmail.com>
Date:   Mon, 7 Dec 2020 08:28:28 +0100
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A462326B-505D-4A92-B789-21BB8FE6AA16@gmail.com>
References: <CAA9rTudStQOK7kRa6jYJHE3D3grnFF3idQe65h9t6oJB30xa1A@mail.gmail.com> <CAPig+cTwNwt+_f4FYDqy5xVsDVU3pqfKXtK6GKtWLLqbU6Y8Vg@mail.gmail.com> <CAPig+cTsEx-puHn1N2=fBVAgdvc7cutCDTC7vBJuLm5utObfJg@mail.gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of your rational, wouldn=E2=80=98t it be good anyway to have a file =E2=80=
=9Eworktree=E2=80=9C inside the .git dir (of the worktree) containing the pa=
th to the main worktree? So to speak any worktree always has a .git dir with=
 a back link to its main worktree (the existence of the git dir might pose o=
ther problems?)=20



Von meinem iPhone gesendet

> Am 07.12.2020 um 05:34 schrieb Eric Sunshine <sunshine@sunshineco.com>:
>=20
>> On Wed, Sep 30, 2020 at 1:33 AM Eric Sunshine <sunshine@sunshineco.com> w=
rote:
>>> On Tue, Sep 29, 2020 at 1:31 PM Gabriel N=C3=BCtzi <gnuetzi@gmail.com> w=
rote:
>>> When you do move the .git folder somewhere else:
>>> git init Test && cd Test && mv .git .git-b
>>> git --git-dir=3D.git-b --work-tree . worktree list
>>> the output is :
>>> ..../Test/.git-b  0000000 [master]
>>> Why is the output a .git Dir and not a worktree. I expected `.../Test`.
>>=20
>> I suppose one way to fix this would be to specially check if
>> --work-tree or GIT_WORK_TREE is specified and use that value as the
>> path of the main worktree. (This special case would only be used when
>> computing the main worktree path; it would not be used when computing
>> linked worktree paths.)
>=20
> Fixing this is more complex than it seems at first glance. In fact,
> I'm not sure there is a good fix at present without somehow recording
> the location of the main worktree somewhere.
>=20
> The problem is that determining the location of the main worktree by
> consulting --work-tree or GIT_WORK_TREE when listing worktrees would
> only give the desired result when `git worktree list` is run from
> within the main worktree. If it is run within a secondary worktree,
> then neither --work-tree nor GIT_WORK_TREE would be referencing the
> main worktree (at best, they'd be referencing the secondary worktree),
> which means that they would not help in determining the location of
> the main worktree, thus `git worktree list` in a secondary worktree
> would give different output.
>=20
> Consulting core.worktree _may_ be doable, but it's iffy and would be
> extra complicated because that configuration value is treated
> specially. In particular, the value of core.worktree of the main
> worktree is intentionally hidden from secondary worktrees. So, while
> it _may_ be possible to write special-purpose code to go and seek out
> the value of core.worktree for the main worktree by manually
> spelunking various configuration files, it would be complicated. In
> fact, it would be doubly complicated because it would require two
> distinct implementations: one for when extensions.worktreeConfig is
> enabled and one for when it is not.
>=20
> The fact that the output of `git worktree list` would differ depending
> upon whether it is run in the main worktree or a secondary worktree
> (and whether core.worktree is configured or --work-tree or
> GIT_WORK_TREE is used) makes me quite hesitant about these approaches.
> I worry that such inconsistency would be perceived as instability, as
> well as making it difficult to script `git worktree` reliably.
>=20
> So, at present, I think any solution which can produce reliable,
> consistent output may need to record the path of the main worktree
> somewhere, but I haven't thought too deeply yet about how to do that
> cleanly (while also taking other Git implementations into account).
