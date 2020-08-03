Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE4CC433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D179820775
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 15:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNexjfRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgHCPGN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCPGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 11:06:12 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E3DC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 08:06:12 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e11so3924941otk.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 08:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c5n+K3e8b//iQyxwOIOqVwFvil3EJyWDIkhpyp9hD3g=;
        b=LNexjfRodsWq0Nc42JPR5PXw5PsZWtlk6ten8bzjzXmlknGgoJlzgOfq12tc29/lVT
         CCpwO589kjGym983apVsTvjABMpOoY27ygBhh0aXjLMNe83ByjKXx0mgBQfm3c4kWMiZ
         4SGYfHtc/wH2EBF1ecc79gf/nksLgxv/92/siCEPl+sbF8meFdKN5tlA/ZjGEbdvfq0O
         2A91u//f2wJA9NUnRXl25AmbQP1L2mVS5E8aJKhmVFm7p9YJFrDur/m+oMfDVFlj1MpZ
         rd3QsWARYPc6VBi1kJm4IcTPVKTadfSlHLA+R94Ws8CwYzD5aLtVZ/vWN4pMLAbRN3vC
         V1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c5n+K3e8b//iQyxwOIOqVwFvil3EJyWDIkhpyp9hD3g=;
        b=QUo8CEt4UJYRX0Z//QjrF187Yi3cQuRVA2ojsrZEIimFztQj/wX7r7JSDDSEh4mlpe
         SNJdQhNS7cvcXA2IcGHLFRHaEiOryB/o+pTED/4KgcFUvLXGdxmc7BCrL5+nNK+gUSkV
         LS+PXCPn17o/71TfwrHIz350RiUxQw+4e3vZrU8+XVzZrLXQKUIXtZHrQp4fSsdpKv9w
         XcWm3bAPbnm4vQbDVyCsGuv3OVLdLxo4r7jn3wFBQdtPhfdq3fN4lwmpM+emaKyzqOdN
         7KSmY2M8ofVl8WBRV6rqIxN1koCU3GrsdBNQzq+m13oRdqdcZ0rnfsxCynpWDZ5/2rOV
         tNBg==
X-Gm-Message-State: AOAM532fX8maUovI8F/XmmjYTwKUzuEIbh2/yi1Lgo6JX6MCrbT886RI
        tejaWmGY7oFXxYKuPsXZs6fzlLYCfHpN+0XjH0U/+MEA
X-Google-Smtp-Source: ABdhPJwFB3DTIiiWPi0MKSSvh8H0U6q0MwPJaQmYgPLJnzbr5p33Tb7Pd1dCel7u+AwkBJoAeOFJD35ovcvPksdaDso=
X-Received: by 2002:a9d:67d3:: with SMTP id c19mr14256661otn.162.1596467171890;
 Mon, 03 Aug 2020 08:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
 <361911817559104672d273e199221e8367e8d595.1596349986.git.gitgitgadget@gmail.com>
 <CAPig+cRB-tQEtgWpoHfZD1+Jg+SbKnUhsR4hBxWxxjQ_9A1YLw@mail.gmail.com>
In-Reply-To: <CAPig+cRB-tQEtgWpoHfZD1+Jg+SbKnUhsR4hBxWxxjQ_9A1YLw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Aug 2020 08:06:00 -0700
Message-ID: <CABPp-BEwK5+A-_TXibCL1ZOVEsMtuxuZRX5Q4anLrq5GHQy85g@mail.gmail.com>
Subject: Re: [PATCH 1/4] t6038: make tests fail for the right reason
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 2, 2020 at 12:11 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Sun, Aug 2, 2020 at 2:33 AM Elijah Newren via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > t6038 had a pair of tests that were expected to fail, but weren't
> > failing for the expected reason.  Both were meant to do a merge that
> > could be done cleanly after renormalization, but were supposed to fail
> > for lack of renormalization.  Unfortunately, both tests has staged
>
> s/has/had/
> ...or...
> s/has/have/

Thanks, will fix in next reroll.
