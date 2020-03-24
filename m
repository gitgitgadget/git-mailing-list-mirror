Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CAF0C43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:08:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6E020714
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 19:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqwiPaLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgCXTIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 15:08:04 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36715 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbgCXTIE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 15:08:04 -0400
Received: by mail-ot1-f66.google.com with SMTP id l23so8057820otf.3
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LSTgTCpZOqCQTdzXjpWmPry22W15HqJbTT59jtARv1Q=;
        b=YqwiPaLRMfUzmiXVZPffESCV9HNLMO7CtoIpipkkJxAeCcHTYrwG8632R8gcduZ0X8
         DmF885UvRG7SRpXGQB6s0dFut2FUSi7fV1qOwXLHei/dM8NH9G8j1kCBpmhSQA8BAgE0
         M1EvDpZY0jAYI3OnaeWxfZY5KdjklC2YwCrvikoCBw8l+ygfjk7s4+xoZjyQUTdM2R0L
         Zp37SNLkeLx5SPnfaw4filgYkRud127GT/QisJ6M+oLvtYOMPnWBcYdoD678Yj/yyB1+
         TBwgOx9mQPpfq1CUeRYwPQLMcmCnkTXOFWbIt0tZ7wbH9LZLHhuvKOoPgy7eOakSM3lQ
         NQQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LSTgTCpZOqCQTdzXjpWmPry22W15HqJbTT59jtARv1Q=;
        b=e+waSu1Tw1nFv7nszxHzXuPu1KOSmaApDCEF3I8PVSf9C7CWV9aIbukjoxD4T5q3rC
         S42ocTNrZu+7RTcUTvCbNNMy/Q/V0RqVPWIOFYOZeZYjwkt4jeafwFDwN70enrhf0n6k
         gMaFSeHGChKKcy4LO46jrYTetY3brXojta0fwy270GDYYodgvbDVvjKDmD0EIV0NNdHd
         FthSjzTv7pWVdzYlQbSGpZ61Ut9PJy49Tc+z1VQg2SjI99P/Utr0J5vtfBIuUEXHi6b9
         7CP1Sp6cj1WBa71eS3SPMq41TLof1ZLztljFNXP5wKNLkt28tOqw/dSMrUiww597f+37
         mmBg==
X-Gm-Message-State: ANhLgQ1/lDD5eMFXZFhMXsTRkCGjtYyjnwZXHhrKnFQ6OHY+bGCZWFZs
        QrHJkWxTcKqfpGRp33MPaUf+s7oqo07BrIHHiE4=
X-Google-Smtp-Source: ADFU+vueWgZ6M217+I/KLyUFld8dk8x1V5jCOQ+Cp0gzaFYfubSdFAaPKQnV3I38ZIvh+UVLZmYvdCJxmjw3SGvFSbQ=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr3408071ots.345.1585076881255;
 Tue, 24 Mar 2020 12:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <a76242ecfa69cf29995bd859305dc2ab1bc1a221.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BEbNCYk0pCuEDQ_ViB2=varJPBsVODxNvJs0EVRyBqjBg@mail.gmail.com> <xmqq7dz938sc.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq7dz938sc.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Mar 2020 12:07:49 -0700
Message-ID: <CABPp-BHtfb4g3-EsiT_X-hCZYiDeDE0mbrV1ZUpOfWujRjAO3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] grep: add option to ignore sparsity patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 11:30 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > On Mon, Mar 23, 2020 at 11:13 PM Matheus Tavares
> > <matheus.bernardino@usp.br> wrote:
> >>
> >> In the last commit, git-grep learned to honor sparsity patterns. For
> >> some use cases, however, it may be desirable to search outside the
> >> sparse checkout. So add the '--ignore-sparsity' option, which restores
> >> the old behavior. Also add the grep.ignoreSparsity configuration, to
> >> allow setting this behavior by default.
> >
> > Should `--ignore-sparsity` be a global git option rather than a
> > grep-specific one?  Also, should grep.ignoreSparsity rather be
> > core.ignoreSparsity or core.searchOutsideSparsePaths or something?
>
> Great question.  I think "git diff" with various options would also
> want to optionally be able to be confined within the sparse cone, or
> checking the entire world by lazily fetching outside the sparsity.
>
> > * grep, diff, log, shortlog, blame, bisect (and maybe others) all by
> > default make use of the sparsity patterns to limit their output (but
> > can all use whatever flag(s) are added here to search outside the
> > sparsity pattern cones).  This helps users feel they are in a smaller
> > repo and searching just their area of interest, and it avoids partial
> > clones downloading blobs unnecessarily.  Nice for the user, and nice
> > for the system.
>
> I am not sure which one should be the default.  From historical
> point of view that sparse stuff was done as an optimization to omit
> initial work and lazily give the whole world, I may have slight
> preference to the "we pretend that you have everything, just some
> parts may be slower to come to you" world view to be the default,
> with an option to limit the view to whatever sparsity you initially
> set up.

It sounds like you are describing partial clone rather than sparse
checkout?  Or perhaps you're trying to blur the distinction,
suggesting the two should be used together, with the partial clone
machinery learning to download history within the specified sparse
cones?

>  Regardless of the choice of the default, it would be a good
> idea to make the subcommands consistently offer the same default and
> allow the non-default views with the same UI.

Agreed.
