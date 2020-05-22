Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA31C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 05:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BCC2072C
	for <git@archiver.kernel.org>; Fri, 22 May 2020 05:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="NSlDbNGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgEVFtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 01:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgEVFta (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 01:49:30 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEA9C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 22:49:30 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id b6so11206019ljj.1
        for <git@vger.kernel.org>; Thu, 21 May 2020 22:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7yVRVjVfPikWq+vUJ7T/ovJLBDTxiJe5+5vguhcIDLQ=;
        b=NSlDbNGWMYFcb4AdOsGa7BnHuwzLcSgfRx8hb/HRn4NwY+K+N5xasCTdlgPVIiCsPN
         AdfAvvZyuUHQ28bg0HvJoH7rUGqFAHBh8tpzZc0SqKpEoSyG55Az38yHcAL49f8yi7di
         aulm5iNv1g9r2BQptSHgF2nn7kSdS4Xjh35PuqHtpzA1lHjr/Hn5inyXrgeSIuVlP1dh
         ZK1PL0B1UIEspcSPX6ioLIXu4RLXrOc0k23Hkj/10Y7Qv8y3D4jQXge1yFr2dNNO2Nx+
         vitsRnLCkzL35c5FvHCg32x1RK/8k9mVB8/CyI7PYEeCBknXL0RWar9u7yKoQP156F+m
         5lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7yVRVjVfPikWq+vUJ7T/ovJLBDTxiJe5+5vguhcIDLQ=;
        b=FGVwwXofi6V6ET1G3uJ0m8JUPjtvWD3RyvbXGQ3iT9fXeLE5wCoHa8BwlbAff/GYDv
         ATNC3U+xMo5ugl3TBTigMRIhjbmaNNGHzYAauubuxIzBydjP+LwhmAurpFENwdJGEVNI
         7CVx98llbRTnFt1GkWiM+jPhUdS2OAuT4U+6sZ+kZ3gtMTuHF7G+61/+1/H9H7uS65f0
         aw4Sh3OqM0UJN/U8th3Dn8NnYzwjFpqDemhJ2mjDYbdHDXdTQ48Nwg1BDmbASrts0WKk
         mqiso5aHtmHMc/wTILcSAP09TyjxD8GHSP+qbfxSQXd6W5pvZQXXeJvBlvsO7DagfwEw
         WtfA==
X-Gm-Message-State: AOAM530JT5iQm/6kcf8rznbAAlDHYuf/k29vO+yebbee9Q3PApBo0R7E
        1on9FUOfU6vTlm7OVehIFmgpQtXrP1cayCP4Fy/ATA==
X-Google-Smtp-Source: ABdhPJydqARnr2LoT4IcTxkPVdoY0aHBWaAICfr+ROpJFa6xFlt6EwWUd2vlM/QK6gyNfax3Znrae2LE16Ut4zQv67M=
X-Received: by 2002:a05:651c:20d:: with SMTP id y13mr6969951ljn.29.1590126566521;
 Thu, 21 May 2020 22:49:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589058209.git.matheus.bernardino@usp.br>
 <e00674c7278b032b826110f33e25a5dee176c7ba.1589058209.git.matheus.bernardino@usp.br>
 <xmqqh7wmqn7k.fsf@gitster.c.googlers.com> <CAHd-oW4k-9ZHQJcqEUqzxw0YShPWCaG61=v4wyBvXte2sSTV5g@mail.gmail.com>
 <xmqqsgg4wuwt.fsf@gitster.c.googlers.com> <CABPp-BFiPO_Hg-F2edv9GVQSqJCNj6NvOaB5Ez8UUzAMPdTqUw@mail.gmail.com>
 <CAHd-oW7K+OVjScLmL34ctQMYRPqz3B+nc9mNP+v1b2JbaNoMsw@mail.gmail.com> <CABPp-BE2PFzUA0uXLXoUw=9aaLU-HvUcf2mdej+atzOGO6GhUA@mail.gmail.com>
