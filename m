Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D1AC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD94561139
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 09:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240682AbhJGJsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 05:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbhJGJsL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 05:48:11 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3CAC061762
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 02:46:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v17so17151218wrv.9
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbZSFlrZWdQ6B6swv0UdSnWvmbn//nd6iH5EIXUSqAI=;
        b=nga+TsFxK6jx0nnd3iYOXC7v5f9lT8EvLNIMjrLQm+ve4V+w7hRCKq1i09NvuFJoMn
         mOw0SksvzzvcRi4qankrB+F3AeQS+8iJidcojShmyoyIS0SwuQfAlXHA+sEMq3R7atO4
         IhGXMY4bY49HJduT1yFO9zldCyGTosGL0D5PNwylMf4zMZ45vk66OD1mqOGLqPk38jPP
         xak8cCJhBMfsWkl+pUia0nDD/TxI7zJJf5RMm+NPCRGXUW2rsJTLAfQLU0wrnY+NC4dZ
         jcCf8ORU+2F4XTB2gnKoEpm2ivDLge4hRp6e+Tu8krkBjPVVZsZyg3qmqcAj6WyU8ZfR
         GYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbZSFlrZWdQ6B6swv0UdSnWvmbn//nd6iH5EIXUSqAI=;
        b=b3tB1n2/C4yKEBqFb/BsPCHijg9DtsnlTU2cR9kxNTHTZlcGKRjn5ueuw3yZ/ZhIK6
         ld901+y2dpdQLYA5e2lLSfoNrQqJjT5WX6ovKxldcl4sTlKVoaotNsgqJiIdhVv/8J65
         frc7bxoK/K430n3xjTFXpcJ8mnMlkNcshvfaY9IZ0xp7pe0L3W486XoJShegnXr1zCiv
         VDxsIAJrO5MuUFKTyrZmTf1OqVO1rHBg9ScDybRpIjOAOxgDVyoovwY/A7YaT13rtsxM
         sg4IBzImD32Fiukdox/T4JBeH42Sq5y+ibGqTTf0yF+mEc+0Krfm4JhOM/yPAixb0U22
         czTQ==
X-Gm-Message-State: AOAM532/AXG6hoqto6LLqz5YY0AH9E7QxvAmch39LQjo70Am2pSSsQbR
        S6at/VIQ5QrIbQ4qOEluaFuQwTvxKEO5hg==
X-Google-Smtp-Source: ABdhPJx16SlzTFm7SLz+b3eheNTPxi14RXSyxWNG1YK7zsx9IJgNRk5o+idDKaBIM4I+BzZNGRL5/g==
X-Received: by 2002:a1c:f01a:: with SMTP id a26mr3455983wmb.150.1633599975883;
        Thu, 07 Oct 2021 02:46:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l13sm7720489wme.38.2021.10.07.02.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 02:46:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Andrzej Hunt <ajrhunt@google.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/3] sequencer: fix a memory leak in do_reset()
Date:   Thu,  7 Oct 2021 11:46:11 +0200
Message-Id: <patch-v2-3.3-66ae63db8fd-20211007T094019Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1446.g6af949f83bd
In-Reply-To: <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211006T093405Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211007T094019Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak introduced in 9055e401dd6 (sequencer: introduce new
commands to reset the revision, 2018-04-25), which called
setup_unpack_trees_porcelain() without a corresponding call to
clear_unpack_trees_porcelain().

This inches us closer to passing various tests in
"t34*.sh" (e.g. "t3434-rebase-i18n.sh"), but because they have so many
other memory leaks in revisions.c this doesn't make any test file or
even a single test pass.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sequencer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 457eba4ab10..fefe5a601f4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -3652,7 +3652,7 @@ static int do_reset(struct repository *r,
 	struct lock_file lock = LOCK_INIT;
 	struct tree_desc desc = { 0 };
 	struct tree *tree;
-	struct unpack_trees_options unpack_tree_opts;
+	struct unpack_trees_options unpack_tree_opts = { 0 };
 	int ret = 0;
 
 	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0)
@@ -3689,7 +3689,6 @@ static int do_reset(struct repository *r,
 		}
 	}
 
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
 	setup_unpack_trees_porcelain(&unpack_tree_opts, "reset");
 	unpack_tree_opts.head_idx = 1;
 	unpack_tree_opts.src_index = r->index;
@@ -3730,6 +3729,7 @@ static int do_reset(struct repository *r,
 	if (ret < 0)
 		rollback_lock_file(&lock);
 	strbuf_release(&ref_name);
+	clear_unpack_trees_porcelain(&unpack_tree_opts);
 	return ret;
 }
 
-- 
2.33.0.1446.g6af949f83bd

