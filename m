Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAE7C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9222C611AF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 17:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbhKIREB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237625AbhKIREB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 12:04:01 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E280AC061764
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 09:01:14 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id bl12so19304467qkb.13
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 09:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0o+0PFlg8CDzg/3wNUMqEbf07rKcFm4R3aCiI+vlLT4=;
        b=Nunu0InENVh8NE66pj84hwyjNwQHU3d2h7PXkRKeA2CAQzQ+U4EiJWZ6n9qjAa+z/v
         x+NSVaydoe7/OOn7QH9PxAfYRdhrMtOCtelzWICzM8weZcLAv0ndRSo1Q16KOaQZdN8b
         8Q8Hp4rxrslh1vst85v0TfSOimhcc+ufr0B4TE79T9z/kN5egn83/qmltWABNkRvMkOj
         Hw+brZdH0twlesnRe0PqFPAQ+paucGTgv0sYmYiElsrgIybCv2IR0ralPqAMFQIm/lUt
         xtn1jJxdQiXocyfy6AYRrk6M5+dq9EiwcjCTf6yzV6NECE6zk//O6CyMGZUopAZVI6io
         LavA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0o+0PFlg8CDzg/3wNUMqEbf07rKcFm4R3aCiI+vlLT4=;
        b=0TdHOpRrzNYKpKFHYoFect8blBeOKM+kbGmL/pTuSnYJ0U99/FKVIiKBuT38JAmlLm
         0giSDJYOu7PFSFooWCfN93cN+J+TdFZebHz/fJtrfUYX+4eQwDJBCd9sAPYiOHtIQyCg
         AV30hYLO/fxRC9rugjdAfLqVYJroDVotWRf93OKFF25N4ph9K3IZA67mMwYjmA0WAMPi
         0wcwnO4XEDDQi8qIhvuJkZsEGqYMQ1HnCaWFR7Vpk5CD3sA/odwpCSe5sC3vYVs5Klrf
         q89V7+uldM/wFvwgLuw4EnTSYam/3T8WedKoj7gGfXMrC7wMxsXriIEFtoCa3WkYgHAx
         y6dA==
X-Gm-Message-State: AOAM530RVryu5RNR99bjCGL34zO0bTCW4iogD8GwWZitekyfA+wSC2CU
        d76Xr7QbKUcWLPHi9C66TRw=
X-Google-Smtp-Source: ABdhPJzXNCxIxcBdJb62cmcCpL0N+r+f2HirW0OKFJVxC+N8ytqsJYBtRp/IPeaVzqFtTWP5x3BHRg==
X-Received: by 2002:a05:620a:bc1:: with SMTP id s1mr7302876qki.49.1636477272345;
        Tue, 09 Nov 2021 09:01:12 -0800 (PST)
Received: from samxps.. (modemcable158.252-203-24.mc.videotron.ca. [24.203.252.158])
        by smtp.gmail.com with ESMTPSA id v3sm11419139qkd.20.2021.11.09.09.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 09:01:12 -0800 (PST)
From:   Samuel Yvon <samuelyvon9@gmail.com>
To:     johannes.schindelin@gmx.de
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
        samuelyvon9@gmail.com
Subject: Re: Description of github.com/git/git, was Re: [PATCH] builtin-commit: re-read file index before launching editor
Date:   Tue,  9 Nov 2021 12:01:02 -0500
Message-Id: <20211109170102.14538-1-samuelyvon9@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <nycvar.QRO.7.76.6.2111091732040.54@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2111091732040.54@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I would be in favor of changing this description. How about:
> Git Source Code Mirror - Pull Requests can be submitted via GitGitGadget
> Thoughts?

I think it might be somewhat obscure for newcomers (What is GitGitGadget?).
I know Github supports links in project descriptions. Maybe

    Git Source Code Mirror - Please read https://gitgitgadget.github.io/ before submitting Pull Requests

This would have helped me figure out if submitting a PR was gonna end up nowhere or not.



