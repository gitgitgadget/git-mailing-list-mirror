Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B819C4332F
	for <git@archiver.kernel.org>; Wed, 14 Dec 2022 01:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236492AbiLNB2O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 20:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiLNB2M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 20:28:12 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718222BF6
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 17:28:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so5523209pjd.0
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 17:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5Dw59Im9jWH8ljHziYe3vkGfE+eMkxeMfU/+G0VICs=;
        b=ZBuUtW5CIusKC8iOlmbxOdVpKNdeNylzWMSG+NOltB5Yk+rVVUYzpBJScsfSb7+1/5
         a1ySpG3SfMMAmXc3QPQ6pcN32IQongpQCB/NxcLNoYGSLuLicV6PohpqLYhTTtBL4ahV
         PqI2kzdLB1toEhAtEGb2NOGKIp48XQybPYNNeBf/GUB6HP2XoeA9ARewS9gJ2K9W8lPo
         VM/Vb2Q8CA/P7pJj6kFp0qXCeH830zYSrIgMf6yHrHKGNL4Uh4H7sQDKHf/yLHHPN5ei
         moxSnJEbiLgaOxG/mZoEU3ZKxJOAUEB/aKypHiUxQW1T2I5cWdADBbEJC1ANzaGkVZZ+
         wANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=D5Dw59Im9jWH8ljHziYe3vkGfE+eMkxeMfU/+G0VICs=;
        b=FPo/nFqD6JQmKTrmLlknaqXZ/XZw2a8OoJiQMB3E5f+DtbPzXuCnWm7V1pA+iW5lzE
         I+t8UxhnHKZ3MNo+noWxLOqL00IMoUGKP0KYtTccvM1BWPlYgiD67tVEdBn46hCoBnfE
         760VLZ8TJhOV/47s0BwoXMSgMi94gAa2VUuZm7vfi0NR+UOyuXlSU1IWGMKd9qoG+kzh
         sMfN6NSlAkjGuDdTo2iOX+UBAtjU042p434RIN4I/Hg2zyRS4HyoeuWlVA9F6uDTQxZr
         xTJ4nNKudC+mVueYMRnNpHLES3VAn5yVy1T5U/XYL2cs6ry91ezqbpH/U0WTHpc1RpmR
         637Q==
X-Gm-Message-State: ANoB5pm3jHA6MP1cdaBdFroQZSxWLBmTdcI3ynovhLG0jsHpCoPgUMH0
        kz4VQE3MRNuYrk7HJHy72YU=
X-Google-Smtp-Source: AA0mqf72znsP1HVXm0wQiFW+UjrXgIVdk4Zgh1pQCv4QaJn6oeLM5voBaavuwlfo+rU3Jflta+5/fQ==
X-Received: by 2002:a05:6a20:3d0c:b0:ad:eac2:25e7 with SMTP id y12-20020a056a203d0c00b000adeac225e7mr4518311pzi.30.1670981288288;
        Tue, 13 Dec 2022 17:28:08 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id a15-20020aa7970f000000b005768b4f2d0dsm8289607pfg.64.2022.12.13.17.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 17:28:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Subject: Re: [PATCH v2 2/2] attr: add flag `-r|--revisions` to work with
 revisions
References: <20221209210321.709156-1-karthik.188@gmail.com>
        <20221209210321.709156-3-karthik.188@gmail.com>
        <674caf56-940b-8130-4a5e-ea8dc4783e81@dunelm.org.uk>
Date:   Wed, 14 Dec 2022 10:28:07 +0900
In-Reply-To: <674caf56-940b-8130-4a5e-ea8dc4783e81@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 13 Dec 2022 15:18:52 +0000")
Message-ID: <xmqqzgbqydso.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> I've got a couple of comments below about the details of the
> implementation but the basic idea seems reasonable.
>
> On 09/12/2022 21:03, Karthik Nayak wrote:
>> Git check-attr currently doesn't check the git worktree,
>
> Normally worktree refers to the directory on disk where the
> repository's working copy is checked out. Here you seem to mean
> something else.

Strictly speaking, what you just said is "working tree".  The term
"worktree" in Git's context yet means something slightly different.
You can arrange to have multiple working trees attached to a single
repository, and each of these is called a "worktree" attached to the
repository.

In any case, thanks for pointing out that the original's wording is
wrong.  It is natural to read it to claim that we do not check the
.gitattributes files that are checked out in the working trees,
which is utterly incorrect.

>> it either
>> checks the index or the files directly.

> This means we cannot check the
> attributes for a file against a certain revision.

Whenever one is tempted to say "This means", one should realize that
one does not have absolute confidence in whatever written before it,
in other words, without additional explanation, one suspects that
what one wanted to say would not be understood.

A good piece of advice for such a person is to try rewriting WITHOUT
anything before (and including) "This means".  And I think this is a
good example to which the advice applies well.

    There is no way with "git check-attr" to apply attributes from
    .gitattributes files recorded in the same treeish to paths in a
    treeish object.

Our usual preference is to (1) start by describing the current state
and (2) propose what can be done by deviating from it, in that
order, so one might write it like so:

    The contents of the .gitattributes files may evolve over time,
    but "git check-attr" always checks attributes against them in
    the working tree and/or in the index.  It may be beneficial to
    optionally allow the version of .gitattributes found in the same
    commit when checking the attributes for paths in an older commit.

By the way, applying the attributes from the working tree is by
design and it should stay to be the default.  People are almost
always working near the tip of the history, and working tree files
are by definition ahead of any committed version---it is a feature
that users can correct attribute definitions in their working tree
files and then apply them to paths in the committed version.

>> Add a new flag `--revision`/`-r` which will allow it work with
>> revisions. This command will now, instead of checking the files/index,
>> try and receive the blob for the given attribute file against the
>> provided revision. The flag overrides checking against the index and
>> filesystem and also works with bare repositories.
>
> The system, global and the attributes in .git/info/attributes from the
> filesystem are still used. It would be useful to document that and
> explain in the commit message why that is useful when using -r.
>
> -r is documented as accepting a revision but actually accepts any
>  tree. That means a user can pass "-r HEAD:subdirectory" and all the
>  attributes will be looked up as if subdirectory was the root
>  directory of the repository which might be confusing. It would be
>  helpful to know if passing a tree rather than a revision is
>  useful. If it isn't then you could use lookup_commit_reference() to
> ensure the user passes a revision.

Unless you use ancestry relationships in any way [*], you do not
want to require commits when an operation only requires trees.  In
this case, taking tree-ish and documenting it as such is the right
thing to do.

[Footnote]

* A good example that makes sense to limit to commit-ishes is when
  merging two histories (without requiring the user to supply the
  merge-base). You'd need to compute the merge-bases, so you require
  two committishes and it is not enough to take two trees.
