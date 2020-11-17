Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507C1C2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 04:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1400C246A6
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 04:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hc0ifUbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgKQEx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Nov 2020 23:53:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKQEx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Nov 2020 23:53:58 -0500
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99A1C0613CF
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 20:53:58 -0800 (PST)
Received: by mail-oo1-xc43.google.com with SMTP id z13so4455679ooa.5
        for <git@vger.kernel.org>; Mon, 16 Nov 2020 20:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X+GxGLcIracSP9Bn3wToZxS9/RMXf8XeFy1u15qyM/k=;
        b=Hc0ifUbukbhNJatm8rVJdUEA8HXw75B5Ng9/KXx4nY/EqejHwJ+Bvtt4KfaA6v7JGg
         Sh39nPgz8nY9tGZ2pS9kZah6XE65imvFOu3qZXVHxZtkH9vt253mffsL6OsiXWeLOZXH
         iZwuy8vvwKY/ErUmc/UIZMqfLJWnwsYgBUnZNBKD2DvxBbarysne2ojKgaG6AV1Rwfa3
         y4YVslBPLaBk20GDPpvC9E/Tg+4Bw1KD67Z2cvO8IskdCCffIPZr/stTqVR46O3lq5Lj
         3ZpM4YOgzkp1YNCbsmFfPv+ZTb8lfZvqT2XW52pAMZ7g2G0qXAJBR9ADaJuVwAfjiopu
         I/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X+GxGLcIracSP9Bn3wToZxS9/RMXf8XeFy1u15qyM/k=;
        b=J5Y1fR5imFhy18WZO7prztXiCb8ck06rCWWllaA4KfPplILqv4nQlBHBGC+2na4KXU
         t1ml7JjR6RoFgCk4HEiJNZuG5/UkV3NajG9w5fKKnE57rV7/1NJFwfIXml8ZMyW/twZC
         svZ7CJqxFY3XjpJFnN5h653EmuwMyhZFooLVaZP+AfjqsrPHEQu/oz4We+8tQ5P+W55r
         Dan74pg4UkmsrL0eI8EtIqNdA2VzSccqGkbrcUUX1Gxv6oz///4g3eZrkllL137PUDvL
         o1iZXFuVMMxqjdifQdslttZ+L68Jot51UZmVdOrHZzzULz9OxpTZ+B16Mdyoqu18N6Fi
         flmA==
X-Gm-Message-State: AOAM530d+G/CPJ77e6NoMZY1bgff1EDhI1XksyJ7BH6QHi957IUjxvkB
        mkEQUxKnIl5rYM+LxDv+M/6Iz9yOvXlzUaEQnd0=
X-Google-Smtp-Source: ABdhPJzSfM/hrZZL4M38ipU6wiUITcL8FIl0Psb3UmQsEfxc5U2hraop0aw/2pnlPXHrv65cv5O3iIbyZ5q5Sn6zckY=
X-Received: by 2002:a4a:8519:: with SMTP id k25mr1910753ooh.32.1605588838038;
 Mon, 16 Nov 2020 20:53:58 -0800 (PST)
MIME-Version: 1.0
References: <9f2135f90ffea7f4ccb226f506bf554deab324cc.1605205427.git.matheus.bernardino@usp.br>
 <CABPp-BGkkNwdjLB4HSygvU43OZRiuhDyt7RjrDGodWrfNgkBXQ@mail.gmail.com>
 <70ae5b1d-b1d2-1b3f-11cf-8e5ceafe6048@gmail.com> <be43763e-6931-3e84-8e5a-0ac839cc0566@jeffhostetler.com>
In-Reply-To: <be43763e-6931-3e84-8e5a-0ac839cc0566@jeffhostetler.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 16 Nov 2020 20:53:46 -0800
Message-ID: <CABPp-BFFcP5a26f3o1_gna=G-WcP1LD78aKztjbWOgjeD5F52A@mail.gmail.com>
Subject: Re: [PATCH] rm: honor sparse checkout patterns
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 16, 2020 at 6:30 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 11/13/20 8:47 AM, Derrick Stolee wrote:
> > On 11/12/2020 6:54 PM, Elijah Newren wrote:
> >> Hi,
> >>
> >> On Thu, Nov 12, 2020 at 1:02 PM Matheus Tavares
> >> <matheus.bernardino@usp.br> wrote:
> >>>
> >>> Make git-rm honor the 'sparse.restrictCmds' setting, by restricting its
> >>> operation to the paths that match both the command line pathspecs and
> >>> the repository's sparsity patterns. This better matches the expectations
> >>> of users with sparse-checkout definitions, while still allowing them
> >>> to optionally enable the old behavior with 'sparse.restrictCmds=false'
> >>> or the global '--no-restrict-to-sparse-paths' option.
> >>
> >> (For Stolee:) Did this arise when a user specified a directory to
> >> delete, and a (possibly small) part of that directory was in the
> >> sparse checkout while other portions of it were outside?
> >
> > The user who suggested this used a command like 'git rm */*.csprojx' to
> > remove all paths with that file extension, but then realized that they
> > were deleting all of those files from the entire repo, not just the
> > current sparse-checkout.
>
> Aren't the wildcards expanded by the shell before the command
> line is given to Git?  So the Git command should only receive
> command line args that actually match existing files, right??

Good point.  I suspect, though, that the issue may still be a problem
if the user were to quote the wildcards; that may have been what
happened and the reporting of the case just lost them somewhere along
the way.
