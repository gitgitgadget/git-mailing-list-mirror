Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F231ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 22:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ1Wzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 18:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbiJ1Wzj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 18:55:39 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15C2C96F0
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 15:55:34 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id b2-20020a170902d50200b001866035cb0aso4070775plg.8
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 15:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x20d15MxIRaG6Z1LY5All0tuVfvQ1e+TyGzoeXmJF34=;
        b=igXaD+tfKkbbTjS5OgTkE09Krii5FNaFmAbvbvchZDW/1iNAweQHtYPqCvpILo9wS1
         zphWRhVFHPxcFsJT3prfFFlGt8pu8secufATHI3stHVsg5XeToRvagfaT1vlzrtQK3GT
         zwnV9QrROXIB6xJ2yFVtxJB/ZKCtXqO8HUAIv1hZqyOHoQeyUa7NoMB9m6r07IuySipN
         ife204vLZ2zBFwnu73egJ+sP87Ht+d/utfbuZhwTmSWgxeTgoNIvynUld6D4isMYWcY+
         xE93cVMnLl5a2qNk/7wYM+l7Za/1Y9aAqeqX2D0c7cy0J1JJ3Ylu3NOKu2nebAPSurd/
         BNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x20d15MxIRaG6Z1LY5All0tuVfvQ1e+TyGzoeXmJF34=;
        b=JVSDIEVmK9LjzZq5RQCFta6EKTxVcx50qNFNHX8e//gVmfY8TR4S/vjuS7qEn2zViP
         Ru0NXRGjVqRbubH6NUb5TNa3cvvnN2gmCtF1X7dsV8o6wxUtFE2Q1+U5OZoYxJmxK1aY
         D8Rjc2JtkheAlssZN0TUvH6BgXw9fvZ4UKnQeadcPe7fEyzkjI99BhPR4s6cqX6miUw9
         vJgCQJlWdXZCsSxXGZBOI51m47nyAF9GLPQTqZDaDImkEFrqNgvw0KXTwd7dlYUMtw0y
         tLhzSywIU+Db8y+GwDSk1mYVHnn3roHC1PcgMJ2I6emRUZiRi+W4vyweOh5T3lEOKseL
         qciw==
X-Gm-Message-State: ACrzQf2TByh5X9RF+rocE6Sp8uWS7zJJQYcP6DXdWCNEnfkdZNjn0sGM
        O0kIZ5f+lgkZesJtyt3yoqxiAfMy9YcmeQ==
X-Google-Smtp-Source: AMsMyM5IdOsx5dhSZRuJIA8jbSb8ejESn9UsJS7V0Bwy89XorqiBSutVyKgrnQ2RrxKb+C0VBhjX/2Pj92vTiw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:1b46:b0:212:fa5b:948a with SMTP
 id nv6-20020a17090b1b4600b00212fa5b948amr19229687pjb.232.1666997734282; Fri,
 28 Oct 2022 15:55:34 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:55:25 -0700
In-Reply-To: <xmqq7d0jhaw6.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com> <432bc7cb3a42cf39d0033701c2cc677c9109b3dd.1666988096.git.gitgitgadget@gmail.com>
 <xmqqmt9fhbjt.fsf@gitster.g> <xmqq7d0jhaw6.fsf@gitster.g>
Message-ID: <kl6lbkpvd0de.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 1/8] clone: teach --detach option
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Wouldn't it the same thing to do "git clone -n && git checkout
>> --detach"?
>
> Not exactly.  It still creates the initial branch and points HEAD at
> it.  It is so close, which is a bit disappointing, though.

Yes. I was quite hopeful that "git clone -n" would just do the right
thing too :/

I'm guessing that changing the behavior of "git clone -n" is a
non-option, since there may be users relying on it.

So a better way forward is to add the new flag, which I imagine might be
useful to certain end users.
