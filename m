Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10D4C4332F
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 18:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234086AbiKVSCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 13:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbiKVSCN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 13:02:13 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AAFB697EA
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:02:11 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id b9so18831042ljr.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 10:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BfDrPHeAeqFmzSQq18lPmlyLuEZYaifOnWB3XGtQKpI=;
        b=VsavQQAsvHcgtDhpR/qlt9dGWZnvG0S2k32WWPpt3z42ZCck05IPMGZO6FT/qdPdc3
         eWjVQiUwDvRCwymkIEGsZYiG9ZOejs/uzcC50GJo+aKIqBsHrvGJdI2f/SwwNV9DfFql
         GAN0YVXnAKDIKmAvqhDnzwyIZtakOeAkhHMPQnsqlJzKXlC/ICfwOB3zmc4JzPfm+Osi
         SFXAw8JIZoaRVpNlhXANJqjI6tpgwTNsPq6h59IU5LEzGsPkQoOlkaJZkEYbXglOQ0YX
         eYB6GP3sxVvfnV/yUxNuOHiG57U1BuNpbH9z9veis55FNytryEzLRgS/7c4LjMmcyoSo
         AajA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BfDrPHeAeqFmzSQq18lPmlyLuEZYaifOnWB3XGtQKpI=;
        b=eABs5nIjJgriaxDV/AFtYGHhKeSujE7TTdj1cA3v7IKw5nf7NmdT5ZTOJf1fMoVtBl
         pym7jW34ENJn4jOTBLT0CwBxbEvdeCKa0SIVqd2A3b5prSaQJir8iyZBemU5nbHD1byO
         NTaMu6GiGvFe/+kFomuEDCJiUZMPWswtPpRwL1ltQGxIKVHALkZxNtqZCPA/UWgx1rdy
         Fs9zNg9ePb/5/ufGJt/6tIFMzFlnKoDlyAz3bYaiU1kHzARk2udDzwlqYD6iT4/zEgB9
         z7uAl/XBSRXzAjospu7USFCFjxh2lWnwC3YPpDRrVX8EptNcmrV6pGsBQx1ncEGDBz9e
         pdRA==
X-Gm-Message-State: ANoB5pmnk++MvQLlufJHJLAdC28vwjlT8g32ABFOKm7zgWxeffoobegv
        01YYPiwAqUd3PnxrD0yYZ6EEvdb6RBLuwTg3gFBl1hcsivA=
X-Google-Smtp-Source: AA0mqf6mG3iKuq2Pj95lBf88WxwZuBAIwYHCAmi7Lhl8xZKq/esEeCztJpGN2GWKBIIgRojJSuZC7sO9kX16uunedNY=
X-Received: by 2002:a05:651c:1ca:b0:277:423a:fcc4 with SMTP id
 d10-20020a05651c01ca00b00277423afcc4mr8548181ljn.325.1669140128359; Tue, 22
 Nov 2022 10:02:08 -0800 (PST)
MIME-Version: 1.0
References: <20221121174419.trgn7izl52cxhahh@nitro.local>
In-Reply-To: <20221121174419.trgn7izl52cxhahh@nitro.local>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Nov 2022 10:01:55 -0800
Message-ID: <CABPp-BGXruSOAvG+e6Z0hC3qV-wXOeh4nSK6PSz+ZDMuDMigig@mail.gmail.com>
Subject: Re: filter-repo: support for copying notes
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 21, 2022 at 10:19 AM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> Hello:
>
> It looks like git-filter-repo has no support for copying notes, even when the
> following is defined in git-config:
>
>     [notes]
>       rewriteRef = refs/notes/commits
>     [notes "rewrite"]
>       rebase = true
>       amend = true
>
> I'm wondering if this is deliberately left out or if it's something that will
> be potentially implemented in the future.

The latter; https://github.com/newren/git-filter-repo/issues/22 .
