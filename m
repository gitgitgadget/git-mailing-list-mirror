Return-Path: <SRS0=wsT/=ED=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF030C55179
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35256206FB
	for <git@archiver.kernel.org>; Wed, 28 Oct 2020 23:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFh7PeMG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733140AbgJ1XOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbgJ1XNh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Oct 2020 19:13:37 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F32C0613CF
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:13:37 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k65so1334057oih.8
        for <git@vger.kernel.org>; Wed, 28 Oct 2020 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7g7dIrWKToJ2N7xelesD6rGIrJ1WvlvSs49fLo3vHP0=;
        b=LFh7PeMGc3Gg1Gisl/kSSNlkVzMwOq5jauFChv2+TPacZJPtqvEL/E6g+pZW6te5tB
         F5/PA4Ii1AWkg6hva7ttjzcK+9g9erUs0Kh7WvyCZnJz0ZtcmR5W0i+N075vZLvGZDMw
         a3J1ynpiYhv3XMF8sJSDJwhrkyI9RY3z3lPg8o0jFy0k2HQobvy9ZV1F6Gf3G4iEcpp+
         Q+/bY3fX2idLkNR29QBJDtVghruyiX0kXexuJ6pBFhDKxSDZxjfmiJ96vczLTwfhCF8X
         1txazduULM8v2vP5df7XGPk//IuUVg2VxEgydd4WnxX2rZjVydHBvE8AG/Im1P6wujRj
         PQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7g7dIrWKToJ2N7xelesD6rGIrJ1WvlvSs49fLo3vHP0=;
        b=YZ0UzB7BKBqRbWr5T96mBmZCtZMxPBDiS8Dh2PG9PBlLACn8/xVomEu0jxtWcR5TYv
         nYTXmvEXpr0dSjqlvC6AMMjV/mGZm/ZfkxQK0IWibHaS0qbMtiRQiwwOTaJiu91osNHx
         XHEOGOXU0eLzHoKUahA/IzOnUPo4G5f43hJ5ElMOjDqxdpAWlcBFvH4FkCWj7nK7aUHH
         ZIJEFkYCIzOxL9yc04vk4Wqo8WjD9laaI3NDbJzyMHRGm2nb3sPwBzrVT7FR/UREo1hI
         tkEkoXiqYJR/USSR1SjsreTZtFmIQeTj8W2V+nFL1zBfGEWpcY6jLEJdktCfsSXb/NsX
         ZG1A==
X-Gm-Message-State: AOAM532cewd41xOTUh5LziPDpm1nJW84VQskM7NqVYQMc3xYakSm3T6p
        J6Nlo7r5nxhi9NXeh9KW3YIRq6yXg6GRAufY
X-Google-Smtp-Source: ABdhPJxpCium8d/1MAVfZwHJyIJLtR8WJGbiigQWCm0iw7BEknMH2xQZO0h/L9S5fCQKmjREfVhi+w==
X-Received: by 2002:aca:ec91:: with SMTP id k139mr396264oih.88.1603850881921;
        Tue, 27 Oct 2020 19:08:01 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t17sm2340722oor.3.2020.10.27.19.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 19:08:01 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 29/29] Update copyright notices
Date:   Tue, 27 Oct 2020 20:07:12 -0600
Message-Id: <20201028020712.442623-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201028020712.442623-1-felipe.contreras@gmail.com>
References: <20201028020712.442623-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 t/t9902-completion.sh                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 811d77cb95..e0fda27f4c 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -2,7 +2,7 @@
 
 # zsh completion wrapper for git
 #
-# Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
+# Copyright (c) 2012-2020 Felipe Contreras <felipe.contreras@gmail.com>
 #
 # The recommended way to install this script is to make a copy of it as a
 # file named '_git' inside any directory in your fpath.
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7b7bc6e4bd..caf4e9101f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2012 Felipe Contreras
+# Copyright (c) 2012-2020 Felipe Contreras
 #
 
 test_description='test bash completion'
-- 
2.29.1

