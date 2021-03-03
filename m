Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ADC433DB
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910C064DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355287AbhCDAWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1576843AbhCCHdk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 02:33:40 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46CAC061756
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:32:58 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id f3so24935925oiw.13
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zt9A5+oBKLppk3JvySTvDSMaOOgpLzrLIaYyGE4tV6E=;
        b=krbgivsm2gXyKlRosGc/JvNixfQqPZDCC3OzHiGC0SxnUFQWUEplSBD4uJwhvW89h6
         82xE8yo4qdCYTmiljsr7grU2XYbAEUePScb7b/I9sXgBB2ToT4Nesummx3blokw/YO9y
         YG9KbWY5wX3VmaAlT7xUA3QXuFY9o9s+FMSmJgxG49G1shw2RbT2JkzIdWgcmOWrMzvR
         ZoyrG6R0aAH2fUb94aFPq5oZhVyMwpqIHUv7cKtYs0SPJTWUXVRh+YiK95J8jKMWu4yv
         EnK8Wum48c8iqbi9GPOGUDujVkzYrO9QOHrFtfggBWRxERLsmG86NYwLdiWhBxi3FS81
         4qIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zt9A5+oBKLppk3JvySTvDSMaOOgpLzrLIaYyGE4tV6E=;
        b=RKZlfYa2ZOWcBAiK5NxIZGqiUCOXV32DgIbipuvQesm1Uk9ByCNRV7/Ct0fD1yjC6k
         RvAHgjolKsfR8xccXcGTxAe/GZ0zr388f4CwlW7yJK+vymEmjAILna2ykIVtls5DGk5C
         icjMiYNDIJVDu8Uq0kw8DN49eRRR1fZg30GrWdgHr0E9tJRItbKW33fox6BVmK3XQ2Lv
         RENrpGeJc4YcHRdbSGE1RfgEDz5S4nZmd2zfVM6a8WakleyJ942DjJzuf/+ywiR7tbOg
         F2j5h4I+xwfF/7y6RMFTfO9JFFLy+Aucim5kwe0t/xCLu5gNRflYl0nxDqUGUkxW5CJT
         RTXA==
X-Gm-Message-State: AOAM5308PCJVYGC6p/l4PbRDTOvr91Vx/L9cxxCIcNWGl12v6BeXUN28
        JEkiHcMMK+kdRF3s5NgeydWwJNbfwlmLHYijYbE=
X-Google-Smtp-Source: ABdhPJwgjJTKv5KxIGvsU91vKLOJL8+BbdoxJpseoz2zSyhcY+SiGOejOBifQMPxrP9YObERuFWVZ1+oxkfx2Ks6mQo=
X-Received: by 2002:aca:3285:: with SMTP id y127mr6222087oiy.98.1614756778120;
 Tue, 02 Mar 2021 23:32:58 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <xmqqlfb6radq.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqlfb6radq.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:02:47 +0530
Message-ID: <CAPSFM5ds3743XcBQg2k6TkQKFhxyefAEG_+RMM5OAA+0odyyAA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 00:04, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > +static int prepare_amend_commit(struct commit *commit, struct strbuf *sb,
> > +                                                              struct pretty_print_context *ctx) {
>
> Why does this need to be overly indented?  Are you using some funny
> tab width settings?  In this project, a tab stop is 8-spaces wide.
>

Oops, I myself didn't expect it after cross-check in the vscode
editor. I will fix this.
