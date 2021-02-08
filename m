Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E604C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5DE64E66
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 04:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhBHEb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 23:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhBHEbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 23:31:24 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F10FC061756
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 20:30:44 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id l23so1349643otn.10
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 20:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCB8pGWKyhUWz5/9Zmy4eDixzjsrMH9vZMi24mCgfEQ=;
        b=IB4+x0mwXEo+EPNqb2LA5bm4s2apt6j9FALEl22MhBxEz0blQ5gv9+7snPJPAnrC1I
         PkHI+k5DNnGFm24DZao38lfLf7OFxHaxeM0tCevNgHFJcyMachZFnA8yFGUZvrYYkn89
         9B806TXEovKPFTEhJViK3LUFGWm9XT/jQ20MAqGRHHm10omO1e8ocMfzYdhGUr3KgqOV
         5QQpZSsMICey5YlT7/uqSDfOZwsTGa/nxj6fTW44sCvgrb7+g36YXtUxJNisszlQNL7D
         DH1iGRtCdkK4XyQNaVoRtUbpABIigMdohOyZU6Y6ihMPSiGgXV3BmfuvYmcCpX7olf5Y
         +iJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCB8pGWKyhUWz5/9Zmy4eDixzjsrMH9vZMi24mCgfEQ=;
        b=r2VnMGrZAUCmDzvcZ2Y7qIhYSVZnFOU1LGSlHPNm/ZZ50qUDeBOAVgToHyVrfE48dk
         7JmtytOI49tMV6tbfk84FilFcCrOo7tzSD2lcUmktZoqkzmE6IxGc6WVn/9yWb763Nhx
         LgKjbAsUL0J2jw1tprbwUBF2oLdWONGMfCvBjQVhwdmZApyeWzLycqhvrXeritbNMyxt
         fG5ffmAxIi3eLxMOVHYNoJRTqUNw/vP5tKrAb9Q+sSgOONaHxI3LflBBryKtPcLfvSA0
         N2lL/PRH0n6xAXriNnaZllRxPXOTMDjDeIbgsgsA0XhVyGsve/4wAt4AupqKixXv/rpH
         IXMg==
X-Gm-Message-State: AOAM532hpTthwIjprw9afYcgQWU3FCbGkAv044uJfwP19dTQ2vZ5hHta
        mzK2xuG/ckDKzorZA6yMgYS4ygOLpYY/rQjTPYA=
X-Google-Smtp-Source: ABdhPJwRP+nw4+FP3aD+LAKcCKu0PM4saogbI3Q6PnTbbz5eGeH/ShEzeLeHjT9o6FyrdzTt4o/3YPA60fWYLJKe+3M=
X-Received: by 2002:a9d:313:: with SMTP id 19mr11250251otv.147.1612758643722;
 Sun, 07 Feb 2021 20:30:43 -0800 (PST)
MIME-Version: 1.0
References: <20210207181439.1178-1-charvi077@gmail.com> <20210207181439.1178-4-charvi077@gmail.com>
 <CAPig+cS-QK7dZ63NfEY8S2z+wveY43dHkQWV3krNDP_dYSfyJw@mail.gmail.com>
In-Reply-To: <CAPig+cS-QK7dZ63NfEY8S2z+wveY43dHkQWV3krNDP_dYSfyJw@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Mon, 8 Feb 2021 10:00:32 +0530
Message-ID: <CAPSFM5ewDzL6UEKoYfjhvBfDxZj-YrzA4aoO2McqNdCVW=SZBQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] rebase -i: clarify and fix 'fixup -c' rebase-todo help
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 8 Feb 2021 at 00:19, Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Feb 7, 2021 at 1:19 PM Charvi Mendiratta <charvi077@gmail.com> wrote:
> > When `-c` says "edit the commit message" it's not clear what will be
> > edited. The original's commit message or the replacement's message or a
> > combination of the two. Word it such that it states more precisely what
> > exactly will be edited and also remove the use of a period and
> > capitalized word in the to-do help text.
>
> If you happen to re-roll for some reason, it might be a good idea to
> explain why you are removing the period and capitalization since the
> reason is not otherwise clear to the casual reader. So, perhaps:
>
>     ... exactly will be edited. While at it, also drop the jarring
>     period and capitalization, neither of which is otherwise present
>     in the message.
>
> or something like that.

okay, I will change it.
