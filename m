Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8AEC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 17:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjBTRdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 12:33:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjBTRdK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 12:33:10 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA29955B7
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:33:08 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id r27so481065lfe.10
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 09:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pY2Eqqa9cjIs/xMlnew3mx9OjcsRTtGI5MXlGoWGa1E=;
        b=VYfrpecz8793ZxixqvqfUADBwgmUWdTe0kcxoFPjuj6NpGv3ztE3q6JaA7y2cWple4
         Hl6zPBAaTEwcp1A9utPGDeTGIoAY3YQXH4A/OpUQe2K2wDoPaX8MbxrOZKNFk4TmQfFU
         /DYECNFwcKKSwPfjcDlJYdohHWsyLZB0/Ar1RHs+F/kz3esnpF3+p5aG7oXvfGIJc/90
         M+lpN7P/vdPTcoKc6GrKTP/a/iig5WGbDbnqXOQlPKGECuGbvkGTKALTRtvs+Wh2s/To
         /+J+lRqCJrr5130QibDa2VcbcdwsTpSGn5ieYTWX1WDhAsUiW4bS/AOfnqpQdK0cwj2L
         FYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pY2Eqqa9cjIs/xMlnew3mx9OjcsRTtGI5MXlGoWGa1E=;
        b=ZQyqp2AVKWe9QY/GQqchF55JWnuUtB/A6zW40mnJf4UhCX1BhO+zIyJK6U2U8roC/0
         FbDK0q4KnLQ4XLG+vaPaliAUnpVDGaJZQpG9squnrM/6kfmipm2H8/Gh0oWcfDbdAf2z
         z49ngBf8MfKagS9fi4dOnYxhyQ/rZ7dXiOr5RLtFDEsqM1bWYKh0KUEN2iecAIzii9iY
         4NMUsGnL1gKxLJpLvHG06CUSvuTLkHd2rS+YCSYOID+IAbH+J9dNJiMgPAM4GLBHPCyj
         IUuYxjQao4IcvdV9IBdSmDWlKWve+Ou9RWAjxkGHdkBRiUjyd97VnZclTwCUGfp4rLlN
         5J5g==
X-Gm-Message-State: AO0yUKUkbFjhOmLAEXJYwfW2qyk3DGF3kyvuecWgyTvVCPObTBo1QqxO
        eFa5quOVTzxWoMRwTfOo1sjkN34tTvRFBN7tIXTDIxafck8=
X-Google-Smtp-Source: AK7set/2mlUnfRwQwqwivcHXkXgK4LrtKdLoRcKu8Wc4gytXaiTBOkUyt8snl2jSBhJCX6PDYj5OIahtc2sCh64NPgE=
X-Received: by 2002:ac2:44a8:0:b0:4d8:6fd3:b8bf with SMTP id
 c8-20020ac244a8000000b004d86fd3b8bfmr851926lfm.7.1676914386892; Mon, 20 Feb
 2023 09:33:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com> <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
 <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
 <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com> <CABPp-BGDi1VQXFdGw_Y8i0ZDBOoHJe9039fh4mO44qJ-nJE1ig@mail.gmail.com>
 <47981D9E-9DC7-4C23-911D-13BA52A27040@gmail.com>
In-Reply-To: <47981D9E-9DC7-4C23-911D-13BA52A27040@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 20 Feb 2023 09:32:52 -0800
Message-ID: <CABPp-BHQn0sjAMwJ+r6uenO=nGLG1HvfnhS6tG8mu1BWt4bdOw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
To:     John Cai <johncai86@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 20, 2023 at 8:49 AM John Cai <johncai86@gmail.com> wrote:
>
> Hi Elijah,
>
> On 20 Feb 2023, at 11:21, Elijah Newren wrote:
>
> > On Mon, Feb 20, 2023 at 7:32 AM John Cai <johncai86@gmail.com> wrote:
> > [...]
> >>> I'm still curious if this should this also include warnings/caveats, such as:
> >>>   * The diff attribute specified in .gitattributes will be ignored in
> >>> a bare clone
> >>>   * The diff attribute specified in .gitattributes will be ignored if
> >>> it is only specified in another branch (e.g. on a branch "special-file
> >>> diff=patience" recorded in .gitattributes, then checkout master but
> >>> run `git log -1 -p $branch`)
> >>>   * When a file is renamed, the diff attribute for the pre-image name
> >>> is the only one the system pays attention to (thus adding "-R" can
> >>> flip which diff algorithm is run for the renamed file).
> >>
> >> I would be fine with adding that--though originally I was thinking that these
> >> can be inferred from the way that gitattributes are documented in [1]. Calling
> >> these out would make it more clear though, so I could go either way.
> >>
> >>>
> >>> Also, since I tested the three items above to verify they are valid
> >>> warnings, I'm a bit confused.  I thought your intent was to use this
> >>> server-side[1], so isn't the bare clone aspect a deal-breaker for your
> >>> intended usecase?
> >>>
> >>> [1] https://lore.kernel.org/git/7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@gmail.com/
> >>
> >> yes, indeed. I was planning on adding bare repository support in a separate
> >> patch series, since the additions in [2] allows .gitattributes to be read from a
> >> bare repository.
> >>
> >> 1. https://git-scm.com/docs/gitattributes
> >> 2. https://lore.kernel.org/git/0ca8b2458921fc40269b0c43b5ec86eba77d6b54.1673684790.git.karthik.188@gmail.com/
> >>
> >> thanks!
> >> John
> >
> > Oh, interesting, I didn't know about [2].  So, is the plan to take the
> > --source option from that series and add it to diff (perhaps with a
> > different name, since log tends to consume diff options and --source
> > is already taken)?
>
> Yep, that would be the general idea
>
> >
> > And do you expect to get the tree-ish from the two the users are
> > already specifying to diff?  If so, which one do you use (the two
> > commits being diffed might have differing .gitattributes files)?  If
> > not, what does that mean for users of e.g. the GitLab UI who have to
> > specify a third tree when diffing?
>
> Good question! Since it seems that when `git-diff(1)` considers diff.<driver>,
> it goes with the path of the first one. (might need some confirmation here)
>
> in diff.c:
>
>
> static void run_diff(struct diff_filepair *p, struct diff_options *o)
> {
>         const char *pgm = external_diff();
>         struct strbuf msg;
>         struct diff_filespec *one = p->one;
>         struct diff_filespec *two = p->two;
>         const char *name;
>         const char *other;
>         const char *attr_path;
>
>         name  = one->path;
>         other = (strcmp(name, two->path) ? two->path : NULL);
>         attr_path = name;
>         if (o->prefix_length)
>
> I was thinking we would just use the tree-ish of the first one

That would certainly simplify, but it'd be pretty important to
document.  (Incidentally, this kind of decision was my reason for
asking about all those special cases earlier, i.e. how to handle diff
between different commits, how to handle renames, how to handle bare
repositories, etc.)

This kind of decision probably also means you'd need a variety of
testcases where .gitattributes is different in every commit & the
index & the working tree, and then you start testing several of the
possible pairings to make sure the right .gitattributes file is used
(e.g. (commit, commit), (commit, index), (index, commit), (worktree,
index), etc.)

However, I'm curious again.  You brought this up because you want to
use it in GitLab, yet configuration of using this option as it appears
in this series requires changing _both_ .gitattributes and
.git/config.  How will users of the GitLab UI do the configuration
necessary for the git-config side to take effect?
