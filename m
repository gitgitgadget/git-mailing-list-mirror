Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2520FC433E0
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E78CC2070B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 17:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="cw09/6YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729340AbgFJRIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbgFJRIt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 13:08:49 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01C5C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 10:08:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so3434837ljv.5
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Cei+ip9JfZPGT+QTiVPkdkyGxs5keACEQM2TXEIFVC4=;
        b=cw09/6YVslUHrrlcHF4R03ghPleCdTFgh35fHTPEllB6w31UZDL2ec/rN40OGeXgan
         yfYY8k61c8ff1FsFNRKHmmQ1OcZ3ucTooPzFL90MG/zg+qw2DmsOonHwJpczHxWp9ijV
         EePZDUfWHgIzJSnUdmHJWr3Zph4dvLUJsoJ2DJAUCAVT7PZ2eHzl+RFCcRW8naEhFpw2
         G5m3Je1r9M2MddPBKj4XAxjSwExdWujJ7PBQ5D1IparXqnDhM0wyKLNj1g/Bc0R2E5jF
         3T3uUSJr2LacknaBVeaYZtdr44ws4hRieGabtm9U5p1rBLcWt76A4J+RmQjySfKUOcOq
         41Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Cei+ip9JfZPGT+QTiVPkdkyGxs5keACEQM2TXEIFVC4=;
        b=kuX4DoZyielZ1cyk1zbSUBL/LbWnS5ZfTCt95v6A4QOI5gdBXJKwBRLVDkOlAa7GJG
         alhWT78/aPieflVVdp44ClBFR554gTqGQx91Gw0eazgYgfG+rbyU7nQXM8+vdagDoQSg
         cmTY+ccja0y9C4phN/eYlFjsbWOv2ceyUVGRr37teQh3mwfDnBuQma3HXlR7Rh3ErD52
         9VeGKy/d/518lWChrpE6Ru9ry1yylVPcXql6I+eZt6y6Q3GtMed1GuUxrdoSzVzRl44/
         Y+PAoWXY9pwK+JcRk4DP2o4Nlol3ab9/5dzdR3IB585RICUPgeG0vcC9bH3VTNHh2LrC
         clTw==
X-Gm-Message-State: AOAM531zdcgdCGTf0TGEYOwp5+heve4EVNHwz14ZvHeZjNBDJvyC32mY
        MR3AL08Azg3wDZ620RTkR4gkwp9zdAC5L2OugPRj0A==
X-Google-Smtp-Source: ABdhPJxz0kmeGkxE1s4iK2tWkiPOSfkByfExmpOr/wiOtVYsvrCI5/Dn1Cm9lY5iKjoYF1hOTtybXcswlJj56O1DtfQ=
X-Received: by 2002:a2e:9dc2:: with SMTP id x2mr2420550ljj.22.1591808927142;
 Wed, 10 Jun 2020 10:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br>
 <5ddac818185d316cd5ad9576105f0e4e695b9456.1590627264.git.matheus.bernardino@usp.br>
 <CABPp-BFsCPPNOZ92JQRJeGyNd0e-TCW-LcLyr0i_+VSQJP+GCg@mail.gmail.com>
 <CAHd-oW7JEu0rBrBMyjfFZ4WZ982+WwpGSvqg4meOwxmHjocknQ@mail.gmail.com> <CABPp-BF6=s-cAy98d-FTTExeR18YhxrHmDNzbH-1P8AiMfskfg@mail.gmail.com>
