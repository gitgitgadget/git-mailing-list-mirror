Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D337C433DB
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A50B64DE8
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 21:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhA1VlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 16:41:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbhA1Vk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 16:40:58 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C947BC061573
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 13:40:17 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id d85so6867858qkg.5
        for <git@vger.kernel.org>; Thu, 28 Jan 2021 13:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7V3ZLLbAJc1fRd80H05UfqGc/7ddCO+Sv4SyDQmyNxY=;
        b=SZ4OHe0rhhp6Z97qp7ObUlcSi1pcQ+lCQ8ojcGcwtZznh/QE/HECOPWCb+hmsM+ni7
         DWnuxUTvCKFi2BB/pv0TVQVcYWjKvQtkg4BnQwRoTNazd7u0iGXMmh13TrnBYvpbMjdO
         yUmOjprlm2w8+L3Al5Sgknr3U9sjOUoETvkSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7V3ZLLbAJc1fRd80H05UfqGc/7ddCO+Sv4SyDQmyNxY=;
        b=LoHu0ABttG3tJT8xV2YGe8nUt4spemyDQAwo9d1XP3IZa/hMVH6YCeksm2jmqexyt6
         tar5BVHh1F6BMdr06LKg33v6P2NCy8qBqdkg6kGq6wMICGDAebTC3dcSjBX9wud8IdZI
         XL/nyfjv8t5tbZkqOFmHS3nXM97+voZMsJfuCgpqSbUrWr1V4YH+F/F+O9kziuESG5PB
         0/y/CP69E+P+zOS4uf9mgXIEYFYF+v0S0Oa7GkjV9B2gzNN6KG9jiEajVu7cWdmdBzr6
         qHbeIIgCsh6uiIn5X6bO4uFmYcoDQlNbUdq+2pZMdVjpcUlw2Yq3KwBF/fFuNBXLd5CM
         ecoQ==
X-Gm-Message-State: AOAM530SnIiS9Z3RzS1CZFKS9aR0uDgnfeMuub+gk2AbbwbTh68+1nF2
        ZnnCSoL0J1qjgIxdtJjXLC/Je+/Gg35ouE2FcfnaWMTAZBDHCw==
X-Google-Smtp-Source: ABdhPJycSHt0brWj78o9AosN5Nt9phJlKDcJbz/q8rahUR84lRlwqtBILynB+q9nfD0dNDeU8xTn3+iENMJryBWLq+w=
X-Received: by 2002:a05:620a:2e5:: with SMTP id a5mr1332897qko.194.1611870016987;
 Thu, 28 Jan 2021 13:40:16 -0800 (PST)
MIME-Version: 1.0
References: <YBCFBivBLgqEAUr1@coredump.intra.peff.net> <20210128160453.79169-1-jacob@gitlab.com>
 <xmqqmtwsx4d9.fsf@gitster.c.googlers.com> <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
In-Reply-To: <CADMWQoPgscKm2wVOo4uEqSSwgrZQTp7_eoMJpG=pdDmc1bJr=g@mail.gmail.com>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Thu, 28 Jan 2021 22:40:06 +0100
Message-ID: <CADMWQoOVe1cfeO6ncL1_E8oHxp_ovK-RViT-DZLiCDhkWWkPZA@mail.gmail.com>
Subject: Re: [PATCH v4] upload-pack.c: fix filter spec quoting bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 28, 2021 at 10:12 PM Jacob Vosmaer <jacob@gitlab.com> wrote:
> Thanks in advance for humoring this contrarian
> suggestion. :)

English is not my first language. I should have said "considering",
not "humoring".
