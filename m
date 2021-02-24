Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6A1C433E0
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB5964E20
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234644AbhBXTeq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbhBXTef (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:34:35 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B70C061574
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:33:55 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u12so1797328pjr.2
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzRWAN5Z7bAKVVbjJsnGHQ9VXjGhh+goqSNyV8MtBJY=;
        b=K4V1r7BNb/SnZcVlDCZ4xcTWfImUFdswKq3gc8d1Sj/3AZevA6JNOv3uf5F13uRkeP
         ebHrsJd0MJEUmut8dTa1xJM1qnddQvev/Y0TtxDVNXg6L4yqCRTWB5PIQmMUBhDYuUty
         bXYnZDwHdr97gr50fKVgOkcTh1898PEitlvyDYChwJu0hXqm/ES3EOvlGfluygiONrO0
         K5pnN78hFN8msJl9o0oQdfi0WCLeVeagJmwK6UXdUOHwUbPhE9bpdOh0/fFJ+uKF5mlW
         6OX55/xKOxbgqIqvP47P2pUaQVTyFRdaXZ7XWmVvCgZkqSkybDYWxJSrz67nA7WApSri
         eWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzRWAN5Z7bAKVVbjJsnGHQ9VXjGhh+goqSNyV8MtBJY=;
        b=MevgFJxFq3iAfQpkFyq7IBlCJ0okqPzx43rKN7C72+pN78ub9175EBA5Pjro25ZUcl
         Iq3tmq6by4bIVJuxs3aYYMEkaDlA7SLkWJf0FdQp6JkTEthK2DSHDqsxsSECGCXm/o9d
         cghQAW54QufT2e+gvGoErZvj5e4aYWSFg1/pa4jiI0lMjq5QqvcAbOVqP7Ms7A8KpZ/6
         kNklTSr4xsGTRQ2PAZP/YyaLxJqjEq7RGWBOtObnnS1Wdo1/UW6CPwa/01RpDxB9xK5v
         h0/igzTff2OyLfrV0aTlpBhugBR0B7fdUp6rOlyjkvF8IRb8oVDMe86FDr9k2ime0L8U
         w34Q==
X-Gm-Message-State: AOAM532cT3g9lSpabUnQVJk1VdhH6adDBhy4xZlffKLFYxy49A5x8Nln
        /OzZJkXp7kEh9LPRTJtrKINxxmCqQcIC6KVvuRZbx/a2N0U=
X-Google-Smtp-Source: ABdhPJw+i/TEBLbBnEC5l1Axr+9Xsj+vsWc3zEpkuQ6Mh4sRUnEylUn/HFDUc0X3XXzeD0GazpSf/tPsDuA6yFpftqQ=
X-Received: by 2002:a17:90b:34c:: with SMTP id fh12mr5871982pjb.137.1614195234606;
 Wed, 24 Feb 2021 11:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20210223071840.44267-1-alexhenrie24@gmail.com>
In-Reply-To: <20210223071840.44267-1-alexhenrie24@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 24 Feb 2021 20:33:43 +0100
Message-ID: <CAN0heSqmAgt_hg0-kQpTK2LcuYPV9T9=1bowbuZ7Qah1q0EAtA@mail.gmail.com>
Subject: Re: [PATCH v3] rebase: add a config option for --no-fork-point
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 23 Feb 2021 at 08:24, Alex Henrie <alexhenrie24@gmail.com> wrote:
> +rebase.forkPoint:
> +       If set to false set `--no-fork-point` option by default.

This should be a double-colon at end of the line, not just a single
colon, in order to make it a "description list separator". When it's
just ":", it ends up being rendered literally, which isn't horrible, to
be sure, but which doesn't match this item's neighbours.

Martin
