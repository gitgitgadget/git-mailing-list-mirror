Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA00C433EF
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 19:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353745AbiBCT2a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 14:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349400AbiBCT23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Feb 2022 14:28:29 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471A6C061714
        for <git@vger.kernel.org>; Thu,  3 Feb 2022 11:28:29 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id i186so3101573pfe.0
        for <git@vger.kernel.org>; Thu, 03 Feb 2022 11:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RKOsBKLj+E2sSLSlhFUtkg//S9HFqboImitL/Xgltus=;
        b=pJHy4S13Db+CD7aMsh94axjLxBWKDsJ5pl9fC8svWYYwusxnIvG++hrOKPe0pj6Xp+
         omS0dB+ijJ9skPt4BsQOWWU3lxTNdNSUZHPEXDLL5Yeu6SdGc2GUiSflAo9r7zRZkyL3
         rsHW4s+CPkps/1ZBfyl17VrBEGmXdIZm0fz5eJgNDENcvKm48TcnSiSirCYnIEnl81WF
         JnkowbDDYUmLp0DoZLPhwIZGfKC+IWLhjeSadJ4xf/Mfu39RsR8XckoCDYXFIQj4jEJp
         aqDZSBISFSZtgFO6RuLelcF+7rnbydwiGJyNKlkabjnLju0FS9S3JZhdc5iHYEttjbNF
         O4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RKOsBKLj+E2sSLSlhFUtkg//S9HFqboImitL/Xgltus=;
        b=GWT2zMuig1+IJ0yz3kgCXen+1l365/3wHdRfAGmANdYyxrbc8mKUgkxKSlOYFjO+aK
         FRYWpKD5iOPik/ufNja4ZFbpIDay5nF85L096IJh/qUPl2LrbWl3R/1giwzczgBQJv7W
         jaZo+bwp+jH5kjIoRtgKNLBDIYOSAStHGGiPa4mG0e0qm+Pwa0UIHw3LiSQr1ZZ9t2fU
         Ha9SrL7PS1Ac7TyZQsiZ7dc5vwGkM0J2uZHU0AnOAnvFvHDn9z82AbY3WtkPVJU1mGdi
         o3IM3fS8N1OpOrlN0BD6aMjI6XgKKlqnQMitjr3ylP53zwvNRGtO+gG74mPzOHtVsVIG
         DAKw==
X-Gm-Message-State: AOAM532aVt2DICj3/iHjzN0hChgP6EXORTvNQP5DzL2LY5Eu6BdHhTzq
        PjfH+0ci7jcEFk8Lhg8w4VA=
X-Google-Smtp-Source: ABdhPJyHRgTpGvMnKhoKmdyp76Cq4FTUO+y48a8258KYfz5UWKbK7ivyQEOpszexzde1Ft8Noj3X/g==
X-Received: by 2002:a63:8941:: with SMTP id v62mr28917713pgd.403.1643916508734;
        Thu, 03 Feb 2022 11:28:28 -0800 (PST)
Received: from localhost ([2620:15c:289:200:b5c2:580b:9b41:56b2])
        by smtp.gmail.com with ESMTPSA id j6sm15418040pfu.18.2022.02.03.11.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 11:28:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, phillip.wood123@gmail.com,
        avarab@gmail.com, e@80x24.org, bagasdotme@gmail.com,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 1/2] cat-file.c: rename cmdmode to mode
References: <pull.1212.git.git.1643915286.gitgitgadget@gmail.com>
        <86df0c9e4df34566c10870e06865af536504a6af.1643915286.git.gitgitgadget@gmail.com>
Date:   Thu, 03 Feb 2022 11:28:27 -0800
In-Reply-To: <86df0c9e4df34566c10870e06865af536504a6af.1643915286.git.gitgitgadget@gmail.com>
        (John Cai via GitGitGadget's message of "Thu, 03 Feb 2022 19:08:05
        +0000")
Message-ID: <xmqqfsozu4v8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> To prepare for a new flag --batch-command, we will add a flag that
> indicates whether or not an interactive command mode will be used
> that reads commands and arguments off of stdin.
>
> An intuitive name for this flag would be "command", which can get
> confusing with the already existing cmdmode.

I am moderately against this change.  "mode" is too vague a word
(i.e. it does not answer "mode of what?" question with the name),
and renaming it to "mode" is probably a regression in readability.

The original name "cmdmode" is not all that better, either, as I am
sure that it was named after the irrelevant implementation detail
that it is originally read using the OPT_CMDMODE() feature of the
parse-options machinery, and did not mean to express mode of doing
"what" with the name.

So, let's think aloud what this "mode" is about.  The feature lets
the batch operation to choose how the blob objects are mangled [*],
so "mangle-mode", "filter-mode", etc. (or find and use a better verb
than these) would be an improvement over the original "cmdmode".


[Footnote]

* 'w' to apply the smudge filter to make them as if they were
  written to the working tree, 'c' to apply the textconv filter, or
  0 to stream them as-is.

