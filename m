Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA61C76195
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 09:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbjC1Jfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 05:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbjC1JfN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 05:35:13 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288836A75
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 02:34:17 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y15so14953244lfa.7
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 02:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679996047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q0n3FEnu4QczeBdIhoaeN/YFmVAHyflxgWVt387q3GQ=;
        b=cj70R5kaKyNrHeHtG8mkZ3JobK/7BexPxTrFMkOdsfCltzcPiBEu9z6K7Cv2DPykJJ
         VUsJrp6ajO04BJz2AugFrJ+Oj4wy0PxAeR31BgSpmLK5smeF7mqzpWQ3aAW2Q5K5RTWn
         EapwvZCbucXX/Gtgj1LvPh7Vs6hd8hLoc+heHOSdDsDh1cJ5Ea85zl64/XepM9vqridn
         vbSyipEvHBFM3g936ZqcA/HZcYStC01PxoBX74XLQj6XTyGab2IfhHm6n6PYunGa3h1O
         5qRF1WLbOVEhc2eac6YWKeOMkFVGmcj/yxkzEeUaTWBkbQCoSZ1EsLyAbkgXX1vq9g4n
         89FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q0n3FEnu4QczeBdIhoaeN/YFmVAHyflxgWVt387q3GQ=;
        b=V6q5L7Xfz/fNqNHfSzU+IRJchRedo78rwUwkDo9Yz+YfeZHOWKK1EMj90B7qwvN1uq
         YEtBll6bLQMXACShPyecGNlQPR6/JKzhY532aU3f54z+NMVzdvB63j517Dhe0UarasGP
         oMmULjnL++6JauJuTJepD5m1dKgOkDg6YNtD/vB0q3KfNWCJCqMXMy8zMajZLarUFylU
         sBgHpU5ihVSN3m9CLIxxtWsl3vHiFH/Ys6KKYSks97iatR7zUqODveCzZgQR9FaoYDzg
         QQxzZZ1ostsqrrl1N4AoaFJhWJp+O6Bpu/U12QpvvVDIv4tzq9dGlkvcfm1+imMuns5r
         vkvA==
X-Gm-Message-State: AAQBX9cHL8Z0+iWAqjl5YYr+oOHwUc/sBNbdcrTgNFIkFnGsX7yO0Ezd
        NqGicj2nZdB1k4VEfzqp8uBBEYJtk7jy6idVM9bPoVoEOHJoaA==
X-Google-Smtp-Source: AKy350Zr5sgKj6ZSkXiiiYe9HtG+BKcNPV76FkbOlROGADEuaLg4iNrhg/fDDTy4MbtpRSYaf8QHWXVIOdD2f1QZVRI=
X-Received: by 2002:a05:6512:4ca:b0:4d5:ca32:6ed5 with SMTP id
 w10-20020a05651204ca00b004d5ca326ed5mr4626889lfq.3.1679996047051; Tue, 28 Mar
 2023 02:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAMbUV8F8y62n5ud3AoWQak8J==Zrn7kzwTE7jCveVJEpfcqncg@mail.gmail.com>
 <CAPx1GvftGM2kpVL9JWWXrjyTRWs+6OxteoJDq9dgeOjuidUGwg@mail.gmail.com>
 <CAPx1GvfFrUQBDnJ9QYue91ScZb9ctB+tWv2S+pcprVC7dTgdxg@mail.gmail.com> <xmqqfs9wcush.fsf@gitster.g>
In-Reply-To: <xmqqfs9wcush.fsf@gitster.g>
From:   =?UTF-8?Q?Jan_R=C3=BCegg?= <rggjan@gmail.com>
Date:   Tue, 28 Mar 2023 11:33:55 +0200
Message-ID: <CAMbUV8Eoi2fkuG5jZhjCSaB51Dry+cEbSXfotxhVGPaxA7BB_A@mail.gmail.com>
Subject: Re: Destructive pre-commit behaviour and "--all"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Chris Torek <chris.torek@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Junio, Chris for the detailed explanations

> FYI, we tried not to do the extra re-reading, because pre-commit
hook was designed to be a mechanism to allow users to validate, but
not correct, what gets committed.

I see, and wasn't quite aware of this. The issue I see is that, in
contrast to what it was designed for, pre-commit is in practice used
to change files.

The pre-commit project, for example (https://pre-commit.com/) has many
hooks (as seen here:
https://pre-commit.com/#4-optional-run-against-all-the-files) has many
useful file-changing hooks. Small cleanup tasks like running code
formatters, fixing end of line spaces etc. are very useful to run
while committing. As this has become more common, also more dangerous
hooks are run as part of pre-commit, like ruff
(https://github.com/charliermarsh/ruff-pre-commit) which has pretty
heavy auto-fixes like automatically removing unused imports.

This is usually not a problem. When you add all your changes to the
staging area ("git add --all") and then commit, you will see what
additional changes happened in the auto-fixes during the pre-commit.
With a "git commit -a", however, this can potentially break your files
without you knowing what exactly was changed in your code. Since that
code was not committed or added to an index beforehand, it's
impossible to find out what the hook changed.

As a developer working on a project using "destructive" pre-commit
hooks, I was just wondering what can be done to make this "safer".
Looking at the issue and comments in
https://github.com/pre-commit/pre-commit/issues/1499 it seems the
pre-commit hooks themselves don't have a way to do that. So it seems
the only option to do this would be to add it somehow to git itself.

I was thinking of something like a setting "git config
commit.add_before_precommit_runs true" which would emulate the
behaviour of "git add --all && git commit". Or is there some other way
(in git, the pre-commit hook, or anywhere else) to make this existing
workflow safer without resorting to bash aliases and stuff like that?

Jan


On Wed, 22 Mar 2023 at 22:58, Junio C Hamano <gitster@pobox.com> wrote:
>
> Chris Torek <chris.torek@gmail.com> writes:
>
> > It would in theory be possible for Git to load *the* index twice,
> > once before and once after the hook, and compare them to see what
> > changed, then perhaps try to use that change to update the
> > additional indices.  That would be a pretty big change, but if it
> > were done right, it might get what you want.
>
> FYI, we tried not to do the extra re-reading, because pre-commit
> hook was designed to be a mechanism to allow users to validate, but
> not correct, what gets committed.  As the system originally was
> designed, users who correctly use Git would *not* be modifying the
> index.  Because it is an error to modify the index in the hook, (1)
> re-reading the index just in case the user commits such a mistake is
> waste of resources, and (2) checking the index to make sure it did
> not change before and after invoking the hook, again, is also waste
> of resources.
>
> It may have been a mistake that we re-read the index in some case,
> which adds to the confusion, but not others.
