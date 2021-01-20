Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CC6C4332B
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 454D523750
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbhAUAZU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732697AbhATVrV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 16:47:21 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44B2C061757
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:46:40 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c12so150783qtv.5
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RJSNuGuxT8OURUyBaIltJm+AlTEFRmrf4A0ojxc0NvY=;
        b=GwAetO1OtgSNC71noeQRaHwmaRIvRkpwEZL+jdQ3sa17LFRKAtDwk5S6WkqhelW51+
         sYAeakx4Expd7V21/w/sGPfad4FK5peDfJBhgiJ9Jie/J0eJ0KPszIfvLG08C7i8o2PY
         iMVbdI+F3PIqxRcE/QbsxyviXjN/n9UnmFocM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RJSNuGuxT8OURUyBaIltJm+AlTEFRmrf4A0ojxc0NvY=;
        b=PukR14Ua++W5CSCPwxLN9u3Fop/7nUilHS7UuKN7DttaoSVOAnTFb2b2rbIjU4Jzxb
         cxZsmXqcy227W80deld9RgiXzeM0ikv1C/KcGXMIVaEh5wOPmgkfhgNOqr0ljD6o2Rfo
         cmbXPHqNEK/MfCPJFvgo3oZ5C2RWgY5a4F/O8OlvkDBWYqN5qfz6VnTPL1y7hnZvmZXM
         m6cb04xlylLrH72yCSDeSJ4wFZz9KBw8vgK5rXoLFGpMVOcqZ2qAQNrYBFmqPFveSzaV
         2G3EmyTS2PHI+l0+oWkcvB/ou/sP2VtBYiQDgUgxK2gjSAFdYFnelOZdJBsc2xyYGsJR
         j4QA==
X-Gm-Message-State: AOAM530B7DSt5kDaPm25Mzr7u+uWYoKxOiByzFyM5iYRmpLfq3W0oipv
        hslvb0Au7npAGufa7ZXSokDLwQBYdA2PgRF9L77aGg==
X-Google-Smtp-Source: ABdhPJxcJ/lhFnnv7stUi9JvPQSqrmjPHf/7BiAX8wSvky1yqwToNkpPu0T0Xv+9oeaqs3IX2covo5MfXSP0q/87GA0=
X-Received: by 2002:ac8:110e:: with SMTP id c14mr10528244qtj.293.1611179200204;
 Wed, 20 Jan 2021 13:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20210120124514.49737-1-jacob@gitlab.com> <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local> <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
 <YAhYHUcdynbWyhwo@nand.local> <YAiIbEAZSlL7B+am@coredump.intra.peff.net>
In-Reply-To: <YAiIbEAZSlL7B+am@coredump.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Wed, 20 Jan 2021 22:46:29 +0100
Message-ID: <CADMWQoPrKBjLM5ABhhhCibEyJVOXQxsNkncSU6dmwjynQ1oCcQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 8:45 PM Jeff King <peff@peff.net> wrote:

> I also rage-replaced peel_ref() with a function taking an oid so we
> never have to do that digging again. Posted separately in its own
> thread.

That sounds like a good solution. Where does that leave my patch? Do I
need to wait for that new commit somehow? I don't know how that works,
"contributing to Git" wise.
