Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AF3C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9177461438
	for <git@archiver.kernel.org>; Thu, 13 May 2021 13:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhEMNVT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 09:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbhEMNU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 09:20:59 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA9DC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:19:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2so38478182lft.4
        for <git@vger.kernel.org>; Thu, 13 May 2021 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:user-agent:mime-version;
        bh=9lL/zcID1IkxEinlg/WJvTpio5fhcF7aXncO+J8UFqM=;
        b=OTBtLaG5YqMDd1sGtkowiXBKdVDV+66C0IDLLbINj5PM5G58pvlKaJt8qTOTDdR2RH
         QPrMic7cb1jf2Ahi8Kj9VUq2rgJfqbI7fipia1gVTpeI5QFzPnuRiHlUy9ZEtWKG9+yE
         0ZfiLVGq7xoUKZZzkD4RtVKF9cxo+ZY0DXid+vtzrrNqMPOEnv7vnNuCJCKZIdk/6bWW
         Ls1h30TjE9IWx+4MO6CBNQWajgqGxVWaGSSeEtc7TITcMd27XQ8LKaN9e+OnbmWxLFJ8
         UZGSMO60g14ps6Vfk4kt7G2lG4eFls8OJQeJwKwLHXVEIpSpaJh/xRgBvfTHwTSxa9wO
         H9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:user-agent
         :mime-version;
        bh=9lL/zcID1IkxEinlg/WJvTpio5fhcF7aXncO+J8UFqM=;
        b=UVHnXxCvUQ9YpYrgfXkCwLMKNYPLa0sRL6tuF/22TDi11vI4sY7IQv4fKC1u5zFHTb
         KaU7jEzLqAWqchPnlnRAkCPWTiuvdyWzSk1Pv8GLGOwELFG0uoKKkoiXrlZcBsi4sOCk
         wyxE2S2gictHwZtxEK59U/dFCSeuYcfZ+N9lh19ZV7mqDpGc7yrZjggFVqBuZefqYD5M
         9osiLH7Yht81AfSglWdvX9FN9Fy4FhES6wNxdhJGhL6g/49iyVs4oY3bClNowNtWY80a
         xLyQxfJXGhzR8PQjcX51X+S13rIXdTqAZhNUJCTgUE73hyinRsdIIEtZlOuUfQ8ahTU6
         w1xg==
X-Gm-Message-State: AOAM532jwbpf9b/y1ogr854Hw1SD4dpFMYlchdJplkNQCDWW21cdegn9
        DKVM9OZ5/b0jhLVsDKg83ZQWI8UlYbo=
X-Google-Smtp-Source: ABdhPJyDTqMTr3h6E3UI7ouLlWYj7axHYJkS4xiXsYpQa/pqqwuczKdLY1+j5QODqwSkJ5EBGldJiQ==
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr22641404lfn.632.1620911986602;
        Thu, 13 May 2021 06:19:46 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t13sm212152lfc.57.2021.05.13.06.19.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 06:19:45 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     git@vger.kernel.org
Subject: Rebase options via git pull
Date:   Thu, 13 May 2021 16:19:44 +0300
Message-ID: <87r1iakbyn.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Is there a way to specify additional options for "git rebase" when it's
invoked via:

  git pull --rebase

? What if rebase is used implicitly due to "pull.rebase" being set
accordingly?

In particular, I'd like to be able to:

  git pull --rebase --no-fork-point

but it doesn't work.

From documentation is looks like "git pull --rebase" is still a
second-class citizen. There is whole section about merge options in the
manual, and none about rebase options.

Thanks,
-- Sergey Organov
