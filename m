Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715F7C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 03:54:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5990D61073
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 03:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhHEDyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 23:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbhHEDyo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 23:54:44 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F2AC061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 20:54:31 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so12165103pjs.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 20:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YIQfEfpfI+68fC5ybSmPmeN+CTRTmISSxT/asB9PySE=;
        b=IibyawPabgJ2L1hpiJP9a6BG9LyrhRMqgpVf4qri8aaj4f+3I2eM69txilv5PApOuu
         Als79SU/TEV5tpfNIXIpgKCOaQOhQEmT3fACuI1wlpqWtz3fGeUZ+WDy22FA/UrFD9R+
         U5KChjIz8tz7F5G3y2uyx9RVD8UErHaPr419mS9mAQtEWoXG0liQQMTgMWl45dIPKnYO
         Sg75BLrnK0wEX9hqRocmDltod2pIqY1yvN8r+ybnsDw66ZQHIN2heM9HTLmNo2nmAvzh
         YXeS86YDd6kkN+OKhfwKeU1YAV7DoILXkEdOD3XLKr9o2HpMB2cmbn6AUwhZ4ux5Trg4
         iC/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YIQfEfpfI+68fC5ybSmPmeN+CTRTmISSxT/asB9PySE=;
        b=IQ0vzQomN/0Lo6oczppyyViDfTsOeztzPj4Vl2NU+/HiPHp2XRQVimgzKvzLfpjLBo
         dCGlpfNaLrt7btrbK+LGqTs7/OQJj8PWbAcJUzBpdVAmuQepAQPj8u60ScixwV9o9CfV
         4qyAWzh7K226hAod1qZ/LU5tkR2wd3DiG4bZMx2xu64EsLDtvJ9bKLLzgjFm8yQC/rgU
         03Qh3d8naBpsOO871gWJbA/N4EpsKtZak7HWA5Cqe705HMYsjQVgqqrvLKTp/OUz+v2j
         12ouQvD/ynuo4NyHXuqAiXsUM1oPOhxD1rgb3jmsk7CJpm6pQbCXog6eTI/vymElpSYh
         QnrQ==
X-Gm-Message-State: AOAM530G/eh6iZIVGD/R5GfCE2KliWWzXiks49DhcjsY3nvE34Q+g4uw
        Vpn46CKzfYiXSlgfskfPbwyEV4MJHgWkEA6iNHI=
X-Google-Smtp-Source: ABdhPJw1fgiFK1OaUgYJwyrhYIox8tSQ8ZmktcjolQolb+4LKtTB22p+B0gXdSM1GsGf2d8azcliHVN5wL3lIwPgxH4=
X-Received: by 2002:a17:902:e28a:b029:12c:13e9:1166 with SMTP id
 o10-20020a170902e28ab029012c13e91166mr403844plc.47.1628135670942; Wed, 04 Aug
 2021 20:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1009.git.1627579637.gitgitgadget@gmail.com>
 <9212bbf4e3cab20fe49ab8e6dd4ac0277c4f2805.1627579637.git.gitgitgadget@gmail.com>
 <CABPp-BGbRbyCYYS+NcYrC-T4hJf7BCoLE2HsXFM4K51A0wSgcg@mail.gmail.com>
 <76639e16-204d-7812-d4c5-56c70e280bed@gmail.com> <CABPp-BE1aKAsp6yKAzM-djRHuiP=GHC_Q7xZxMWPJ=f28bOeUg@mail.gmail.com>
 <53d1b6ac-76a0-034b-109c-df2835c8fad6@gmail.com>
