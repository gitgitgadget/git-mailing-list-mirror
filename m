Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EFAC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 02:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA33239E5
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 02:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgLICda (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 21:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgLICda (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 21:33:30 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1CDC06179C
        for <git@vger.kernel.org>; Tue,  8 Dec 2020 18:32:44 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id m5so61246wrx.9
        for <git@vger.kernel.org>; Tue, 08 Dec 2020 18:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mPzs7Ez4akuOIElfU7Z0K5FUjRg73FKCgRx+oz6yBRQ=;
        b=ijuqMcT/uzP2pbmdrTiiW0fiCvxHLqRVS/OCrWVluH8QBybGSiohEWc337VDOuW55T
         oCrrwYlZr4scqndaJIq3QuJKY+5GzrARWs/mCvn2E3oFrPBgKMRQEeAM1yjmic7kGUv9
         CXkR+cFvW3s3Wb5yGWdyXfkmOntufsmncyP/vtxFSZ5VsVh6wCtEpnydxQoxdCEgc55X
         JgXsJZEiFl/ZspmKyU146cSur4p8aA//wZB5QGc7lk9g0TAEDDgjceh9FMYRI2B7b96J
         0VR03Pmci/k63JA8nQeDFQlUMWqXsqmI0QvBAN/DaGvryS8aDdXU4nCqmo/IPnQHqSBu
         zQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mPzs7Ez4akuOIElfU7Z0K5FUjRg73FKCgRx+oz6yBRQ=;
        b=SpJnNxTuDx2qTOIYECWrzChNUjehofI071RfN7isP/g1f0kHegtHCadTAF2ZgAJcic
         Xl6ztsAewnnRESz4GwpCNpNjk6aEbkB+g++c4iaUXSYMX2JexTPzknTCADtNMMR8IrC1
         C0NoI8GtdIVD2pS2zJ17nJGGG6LJkiTL0mNJXk0qn1Nt0y7wJsJ9MEvrISsMAXC9MZ5E
         HQlSV2mDt7gUwY0kikWDJoNCXKvyuRrM7LLtr8BHRfhPjnXz0sxHeLt7TCjawgYp3ZUd
         sxb1HWmrUHDEMb1zot2WJsy8OFKlE2eBmDPTvuiOccMHJ8aOdo99wRhQCy4rADofy40r
         26aA==
X-Gm-Message-State: AOAM532AGSrLNEPUtoS4EDgtjzSkkWotJNyTBFk6TAwIdYnsijfBifAR
        Z9A1a8J8/QE1PkODhJQ5nsuiGiKUQSHWRj210qU=
X-Google-Smtp-Source: ABdhPJy6FN8qN8UCzC4KN9yRIXhXIRVvvHoVyclipU13DTi49jS4US2v2SEF0dJQnwsC7d37pt0nD1v0KP27wiZ7sec=
X-Received: by 2002:a5d:68c9:: with SMTP id p9mr77101wrw.139.1607481163029;
 Tue, 08 Dec 2020 18:32:43 -0800 (PST)
MIME-Version: 1.0
References: <20201209002619.25468-1-felipe.contreras@gmail.com> <xmqqy2i74wgv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2i74wgv.fsf@gitster.c.googlers.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 8 Dec 2020 20:32:32 -0600
Message-ID: <CAMP44s0nno90=xKmiZ0=PYQKraSwev7hmEUXfHoFDU3FR37KCw@mail.gmail.com>
Subject: Re: [PATCH] Add project-wide .vimrc configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 8, 2020 at 7:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
> > It's not efficient that everyone must set specific configurations in all
> > their ~/.vimrc files; we can have a project-wide .vimrc that everyone
> > can use.
>
> Does .vimrc gets used from the current directory?  If so, just like
> clang-format, it makes sense to place it with dot-prefix at the root
> of the project, like this patch does.  But ...

Actually no. I tested this with "vim Documentation/git-pull.txt", and
that works fine, but apparently only from that directory.

I'm investigating other solutions.

> > By default it's ignored, you need the following in your ~/.vimrc
> >
> >   set exrc
> >   set secure
>
> ... it does not sound like it is the case.
>
> And I am sensing that this ".vimrc that happens in the current
> directory is not used by default" is not such a well known fact
> among vim users (otherwise you wouldn't be writing it here), and if
> that is the case, I am afraid that this invites an unneeded end-user
> confusion when they see dot-commandname-rc file and see its contents
> not honored at all.

I'd say at least 90% of what vim does is not well known for most vim uses.

> Whether it is well known by intended audience that it is by default
> unused, we should give the instruction we see above (and below, up
> to the description of how to override) in a comment at the beginning
> of the file, I think.  Then, once the user follows the insn, the new
> file added by this patch would start working without any further user
> action, which is very nice.

Right. That makes sense. I'll add the instructions to the next version
once I find a good alternative for exrc.

Cheers.

-- 
Felipe Contreras
