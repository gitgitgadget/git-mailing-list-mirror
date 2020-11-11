Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B9EC5517A
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A757020679
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 15:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rFHo/fhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgKKPSO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 10:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgKKPSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 10:18:13 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBB0C0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:12 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so2851402wrf.12
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 07:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygoYOGkNBkLXvhAU8LGDgP1EZGa3bXkUC4u6Sb3V8Tg=;
        b=rFHo/fhs9wDe5VmlnqZNa71NjGRmGHy16293RD8+o/w5COqWxdCT88jeuwVhh421QY
         hxbd/F4YAUstqmq8gijIcqVKorSjS5BEv4K78pa23NXBpzsUeKMTjXHgsNE7FeCwXsxt
         goX7pLABIn3NnGxPRuqirgsIoLWr1sNKaMZcV9R5nOs4mLXEybdntxHDRkwaBTIVTW/9
         Jpbi6/xnhrDFb4Yu+jgVaCu2nxxQv39JcF4BERVsCBYOcciq98z97P0d88nAga+3z/h3
         RHKi4dmdi3G6iNSL02JhfgBanqL7ylKkyPKKfsHZeWgyA3nEOELkbCzLZki+WbCsLqcu
         0KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygoYOGkNBkLXvhAU8LGDgP1EZGa3bXkUC4u6Sb3V8Tg=;
        b=ZhC4mrUNxbI8l+vyxRVWk9JEota3bjGxHHQLDBw8QIBdOve6duXWsj9l5GdojOxDTb
         wbvDt7JtKfb5qTDZIfM7SIDbiE/z+uwrc7VEAdUbvMqRLxhh8oGL0xXK/beZfNGgeEB/
         5DljTLRoVAfbdU0zJKPHpBiMEmTiBI0neLMpKOdCb1Js5Qn+r18Ii5J1g2KKiIu8nNm9
         zka07tbaJ+EC7im+hJnjUMJelCs5geW7/g6YHe7Z3iaf1p8ZVcsxJLggVzXFVO+jIyLZ
         OM0ghwpHkgsvWL7KkMvTYDjNPuuM8RAS1N+ntQew1XJ1n8uZ48hVCtVWaLRolfXdg/Rg
         EyWQ==
X-Gm-Message-State: AOAM533RmrKlTcWbAe/elGM/Dl31ZVSTpBrWEDJgcTBdd+Me0pBh7eYV
        N3iBRP9MHd8Y9m+ilrIZ99YkGPKPHe3wFA==
X-Google-Smtp-Source: ABdhPJxzx1qkjvo2tkyRjd+xnXx6GZDrYQGfR9KeQqG58Z3JvSsQ9AJhXdbDaIEn339jXEEOQPAl+g==
X-Received: by 2002:adf:c58f:: with SMTP id m15mr31493547wrg.144.1605107890380;
        Wed, 11 Nov 2020 07:18:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q2sm2940010wru.76.2020.11.11.07.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 07:18:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/5] Remove now-unused git-parse-remote
Date:   Wed, 11 Nov 2020 16:17:49 +0100
Message-Id: <20201111151754.31527-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started poking at removing .git/branches from the default template,
which I had a patch for until I noticed Johannes's old[1] series.

In any case, this is one thing that came out of that
investigation. The code we're keeping by moving it to git-submodule.sh
can also be replaced by some C code we have, but I wanted to leave
that to another submission (if I'll get to it), and make this simply a
code removal.

1. https://public-inbox.org/git/cover.1494509599.git.johannes.schindelin@gmx.de/

Ævar Arnfjörð Bjarmason (5):
  parse-remote: remove unused GIT_DIR variable
  parse-remote: remove long-dead rebase code
  parse-remote: remove long-dead git-pull.sh code
  parse-remote: move used code to git-submodule.sh
  parse-remote: remove this now-unused library

 .gitignore                         |  1 -
 Documentation/git-parse-remote.txt | 23 -------
 Makefile                           |  2 -
 command-list.txt                   |  1 -
 git-parse-remote.sh                | 98 ------------------------------
 git-submodule.sh                   |  8 ++-
 6 files changed, 7 insertions(+), 126 deletions(-)
 delete mode 100644 Documentation/git-parse-remote.txt

-- 
2.29.2.222.g5d2a92d10f8