In-Reply-To: <53d1b6ac-76a0-034b-109c-df2835c8fad6@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Aug 2021 21:54:19 -0600
Message-ID: <CABPp-BGi1CBnerhtV87Do+=RyEkSexRFPqG566MSvM3zDWam_A@mail.gmail.com>
Subject: Re: [PATCH 2/2] sparse-checkout: clear tracked sparse dirs
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 4, 2021 at 7:55 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/2/2021 12:17 PM, Elijah Newren wrote:
> > On Mon, Aug 2, 2021 at 8:34 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 7/30/2021 9:52 AM, Elijah Newren wrote:
> >>> On Thu, Jul 29, 2021 at 11:27 AM Derrick Stolee via GitGitGadget
> >>> <gitgitgadget@gmail.com> wrote:
> > ...
> >>>> +                */
> >>>> +               if (S_ISSPARSEDIR(ce->ce_mode) &&
> >>>> +                   repo_file_exists(r, ce->name)) {
> >>>> +                       strbuf_setlen(&path, pathlen);
> >>>> +                       strbuf_addstr(&path, ce->name);
> >>>> +
> >>>> +                       /*
> >>>> +                        * Removal is "best effort". If something blocks
> >>>> +                        * the deletion, then continue with a warning.
> >>>> +                        */
> >>>> +                       if (remove_dir_recursively(&path, 0))
> >>>> +                               warning(_("failed to remove directory '%s'"), path.buf);
> >>>
> >>> Um, doesn't this delete untracked files that are not ignored as well
> >>> as the ignored files?  If so, was that intentional?  I'm fully on
> >>> board with removing the gitignore'd files, but I'm worried removing
> >>> other untracked files is dangerous.
> >>
> >> I believe that 'git sparse-checkout (set|add|reapply)' will fail before
> >> reaching this method if there are untracked files that could potentially
> >> be removed. I will double-check to ensure this is the case. It is
> >> definitely my intention to protect any untracked, non-ignored files in
> >> these directories by failing the sparse-checkout modification.
>
> This is _not_ true, and I can document it with a test.
>
> Having untracked files outside of the sparse cone is just as bad as
> ignored files, so I want to ensure that these get cleaned up, too.
>
> The correct thing would be to prevent the 'git sparse-checkout
> (set|add|reapply)' command from making any changes to the sparse-checkout
> cone or the worktree if there are untracked files that would be deleted.
> (Right? Or is there another solution that I'm missing here?)

We could sparsify as much as possible and print warnings, much like we
do with tracked files that are modified but not staged.  In fact, it
might feel inconsistent if we sparsify as much as possible for one
type of file, and abort if we cannot completely sparsify for a
different type of file.  We could consider changing how we treat
tracked files that are modified but not staged and have them abort the
sparse-checkout commands as well, but I worry that might cause
problems during conflict resolution in the middle of
merges/rebases/cherry-picks/reverts.  I don't want users caught where
they need to update their sparsity paths to gain new files/directories
that will help them resolve some conflicts, but be unable to update
their sparsity paths because they have conflicts.

That said, the basic idea of aborting sparse-checkout in cone mode
when there are untracked unignored files in the way of removing
directories sounds reasonable, if there's some clever way to avoid or
ameliorate the inconsistency issues mentioned above.  Implementing it
might require walking all untracked (and tracked?) files twice,
though, because if there are untracked unignored files in the way, we
probably don't want to abort after first deleting lots of ignored
files.  (And there's a small race window in the double walk...)
However, I don't expect people to run sparse-checkout commands all
that often, so the double walk is probably a perfectly reasonable
performance cost.  I just wanted to note it.

> >>> My implementation of this concept (in an external tool) was more along
> >>> the lines of
> >>>
> >>>   * Get $LIST_OF_NON_SPARSE_DIRECTORIES by walking `git ls-files -t`
> >>> output and finding common fully-sparse directories
> >>>   * git clean -fX $LIST_OF_NON_SPARSE_DIRECTORIES
> >>
> >> I initially was running 'git clean -dfx -- <dir> ...' but that also
> >> requires parsing and expanding the index (or being very careful with
> >> the sparse index).
> >
> > `git clean -dfx -- <dir> ...` could also be very dangerous because
> > it'd delete untracked non-ignored files.  You want -X rather than -x.
> > One of those cases where capitalization is critical.
>
> Good point. I'd like to avoid using `git clean` as a subcommand, if
> possible, that way we have one fewer thing to do before integrating
> the `git sparse-checkout` builtin with the sparse index.

Oh, I didn't want to invoke a subcommand, I was just pointing out
where similar code might be found in case we wanted to call the same
functions from elsewhere (or maybe even turn some of it into library
functions we could call).  But that might be a moot point if we end up
making sparse-checkout fail if there are untracked unignored files
hanging around in the relevant directories.