In-Reply-To: <CABPp-BF6=s-cAy98d-FTTExeR18YhxrHmDNzbH-1P8AiMfskfg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Wed, 10 Jun 2020 14:08:35 -0300
Message-ID: <CAHd-oW4bKG+MDCaDm+5Ha-+vvFy=LT9nnxCmQUre-BCtqWcd3Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 2, 2020 at 11:38 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Sun, May 31, 2020 at 9:44 PM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > On Sat, May 30, 2020 at 12:48 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Wed, May 27, 2020 at 6:13 PM Matheus Tavares
> > > <matheus.bernardino@usp.br> wrote:
> > > >
> > > > +static int in_sparse_checkout(struct strbuf *path, int prefix_len,
> > >
> > > This function name in_sparse_checkout() makes me think "Does the
> > > working tree represent a sparse checkout?"  Perhaps we could rename it
> > > to path_matches_sparsity_patterns() ?
> > >
> > > Also, is there a reason we can't use dir.c's
> > > path_matches_pattern_list() here?
> >
> > Oh, we do use path_matches_pattern_list() inside:
> >
> > > > +       *match = path_matches_pattern_list(path->buf, path->len,
> > > > +                                          path->buf + prefix_len, &dtype,
> > > > +                                          sparsity, istate);
> > > > +       if (*match == UNDECIDED)
> > > > +               *match = parent_match;
> >
> > > How does this new function differ
> > > in behavior from that function?
> >
> > The idea of in_sparse_checkout() is to implement a logic closer to
> > what we have in clear_ce_flags_1(). Here, it is effectively a wrapper
> > to path_matches_pattern_list() but with some extra logic to decide
> > whether grep should search in a given entry, based on its mode, the
> > match result against the sparsity patterns, and the result from the
> > parent dir.
>
> I've had this response and one to 5/5 sitting in my draft folder for
> over a day because I was hoping to go read clear_ce_flags_1() and find
> out what it is.  I have no idea, so your answer doesn't answer my
> question... ;-)  I'll try to find some time and maybe respond further
> after I do.

Oops, sorry for the incomplete answer. clear_ce_flags() recursively
traverses the index entries, unsetting the bits specified in a given
mask when the entry matches a given pattern list. (It is used in
unpack-trees.c:mark_new_skip_worktree() to clear the
CE_NEW_SKIP_WORKTREE bit for the matched entries.) clear_ce_flags()
does use path_matches_pattern_list() but it also has to check some
additional rules for cone mode (as there might be recursive
matches/non-matches). These rules are implemented in
clear_ce_flags_dir().

in_sparse_checkout() is a small wrapper around
path_matches_pattern_list() with (1) the additional checks for cone
mode, similar to what clear_ce_flags_dir() implements, and (2) the
usage of the parent dir's match_result when undecided about the
current path. We could just implement this directly in grep_tree(),
but I thought that isolating this logic into its own static function
would make grep_tree() more readable.

> > > > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > > > new file mode 100755
> > > > index 0000000000..ce080cf572
> > > > --- /dev/null
> > > > +++ b/t/t7817-grep-sparse-checkout.sh
> > >
> > > Looks good.  Do we want to add a testcase where a file is unmerged and
> > > present in the working copy despite not matching the sparsity patterns
> > > (i.e. to emulate being in the middle of a merge/rebase/cherry-pick)?
> >
> > Sure, I can add that. But after a quick test here, it seems that the
> > unmerged path doesn't have the SKIP_WORKTREE bit set. Is this how it
> > should be?
>
> Right, the merge machinery will clear the SKIP_WORKTREE bit when it
> writes out conflicted files.  Also, any future 'git sparse-checkout'
> commands will see the unmerged entry and avoid marking it as
> SKIP_WORKTREE even though it doesn't match the sparsity patterns.
> Thus, grep doesn't have to do any special checking for whether the
> files are merged or not, and from your current implementation probably
> doesn't look like a special case at all -- you just check the
> SKIP_WORKTREE bit.
>
> However, I think the test still has value because the test enforces
> that other areas of the code (merge, sparse-checkout) don't break the
> invariants that grep is relying on.  (I could see someone making a
> merge change that keeps the SKIP_WORKTREE bit accidentally set even
> though it writes the file out to the working tree, for example.)
> Sure, merge has some tests around that, so it might be viewed as
> slightly duplicative, but I see it as an interesting edge case that
> exercises whether the SKIP_WORKTREE bit should really be set and since
> grep expects a certain invariant about how that is handled, the
> testcase will help make sure our expectations aren't violated.

OK. I will add this test for the next version.
