Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80959C433E6
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A1E96146D
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355310AbhCDAWU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1835973AbhCCIDW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 03:03:22 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41596C0610CB
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:42:27 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id l64so24969641oig.9
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dqI6mDSKa/52TNwSFf78hnaXqAXOPsM5oD3UsXR/x+o=;
        b=DJH1e7nEGV7wMuGMwDhkj6/FxXMcVtwE7QY8gABSQT9ZS7j83ouRnoIdISIvtsQxMB
         D3084PwmqG9WGhd84+pIUuMVD4aPnCOsG/T5XazzUYlGwkT+FHB3p/ihgap9NE035qW7
         KDRHSCyFHXGsGE8wnK68dty7+RJxsE0WJSSHyqkizIme00JAiNsOjRajBxHABNU2CRMK
         P8g6SY64nhCk6fZDNvzgAe9nJyo3dxVcWFiCkj2OBzOpENGFEyr7kJbuMsYwbIliZIv8
         wevaPX/zkby4Jr6ymlVkJaZWNNgoY8fxxHSI/SULNU+PtwSHJ8Sh3RjpiPa8P3Bweg+p
         +YsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dqI6mDSKa/52TNwSFf78hnaXqAXOPsM5oD3UsXR/x+o=;
        b=O1/BimDPn7h5oT5CH/6yVHxLB/qOEBUImNAIOuQQBcbtbosINI9zwrYCuLuy7cHXLC
         lRim8acAVcDXl1WatmyCci7ejKTVV3uIkpjU0cUfdE8VGYbe2OM+dBTPFOgdtQPXJfE1
         qzw13I9RAx8d0V5o3mHYcgatJhUkKbEcZypClgbNb/1uQBUXolHQ2I7+vomhWtWjWJpF
         kCzYZX2uHEA6yP58g9FXeuujKvylpasT2AddOFiBv4/Zc45ciIJLzgGXa3MhtDV8fg+T
         kIyfOekr68j0l104v5BzDJ1yRKpFdZADa14ElrrhphsDVMZCSS79gy5oMNwfTUsh/96O
         WsgA==
X-Gm-Message-State: AOAM533Rod4T9rC53lBhl+xgM2BcZ58d6YsP1ioh4jEHKnhJSJ8MxlyX
        oOO7F4CDTO1bbJuZAm5EnAJsb3bEtSoCNjzlHgs=
X-Google-Smtp-Source: ABdhPJwkg4BxPdKsU8vc2fsBmttbz/o6XovWNYf85rKq3F1lV0RoX5C1IqVpSngjchj6T/pTD0pcrmSm0+84d7asx7o=
X-Received: by 2002:aca:3383:: with SMTP id z125mr6278077oiz.48.1614757346719;
 Tue, 02 Mar 2021 23:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-3-charvi077@gmail.com>
 <CAPig+cQAG3p6rhGHzBNGPUxMXQbbLZgiw-uUpizNiEWY9wm-3A@mail.gmail.com>
 <xmqqlfb6mrnx.fsf@gitster.c.googlers.com> <CAPig+cQ9wBLdKqmgjX4eOT6mvukmHXCDicTo5Ud+4VTkzxcXrg@mail.gmail.com>
In-Reply-To: <CAPig+cQ9wBLdKqmgjX4eOT6mvukmHXCDicTo5Ud+4VTkzxcXrg@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:12:15 +0530
Message-ID: <CAPSFM5eosfQofhZjPz_TbchrSqj07EnQPKU0MFvgG=LtsiKVPg@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] commit: add amend suboption to --fixup to create
 amend! commit
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 04:17, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Mon, Mar 1, 2021 at 5:32 PM Junio C Hamano <gitster@pobox.com> wrote:
> > Eric Sunshine <sunshine@sunshineco.com> writes:
> > >     if (skip_prefix(msg, "amend:", &arg) ||
> > >         skip_prefix(msg, "reword:", &arg)) {
> > >         ...
> > >     }
> >
> > You still need to compute "len" because you'd want to tell between
> > --fixup="HEAD^{/^area: string}" and --fixup=bogus:HEAD (the latter
> > would want to say "no such variant 'bogus' for --fixup", but the
> > colon in the former is not the end of the name of variant.
>
> I see what you mean. I vaguely recall quickly scanning over that
> earlier discussion about ":" being otherwise legitimate when embedded
> in the argument as you demonstrate, but didn't think about it when
> reading this code. Perhaps the comment which this code adds:
>
>     * As `amend` suboption contains only alpha
>     * character. So check if first non alpha
>     * character in fixup_message is ':'.
>
> could be extended a bit to mention that briefly since, without it, the
> significance of "alpha-only characters followed by colon" is not
> immediately obvious.

Okay, I will reword it and make it more clear regarding the main
reason for choosing this way.
