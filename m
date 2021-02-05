Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F584C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 11:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6A3E60241
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 11:06:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbhBELGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 06:06:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbhBEK76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 05:59:58 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815BFC06178B
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 02:59:18 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v5so7078837lft.13
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xjZLdd+wsnprPpwJkqrqQW7hzi8vFE/4skt4svztTVQ=;
        b=muh5THGcjHr6kfcDrSsIHdKpRd0vpcMkDfxVeA/Z7X0kNojAAVlZOgU9YmFfisKF9g
         JLLLAwhhm7QzSDFbR8iOZw5uTAfp5qm9HoHVYIkiOYhfAm+69bNORil1WQ6HvU2FgUz2
         L+zOT6lw+Okkjdtzx9VE/tyviLCfE3c9TooApuUmKAAsH6LnSTsdq6Sa8d5pgwPVq8Pr
         IMl+Lz1uf/71WVbxyznVK+Eeo8Gg80l4Q7btFuEwyX8fKrj94Aim5+88w8BdcjVhmUVX
         MZNIcTnk9HQAXIcIlYiusT4u5eQiHINolyYO6ArspIhZ3ipgDEHenzxpCvdZgDPfA5Uk
         q2Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xjZLdd+wsnprPpwJkqrqQW7hzi8vFE/4skt4svztTVQ=;
        b=XCTJFsItRoFmyhz8hvly0yE7aDijouIjuVEkMhKYEyFkTX2gtBcnddJtN7JGeMxh1z
         nb2gbQytFrO9fwJy+9jF5NoH3CeGvBTEmP+6XLkDUkxkK6wXc35Ob/bmWnRx3xroc9ef
         6wlpFAniO/dphtrafkqxUyeM56nBQKrqyDCCRshqx8nb8N+lH7NP4W091BtRp0vjoyWS
         WoCwwCX83YCr1mbWXZ29Zbnsf4cokNfVyAjumaRVkps1tMVTxorxYuTzS5nnwdyBc6s0
         jC+Unhx9MW1Di1PO4jQGIl61oDorVKHWsmMmMLhHUxg3yfxaeSzXwJ6RWm7Nc9pnfGWN
         9T8w==
X-Gm-Message-State: AOAM530wJKEMrrx2vBzUWiDZ3+m5iugWNYrv6daunvRTN6ibVyolPB2q
        IiWXxCqM4EJRUFGAyqcxrD4eldQj9Io7gGm0qNE=
X-Google-Smtp-Source: ABdhPJxn8a3F/uAne/Qn/6hcm7/qsJHt9+ToOC/hLspxFHcJDXijH2WES2IvzJ3CTatf6Ya8yFsYYEVCAawq+aaQXUo=
X-Received: by 2002:a19:3806:: with SMTP id f6mr2347043lfa.242.1612522757061;
 Fri, 05 Feb 2021 02:59:17 -0800 (PST)
MIME-Version: 1.0
References: <pull.848.git.1611676886.gitgitgadget@gmail.com>
 <pull.848.v2.git.1611759716.gitgitgadget@gmail.com> <83d292532a0fa3f3a0ad343421be4a99a03471d0.1611759716.git.gitgitgadget@gmail.com>
 <xmqq8s834c4s.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8s834c4s.fsf@gitster.c.googlers.com>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Fri, 5 Feb 2021 02:59:06 -0800
Message-ID: <CAPx1GvcNTkXo-6rdaRc4YNGAq8AoCtwT86AEUT+A6c22erVW0g@mail.gmail.com>
Subject: Re: [PATCH v2 15/17] midx: use 64-bit multiplication for chunk sizes
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        szeder.dev@gmail.com, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 4, 2021 at 4:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>  * the fourth parameter of add_chunk() is of size_t, not uint64_t;
>    shouldn't the multiplication be done in type size_t instead?

There are (still) systems with 32-bit size_t (but 64-bit
off_t / file sizes), so ... probably not.  Is size_t ever more than
64 bits these days?

Chris
