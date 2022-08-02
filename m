Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C46C19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbiHBPrd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236119AbiHBPq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:46:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49A823BF5
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:35 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso7142461wmq.3
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=yhZ9Lh9Fgv7nM+ZluUnhHI8lw2CMsdcCtaqEQ7/3mzA=;
        b=qiN6d97I+xicyevL7vWE32jiZxS7WbPsZJCsmrSH8g68vUEAzKx5wNJTmCQp4p8mJH
         ES2Fi2HM1vZXj7S/Vs+VZFqXJ5MUUMpQBqb8Dp0O7nwNfYpY0uC3/nIBTlwg7F7Hu4Iw
         nciX6dax+27/Gfn+WeRQ4P53KCKGdOR95ozYrygRAnvUEvinxSkGjdHejCntefSJXwCJ
         DTNpnrZfqOsawrPs+qVv4ucBiy2dmHcIciFh7US0Lmer9MokyYqCBYCqNPZZTZAGg6T7
         frTePv5rGPJ1H938oUq8pYph5WTqmWYiuIVoY8xCsUt8QyVLfHMJNzpDWh/JRfFU6ENw
         gx8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=yhZ9Lh9Fgv7nM+ZluUnhHI8lw2CMsdcCtaqEQ7/3mzA=;
        b=7NY5QmIkSCvAWJvZZu/BzWw2lQ4QnpbJjqlnt4pJPQLC+DEKSpjDBBsyL3HMWLGDw+
         p7/Rp6jJMt637/sCfKxF1L4N8R5LOwPDSWGXrd48ECwNIIdqzjJendSXs4I+sd9o4h9K
         bBlA7EJAqNQLQ0mYCreywMrZ0f0TBD9sy1E7cxKSN6B0aYbvyrT/6H1j7VJrgdrIajRG
         aycElDHCIYtb7d1TAi0qhX2SfqYBvemCcj+lxh5VMZSqzVL46neKeEgmacXKRACC9hDE
         f5r2n9gyFrkpqIsnahBAWP4VILEsOuduircT1GvKbuY5GSCOBsuIgk01west6QfMYO7t
         +smg==
X-Gm-Message-State: ACgBeo2iuy3mHWGmfNUr2jrE/W+/ZMujYS1pt6K/mqIc/11YNZMuBYXK
        41CGwT62mOIc2uGc5XD6RV/1gCNczxhRBw==
X-Google-Smtp-Source: AA6agR6DVnNyoZX2SVuk2LJYmobP87OgnuIKbBOAnHM356txB3cskKYoy6ZqVXy5DUE3icYEk2BioA==
X-Received: by 2002:a05:600c:4fcf:b0:3a3:40f6:4c4d with SMTP id o15-20020a05600c4fcf00b003a340f64c4dmr75082wmq.60.1659455194956;
        Tue, 02 Aug 2022 08:46:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 18/28] submodule--helper: rename "int res" to "int ret"
Date:   Tue,  2 Aug 2022 17:46:02 +0200
Message-Id: <patch-v2-18.28-78f74df6d5e-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename the "res" variable added in b3c5f5cb048 (submodule: move core
cmd_update() logic to C, 2022-03-15) to "ret", which is the convention
in the rest of this file.

Eventual follow-up commits will change the code in update_submodule()
to a "goto cleanup" pattern, let's have the post image look consistent
with the rest. For update_submodules() let's also use a "ret" for
consistency, that use was also added in b3c5f5cb048. We'll be
modifying that codepath in subsequent commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a19723f596..29f3e1dd8c8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2424,7 +2424,7 @@ static int update_submodule(struct update_data *update_data)
 	if (update_data->recursive) {
 		struct child_process cp = CHILD_PROCESS_INIT;
 		struct update_data next = *update_data;
-		int res;
+		int ret;
 
 		next.prefix = NULL;
 		oidcpy(&next.oid, null_oid());
@@ -2436,13 +2436,13 @@ static int update_submodule(struct update_data *update_data)
 		update_data_to_args(&next, &cp.args);
 
 		/* die() if child process die()'d */
-		res = run_command(&cp);
-		if (!res)
+		ret = run_command(&cp);
+		if (!ret)
 			return 0;
 		die_message(_("Failed to recurse into submodule path '%s'"),
 			    update_data->displaypath);
-		if (res == 128)
-			exit(res);
+		if (ret == 128)
+			exit(ret);
 		return 1;
 	}
 
@@ -2451,7 +2451,7 @@ static int update_submodule(struct update_data *update_data)
 
 static int update_submodules(struct update_data *update_data)
 {
-	int i, res = 0;
+	int i, ret = 0;
 	struct submodule_update_clone suc = SUBMODULE_UPDATE_CLONE_INIT;
 
 	suc.update_data = update_data;
@@ -2469,7 +2469,7 @@ static int update_submodules(struct update_data *update_data)
 	 * - the listener can avoid doing any work if fetching failed.
 	 */
 	if (suc.quickstop) {
-		res = 1;
+		ret = 1;
 		goto cleanup;
 	}
 
@@ -2481,12 +2481,12 @@ static int update_submodules(struct update_data *update_data)
 		update_data->sm_path = ucd.sub->path;
 
 		if (update_submodule(update_data))
-			res = 1;
+			ret = 1;
 	}
 
 cleanup:
 	string_list_clear(&update_data->references, 0);
-	return res;
+	return ret;
 }
 
 static int module_update(int argc, const char **argv, const char *prefix)
-- 
2.37.1.1233.ge8b09efaedc

