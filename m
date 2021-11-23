Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF55C433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 01:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbhKWBtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 20:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbhKWBtF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 20:49:05 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC87C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:45:57 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id v1so51340231edx.2
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 17:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jlVKAA0NQQlxY7NprAfqF4VA2Q9YWHDIYe5+uvurNpA=;
        b=lXqAxnCZWbzbYYbQ2uwMW6g8OXfbRE3iS9v7rRKt6Gqw4z02nBXEpksZ7apLLDWinX
         xKYAHO6eXtY5a9Bzh0bf6+G43ctjHpTp5rR7qbSBL7Z0nAYBUJtn5a8T+nDo4joKLuO8
         UY5jH0S1tlpllEr8uWbZCRwaTN5yfn73k/K0OYkOn3fFmMdGTxFJt8FZUfYMkCl3f/nn
         /ACj28nAbutER4wMqV/jwElLhRp7/PDiBbAYz0t1nxUp1L7zxllfcAATYOp+0d5hbPpv
         yU93TjSwI7A4H81CxOU2TqghPN+3llzRhcYNY3LnIT5sH4YmbFdyoAVeNPCAniGUz7qa
         jx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jlVKAA0NQQlxY7NprAfqF4VA2Q9YWHDIYe5+uvurNpA=;
        b=VEBaxgVgY6URFc74sc3roAGq1PoqgNauP98ZCTwqaSMGL5SoW8wn9ZTu241JpsiOvM
         3bjsK7RUyzWNr0sN20HhlPDJJ+JzWg01bvizpvQHwQAwEDRVqbvditVw5HHvHS0mJnXJ
         y9Yj7OyaKGghER0gHza9Seovd59cZRi7bVG/V+EN6+yhLtYLLhit643d4nQQn2ky5vC5
         dCtOkTCJO9Wg48qsWsALKZ2a2wUl0yfRORLxPFFnDGN8VZDRpsjsEAX7BShpl/UNyCyD
         N7m5QV0Z73jHLgaUiG+4sZsvbcZ/a7dTPhsyb9//uAQ4yV4TjtPNWg4IRFy2fteiIxWe
         kE1Q==
X-Gm-Message-State: AOAM5333/GrPLLAUbqJCAnzy2eoMCrBPEkMGSuW5xNIYaRqJW9b1Dgxj
        X1JhWbPGGinQHPnREWo6Ghgx4SndJrozoMBPFUA=
X-Google-Smtp-Source: ABdhPJwRPG5qmkvHrI9+sbuHr/9t4flFgeFGW9yo35Frlu/aRUumlai9HQKeB2DKlD/pfYGCubCFynUOZgcTZDDAFc0=
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr2535529ejy.443.1637631956435;
 Mon, 22 Nov 2021 17:45:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <0b71996a3b462d4147fb792b20057544b9ef1710.1637455620.git.gitgitgadget@gmail.com>
 <211121.867dd11jbl.gmgdl@evledraar.gmail.com>
In-Reply-To: <211121.867dd11jbl.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 17:45:45 -0800
Message-ID: <CABPp-BEp3OL7F2J_LzqtC-x-8pBUPO8ZR1fTx_6XbqZeOH1kRw@mail.gmail.com>
Subject: Re: [PATCH 1/8] t2501: add various tests for removing the current
 working directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 9:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Sun, Nov 21 2021, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
>
> > +test_expect_failure 'checkout fails if cwd needs to be removed' '
> > +     git checkout foo/bar/baz &&
> > +     test_when_finished "git clean -fdx" &&
> > +
> > +     mkdir dirORfile &&
> > +     (
> > +             cd dirORfile &&
> > +
> > +             test_must_fail git checkout fd_conflict 2>../error &&
> > +             grep "Refusing to remove the current working directory" .=
./error
> > +     ) &&
> > +
> > +     test_path_is_dir dirORfile
>
>
> I'd find this & the rest of this series much easier to understand if we
> started out by positively asserting the current behavior here, and
> didn't test_cmp/grep for erro r messages that don't exist anymore.

Yeah, this is my fault for my bad commit message.  I stated I was
adding tests checking for the problems of interest, making it sound
like I was testing existing behavior, but I should have stated I was
adding tests with the behavior we'd prefer to have (i.e. basically a
test-driven-development) setup.

Also, there really wouldn't need to be so many tests for describing
the existing behavior.  It's basically just `git
$OPERATION_THAT_REMOVES_CWD_AS_SIDE_EFFECT` followed by nearly any
other git command will cause the second and later commands to fail
with:

```
shell-init: error retrieving current directory: getcwd: cannot access
parent directories: No such file or directory
fatal: Unable to read current working directory: No such file or directory
```

However, we do need a lot of tests for corrected behavior, because
there are so many different codepaths we can follow which will lead to
deletion of the current working directory.
