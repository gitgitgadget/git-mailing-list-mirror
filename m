Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EFFC4332F
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 20:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLOUUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 15:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLOUUn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 15:20:43 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B81E17426
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 12:20:41 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id p24-20020a0568301d5800b0066e6dc09be5so166758oth.8
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 12:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mvYEYI0bW6YXcPGx6k0HF6f+E5TFQouZYTRvghiu7W8=;
        b=IS9mzExq83ZpyGbBwVRnjQXUBDNVQghWWnPY3oTo0NJgbdKGoceucZwDm4nFKKVYTc
         iWO+Qtv/EoFE9yWOl4nLZ2e2nbC1gmNCUW90IhhUtC3840WWxDtpxYvpk+3Ezr2eeNPT
         25yYN5P/ZV01hUxm+TfUB6z893J08Zt/pbHt7GL/xMOHWlUVe0b0ZMXJcQDMrL4/6qQZ
         cHqwxCYHClPs6YaopnCOOGVtpBoih1l6GU6LDKpFlF/20qQA8/4qKgAgmx0ycghBe/m3
         DGdHh3n5quzImY3fXVChkLSW61N/E1jlEqfSz+UQRx6u325cNdykowX6R0X7nLUcJq2B
         WC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mvYEYI0bW6YXcPGx6k0HF6f+E5TFQouZYTRvghiu7W8=;
        b=B4g2WlHyLykbOf211fzHevPlhJoyMaOTfIM4sx5QZ2PdxxM8WNindrpsOIOMcLAZ5p
         DRkQnxgedKsG57tW9LOYTe19ebIQZIKLP2ormDBsDPzr5RhLeWj3Irtqa3qI3nJsMvLq
         DDeNtl6lLVVKCvWfdn5Zqj37VTd0U9HEI0PwncoUWGapjk/M/WwDuKHT/HzyvWYqhbxK
         3HUIPlWiooBhmRfIqnf7fsd596flIAzkzgiHOyjbXbM+rTIBhXGdBxC+wGLHz3mTIj4c
         AmOzIlwdj+ZIX9jXuK1Be45bmB39/U/ba5gq0BMQI1gWBfr8PRD9ZVXiDAoE8P+PnlaE
         gI3A==
X-Gm-Message-State: ANoB5pl7lONthQtrOANeAGsPij7tWYLFJihi5GhDKZZuhxdtj6k6HCEu
        j9Yo/vD469RgDBueERjmZosDGXP4K+JECfov2dkBSP0W/JqprA==
X-Google-Smtp-Source: AA0mqf5hQu7E+xZzwxpJX8IaMi7oIAgCWLoY8Yx+pCd8D9FqsD+g+fB1qBd84ly1s7TXiBXujHDMXeVQfo7zENBC2FQ=
X-Received: by 2002:a9d:7656:0:b0:663:c86f:7573 with SMTP id
 o22-20020a9d7656000000b00663c86f7573mr40353736otl.187.1671135640458; Thu, 15
 Dec 2022 12:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20221209210321.709156-1-karthik.188@gmail.com>
 <20221209210321.709156-3-karthik.188@gmail.com> <674caf56-940b-8130-4a5e-ea8dc4783e81@dunelm.org.uk>
 <xmqqzgbqydso.fsf@gitster.g>
In-Reply-To: <xmqqzgbqydso.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Thu, 15 Dec 2022 21:20:14 +0100
Message-ID: <CAOLa=ZQ2CKcKNOq3AvZHWxKW_L=zLTJXGEGkUbCSYUmBRMDRZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] attr: add flag `-r|--revisions` to work with revisions
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 14, 2022 at 2:28 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > I've got a couple of comments below about the details of the
> > implementation but the basic idea seems reasonable.
> >
> > On 09/12/2022 21:03, Karthik Nayak wrote:
> >> Git check-attr currently doesn't check the git worktree,
> >
> > Normally worktree refers to the directory on disk where the
> > repository's working copy is checked out. Here you seem to mean
> > something else.
>
> Strictly speaking, what you just said is "working tree".  The term
> "worktree" in Git's context yet means something slightly different.
> You can arrange to have multiple working trees attached to a single
> repository, and each of these is called a "worktree" attached to the
> repository.
>
> In any case, thanks for pointing out that the original's wording is
> wrong.  It is natural to read it to claim that we do not check the
> .gitattributes files that are checked out in the working trees,
> which is utterly incorrect.
>
> >> it either
> >> checks the index or the files directly.
>
> > This means we cannot check the
> > attributes for a file against a certain revision.
>
> Whenever one is tempted to say "This means", one should realize that
> one does not have absolute confidence in whatever written before it,
> in other words, without additional explanation, one suspects that
> what one wanted to say would not be understood.
>
> A good piece of advice for such a person is to try rewriting WITHOUT
> anything before (and including) "This means".  And I think this is a
> good example to which the advice applies well.
>

I agree with what you're saying here. I think that's excellent advice,
too. Thanks!

>     There is no way with "git check-attr" to apply attributes from
>     .gitattributes files recorded in the same treeish to paths in a
>     treeish object.
>
> Our usual preference is to (1) start by describing the current state
> and (2) propose what can be done by deviating from it, in that
> order, so one might write it like so:
>
>     The contents of the .gitattributes files may evolve over time,
>     but "git check-attr" always checks attributes against them in
>     the working tree and/or in the index.  It may be beneficial to
>     optionally allow the version of .gitattributes found in the same
>     commit when checking the attributes for paths in an older commit.
>

Furthermore, I think you've put it nice here, I will copy this over and modify
the last statement to:

    It may be beneficial to optionally allow the users to check attributes
    against paths from older commits.

> By the way, applying the attributes from the working tree is by
> design and it should stay to be the default.  People are almost
> always working near the tip of the history, and working tree files
> are by definition ahead of any committed version---it is a feature
> that users can correct attribute definitions in their working tree
> files and then apply them to paths in the committed version.
>

Yeah, this was my understanding as well, I don't think I tried to change this or
implied the same anywhere.

> >> Add a new flag `--revision`/`-r` which will allow it work with
> >> revisions. This command will now, instead of checking the files/index,
> >> try and receive the blob for the given attribute file against the
> >> provided revision. The flag overrides checking against the index and
> >> filesystem and also works with bare repositories.
> >
> > The system, global and the attributes in .git/info/attributes from the
> > filesystem are still used. It would be useful to document that and
> > explain in the commit message why that is useful when using -r.
> >
> > -r is documented as accepting a revision but actually accepts any
> >  tree. That means a user can pass "-r HEAD:subdirectory" and all the
> >  attributes will be looked up as if subdirectory was the root
> >  directory of the repository which might be confusing. It would be
> >  helpful to know if passing a tree rather than a revision is
> >  useful. If it isn't then you could use lookup_commit_reference() to
> > ensure the user passes a revision.
>
> Unless you use ancestry relationships in any way [*], you do not
> want to require commits when an operation only requires trees.  In
> this case, taking tree-ish and documenting it as such is the right
> thing to do.
>
> [Footnote]
>
> * A good example that makes sense to limit to commit-ishes is when
>   merging two histories (without requiring the user to supply the
>   merge-base). You'd need to compute the merge-bases, so you require
>   two committishes and it is not enough to take two trees.

Will leave it as it is then.

Thanks both for the review. I think I will push a version 3 now,
mostly changes would be:
1. Documentation
2. Commit message

Also, it has been a while for me on this list, but I did notice this
topic missing from the
`What's cooking in git.git` mail, do I need to do something further?

--
- Karthik
