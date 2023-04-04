Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117C6C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 16:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjDDQT4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 12:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjDDQTt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 12:19:49 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA02813E
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 09:19:48 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id cn12so132891557edb.4
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 09:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680625187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8I1NrWxwfdqtykyTIRQrKmuMiCfBT4uNbYHcOlOlIs=;
        b=ARuX67DB08aMtyxY576mYATtDy3jF4yv6Apk735gSqVMoq0aPed1/5J5cBBY0CF108
         PB+0VLqlRpXSY1KZPKX2LdlxhWHQ0BDN6y21/6CzUxACnXwdayeAxeM+Ju37vlepDXG1
         cXlkzpKZoX3b3PvA92GWqtLt7OfjhelYi12Xt67LOEEJTn5U9bj36YHwwSH8EjGERLoB
         /S2TJG6O89b+nx34lDGfQoyYMi/UfwnGbxYnK/pxLPt8kaZfxcTFtYcQ/JTqTSNz8OWs
         xffoQkqlbFGaMZNftQ7o1w+w0ws2fAG2Qh8X/TvFVsYkPF6IiRrXstaPlHwLj9CN8G88
         8/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680625187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f8I1NrWxwfdqtykyTIRQrKmuMiCfBT4uNbYHcOlOlIs=;
        b=X39McgGy5IuaCCKoLCANFgCbwM/9Jf99wsMjzjSki5Pw6hfiND8xDZogScNWlXZvx7
         bjpN1aqVjY2G8JIFbQ6L7z2nRmGr0bR3MSjQOuirZ7ivSHkndwgouy31ylqklCdms3N5
         MZzSKmVlrenZjVmMTQ1T/R2Ls0J4WBVqWSXf+fLC7EiLfLZDD3tqyuPTVMrm7WLyrRZd
         W/bxJ6+KoJARUR5KpV/7J8Ue9QAn2/dVoN5LjS4BV1KlFseU8LaAh/D/TZXJxfDkcfRT
         dE6XBnnndLnMh+Yt0P8J0mXPARVvAwI5M5+cdIFMXIjlI20VGcqIHX+EdIZ4jfXvy037
         uriQ==
X-Gm-Message-State: AAQBX9eNohF1rsuJZvPwvkRhgLqC0whe5M2CjPX0BtD/9tKg0ODSPsAr
        UAIoLIaouhFH9klXaKVCzzI39MVZQDOZl/Pj5HvlIsWPkeA=
X-Google-Smtp-Source: AKy350YWjfOKDExQOuVefkaXtC0FliqFpWVCDUEVv3ZI0Dr2WrKCCkjWBWFJFxZIVfatG+XC0jkFQf/5u8gSHMQ44R4=
X-Received: by 2002:a50:9ea9:0:b0:502:62ba:865b with SMTP id
 a38-20020a509ea9000000b0050262ba865bmr28408edf.3.1680625186904; Tue, 04 Apr
 2023 09:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAGP6POLrtA_9kjCwUbVB8-F+dgQbhz==oy5SsXULfspNj_Umuw@mail.gmail.com>
 <87edp0ak45.fsf@vps.thesusis.net> <CAGP6POLVpjxO91s1dX98TLepXMrybSWq9y8qJ6b7w+e0SRJT1A@mail.gmail.com>
 <CAGP6POJr63o67k+7BeokM-pkPbXYrQy4kcWwMXTfoeuFaPaADQ@mail.gmail.com> <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
In-Reply-To: <CAGP6POLx0+OhMJ9oqmK8R9Lq7tppC258NWHNFhqXMbO9smXd+w@mail.gmail.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Tue, 4 Apr 2023 09:19:35 -0700
Message-ID: <CAPx1Gvcz6f3AQJYfq7Sih0bL6pAi5mHZj8rj=kd7kRDWKLZEzw@mail.gmail.com>
Subject: Re: git revert with partial commit.
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Phillip Susi <phill@thesusis.net>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2023 at 9:00=E2=80=AFAM Hongyi Zhao <hongyi.zhao@gmail.com> =
wrote:
[various previous conversations and methods-that-work snipped]
> But I still wonder why the following method doesn't work:
>
> werner@X10DAi:~$ git revert f18fbd1e16a1ca4215621768d17858c036086608
> --no-commit -- Public/CTAN/IDE/phonon/compile-install-phonon
> Public/CTAN/IDE/texstudio-org/texstudio.git.sh
> fatal: bad revision 'Public/CTAN/IDE/phonon/compile-install-phonon'

Neither `git cherry-pick` nor `git revert` allow specifying files.

There are some terminology issues here that, if clarified, may
help you in thinking about all of this.  (Some of these may
involve language translation issues as well.)

In Git, a *commit* is an atomic entity consisting of two parts:
information about the commit itself (metadata such as the name
of the commit's author, some time stamps, and so on) and a
full snapshot of files.

A commit *is not* a *set of changes*.  It *is* a snapshot.  We
can form a sort of "changeset algebra" out of these things,
by which taking two snapshots and subtracting them produces a
delta, in the same way that taking two integers and subtracting
produces a delta:

    delta =3D v2 - v1

In this algebra:

    v1 + delta =3D v2

The same works in integer arithmetic, of course.  In integer
arithmetic, a sum of any set of deltas can be used as a new delta.
But this is not true of "source code deltas" since one delta may
show a file being deleted entirely and another delta may show
the same file being changed.  We lose some properties, such as
the ability to do order reversals (commutativity).  So we must
be careful to treat deltas as nothing but deltas, and snapshots
as nothing but snapshots.

Now, `git cherry-pick` means: given some commit, find its parent
(singular), then use that parent/child pair to compute a delta.
Attempt to apply *that* delta to the *current commit and working
tree* snapshot.

Similarly, `git revert` means: given some commit, find its parent
(again, singular), and use that parent/child pair to compute a
delta.  Attempt to reverse-apply that delta to the current commit
and working tree snapshot.

This kind of operation produces a new commit, so there's no such
thing as a partial revert or partial cherry-pick, at least in
terms of "things Git can do by itself".  But we, as humans writing
programs, wish to *achieve* such things.

It's probably wisest to avoid calling these things "partial
reverts" or "partial cherry-picks".  This is the terminology
issue: these phrases make sense to humans, but not to Git.  You, a
human, can achieve these results, but if you ask Git to do a
revert or cherry-pick, Git will attempt to do a revert or cherry-
pick -- not a "partial revert", whatever you mean by that!

To do what you want, you will want to:

 * compute the appropriate delta, then
 * pick and choose some part(s) of this delta to apply or
   reverse-apply

and there are many ways to do that, but none of them involve
using *only* `git revert`.

Chris
