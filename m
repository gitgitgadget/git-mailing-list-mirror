Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1284DC00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 18:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A605E2151B
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 18:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTRrMYlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbgJ3SDB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 14:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3SDB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 14:03:01 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2153FC0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 11:03:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w191so7548745oif.2
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 11:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igwwMtzoXlFL4KB/FPZBFsgFRF4J3w7/z3O892tRg8M=;
        b=GTRrMYlVTtytQn2+ahvC1CQMIVJDQ6waBdRbBCWWPyNzvvdmJtouopOLDJL9Ihtk/i
         1Epg/F/yE5p+cKG5Hbo6qo4/F61D5I1BFGUnr/3r8/QwX/ULjleKi7kNVDIHxbuwcy2y
         4nmeT4vx8NfZ0GFWD6HUl5YArS9Ck4RQ2Dnhv+Dt26yBr43Sfdfcid4wCj/RAnn0vLub
         pPFYO343PPbeLny75xbplwOkH+wFrzFDPgdGZwGIYmg3PhlMrWIx4L+xSFgnHz7X9Ktx
         kw9kI0ez6oWwPp5Wg5gwUd9g2NAK8AeWtpeaL/+BL5WFvTm3s+KdWdYI1/YjlSbxWRI/
         /stA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igwwMtzoXlFL4KB/FPZBFsgFRF4J3w7/z3O892tRg8M=;
        b=ar3lskxvWCL/Gk+3MV9Zna0EK/aU8xd5fHdBpuYcFAM93mr7DCGBMTJlf2u5K3NVyk
         NnUSdFkFhuUsChFx5bPV3WlscVh3nZRKrU/ehdnRLR1rb7tGMPpCebJzFFJ10jgvKNx0
         tMNkpOF+VY3y4M996mX2ZCirv7Y5sZdwiayyN1jbZbJgWY1liZ/ZPJfjCGR2GHC23LS+
         YGeUb7eDDS1BcSFKfm3BdVaczphfq3CiQTHlL+/HtGzojMviyDj3nkRUkxnpPDqs5kM7
         xGOeRe6gpIssjr4LJ9NzbGVg0DGldguzDCtddenRtbTpg4ku+SeULsa8EsidbDpaBUtV
         ZeRQ==
X-Gm-Message-State: AOAM531sb064+8wV1JVisKGXJSmFnoAXaKysH2oxNRGOsbX3jTiuHrSu
        tQ/qs1OaJvcm1V8qRAgURzbcgCnTKQlb54xs77w=
X-Google-Smtp-Source: ABdhPJwrrYFwmtuZJfSn2hv7pcgwIZLoJm7bZdb+ug6TnNhSgsH54Ej12LrdbEGt/ChafjRmD/HEaN90B5oMwC7F2M4=
X-Received: by 2002:a05:6808:17:: with SMTP id u23mr2370012oic.31.1604080980503;
 Fri, 30 Oct 2020 11:03:00 -0700 (PDT)
MIME-Version: 1.0
References: <pull.835.git.git.1598035949.gitgitgadget@gmail.com>
 <pull.835.v2.git.git.1602549650.gitgitgadget@gmail.com> <490d3a42add2cc5f0d30db8f2351614294e00121.1602549650.git.gitgitgadget@gmail.com>
 <20201030144418.GI3277724@coredump.intra.peff.net>
In-Reply-To: <20201030144418.GI3277724@coredump.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Oct 2020 11:02:49 -0700
Message-ID: <CABPp-BH63BtybTqT43PXf4=ruyRwP2SBeVw3632zMfQfizeujw@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] strmap: add a strset sub-type
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 30, 2020 at 7:44 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Oct 13, 2020 at 12:40:49AM +0000, Elijah Newren via GitGitGadget wrote:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Similar to adding strintmap for special-casing a string -> int mapping,
> > add a strset type for cases where we really are only interested in using
> > strmap for storing a set rather than a mapping.  In this case, we'll
> > always just store NULL for the value but the different struct type makes
> > it clearer than code comments how a variable is intended to be used.
> >
> > The difference in usage also results in some differences in API: a few
> > things that aren't necessary or meaningful are dropped (namely, the
> > free_util argument to *_clear(), and the *_get() function), and
> > strset_add() is chosen as the API instead of strset_put().
>
> That all makes sense.
>
> We're wasting 8 bytes of NULL pointer for each entry, but it's unlikely
> to be all that important. If we later find a case where we think it
> matters, we can always refactor the type not to depend on strmap.
>
> I'd want a strset_check_and_add() to match what I used recently in
> shortlog.h. Maybe strset_contains_and_add() would be a better name to
> match the individual functions here. I dunno (it actually seems
> clunkier).

Yeah, I'll just go with strset_check_and_add().  :-)
