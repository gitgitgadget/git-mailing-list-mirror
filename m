Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8224DC433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D27761184
	for <git@archiver.kernel.org>; Tue, 11 May 2021 19:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbhEKTNX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 15:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKTNW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 15:13:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A57C061574
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:12:15 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id h127so16774261pfe.9
        for <git@vger.kernel.org>; Tue, 11 May 2021 12:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j99plUTOOvUWsLURMjarywqHf0OeYYWLKpVFPbbn5Mc=;
        b=cHEHJM4XkffS+sRByeRLdHYlV7RyZmQZb6sari46jZneKTlEFn5tlqQ4QmQYIkdbbb
         ry74AbT5gBUP+3fdR/K9k4+U7WSBa246U1lhAVLKSRBt/FVIfUkrAwcDLZyXfvczEciH
         IZPPt+6h2hO0qf8nRsdRKURYUNE6kpgbX3vTlXCZP6VMEKUMD3k+g7alhDoIsuZ/BoRJ
         SCmaaHEsuPC64hgldfBLQB28qNOoOoPG0ZOf2qO/gRxVWtyigK6HCkASt5kJ+F+HXe/Z
         TE3Ndf0cDmjsrnlUYsTXV7GxuCb5I3ATOEADBoCI5JwKnrodLMweJEBbAPlwQP+Gzt8T
         6Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j99plUTOOvUWsLURMjarywqHf0OeYYWLKpVFPbbn5Mc=;
        b=ITMmdqS8NZiJ8Qg/ZSs0tppp1bJRxOrO5RV5aPtplJDwAUzac1ACR2dapZqJtjGV9D
         qqylAUjnCdMzX1ZBcIYTboUCwLC5sMu4QNxfDWUXqYkQXRBS3kkbb9vA690meOg2Lyd2
         en+2mYh1ne9yR4ZFJGLgUmM89aI8KfjbJjyuZisQvj+Mx8lPTGGrEUvSz7uUNAcmrpfn
         u0FIS84xDK3dcPErVUik5aGSD4iM7gQpnifpBVAd0+zkbGa5PAzNIbYMgK78mbxpZuY5
         dXMAdQH9Qy6KjTYH0pe18dOa4Z3ATfRYjGj+6kEjNEnasCccAKHC4NUSy1DkSZpUpCqi
         gymA==
X-Gm-Message-State: AOAM53016HpS2DfDjoSPsfIRy5rV5YOz7RRGtQsQiYjtB+2JOBlxx64I
        6YCngNoyQy6uUSN11yUl6HNsl1i+ZWEDZuSEVJM=
X-Google-Smtp-Source: ABdhPJzPjNCjednNHMzSaAJcpzXS3nQkU5LhxvmV+lSRMK0GwC1tErR65TqHdi9ZKUP2Kd1ByorqfoC3yrd7cUuP6ao=
X-Received: by 2002:a05:6a00:230b:b029:2ca:4c19:ea87 with SMTP id
 h11-20020a056a00230bb02902ca4c19ea87mr4101922pfh.43.1620760334870; Tue, 11
 May 2021 12:12:14 -0700 (PDT)
MIME-Version: 1.0
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net> <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
 <YJmykGWaWi03+WoW@coredump.intra.peff.net> <CAN0heSp6uw7yqNZLD5w13xJUgnUtgHM0OYw9KQ6Z-FKk+x4OPA@mail.gmail.com>
 <YJrV52HOv0mlbJB1@coredump.intra.peff.net>
In-Reply-To: <YJrV52HOv0mlbJB1@coredump.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 11 May 2021 21:11:59 +0200
Message-ID: <CAN0heSpTPb_3h_Bn6Tboqvg_hW2bT184Z34pfQXg0q_u+JgDXQ@mail.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 11 May 2021 at 21:07, Jeff King <peff@peff.net> wrote:
>
> So I dunno. I certainly don't have a big complaint about _starting_ the
> transition. If we can hold on to python asciidoc support (or even
> old-asciidoctor + xmlto) for a while as a fallback, even if we know it's
> slowly bitrotting, then it's possible nobody would even complain.

You made several good points; I just quoted the last few here. Thanks
for your thoughts on this.

Martin
