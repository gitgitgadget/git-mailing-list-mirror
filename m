Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EFDC4332F
	for <git@archiver.kernel.org>; Fri, 20 May 2022 03:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345030AbiETDGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 May 2022 23:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345027AbiETDF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 May 2022 23:05:56 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E6F6305
        for <git@vger.kernel.org>; Thu, 19 May 2022 20:05:53 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id a38so3777057pgl.9
        for <git@vger.kernel.org>; Thu, 19 May 2022 20:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4HtF0zfOPnbhSpONjV62TDWnajMrfBaAsFsQq1Tl2AI=;
        b=Yu/nE4OP6Sr3487aQSs9y72uZowZKApQ0ZQ+5KVYU0evNWCeq9GwpZW/1yWPBa3Jqc
         LO1QKV4f3J/YbhyKzB59JAauV+Tx6Bl9g30CrrFHifNMVSY6SLO+pxwtpNkTOGmOTaPY
         qvHnwyTY6lxxaDhquVyT5D89FpQLsipPqdSgXAUy7+8xJtBcxaMHA5o5uynGrf/ye6MI
         WSdIevyElL0XpXmDRfutrgzyfSpGrPUE9EwUYR5z6+7TV5pNM0G18cf2704yb58zHyQm
         UVQWanQP5Xq9Dy5bBphvT5AZXGp4pyRFE+VEhRjPEf50LIIA8HAxQasqiJMjdah9360H
         w6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4HtF0zfOPnbhSpONjV62TDWnajMrfBaAsFsQq1Tl2AI=;
        b=pmkxp1SmzHy7XutqWfR2dGd/vPx/K7fAcsQ8B421TPT4LGQbZF3Q8R7rKTt52bWk8M
         TwXWepvV5rbY/fsJkJetg/9ntLRRJkpr4L7mZqmxA1Q7FuoUVn92P0MvkXOumYCuMZxP
         z7ubRXHDaY4RwZiccxODTg/5MD12V+RzAy1sRSVsqLoTy6w2n3Ts4iO7PppyuFoU4KmB
         hOalvgwUIRvHdfIsbXVM/6k/prnzk3YMp3Z3kmKDXlKae5i34eaLJyaXqsihGfC4Z0+f
         fmCs/ExOmCH7A8ek16MXhX4CfEw+Gjsk/57srJCmKxfYVHFSD6ttM9AfRchhneyKbOI9
         rJhQ==
X-Gm-Message-State: AOAM532dNsIqAjfQwTd7IXYVRnGTffzc9Xh4zxb6tO+BJ4STq5DCHPp1
        /Cly5lPm4kbXg1LPZ+wDvJNkFasPiyw=
X-Google-Smtp-Source: ABdhPJwhW4XS6wu0JkobJLWrbfvDyGUbdLqGVSOF+T8MxnUokaEVh/1S1B5ZmO960OCIHmMWyhpVGA==
X-Received: by 2002:a63:7d3:0:b0:3f6:885:cd22 with SMTP id 202-20020a6307d3000000b003f60885cd22mr6718172pgh.143.1653015950657;
        Thu, 19 May 2022 20:05:50 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id z5-20020a63e105000000b003c14af505f6sm4294471pgh.14.2022.05.19.20.05.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 May 2022 20:05:49 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     git@vger.kernel.org
Cc:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/1] unpack-objects: low memory footprint for get_data() in dry_run mode
Date:   Fri, 20 May 2022 11:05:13 +0800
Message-Id: <cover.1653015534.git.chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
References: <cover-v11-0.8-00000000000-20220319T001411Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch teaches "git unpack-objects" to use a lower memory footprint
for "get_data()" in dry-run mode since the returned data is not used.

This patch is separeted from "[PATCH v12 0/8] unpack-objects: support
streaming blobs to disk"[1] because it has less impact and less controversy
on existing ones.

1. https://lore.kernel.org/git/cover-v12-0.8-00000000000-20220329T135446Z-avarab@gmail.com/

Han Xin (1):
  unpack-objects: low memory footprint for get_data() in dry_run mode

 builtin/unpack-objects.c        | 34 ++++++++++++++++++---------
 t/t5351-unpack-large-objects.sh | 41 +++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 11 deletions(-)
 create mode 100755 t/t5351-unpack-large-objects.sh

-- 
2.36.1

