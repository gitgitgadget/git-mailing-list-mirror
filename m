Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6086C433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 04:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63DAB64E8E
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 04:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhBMEZZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 23:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbhBMEZY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 23:25:24 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A4FC061574
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 20:24:44 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id e5so1176921otb.11
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 20:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hsD7fXo9ldLGN5f7GtWpKrpklW0m6IufblxKi8ZAcHE=;
        b=nEuTjMvKGkiWhbYq8nFfvmRYkgfoz2thSoX76AqySDazNnn3tbIeQCblxsxwjaIfDN
         fXLPyQrUyif08NL5G2Ulol5Xhs7GU/UKWWWmf//fA9JTpHK6p5SxVyNhcD5OMTn8W4XC
         PyW70mamwzdR3R9kaDPgtkfG1g2QfFoRLH+9FZOi/hP09HB2YJ+g0XufANu3RvEaFJCh
         LKg0aOxXau6jGaSlLUGvOXwcRlnGb/TVSXQ0ElALIVSl/LJH6mCmuqEHaAiOxeyeau5R
         Y5Y6JNk1uIMdRRkRsd6gHsP9T56ObaINC04bvBjv6h6uXVy21K+sgK6jNPw7ZedcBD9M
         GR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hsD7fXo9ldLGN5f7GtWpKrpklW0m6IufblxKi8ZAcHE=;
        b=nISJVYuJ4E6Fx/bJK0hiFFX1jBCrptce1E1ncnT0xV2BlRLDNNGvVFwl2opi8faMYP
         CuheE15Y+kRjG/2WXy+w3ZX2UI1v5S/Ts5J3FtmZ7LoDwyRPmOzjy7xNsX4OoJx2MWLv
         23YZckAHXNq/fkpNUH2xr9M1c6djprlMenhAMEm05nrPAKGWsjB07WNw0Mpw4aU0Jgdj
         ZGhh+SuHVGzIpTQ3Qla2EboPQf+yOHzEpIK/GGdGaCTzxkJ92BzbCfNI/kqLaNvIMvD7
         TYk59I5xW3cO4g7ozksBVEvicQ+fcKbzKeErKtKYWj2jA/fOxjBfsW2BWZWsgD8LENhq
         sWVg==
X-Gm-Message-State: AOAM531XbfXnZIAsdadIzbNUKIMfCFZBErYV9DHV2ZEMqwmGcMUTe5ly
        5hve6pBEcjOjdxA9EZMN8dIE7BlNJWfKo9zWYr7is88tKKU=
X-Google-Smtp-Source: ABdhPJwkqMrIG5tPLIM5qMJWE83PXbIT+Zfb6tStanN92MONCSuEk5EttsQX7oMHt8uS4kebaozEoRoyFLJftY1kREs=
X-Received: by 2002:a9d:7dd3:: with SMTP id k19mr4404089otn.162.1613190283211;
 Fri, 12 Feb 2021 20:24:43 -0800 (PST)
MIME-Version: 1.0
References: <pull.842.git.1612331345.gitgitgadget@gmail.com>
 <pull.842.v2.git.1612382628.gitgitgadget@gmail.com> <7ae9460d3dba84122c2674b46e4339b9d42bdedd.1612382628.git.gitgitgadget@gmail.com>
 <xmqqczx4vkus.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczx4vkus.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 12 Feb 2021 20:24:31 -0800
Message-ID: <CABPp-BEpvx-pHQs3_mK-Wr=ZmZRwLD4vA64LLryU4ehqiCz58w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] diffcore-rename: filter rename_src list when possible
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Karsten Blees <blees@dcon.de>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 12, 2021 at 5:04 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +             return; /* culling incompatbile with break detection */
>
> incompatible.

Thanks.

> >       /*
> > -      * Calculate how many renames are left (but all the source
> > -      * files still remain as options for rename/copies!)
> > +      * Calculate how many renames are left
> >        */
>
> This no longer needs to be a multi-line comment, does it?

Indeed.

Will fix both.
