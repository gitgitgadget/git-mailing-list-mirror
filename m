Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FA5C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 16:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiF1Qkh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 12:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239573AbiF1Qgc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 12:36:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C6C244
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:34:51 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j23-20020a17090a061700b001e89529d397so5355390pjj.6
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 09:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=x+ljXexd6pqRquODB3U9gXVWupTMH4zuui20yiJyXXo=;
        b=GHoYivIAttEOjSaFKu/FX4akJMq1j69tDDbGpBO+7U8FdccC4+jllSmfpcV/22JuvF
         m2qsji47Xo7M8ZyVI6KUdcY373oX6pbWWSPE1bkJY1+9OuXqOQwdlqI57+U4KyircifZ
         s3nw3Hk3KFTh6Y2NMcbpsN2c2q3mqASgprxa8uKneoia9gLUZDajkJ4DWaoh88GywrQT
         j6pb7hf85LiGNSQdr2BbzyuDzv73C+UUHhgfkHwa/2WAkygOAFfLpeHaonrE04qqJ3Ww
         xEbIfe0jTCzJYP1dhuoAvdgk5XBZDElXtT3f7S76tr2ZEqvYI2fHzfwjNE4SLlThbt2X
         gj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=x+ljXexd6pqRquODB3U9gXVWupTMH4zuui20yiJyXXo=;
        b=5C120CGp6kZykD5ujFymbldiNY6Ca2mN1y5zLXuOKDB9z+5UgAkhGHtg20PP36KdCE
         jY6nKdc/Tnfvc/uCQ/YAhMOGe0LybskJcdo47PQc+Z2+EpaZZsIsuLP/1F+Fn2IyNOcO
         yARnrfkzwFzDCK7nFBIZBWoMcIPVnxHBvK237S+/7yo8qV4/uIPv+0JFZe+qvqkpKETd
         cJKbVtfpd+kY89GUhgiXpav3FFDiUgwSCwfQDC7eFQXjPElm4UG3EEbE6on67ngh1hgD
         54xhHOLCvDPqf3QcLeGqGg4NztuHsPdiMxqZMNk7jkxlVgUb9I4/gsOU+c0MNdlRk2PQ
         JtnQ==
X-Gm-Message-State: AJIora/o2lN9aDlh8wfd0DsxRAedYGuPpd0hNvlb0dJDS8jdltqpuzNF
        cjR0gZPsC+07x/wkSuizeKXfvhRV/ynXfQ==
X-Google-Smtp-Source: AGRyM1uP1lkPOEj+VdF72RwDHKcZBgtqoTK9lIbS2dLVbmrJsfINoR3e7ixQe9gE5mnNTwqRLt1znBn9ObtoRw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4b48:b0:1ec:fc87:691c with SMTP
 id mi8-20020a17090b4b4800b001ecfc87691cmr518253pjb.120.1656434090940; Tue, 28
 Jun 2022 09:34:50 -0700 (PDT)
Date:   Tue, 28 Jun 2022 09:34:49 -0700
In-Reply-To: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
Message-Id: <kl6l4k04iw5y.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
Subject: Re: [PATCH 0/5] submodule: remove "--recursive-prefix"
From:   Glen Choo <chooglen@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason" 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> =3D Interactions with other series
>
> This would have been rebased onto ab/submodule-cleanup, but it's not yet
> clear to me if that series will be merged first. That series is almost do=
ne,
> but =C3=86var is still doing some digging on SUPPORT_SUPER_PREFIX [3] and=
 may
> come back with findings that affect this series.
>
> Fortunately, this series is only tangentially related to
> ab/submodule-cleanup, and the conflicts are quite simple:
>
> | this | ab/submodule-cleanup | resolution |
> |-----------------------------+-------------------------------+----------=
-----------------|
> | push --super-prefix arg | add new "ud" var | keep both |
> |-----------------------------+-------------------------------+----------=
-----------------|
> | remove "--recursive-prefix" | add "--checkout", "--rebase", | keep both=
 |
> | | "--merge" | |
> |-----------------------------+-------------------------------+----------=
-----------------|
> | add SUPPORT_SUPER_PREFIX | remove SUPPORT_SUPER_PREFIX | keep
> ab/submodule-cleanup | | to "git submodule--helper | from "git
> submodule--helper" | | | update" | | |

Hm, maybe I'm not using GGG correctly, but these whitespace issues seem
pretty common (Markdown collapsing the whitespace maybe?). Maybe I need
to blockquote the monospaced stuff.

Here's the original table:

| this                        | ab/submodule-cleanup          | resolution =
               |
|-----------------------------+-------------------------------+------------=
---------------|
| push --super-prefix arg     | add new "ud" var              | keep both  =
               |
|-----------------------------+-------------------------------+------------=
---------------|
| remove "--recursive-prefix" | add "--checkout", "--rebase", | keep both  =
               |
|                             | "--merge"                     |            =
               |
|-----------------------------+-------------------------------+------------=
---------------|
| add SUPPORT_SUPER_PREFIX    | remove SUPPORT_SUPER_PREFIX   | keep ab/sub=
module-cleanup |
| to "git submodule--helper   | from "git submodule--helper"  |            =
               |
| update"                     |                               |            =
               |

(For the org-mode users: org-table-align fixes everything except the
last row, presumably because of the rogue line breaks.)
