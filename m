Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2305C47424
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 16:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99540613FF
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 16:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFDQc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 12:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDQc3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 12:32:29 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 838ECC061766
        for <git@vger.kernel.org>; Fri,  4 Jun 2021 09:30:27 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id c3so10280125oic.8
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 09:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JF9qMkUQ9oo8t+zcKep1aP0qV6IIbGahJ8Lngq3n3xE=;
        b=E0PJ6kXfH2t/HQklBQzVZDZtFrDjJUTLIDR/FxTB/cijJIGoPKSA1Q7kUoZ7ka95cq
         dIqQm9XtHS5gos9q1OLH+SasKomeP4bIDBCuedYvWoijh19K9gFPcXmjQklriuu4zXGP
         28va/v0zLC4k1SNV+GGBpxwWO31m3HdTpA6eM4MI7ctv4VZJ8tQFe1lNaJ042zkc7S0e
         DGcdYzcK8YngYmZjflAlYBAGZ1/WB7MzmlncpcdtQfbk7z2KuoGyP0UA8/940yUOa+s9
         xsysId5HfzmWmnaGrKN5r7KAYmlcG10Jku3fkKHirueq7rEHCjedmBy7khCBq2P7VFb1
         uMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JF9qMkUQ9oo8t+zcKep1aP0qV6IIbGahJ8Lngq3n3xE=;
        b=oJWibaCn/1b2IkUTLYAn+hp8A2LVrckDc3W7x4ko7hmEjTGZXh3EdIpHUVI5NPUv8z
         hk58l1ziuCvWrJHyT5ykzSxMLQe9L7LQLB3WbCnysNeY1wxJs6JAHIbM5f07B3+goGKZ
         A0yv7rUH/ZszK1UsWdi9EnkRIn1vMQ1GeJEbyS6KNUhM4Qt6Aw3C5gttvrG+y5/5Mb4z
         NKQN1T6jjB46H2lwRcJbWjo8pp9GNuk+T34S+C9Yu26dENbzbT/DreQ8i7lwb6D4xUwk
         DUWC4SnjMH4Z6Mu4M3WFzw8lNz9STD4ro8p4OseNUYFFbHRuGCQtc6SgIrYAWAf4xsFN
         mahQ==
X-Gm-Message-State: AOAM531SgoycEhQQy90FaZyGSoetPBa2R3j4EaU2BP1tLczXhuwb0dKn
        z5pivT7m4d3Ie1LpTjLmoZ3MQDX7fPtIDa0TzMA=
X-Google-Smtp-Source: ABdhPJwZaKWpzxuJxoV0fAoScriCt59rtmPCjHTgvPDpmLAw2vSXh4PSwz6Rk3fM8fq3VAJkntVtt6qBkroOpd8a+h0=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr9136994oib.39.1622824226887;
 Fri, 04 Jun 2021 09:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
 <pull.962.v3.git.1622781578.gitgitgadget@gmail.com> <a5755340-c0c8-8028-7c03-3c8e7f0268d1@gmail.com>
 <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
In-Reply-To: <CABPp-BEsiw-E9_TGUDaGEkhQHNqLH48=ZTu7yXX7XqRaM2JdOQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 Jun 2021 09:30:15 -0700
Message-ID: <CABPp-BHbDY+y6mJb3QgYeLaqbPM8qphOGmoZXsO31094ZWgwrA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Optimization batch 12: miscellaneous unthemed stuff
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 4, 2021 at 8:48 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Fri, Jun 4, 2021 at 6:11 AM Derrick Stolee <stolee@gmail.com> wrote:
> >
> > On 6/4/2021 12:39 AM, Elijah Newren via GitGitGadget wrote:

> > >  * Added Stolee's Acked-by
> > ...
> > >  1:  c4a0f6a9510c ! 1:  f63ffc2a7c22 merge-ort: replace string_list_d=
f_name_compare with faster alternative
> > >      @@ Commit message
> > >               just-one-mega:   500.3  ms =C2=B1  3.8  ms   480.1  ms =
=C2=B1  3.9  ms
> > >
> > >           Signed-off-by: Elijah Newren <newren@gmail.com>
> > >      +    Acked-by: Derrick Stolee <dstolee@microsoft.com>
> >
> > I believe the sign-off should always be the last thing in
> > the message. Perhaps Junio is willing to fix this without a
> > re-roll?
>
> Interesting, this is the first I've ever heard of such a requirement,
> and I've submitted patches this way numerous times and have seen
> others do it.  A quick search through git.git history says there are
> 5133 commits that place such trailers before the author's
> Signed-off-by, and 1175 that place them after.  While the former is

Sorry, there was a bug in my script, found while running it on the
linux kernel (where the Signed-off-by stuff came from) to see if it
was different.  The corrected numbers are:

Author Signed-off-by comes after all non-Signed-off-by trailers: 2990
non-Signed-off-by trailers follow the Author's Signed-off-by line: 3069

So, this suggests it's even less of a rule.  For those curious, the
Linux kernel has these numbers:

Author Signed-off-by comes after all non-Signed-off-by trailers: 83530
non-Signed-off-by trailers follow the Author's Signed-off-by line: 199778

> ...
> So, if "Signed-off-by should come last" is a rule, then neither
> existing practice nor our documentation seem to cover it.  I'll assume
> it's not a rule for now.