In-Reply-To: <CABPp-BE2PFzUA0uXLXoUw=9aaLU-HvUcf2mdej+atzOGO6GhUA@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Fri, 22 May 2020 02:49:14 -0300
Message-ID: <CAHd-oW7_6+Jv+SQG3qh8eRjwJmqnRJKs=_bAV3WaC4-SKkoywg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/4] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 2:52 PM Elijah Newren <newren@gmail.com> wrote:
>
> On Thu, May 21, 2020 at 10:36 AM Matheus Tavares Bernardino
> <matheus.bernardino@usp.br> wrote:
> >
> > On Thu, May 21, 2020 at 4:26 AM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Tue, May 12, 2020 at 5:17 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > >
> > > > Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:
> > > >
> > > > > The idea behind not skipping gitlinks here was to be compliant with
> > > > > what we have in the working tree. In 4fd683b ("sparse-checkout:
> > > > > document interactions with submodules"), we decided that, if the
> > > > > sparse-checkout patterns exclude a submodule, the submodule would
> > > > > still appear in the working tree. The purpose was to keep these
> > > > > features (submodules and sparse-checkout) independent. Along the same
> > > > > lines, I think we should always recurse into initialized submodules in
> > >
> > > Sorry if I missed it in the code, but do you check whether the
> > > submodule is initialized before descending into it, or do you descend
> > > into it based on it just being a submodule?
> >
> > We only descend if the submodule is initialized. The new code in this
> > patch doesn't do this check, but it is already implemented in
> > grep_submodule() (which is called by grep_tree() and grep_cache() when
> > a submodule is found).
>
> Good to know.  To up the ante a bit: What if another branch has
> directory that doesn't exist in HEAD or the current checkout, and
> within that directory is a submodule.  Would it be recursed into?

In this case, `git grep --recurse-submodules <pattern> $branch` will
recurse into the submodule, but only if it has already been
initialized. I.e. if we have checked out to $branch, ran `git
submodule init` and then checked out back.

> What if it matched the sparsity paths?  (Is it even possible to
> recurse into it?)

That's a great question. The idea that I tried to implement is to
always recurse into _initialized_ submodules (even the ones excluded
by the superproject's sparsity patterns) and, then, follow their own
sparsity patterns inside. I'm not necessarily in favor (or against)
this behavior, but this seemed to be the most compatible way with the
design we describe in our docs:

"If your sparse-checkout patterns exclude an initialized submodule,
then that submodule will still appear in your working directory." (in
git-sparse-checkout.txt)

So, back to the original question, if you run `git grep
--recurse-submodules <pattern> $branch` and $branch contains a
submodule which was previously initialized, git-grep _would_ recurse
into it, even if it (or its parent dir) was excluded. However, your
question helped me notice an inconsistency in my patch: the behavior I
just described is working for the full pattern set, but not in cone
mode. That's because, in cone mode, we can mark the whole submodule's
parent dir as excluded. Then, path_matches_pattern_list() will return
NOT_MATCHED for the parent dir and we won't recurse into it, so we
won't even get to the submodule's path to discover that it refers to a
gitlink.

Therefore, if we decide to keep the behavior of always recursing into
submodules, we will need some extra work for the cone mode. I.e.
grep_tree() will have to check if NOT_MATCHED directories contain
submodules before discarding them, and recurse only into the
submodules if so. As for the implementation, the first idea that came
to my mind was to list the submodules' pathnames and do prefix
matching for each submodule and NOT_MATCHED dir. But the places I've
seen such submodule listings in the code base so far [1] seem to work
only in the current branch. My second idea was to continue the tree
walk when we hit NOT_MATCHED dir entries, but not doing any work, just
looking for possible gitlinks to recurse into. I'm not sure if that
could negatively affect the execution time, though.

Does this seem like a good approach? Or is there another solution that
I have not considered? Or even further, should we choose to skip the
submodules in excluded paths? My only concern in this case is that it
would be contrary to the design in git-sparse-checkout.txt. And the
working tree grep and cached grep would differ even on a clean working
tree.

[1]: builtin/submodule--helper.c:module_list_compute() and
submodule-config.c:config_from_gitmodules()
