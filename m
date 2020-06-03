Return-Path: <SRS0=EE6k=7Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E7C433DF
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:38:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FA0320663
	for <git@archiver.kernel.org>; Wed,  3 Jun 2020 02:38:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiGmy/Hk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgFCCiw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 22:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCCiv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 22:38:51 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442CBC08C5C0
        for <git@vger.kernel.org>; Tue,  2 Jun 2020 19:38:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id s13so677413otd.7
        for <git@vger.kernel.org>; Tue, 02 Jun 2020 19:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARgTm47GcHyeOxfWXcFltmaVAx85YOrV5Az22YU1P/8=;
        b=fiGmy/Hkx7ziOLdhfRgnY1tzLJGSNfvhtYZOX5OMDIP/mv7hH4XCqBzHlHgm9UsVQP
         Wi/KT8PIDwP3FXVy6Yv3NrukYcfeWPBqoPhUFvXc4QYV+zzpgs41QkDZH25VhzKWB79G
         eYPywX3lcgIVxuGoxmyk+DEkO3ZgCXl/DBBuvHkFOK1cjP0mdqy+8tQ3xMgB8Pl087zw
         qmYABcdTk0VFCszb6EgDgi0OGjn1vlWVeq+j2aDb/XpDBEOpatRogs+SWd8qd3BDU2Nz
         4gm5SJPhuB2bWnuvYoEP+5b7h/7N8nJeKZk5qdeCUlZ18kjAQdEEIWAzloKC0Oi9717X
         nw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARgTm47GcHyeOxfWXcFltmaVAx85YOrV5Az22YU1P/8=;
        b=L50xhIYx36SqVXeeTNV8CbMET5TEHJK4+ybl9Xc55IKYIvlrqZPu2NuinpMdB27men
         vhLTFfIQIlkKnZqWiHNyqDiD1+pa8F0/5ufV+EUAXIrnIEzB1nd12jSI1mrTStED9+nt
         YmZW3e5jeokgZ1JE5hswfq0pfyZ5LBMfR14RZUBoKhCDj17dzSdn54YMFm/IOTIvuexm
         0LtZVRBDyRCamxbRY+Kdt72V2HDUyb0vXhD9dTux4guiRZaI4xcDQ+W9gO35dgAZMXFI
         xz901DLgO97E4k177ET01dhCavz5sMEtix2cYTd80qWNCP4dSRUHyYqcH4lp1f7VU00m
         1ipw==
X-Gm-Message-State: AOAM533JY31yjpVl/ikbi4dCj9PMGA66RDXlhG4R5SV0A64xA2QXHFjK
        u3cwvKeL6NBjBeePdf0iGmmSMYyuu+hSXVZQzBQ=
X-Google-Smtp-Source: ABdhPJz68x0QuFDXSjWjlwonCXPbdOwNethUO/OJXyGy+iGOo4vTTIy8HKu7fJLE4wBqjJ6sTHwePVNK6AlawgSQ5OA=
X-Received: by 2002:a9d:6c07:: with SMTP id f7mr1628402otq.345.1591151930510;
 Tue, 02 Jun 2020 19:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <5ddac818185d316cd5ad9576105f0e4e695b9456.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com> <CAHd-oW7JEu0rBrBMyjfFZ4WZ982+WwpGSvqg4meOwxmHjocknQ@mail.gmail.com>
