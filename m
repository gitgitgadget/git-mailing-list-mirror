Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256BDC433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE8EC6146D
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 03:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBRDUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 22:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhBRDUx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 22:20:53 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB00C061786
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:20:12 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id m22so2457323lfg.5
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 19:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ik577a4SJRFNNmPJ9hrr5GgO02UEYvP+rsmSIkiF/c=;
        b=E2q+RRLtE2xBUqizP2WkfPJoZUgkZwy730GX0aeHz1JXfdGnyKc+sIcQH+KiF6aApQ
         B2SHpvezKfqEVRlk0GN8zVUgr5OeN633CvVMHlSamtRRJebmbygxsdKDCFT7GJZ/NUVU
         Jz3JfS7LyasN/+DaOxudNEEmpvlUAZnG+fwPKvhbkXBjOIiY/LsmneCcetVZb1F6mWaK
         uRCcJBu274ZFO0SHmOhib3P2haCBACjCEVQhRyZSoieSXKOptR9fXhIZT8ennmxmozHR
         QMcDwGuWnyvnXOTdXJMW1zB4UG5GEPg7nA+IkBYXVtQfR5q89K73IHUb01HqHkhyRQJf
         pnBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ik577a4SJRFNNmPJ9hrr5GgO02UEYvP+rsmSIkiF/c=;
        b=o8kocEu84uFgaFAPLGGTpzhZus1bzlgf3238nlb3pdKKHKPKkfr1BhSK1MvlfcYpzK
         oj6hF9CZ8oLc50Su/W8k/qLTL30HE0ZhynmF5NcmUJbtVieej5A5DVDRS+1RGcZQ1B+b
         r1St6ODfH8M6ci04lc3o95Ioy5qrBKIOtenyIpzNoQ0RiTF1U1wZkxw4TM8Qcu9lNDrH
         k8rerP3Mkea5FRRdS8myZlt7A5HgaY2aHWRYj3hAtXD6mpVUVo7uYgQMp1EHP0bZd4nt
         M88UKjnCRn73vPza6VU32aQhoJ8hKtWcv2Mxe9BYl71VavwmcY1hRovvysAqHqhAuogd
         OOgA==
X-Gm-Message-State: AOAM530/xCgN4s3xza0dYSwCCc5PmXsxWpyOqV7yV/EDKpixZu5nNJ/Q
        TUNbcaldJZP0ccL46GCu2P/yXxb6Lk3G6PFcabEZtA==
X-Google-Smtp-Source: ABdhPJz1u3hQOkIvM2Tjz/eTltinR0FbmV1d/V/WCREovX1zjCvEUoWhGPlfNrjptK3uiPOex4yBExlaiB8+PXL4le8=
X-Received: by 2002:ac2:508f:: with SMTP id f15mr1153047lfm.527.1613618410850;
 Wed, 17 Feb 2021 19:20:10 -0800 (PST)
MIME-Version: 1.0
References: <xmqqr1legm5v.fsf@gitster.g>
In-Reply-To: <xmqqr1legm5v.fsf@gitster.g>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Thu, 18 Feb 2021 00:19:59 -0300
Message-ID: <CAHd-oW4SxfAdJyDOdgqFsw2biUHHnU9wo78SLQMxs2VTeOar6Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Feb 2021, #03; Wed, 17)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio

On Wed, Feb 17, 2021 at 11:13 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * mt/grep-sparse-checkout (2021-02-09) 1 commit
>  - grep: honor sparse-checkout on working tree searches
>
>  "git grep" has been tweaked to be limited to the sparse checkout
>  paths.
>
>  Break out and fast-track bugfix from the remainder of the topic.
>  cf. <CABPp-BFkACtF6LHkFJNt9dTOmwfQbf8ZO=BTrPYwPSmbqc9+hg@mail.gmail.com>

Perhaps is this description outdated? I see that you have already
picked up the bugfix [1] which was broken out from the previous
version.

[1]: https://lore.kernel.org/git/5f3f7ac77039d41d1692ceae4b0c5df3bb45b74a.1612901326.git.matheus.bernardino@usp.br/
