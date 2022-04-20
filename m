Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A53EC433FE
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 20:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382134AbiDTUqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 16:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382122AbiDTUqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 16:46:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6214393CD
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso2027111wml.5
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 13:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FYejdevIv/sNJ+Pm7nNh32hrd+w9z8t9/s1drm2KRzs=;
        b=eO3tXYjk5rpa5iFn2MkndjEykwzpvoVRKzD2dRI31gFJIE12oM8aMi4CbTIO6STZst
         fmZvPaDYJzaANZWnti8FEqLRtSarOUC3QjiuifeKqbQC6BbycUzuUvH2umfdE6jTzNkk
         sLwFUQaJ/UCnHjBSX6erl/wQOiABF1UgEcloTHa7NPrBycEK3qsvf25oqayivMfQ+lId
         uRtZ+Mb1fmCu+KXqrazgetNd0Aw8N0i7e1zmiatrhIszg0a+NNYKga8SGBlyZgIDZ1EJ
         AkNCcz+SsSYqxo9Cel1mlxUEBNUXB8TmG0KCewG0Eex0WLy+jhxcCZpZW6Kg9lAQ1lGE
         Ndyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FYejdevIv/sNJ+Pm7nNh32hrd+w9z8t9/s1drm2KRzs=;
        b=NGHAhVJcUCb4TBP9h7z5KcZIkXvY1pojT1XWcSs54opHHCrILtdE194EHgdxMyN2vH
         zZUc9V6OidsNUnlOBLTa+9l8Tc6N4DpqQGVVyDrjSV12SdFA0IiHRdYSZ6hK6gSFjNjj
         3/V5xbLE8Hbqr/QPArql6fQKuODcFK3wu+r5lxz+D3eMua8WD1CSoP4OrVIMSc/I3IPB
         gEcpIRLUa9R2V3XHh5Op8C+NwYhFvDa8EuS6xUUVuGF0se2MHlly9eVrq4GCtB1zcS+V
         RUZsQNYiO5T6DPG9OaxlBFAaMc8EKjCglTJEF+OcxT8z3cWhecqTDZ2pL3+umYP6Mj0h
         aW2A==
X-Gm-Message-State: AOAM533SQpG4J9Fxto+nPCyUL51D+K8Ad6OGfQjrMvPZUvSDNSH+Hr52
        hOEPDvU/Yr7kaJBzQW5dyk/Vgpqu8po=
X-Google-Smtp-Source: ABdhPJwXrUheSyWgR3uKftzYw8LRNfTNsWfm/yJ59ob07QkmZpFEUmPoryTSiAvGL5pYuMOeNzU7Xw==
X-Received: by 2002:a05:600c:3b91:b0:38f:f29a:202f with SMTP id n17-20020a05600c3b9100b0038ff29a202fmr5368955wms.35.1650487404104;
        Wed, 20 Apr 2022 13:43:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c3807000000b0038ffac6f752sm308599wma.45.2022.04.20.13.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 13:43:23 -0700 (PDT)
Message-Id: <5b246bec2470431898ddc74013f6fb325c2bc281.1650487398.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
References: <pull.1143.v4.git.1648140680.gitgitgadget@gmail.com>
        <pull.1143.v5.git.1650487398.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 20:42:52 +0000
Subject: [PATCH v5 02/28] t7527: test FSMonitor on repos with Unicode root
 paths
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Create some test repos with UTF8 characters in the pathname of the
root directory and verify that the builtin FSMonitor can watch them.

This test is mainly for Windows where we need to avoid `*A()`
routines.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index 1be21785162..c9c7dd77e3c 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -671,4 +671,27 @@ do
 	done
 done
 
+# Test Unicode UTF-8 characters in the pathname of the working
+# directory root.  Use of "*A()" routines rather than "*W()" routines
+# on Windows can sometimes lead to odd failures.
+#
+u1=$(printf "u_c3_a6__\xC3\xA6")
+u2=$(printf "u_e2_99_ab__\xE2\x99\xAB")
+u_values="$u1 $u2"
+for u in $u_values
+do
+	test_expect_success "Unicode in repo root path: $u" '
+		test_when_finished "stop_daemon_delete_repo $u" &&
+
+		git init "$u" &&
+		echo 1 >"$u"/file1 &&
+		git -C "$u" add file1 &&
+		git -C "$u" config core.fsmonitor true &&
+
+		start_daemon -C "$u" &&
+		git -C "$u" status >actual &&
+		grep "new file:   file1" actual
+	'
+done
+
 test_done
-- 
gitgitgadget