In-Reply-To: <CAHd-oW7JEu0rBrBMyjfFZ4WZ982+WwpGSvqg4meOwxmHjocknQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 Jun 2020 19:38:39 -0700
Message-ID: <CABPp-BF6=s-cAy98d-FTTExeR18YhxrHmDNzbH-1P8AiMfskfg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] grep: honor sparse checkout patterns
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 31, 2020 at 9:44 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Sat, May 30, 2020 at 12:48 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> > >
[...]
> > > +static struct pattern_list *get_sparsity_patterns(struct repository *repo)
> > > +{
> > > +       struct pattern_list *patterns;
> > > +       char *sparse_file;
> > > +       int sparse_config, cone_config;
> > > +
> > > +       if (repo_config_get_bool(repo, "core.sparsecheckout", &sparse_config) ||
> > > +           !sparse_config) {
> > > +               return NULL;
> > > +       }
> >
> > Is core_apply_sparse_checkout not initialized for some reason?
>
> It should be already initialized, yes. But we cannot rely on that as
> `repo` might be a submodule, and core_apply_sparse_checkout holds the
> configuration's value for `the_repository`.

Ah, gotcha.  Thanks for straightening me out.

> > > +static int in_sparse_checkout(struct strbuf *path, int prefix_len,
> >
> > This function name in_sparse_checkout() makes me think "Does the
> > working tree represent a sparse checkout?"  Perhaps we could rename it
> > to path_matches_sparsity_patterns() ?
> >
> > Also, is there a reason we can't use dir.c's
> > path_matches_pattern_list() here?
>
> Oh, we do use path_matches_pattern_list() inside:
>
> > > +       *match = path_matches_pattern_list(path->buf, path->len,
> > > +                                          path->buf + prefix_len, &dtype,
> > > +                                          sparsity, istate);
> > > +       if (*match == UNDECIDED)
> > > +               *match = parent_match;
>
> > How does this new function differ
> > in behavior from that function?
>
> The idea of in_sparse_checkout() is to implement a logic closer to
> what we have in clear_ce_flags_1(). Here, it is effectively a wrapper
> to path_matches_pattern_list() but with some extra logic to decide
> whether grep should search in a given entry, based on its mode, the
> match result against the sparsity patterns, and the result from the
> parent dir.

I've had this response and one to 5/5 sitting in my draft folder for
over a day because I was hoping to go read clear_ce_flags_1() and find
out what it is.  I have no idea, so your answer doesn't answer my
question... ;-)  I'll try to find some time and maybe respond further
after I do.

>
> > > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > > new file mode 100755
> > > index 0000000000..ce080cf572
> > > --- /dev/null
> > > +++ b/t/t7817-grep-sparse-checkout.sh
> > > @@ -0,0 +1,174 @@
> > > +#!/bin/sh
> > > +
> > > +test_description='grep in sparse checkout
> > > +
> > > +This test creates a repo with the following structure:
> > > +
> > > +.
> > > +|-- a
> > > +|-- b
> > > +|-- dir
> > > +|   `-- c
> > > +|-- sub
> > > +|   |-- A
> > > +|   |   `-- a
> > > +|   `-- B
> > > +|       `-- b
> > > +`-- sub2
> > > +    `-- a
> > > +
> > > +Where . has non-cone mode sparsity patterns, sub is a submodule with cone mode
> >
> > Maybe "Where the outer repository has non-code mode..."?  The use of
> > '.' threw me for a bit.
>
> Sure!
>
> > > +test_done
> > > --
> > > 2.26.2
> >
> > Looks good.  Do we want to add a testcase where a file is unmerged and
> > present in the working copy despite not matching the sparsity patterns
> > (i.e. to emulate being in the middle of a merge/rebase/cherry-pick)?
>
> Sure, I can add that. But after a quick test here, it seems that the
> unmerged path doesn't have the SKIP_WORKTREE bit set. Is this how it
> should be?

Right, the merge machinery will clear the SKIP_WORKTREE bit when it
writes out conflicted files.  Also, any future 'git sparse-checkout'
commands will see the unmerged entry and avoid marking it as
SKIP_WORKTREE even though it doesn't match the sparsity patterns.
Thus, grep doesn't have to do any special checking for whether the
files are merged or not, and from your current implementation probably
doesn't look like a special case at all -- you just check the
SKIP_WORKTREE bit.

However, I think the test still has value because the test enforces
that other areas of the code (merge, sparse-checkout) don't break the
invariants that grep is relying on.  (I could see someone making a
merge change that keeps the SKIP_WORKTREE bit accidentally set even
though it writes the file out to the working tree, for example.)
Sure, merge has some tests around that, so it might be viewed as
slightly duplicative, but I see it as an interesting edge case that
exercises whether the SKIP_WORKTREE bit should really be set and since
grep expects a certain invariant about how that is handled, the
testcase will help make sure our expectations aren't violated.
