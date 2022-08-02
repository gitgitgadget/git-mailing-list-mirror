Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D2AC19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbiHBPrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236599AbiHBPqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:50 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB0617045
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id v3so17488127wrp.0
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RyRyFnQK0UAb4/oaWKsyQAK+QbbZ/o2Q8pSMw6T4E/c=;
        b=lVIiDpcF6AaHIhmk5rpvwiLSUYRbkfuZta2yWUr1X+tJdqjJfB300cApLcmihtPsV6
         dxfNkGqBVOaAxD27R2u7xh1KCW21G4kZWzv/gjpas8EHfvbxogSY+0Ty1J4F3XCzUXsy
         f7BxLgSgpJKjH+uPADKx5MOT4pmwde8rbTAotRV9f3hcoeudpZRhkg4APPA3WlQ1KL5c
         wGmPgpLe5M24t2EqwWbV84HdrTxKKwgT9O8efVfgamHXuiafIYrCXed2LIaBnW1AP90U
         KNLtOiOVrdAhhnjljgPVTQQBZG2KyZra2Degd/yX3znfTMjPOXfyDPUkMaRbTK1a09bX
         i8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RyRyFnQK0UAb4/oaWKsyQAK+QbbZ/o2Q8pSMw6T4E/c=;
        b=YPUnofg/R3tps7n7VPpp0o+O8aWXCJ+AjNdpioNMyxul22uJbPUf+dfIJhp49su82n
         mU9xpR9RTOT2k8D7Fd/7pix9ixC71rv8V66e0uQmpW5MuH5fcwWU1pRHYe/ee7ujW97I
         p3JBC0LCGPAKTNfhHzKRuNbgY2PC0G1vBJP6aHDnFKHGDlzgzOUzh8EEiPfkA3AA/OE8
         RaNFCuaw9xTLEdcvMlMWRFOP+WbQtv2uaP/q7OR+U+DizoM3+IzFy1//9O8+N9w+/UYA
         VRWdz1Gdg+48RLbAV5DWEEAxmF//uIk7MhNmnP6zkl8pMQ7E8cYUffyb8wRwf8lYfQPK
         bKWg==
X-Gm-Message-State: ACgBeo0u1kHr3Mn0Ha71joMQmhQ7POMLkFiUoXjVp7OM39CLZX+mDBrU
        bqzPwAPGBw1UxG45Rqd948FDgyoV95Nh8g==
X-Google-Smtp-Source: AA6agR6CQq4doWm5mIUZLbDA4DX0/kiRRk1Pgi2PobKKGsA3X1K4rewlBWM+htEKcwLo/DTTDY4qmw==
X-Received: by 2002:a5d:514f:0:b0:220:6b4d:f806 with SMTP id u15-20020a5d514f000000b002206b4df806mr4439167wrt.137.1659455189089;
        Tue, 02 Aug 2022 08:46:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 12/28] submodule--helper: use xstrfmt() in clone_submodule()
Date:   Tue,  2 Aug 2022 17:45:56 +0200
Message-Id: <patch-v2-12.28-e5e267dccd5-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use xstrfmt() in clone_submodule() instead of a "struct strbuf" in two
cases where we weren't getting anything out of using the "struct
strbuf".

This changes code that was was added along with other uses of "struct
strbuf" in this function in ee8838d1577 (submodule: rewrite
`module_clone` shell function in C, 2015-09-08).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 60165a848a2..63008970f1c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1568,12 +1568,11 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	sm_gitdir = absolute_pathdup(sb.buf);
 	strbuf_reset(&sb);
 
-	if (!is_absolute_path(clone_data->path)) {
-		strbuf_addf(&sb, "%s/%s", get_git_work_tree(), clone_data->path);
-		clone_data->path = strbuf_detach(&sb, NULL);
-	} else {
+	if (!is_absolute_path(clone_data->path))
+		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
+					   clone_data->path);
+	else
 		clone_data->path = xstrdup(clone_data->path);
-	}
 
 	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0)
 		die(_("refusing to create/use '%s' in another submodule's "
@@ -1625,14 +1624,16 @@ static int clone_submodule(struct module_clone_data *clone_data)
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    clone_data->url, clone_data->path);
 	} else {
+		char *path;
+
 		if (clone_data->require_init && !access(clone_data->path, X_OK) &&
 		    !is_empty_dir(clone_data->path))
 			die(_("directory not empty: '%s'"), clone_data->path);
 		if (safe_create_leading_directories_const(clone_data->path) < 0)
 			die(_("could not create directory '%s'"), clone_data->path);
-		strbuf_addf(&sb, "%s/index", sm_gitdir);
-		unlink_or_warn(sb.buf);
-		strbuf_reset(&sb);
+		path = xstrfmt("%s/index", sm_gitdir);
+		unlink_or_warn(path);
+		free(path);
 	}
 
 	connect_work_tree_and_git_dir(clone_data->path, sm_gitdir, 0);
-- 
2.37.1.1233.ge8b09efaedc

