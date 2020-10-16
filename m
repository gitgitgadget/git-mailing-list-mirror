Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D57C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F9AD216C4
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7x01Y8q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409200AbgJPU5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389479AbgJPU5L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:57:11 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8DDC061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:57:11 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l85so3955334oih.10
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x9/g7IsfquJDP58pR/I3Un9Q/FXK3ZO8vu0hBJNo09A=;
        b=W7x01Y8q0HcELcdLH85tIy5VBSIaT32PjIxwNj84cn9P5ABcCMfaXsspuJ75xnA3fr
         vwvg5XiRL8MRnPLsPGWfhuyOQWiIuGwVfTeLoG+KgIcFcyS3bWnBAR7vx4wMODhoWOfE
         B7fHC6HKTefXKgszrahaCpnAqow3uEMMZDY8PPXLd2HiUj/Y56j7Zhp1alNwLrdb8+Vz
         q2fiZJMbtk/8y4JoBje2Dm0QdCjuTiDiLej1kM1jzsW+CKSQPqsNyVMynvFuUb/+XhXP
         6oKNMCKG6cJb4SJ5oMmpGJJpVG2flJaaXvkuqF4CqGw4mCXB9sVG0D0lW6G+1DuzS3R0
         PV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x9/g7IsfquJDP58pR/I3Un9Q/FXK3ZO8vu0hBJNo09A=;
        b=e+j7InsCfJjNUyb/UMprFm8qKI7S7H0NKhfP4LT6UXSoilCCTBCf6GDDNLXOL8HLI/
         u4GedoVqy71K3WYhd8KcfaBT6XPpurWWUjDm1Ab6eAx12u4ttp9W7epfTOVeP9e0yyqL
         0rP9zQNmI1EHcbGuHrsnhs/zlXwWaHSdGJEJXPI7tHziGC05ABlxDDYbKlcl6mm4cwl7
         tDIZCZV33WF6RWcpGItdpeVlWat26xhjC5zGW8+pTBD0yzHci5VLrk/fCpX5AJ+B+OMn
         BIIgTNrl4e6FILBx10DkmIFyclrIDz/sXxHuPeUExtr+E8UBrB5ZhuB3+OogjFwAOBD0
         3m6g==
X-Gm-Message-State: AOAM530vVPqpS5xoxapeOni+agpOKzKHiqKjv24PCpjGysVmMe3y47C5
        6UDayNhO3siSqYGP4JdKH1r03DoILUwltBRBZHcTAvA3Nos=
X-Google-Smtp-Source: ABdhPJw8YA0DdzcQmO3EaHSLTDNlgtKgVKx6BRJzfsH2Fxj0DVhDqtTJAfYuIaTUn1iVK8NfW/VFGo6nbuFb+iyjm8M=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr3588564oic.31.1602881830748;
 Fri, 16 Oct 2020 13:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <pull.878.v3.git.git.1602710025.gitgitgadget@gmail.com>
 <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com> <xmqqzh4lapfr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzh4lapfr.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 16 Oct 2020 13:56:59 -0700
Message-ID: <CABPp-BERdr-UvMEe=kjeRjtXfeV0uu2LOk6G3oYGMWe=gxKxeg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] Make test selection easier by specifying
 description substrings instead of just numeric counters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 1:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Changes since v3:
> >
> >  * Added text to the README explaining what to do if the substring you want
> >    to search on includes a comma or whitespace (namely, use the '?' glob
> >    character instead)
>
> That would work just as well with or without forbidding spaces.
>
> >      ++The argument to --run is split on commas and whitespace into separate
> >      ++strings, numbers, and ranges, and picks all tests that match any of
> >      ++the individual selection criteria.  If the substring of the
> >      ++description text that you want to match includes a comma or space, use
> >      ++the glob character '?' instead.  For example --run='unnecessary?update
> >      ++timing' would match on all tests that match either the glob
> >      ++*unnecessary?update* or the glob *timing*.
>
> OK.
>
> Will queue.

Since both you and Peff argued for just changing IFS, I'll do that,
and update this text and elsewhere in t/README to reflect that we only
split on commas and send that in as v4.
