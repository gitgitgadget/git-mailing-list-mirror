Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6AFC433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 00:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235199AbiKWAQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 19:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbiKWAQU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 19:16:20 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67358D5A0D
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:16:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k7so15180710pll.6
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 16:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pU5GNQRaiomwKlhDYYFeCmAQmmXpFUwWy4xGBF+1TlM=;
        b=mnPfrv9sxyQ0BKDUp6HRMqGnuNV2tTKf18OOCNYExgJKLbaKOXjLkYsB2gHqdLigAZ
         I6sZjANIqQBY6Rm+9MNJTN1rZUdCkdeo6/LNqDkEQVv6C+P9wxcUwsnb65uSF/h1Qjm1
         Kt1pFw84sRc5dUjVDE/77at8oJpGto73TVT1A7zKXUav4jwJZVowpKGTm7TITaqk77jt
         ftvrlbu01e7BqvOmddIu+D7lK6usXq+nlJ3z5KZYvp+BUPlTWUqanILKlNcrbgBiA60F
         Mcf5G+7kl3gx+BkvYjYleiRYN7LKszB16HxS1ApdTIuCY0sfhXiEiSsE9rWEjoOAupJx
         LkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pU5GNQRaiomwKlhDYYFeCmAQmmXpFUwWy4xGBF+1TlM=;
        b=VqShDT79uJd4Gt0cm1PKsgaORfo2i5E5GQ1jC2QJahCCOzjD7LKKrCrBRvpcKUNJgK
         efKoPQD67M6YVBsBY9A97FrNTQM0hpw3A9mA55URFwCt2yxLrCDDZuDY2rSnErlGtVDv
         gmk/6u/OHw+3SVhb4T5h0zYiVgyklxJNe6G6CDbhaGWW4EzCvr3Lt9jlPX87A+YU2mOM
         ghTdstapiFQdyi4lhptLp00lEqCVA291D3n2/wQtsb59IstohFn90qbiIDbXWv7UJJy4
         eIaKyjZ+zvrsf9m+c1pHwc5UKb48xIdiV7EQrqvMnOE9z2G34LD3eedRkhngcxH3XK25
         TjtA==
X-Gm-Message-State: ANoB5pkqGocnSX3kWjjvH0zlUnjnLaYsGV87x6xDsNv9WZyO7IogQnp3
        kXXVqj80mK5LTIv/mi+vG5g=
X-Google-Smtp-Source: AA0mqf5knTUm752yTFJr9ezanvym3BPPnYKZwhZ5zkjT/Vcwa0j8q1GYVcgzI2+c/eHiZh9/bAtChw==
X-Received: by 2002:a17:90b:2809:b0:212:e8da:fc3f with SMTP id qb9-20020a17090b280900b00212e8dafc3fmr33092440pjb.189.1669162578843;
        Tue, 22 Nov 2022 16:16:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id nk22-20020a17090b195600b00218998eb828sm127121pjb.45.2022.11.22.16.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 16:16:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] config: introduce an Operating System-specific
 `includeIf` condition
References: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
        <pull.1429.v2.git.1669058388327.gitgitgadget@gmail.com>
        <221122.864juraxl2.gmgdl@evledraar.gmail.com>
        <9c0ecaff-3d66-2b83-eb78-64632d1fcddd@dunelm.org.uk>
Date:   Wed, 23 Nov 2022 09:16:17 +0900
In-Reply-To: <9c0ecaff-3d66-2b83-eb78-64632d1fcddd@dunelm.org.uk> (Phillip
        Wood's message of "Tue, 22 Nov 2022 14:31:52 +0000")
Message-ID: <xmqqilj6plta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> All the other items listed in your table such as branch names are case
> sensitive. The os name is not so it is of no benefit at all to the

You keep saying that you consider the OS name is case insensitive,
but I doubt that is the case, not in the sense that MacOS and macOS
are two different operating systems, but in the sense that OS
publishers have a single preferred way to spell their ware (which is
shown in "uname -s" output), and we should respect that.

