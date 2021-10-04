Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A2BC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55D206136F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 14:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhJDOmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 10:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbhJDOmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 10:42:01 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C7C061745
        for <git@vger.kernel.org>; Mon,  4 Oct 2021 07:40:12 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id g8so65890262edt.7
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 07:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DhNP635U0MYP1KY0JydXxgmD0F2S0eAafF6Ob8ERVTM=;
        b=ahUEyPNkVLpPYXLTenMpmEy5PMgUR1qNIwmHIl+whSqBgBG1D6IzcmBlA9mamwd6Hi
         VE+NfcKZ6gphE1m2XZwdQhI7YwqmhM019gFYwFwcV9EdBLwbzbY9t0wnOZQWCQ7iY9nq
         mHE5C62q/o/og58RhnAiBlpusgCAF84SEm6M7Zr8q8a2p5+IaJFOAYVpOZpP70KG0/UE
         APjxQMG/hqcxMCmLgy7zXpJqkexC/+Co6LA+MUok2rB7kqtWoEjCk7uzc5qEWCLAdTYs
         RkIb/rEV1mpOZWWI9reeNbaBItjO/whUHGW26vS9vI6SPAMxTNF0NZ+XlGjrlASVsfhi
         Q9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DhNP635U0MYP1KY0JydXxgmD0F2S0eAafF6Ob8ERVTM=;
        b=ZhmQHbBxAMLnYcGlXLlIOuU4YGT5HIewpPs+XWmiR3+JvsLcbR4WiXFLAJUlWUjmnb
         8lLONdeG35wzgWZ4bAZsmNNJQoZuIwAWkpFvV7JiQCQ7ywQvRpi/t0Re15d0V8hfwAdn
         f46eDwtzaWZ1vV8hDnQd/YczmKLCKCoJaoe1lU5HejY5nLgsZSSUzCdWewyBZVaQU6QI
         YNAL5w5gdjVPdxs1YBNVAQqxNrVuvfD6U8ZS613EJCvNzG5n1+pw+0yiGBzTc7e3DqXB
         LiQ+Q0EKcPp+ZHUWHgTnRCVYWOizAe8d0GopuCRUw+SGBYQ7v56LiJtsh7Rdc9QriC9g
         v7Gw==
X-Gm-Message-State: AOAM531a8YzJhu74/77blXXl5ENBbclzmc+EwBHnG+DIlCc18Z6ssheD
        HkRdip2oy9aS87bk7TvRbvRxGGvIpb33rRy/5yM=
X-Google-Smtp-Source: ABdhPJxKfUmjj16eUEntMNWYa8fWfH1I93tAIKO51WOUzLlIsd/Ks5GFOV7Hy05WR+eYrYxmuPCnsE0wn0VaM8l3fm0=
X-Received: by 2002:a50:be82:: with SMTP id b2mr18337444edk.56.1633358309507;
 Mon, 04 Oct 2021 07:38:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
In-Reply-To: <RFC-cover-v4-00.10-00000000000-20211004T004902Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 4 Oct 2021 07:38:17 -0700
Message-ID: <CABPp-BEaJAG=pqyjCR93YUoqj06WwSqjiPENDHjgSTWwzd_C2A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/10] Fix various issues around removal of
 untracked files/directories
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        Fedor Biryukov <fedor.birjukov@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 3, 2021 at 6:12 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avar=
ab@gmail.com> wrote:
>
> This is an RFC proposed v4 of Elijah's en/removing-untracked-fixes
> series[1] based on top of my memory leak fixes in the "unpack-trees" &
> "dir" APIs[2].
>
> As noted in [2] Elijah and I have been having a back & forth about the
> approach his series takes to fixing memory leaks in those APIs. I
> think submitting working code is more productive than continuing that
> point-by-point discussion, so here we are.
>
> I've avoided making any changes to this series except those narrowly
> required to rebase it on top of mine, and to those parts of Elijah's
> commit messages that became outdated as a result. In particular
> 3/10[3]'s is significantly changed, as much of its commit message
> dicusses complexities that have gone away due to my preceding
> series[2].
>
> The "make dir an internal-only struct" has been replaced by a commit
> that renames that struct member from "dir" to "private_dir". I think
> even that is unnecessary as argued in [4], but I think the judgement
> that something must be done to address that is Elijah's design
> decision, so I did my best to retain it.
>
> I did drop the dynamic allocation & it being a pointer, since with my
> preceding [2] and subsequent unsubmitted memory leak fixes I've got on
> top having it be embedded in "struct unpack_trees_options" makes
> things easier to manage.
>
> Havingn read through all this code quite thoroughly at this point I do
> have other comments on it, but I'll reserve those until we've found
> out what direction we're going forward with vis-a-vis what this will
> be based on top of.
>
> I'm (obviously) hoping for an answer of either on top of my series[2],
> or alternatively that Elijah's series can stick to introducing the
> "preserve_ignored" flag, but not change how the memory
> management/name/type of the embedded "dir" happens (and we could thus
> proceed in parallel).

