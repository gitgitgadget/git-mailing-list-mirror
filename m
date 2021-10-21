Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56672C433FE
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E6A7611CB
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 15:57:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbhJUQAD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 12:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJUQAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 12:00:00 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB98CC0613B9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:44 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id v17so227850wrv.9
        for <git@vger.kernel.org>; Thu, 21 Oct 2021 08:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sFGZhDckZHi4LCQKi6L1+tYWxq8SIqnm5SIpUKcirdM=;
        b=b3wb3GkEPJCPvxPoDmS0kky3okjpY71wn9K+BFkQ1EIlHxhQkTjgriZpQWaT9cFqdg
         uw08oZxNgy+UqRdgGaxCic1eeVOZJ02bKBRvf24uWpMwh/e9swb0efqUVCkkCyKy1COI
         mb5sdrhIS916N1uTFT848Mb4jrU3tsg7uOOMmeGUCyHAsnUpfz+v52bhNBTHrxrSR2JP
         iRC4MRbonCpL7akJnxG/h+paPuZ+uI99qgHiA4oDFb2LQYGaNMprrjFPImxLqM6QiPbs
         1oLFta+K+QN16hNTPSwtombftlIhJQbjlsw9NRBai/Gh+s+SjCa1gudFzrUf3UOvmttS
         2Jqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFGZhDckZHi4LCQKi6L1+tYWxq8SIqnm5SIpUKcirdM=;
        b=eWaFgAftyyHHkoaB2krHSzwESPaEZrglvBqUvVA9ShehHAaa23mvmtuApyJpkBZCuX
         WdwKLHxaYRViJnolTplENCwfP3r2vHxGTz4LP/sUBTwHwVo+cTfas3B4ydtHTefhROkr
         Qjf7aGUtdSfk2QVY0QeYPR/kJw18/TzVc+r/7ki8W3AUjl0plcyJis3Xz6zDwOYaXajP
         jnuGeA8X68s2asB6MjyNLmlLiJFia70pupw4JZsnsoRLtWhNBOMGzVpMee/vMt0Kf9mK
         eZ5MUNS9UsjKWgANkye+pCpwx6KrG6bihJv0Q+RvxnPmBXtgv0zdRgbRU5Gdv2It+nYe
         Mm2w==
X-Gm-Message-State: AOAM533IwhJukC4z/sD4jwWHbgeYk5JjurqDUgwyodooTee05SR4EA6s
        /LFZCFq7OSHFIXfgYsAmDsT2vdzwG32+CA==
X-Google-Smtp-Source: ABdhPJwqAZIgtpCPVLHeQOfVVaGuL8gs/IiFfBY31Y2IvE8pazyl9o/WeHBPlMTY0Y3jUtTyBzvFZA==
X-Received: by 2002:a5d:4d06:: with SMTP id z6mr8214166wrt.149.1634831863121;
        Thu, 21 Oct 2021 08:57:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm7082259wmp.1.2021.10.21.08.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 08:57:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/6] submodule--helper: fix small memory leaks
Date:   Thu, 21 Oct 2021 17:57:35 +0200
Message-Id: <patch-4.6-9c3c0529ad0-20211021T155529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing strbuf_release() and a clear_pathspec() to the
submodule--helper.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6298cbdd4e5..a157656a48a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3220,6 +3220,7 @@ static void die_on_index_match(const char *path, int force)
 		}
 		free(ps_matched);
 	}
+	clear_pathspec(&ps);
 }
 
 static void die_on_repo_without_commits(const char *path)
@@ -3231,6 +3232,7 @@ static void die_on_repo_without_commits(const char *path)
 		if (resolve_gitlink_ref(path, "HEAD", &oid) < 0)
 			die(_("'%s' does not have a commit checked out"), path);
 	}
+	strbuf_release(&sb);
 }
 
 static int module_add(int argc, const char **argv, const char *prefix)
-- 
2.33.1.1494.g88b39a443e1

