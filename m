Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3F9EC3B184
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE30821775
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 00:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErXPypYe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgBJAbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Feb 2020 19:31:13 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44574 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727417AbgBJAbL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Feb 2020 19:31:11 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so5373952wrx.11
        for <git@vger.kernel.org>; Sun, 09 Feb 2020 16:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ura7joPGvQVceXsTwzocUlrhSEn5DAEWoPVexjnRSW4=;
        b=ErXPypYei8+GJnJpy3w9TWDdwNkp3c6KTC8lWQmr4Vaty6TxotO2ONXCWFUmKL4VAZ
         FG+qy32Gz0qJn9fA6WpSxLIzCqt2sTdi9PYjzX3K3gre2oVDIJ3IQxzlwe58x4VNG4+H
         xE4XJPD8+94ixoCg3yVT6tqjsx5W2iTdumGnff+Dm78f2dAIaWalAT/odR776KBbc5Ql
         Sg9k4Hf7eviNDnBRcb2R30cy+DZT7rS8hpkpY/e7x04eS35i4SEprW3qLVxE/JXLRlM4
         LP//uSimnNMhjWqDdQlkz0gso4o5ksNcI82CH6GYw9epjxAK+02rAM88WTKF/NSYiUj9
         AkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ura7joPGvQVceXsTwzocUlrhSEn5DAEWoPVexjnRSW4=;
        b=mEZpClEaX/qSV5SPkQ33CJWklXnamwYTkKBE1vN/Df/zm59nMRN3pMqBnOmEKdeBwW
         nFt1NbOQDeYAgQQ+dcyzShEtlRlqXltASXANNGrC5D6qi4uGAdNIKoXhTB/ztWPlUpjs
         9fgKA/0b/L6oSH+i+JAosx6fZiFz6QWTkU4t9FVMT0Oz1Pi4BlSfZWEbORVLi2GYM8Cq
         SX/bo4fTyhCuLzTeWAUAr9MwYjf/NVFJl/wTTWeEwE6gWifsgqceTbjRoVlCZ+KI4dt8
         hYJJ5O9NmFOtkIpHNh/XdZGCIL0eLNCMz4t9RsM4s/fcSRHuyOh7BIGtrYE/JHOL16m3
         NUmQ==
X-Gm-Message-State: APjAAAUzWK4OZfUqB/5OGRCuK3OEaFLHQc5tmNKSUsgTOZrrG9DY0ZiX
        EHI2NOkUnIGEMKPiGjSUQGzp7rP/
X-Google-Smtp-Source: APXvYqy6MifxdDJeG5RURAXdWPytMc6qhzTak1bp5iRjz9i9vvmM8Wo0pRXQKIZq9VQAfU753q1XhA==
X-Received: by 2002:adf:ea85:: with SMTP id s5mr13038704wrm.75.1581294668583;
        Sun, 09 Feb 2020 16:31:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a62sm13376380wmh.33.2020.02.09.16.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2020 16:31:08 -0800 (PST)
Message-Id: <dd376246ec75e50b2e07f10ae7ec1e59c1e0572f.1581294660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
References: <pull.478.v6.git.1580268865.gitgitgadget@gmail.com>
        <pull.478.v7.git.1581294660.gitgitgadget@gmail.com>
From:   "Matthew Rogers via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 00:30:58 +0000
Subject: [PATCH v7 09/10] submodule-config: add subomdule config scope
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Matthew Rogers <mattr94@gmail.com>,
        Matthew Rogers <mattr94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matthew Rogers <mattr94@gmail.com>

Before the changes to teach git_config_source to remember scope
information submodule-config.c never needed to consider the question of
config scope.  Even though zeroing out git_config_source is still
correct and preserved the previous behavior of setting the scope to
CONFIG_SCOPE_UNKNOWN, it's better to be explicit about such situations
by explicitly setting the scope.  As none of the current config_scope
enumerations make sense we create CONFIG_SCOPE_SUBMODULE to describe the
situation.

Signed-off-by: Matthew Rogers <mattr94@gmail.com>
---
 config.c           | 2 ++
 config.h           | 1 +
 submodule-config.c | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/config.c b/config.c
index 9b6afca210..18a6bdd9ff 100644
--- a/config.c
+++ b/config.c
@@ -3311,6 +3311,8 @@ const char *config_scope_name(enum config_scope scope)
 		return "worktree";
 	case CONFIG_SCOPE_COMMAND:
 		return "command";
+	case CONFIG_SCOPE_SUBMODULE:
+		return "submodule";
 	default:
 		return "unknown";
 	}
diff --git a/config.h b/config.h
index 165cacb7da..fe0addb0dc 100644
--- a/config.h
+++ b/config.h
@@ -42,6 +42,7 @@ enum config_scope {
 	CONFIG_SCOPE_LOCAL,
 	CONFIG_SCOPE_WORKTREE,
 	CONFIG_SCOPE_COMMAND,
+	CONFIG_SCOPE_SUBMODULE,
 };
 const char *config_scope_name(enum config_scope scope);
 
diff --git a/submodule-config.c b/submodule-config.c
index 85064810b2..b8e97d8ae8 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -635,7 +635,9 @@ static void submodule_cache_check_init(struct repository *repo)
 static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void *data)
 {
 	if (repo->worktree) {
-		struct git_config_source config_source = { 0 };
+		struct git_config_source config_source = {
+			0, .scope = CONFIG_SCOPE_SUBMODULE
+		};
 		const struct config_options opts = { 0 };
 		struct object_id oid;
 		char *file;
-- 
gitgitgadget