???

This really bothers me.  I'm not quite sure how to put this into
words, so let me just try my best.  Let me start out by saying that I
think you often provide good feedback and ideas.  Sure, I sometimes
don't agree with some of the feedback or ideas, but overall your
feedback and contributions are definitely valuable.  I also think your
other series you rebased this on has some good ideas and some good
bugfixes.  There is something that seems off here, though.

In this particular case, to start with, Junio already said let's take
v3 as-is[1].  So your series should be rebased on mine, not
vice-versa.

Further while your other series that you are basing this on has some
memory leak fixes; to me, it mostly looks like refactorings for
stylistic code changes. Even though some of those stylistic changes
are good, making a series such as mine that includes bugfixes (to a
user reported bug no less), after multiple rounds and most reviewers
are fine with it, suddenly depend on a new big and unrelated treewide
stylistic refactoring series feels very off to me.  But that doesn't
quite fully explain my misgivings either; there's a bit more:

  * Junio has referred to several of your series as "Meh" and "code
churn".  That makes me think we'd have a higher than normal chance of
a user-reported bug ending up blocked on unrelated stylistic changes.
(Two of them actually, since I have another series depending on this
one that I've waited to submit until this merges to next.)
  * Your stylistic refactorings also manage to confuse the code in
merge-recursive.c, overall making the code potentially much harder to
understand[2][3].  And you open a foot-gun in
clear_unpack_trees_porcelain[3].
  * At least half the series of yours I've reviewed have had
significant bugs[4][5][6] (in addition to [2] and [3]).  This would be
fine if it was complex code that had bugs we were fixing, or if we
were adding new features, but:
  * You submit a huge volume of patches, with a very
disproportionately high ratio of stylistic refactorings rather than
bugfixes and new features.  (This is by no means bad on its own, it's
the combination of this with other factors.)
  * You misrepresent my changes in multiple ways, including ways I had
pointed out corrections for in our previous discussions (including
some of which you acknowledged and agreed with), and you do so even
after you have rebased my patches and added your signed-off-by to them
suggesting you ought to be familiar with them[7].

So, I guess trying to distill what bugs me, I'd say: it seems to me
that you have ignored what Junio said about taking my series, and then
you rebased my series on top of unrelated stylistic churn, with that
churn containing three issues that trigger ongoing misgivings I have
about the care being put behind these refactorings, especially
considering their value compared to the features and bugfixes we are
getting, and you seem to fail to try to understand my changes and
misrepresent them in the process.  I hope I'm not overreacting but
something feels wrong to me here.


A big thumbs down on this reroll.

[1] https://lore.kernel.org/git/xmqq35pk8ylz.fsf@gitster.g/
[2] https://lore.kernel.org/git/CABPp-BFYxWXZQXvDSrM1Y1ZaQ1d2TENQDvx1cyawvr=
DO1OvExA@mail.gmail.com/
[3] https://lore.kernel.org/git/CABPp-BH4ubjJ98Nvgp2iyKxmU9X+ypw4m1o=3DiL9Z=
4vSNZ-QTDw@mail.gmail.com/
[4] https://lore.kernel.org/git/CABPp-BGE+e1er6qFuG90j9+eVG34O8TN=3DimX=3Dj=
tcb+jbQjN1QQ@mail.gmail.com/
[5] https://lore.kernel.org/git/CABPp-BEPkukGz32rrro1hzMvSQzX4v7U17CAcV-G2N=
S6v0u55g@mail.gmail.com/
[6] https://lore.kernel.org/git/xmqqfstppxzm.fsf@gitster.g/  [Note:
problem was flagged by j6t; I was about to flag the same problem when
I noticed he had already done so.]
[7] https://lore.kernel.org/git/CABPp-BEr28xzbpEZc5dq-RVDupXy+h-+PH6CoANF4e=
0kmxqf0Q@mail.gmail.com/
