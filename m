Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12243C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6E0606A5
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 13:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240387AbhHJN62 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 09:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233465AbhHJN61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 09:58:27 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F205C08EB1C
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 06:58:05 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id t35so1720729oiw.9
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 06:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vgy8S9Y9gDPSt2mEUgp7BZa/okDnQ5nSOCwiVqZGV3U=;
        b=bxva97SSA1GGfrjsqDBwnfNO7g8m/JkplSSuSdyMiM1Cyw13h1B9VWOORV34ypnIXc
         7NvGrfyNv9ofiQ/lQikggBLMUzbKjs81u0FW1x3Ecnv54NJBeZCQrWK+80meJLxfha1d
         1QLcaFoSPqf9tYAe/Q4Zg72FgwJRkRfDCVZEdOHWQURKUvWH798QJHRrbkWyYLumKKoj
         3daqsXWqtzYwmbkQpCV3uGnaVuPp9vGBjjdTR3oBA4INmJIUNwQaPKdUgY24zZIfiGYX
         OKtE5lSVCXcU4kcnFHloYXh1JafhyOi4e/ySiAXYVC+SHJs0cqLyVowMGXT5o7Y1JLML
         MxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vgy8S9Y9gDPSt2mEUgp7BZa/okDnQ5nSOCwiVqZGV3U=;
        b=ugGPFRfsreoIP1cTSNOHbJDH1pMLSK1mJCYiWJKJousWtoU9z9RaMAZLsM6g/sy+mg
         rX0Esx8qRGe5PuLjPwKTDBcCIzGWtrjSJUka2bWnoCbzeIzLgoP1pgkqKzkMlzc1A+M6
         GoCJOKr1zeDYXvFERA1Qi5lB/Ru8Zz2Wo5GUPCEyB08uTGcc2dabxSxnj/k8mArcGkQ7
         fC54Lt8+IiVEMWVts4NkINPxJozCmc/+5zWwHs/02WMEPveLdin1EbqVAtBAmydKe8eX
         BlTueJjm//ZGac47hodgf25JFpcGoDI8xkoGsISe5v6ycUHTVVqk9jqCUso+YqSKSB3V
         m0Kg==
X-Gm-Message-State: AOAM533urzjjBcOv9SIhZvnSnpHJU/p66gqsHXbk7Uczc2uJRJm0itHC
        x/3+VgVqLY/elPHPZWCLCj5gznicJwmMxzCuMeU=
X-Google-Smtp-Source: ABdhPJw0q7I6PaPWfsfAxYZwK27kG+4X0BDFF2tsHOAujDhkGzrFWWAIBbbwe7H0IZdBd8k3NWxBWbLb7FSN30PGZNw=
X-Received: by 2002:a05:6808:85:: with SMTP id s5mr134388oic.31.1628603884615;
 Tue, 10 Aug 2021 06:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAPkN8xJqqnJfdUM5fEEMA00JoKsFcqnQo--_qbCLAx1qXSrgdQ@mail.gmail.com>
