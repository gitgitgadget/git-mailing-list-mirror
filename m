Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E08C25B50
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 20:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233023AbjAWUMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 15:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjAWUMt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 15:12:49 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F9893F8
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 12:12:47 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id bk15so33540914ejb.9
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 12:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dOsdRQpqJFs0/5ff33ZUqdpUbD6LUz3XNHbgW+oH6o=;
        b=P7W3m8o1F6NUwPHTa6c4FpeK3k9qP1wdvdTsfeiM9vHpPTydhizSSm/IFt787GRzdQ
         Ok6ZtAChGw390mK2RN7urjVhWOOB64b3AY/tNpOmIgTYSxuDlNPMlY7F61LfKMKygh/W
         u7JKPv+2NKGCLPPHOngxSMwgdNUnmvqKFHSxcWBDvnt0P/gOAiJjutfhh2QHRWJxDYSU
         4BF+qP1rQ/qlxJ4z99wrMybvnpolmfQDIOqtpBXSVXlnfe//BuG0UZI4onOv3T2P6zpF
         EJlrYQ28PoAE1sNl/iCb173Xelo4xIQhz5atHgMsc9q/U8IRHabDYJUXXznryfHm2OZq
         Mx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dOsdRQpqJFs0/5ff33ZUqdpUbD6LUz3XNHbgW+oH6o=;
        b=kQ6dsrgBh/XFnaaRGxa26EOyKzv4lrJOq7O7AZGCIzLEVuWfQjyTowjcJq5+03D8yn
         wUQie9yC91x5WLXRcOYpVJpxC5tQ/t/lv2vRvhDKWCwe0GCFrFNVbtPiSNaqdgKNjHyq
         2YmZNt9N13LDxy3criT1vW6zZSLSXyR1nVX1MpSym/Z1WK4WXjzQNcgCOISHo/srkyKD
         frivkhDGhPDPqZzsn7yCsByhhWf610LB1DW/MFyKj/0XKGxwOeuiZdr1rSatUiSF7zYT
         I3v6fupO2nYU2DPKfzkjDlajdWJKol705bCp0xSJ/vVFLYDGjn1EIJlz/hrF+9tgUmRA
         xwLQ==
X-Gm-Message-State: AFqh2krPx3jDXLLXN6W3dKJV+2cAXA5zBRC38Bx0+2arvKWiQ7cHSmwu
        +aslz6zJ/hfhxGZi71eySyXpl/Y745NHdV/KyD1V8JlLxd80HPHi
X-Google-Smtp-Source: AMrXdXsY0NeaqptMZEPAa9u198CjF3drRA/Lu1igdKkZ5NnDr/qJ0VZ3TIFDau2A/fcBj6M+sA2zmsY8y2FN9rkeq8c=
X-Received: by 2002:a17:907:175a:b0:86f:5319:c584 with SMTP id
 lf26-20020a170907175a00b0086f5319c584mr1846843ejc.359.1674504765517; Mon, 23
 Jan 2023 12:12:45 -0800 (PST)
MIME-Version: 1.0
References: <1716310675.20230122233403@inbox.ru>
In-Reply-To: <1716310675.20230122233403@inbox.ru>
From:   Emily Shaffer <nasamuffin@google.com>
Date:   Mon, 23 Jan 2023 12:12:32 -0800
Message-ID: <CAJoAoZkjfOQwkeQqzQY5qDo7Md5QWSz1pOTBQKHL5KwNu2VoDg@mail.gmail.com>
Subject: Re: nested submodules detection w/o .gitmodules file
To:     Andry <andry@inbox.ru>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2023 at 12:45 PM Andry <andry@inbox.ru> wrote:
>
> Hello Git,
>
> I have a pretty long investigation has been started from usage 3dparty pr=
ojects related directly or indirectly to the git submodules:
>
> `svn externals replacement` : https://github.com/chronoxor/gil/issues/6
> `svn complete replacement for externals` : https://github.com/dirk-thomas=
/vcstool/issues/243
>
> And stumbled on this discussion:
>
> `nested submodules detection w/o .gitmodules file` : https://github.com/g=
itextensions/gitextensions/discussions/10644 (https://github.com/gitextensi=
ons/gitextensions/issues/10642)
>
> The main question here is that, could the git have has submodules without=
 `.submodules` file?

There is a little nuance here. Git can have nested repositories in a
few different ways; submodules are just one of them. A submodule is
the combination of a gitlink object in the object graph *and* a
corresponding entry in the .gitmodules file. It's certainly possible
to embed a nested repository in other ways, such as by ignoring the
.gitmodules file, but then your nested repository is no longer a
submodule, and operations which recurse over submodules will not
consider that nested repository. The reason is that we need to
understand where to clone the submodule from - that information isn't
contained in the superproject's repository URL, and it can't be
contained in the gitlink directly (which is in essence just a commit
object, but one that exists in the nested repository, not in the
superproject repository). If we didn't have a way of writing down the
submodule's remote URL and version controlling it, we wouldn't have a
way to populate the submodules when a user is cloning.

>
> If no, then all side projects which utilizes it's own input file for the =
externals may subsequentially fail:
>
> https://github.com/chronoxor/gil
> https://github.com/dirk-thomas/vcstool
> https://github.com/ingydotnet/git-subrepo
>
> If yes, then other projects which does rely on the `.submodules` would ha=
ve not actual or even invalid state:
>
> https://github.com/gitextensions/gitextensions
>
> Or even the github itself:
>
> `Zip archive to include submodule` : https://github.com/dear-github/dear-=
github/issues/214
>
> (`[PATCH] archive: add =E2=80=93recurse-submodules to git-archive command=
` : https://git.github.io/rev_news/2022/11/30/edition-93/, https://lore.ker=
nel.org/git/pull.1359.git.git.1665597148042.gitgitgadget@gmail.com/)
>
> Mine point here is that:
>
> Git database is a primary storage. The `.gitmodules` file is not a primar=
y storage, so can be in not an actual or desync state with the database.
> And any application or a 3dparty project must read the database directly.

The .gitmodules exists to help at clone time; it's possible, as I
think you're pointing out, to have some intermediate state locally.
But this file is what needs to be the source of truth for putting
together the repository on a new machine for the first time.

>
> But another problem here is that the git still does not have a stable API=
 for that.
> For example, a submodule can be declared directly from the `.git/config` =
file in a working copy:
>
> https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-in=
it--ltpathgt82308203
> https://git-scm.com/docs/gitsubmodules#_active_submodules
>
> So, who is right and what is wrong here?
>