In-Reply-To: <CAPkN8xJqqnJfdUM5fEEMA00JoKsFcqnQo--_qbCLAx1qXSrgdQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 10 Aug 2021 06:57:53 -0700
Message-ID: <CABPp-BH4dcsW52immJpTjgY5LjaVfKrY9MaUOnKT3byi2tBPpg@mail.gmail.com>
Subject: Re: Working with git binary stream
To:     anatoly techtonik <techtonik@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 9, 2021 at 9:16 AM anatoly techtonik <techtonik@gmail.com> wrote:
>
> Hi.
>
> In https://lore.kernel.org/git/CAPkN8xK7JnhatkdurEb16bC0wb+=Khd=xJ51YQUXmf2H23YCGw@mail.gmail.com/T/#u
> it became clear that it is impossible to make fast-export followed
> by fast-import to get identical commit hashes for the resulting
> repository (try https://github.com/simons-public/protonfixes).
> It is also impossible to detect which commits would be altered
> as a result of this operation. Because fast-export/import does
> some implicit commit normalization, fixing that probably requires
> too much effort.
>
> As an alternative it appeared that that theres is also a
> "git binary stream" log that is produced by
>
> git cat-file --batch --batch-all-objects
>
> Is there a way to reconstruct the repository given that stream?
> Is there documentation on how to read it?

Peff already responded about hash-object.  And pointed you, again, to
the manual for cat-file.

Can I suggest an alternative, even if it changes the problem statement
slightly?  For some reason you didn't like my
--reference-excluded-parents suggestion, but there's another way to do
this as well with fast-export and fast-import as they exist today: use
fast-export's --show-original-ids flag.  With that flag, you'll know
the original hashes.  And if your filtering process does not modify a
commit nor any of its ancestors, it can simply omit that commit (i.e.
not pass it along to fast-import) and replace any references to the
commit with a reference to the original hash.  So, for example if the
`git fast-export --show-original-ids ...` output looked as follows (a
simple repository with just three commits for demonstration purposes):

"""
reset refs/heads/main
commit refs/heads/main
mark :1
original-oid 81b642ea15a614e84cdd52514a963735426ab06c
author Developer Name <developer@foo.corp> 1628603376 -0400
committer Developer Name <developer@foo.corp> 1628603376 -0400
data 35
First commit, which was gpg signed
M 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 fileA

commit refs/heads/main
mark :2
original-oid 0024a18e9bfef3fd1091305cef4dd5a789164809
author Developer Name <developer@foo.corp> 1628603396 -0400
committer Developer Name <developer@foo.corp> 1628603396 -0400
data 14
Second commit
from :1
M 100644 f2e41136eac73c39554dede1fd7e67b12502d577 fileA
M 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 fileB

commit refs/heads/main
mark :3
original-oid 96efb1173ad5c037f03f3639976f2465b1c58186
author Developer Name <developer@foo.corp> 1628603422 -0400
committer Developer Name <developer@foo.corp> 1628603422 -0400
data 13
Third commit
from :2
M 100644 f15bf479158b73b9bb79e158ce93d75190bc9597 fileA
M 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 fileC
"""

Then we'd parse the first commit, decide we didn't want to filter it,
note that we hadn't filtered it or any of its parents, and then decide
to replace any references to ":1" (the stream's name for the
replacement for that commit) with
"81b642ea15a614e84cdd52514a963735426ab06c" (the original hash).

Then we'd parse the second commit.  Perhaps on this one we decide we
want to remove fileB.  So we output it after removing the fileB line,
and after replacing ":1" with the appropriate hash.

Then we'd parse the third commit.  We decide we don't want to change
this one, but we did change the second commit (the one with "mark
:2"), so we still have to output it.  There are no direct references
to :1, so we don't need to update those either.

In the end, we'd pass this stream to fast-import:

"""
reset refs/heads/main
commit refs/heads/main
mark :2
original-oid 0024a18e9bfef3fd1091305cef4dd5a789164809
author Developer Name <developer@foo.corp> 1628603396 -0400
committer Developer Name <developer@foo.corp> 1628603396 -0400
data 14
Second commit
from 81b642ea15a614e84cdd52514a963735426ab06c
M 100644 f2e41136eac73c39554dede1fd7e67b12502d577 fileA
M 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 fileB

commit refs/heads/main
mark :3
original-oid 96efb1173ad5c037f03f3639976f2465b1c58186
author Developer Name <developer@foo.corp> 1628603422 -0400
committer Developer Name <developer@foo.corp> 1628603422 -0400
data 13
Third commit
from :2
M 100644 f15bf479158b73b9bb79e158ce93d75190bc9597 fileA
M 100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 fileC
"""

and it'd recover the original commit as you wanted.

This does presume that you're importing into the original repository
(or a clone --mirror of it), because it expects certain hashes to
already exist.  And when importing into such a repo, you want to use
--force with fast-import.  But it should do what you're asking for,
without needing to do any extra work in fast-export or fast-import.
