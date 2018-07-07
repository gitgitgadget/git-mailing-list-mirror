Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F0C1F62D
	for <e@80x24.org>; Sat,  7 Jul 2018 20:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754465AbeGGUoX (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Jul 2018 16:44:23 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:40263 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754413AbeGGUoP (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jul 2018 16:44:15 -0400
Received: by mail-yb0-f194.google.com with SMTP id y11-v6so5838954ybm.7
        for <git@vger.kernel.org>; Sat, 07 Jul 2018 13:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8VO+oM0QDWTbNCK3vHh8vKkyHctw1iYfjukD9K+7qQ0=;
        b=GOSK7a2W/RgPK1YRXf1eWCYPsUiS/A9NRwo5cXXQ2T1+TKRky8++cveo5I2/TzR7Yd
         CIn/TqKeks09lLbTr2gQW92+6rcYfhlpaLNBCOSlh24NjfkwOjZlFeZsvaipqifzg/dm
         BFKxZh2ANqC6XLN0tUHn1+tTv5yNMlNu+TU2YcyP2mnAuraAmliznDBMZ9B3dVK/CQky
         MaLa7F+nZwLYthNPMUxHEH9W/3/dg61JL1ZvqE/pMmuyUI8Ty1GSaDDQtb9w3xCwANzq
         VLu77cuIZa0opltmp2TsKOdaUcPJo5dVrKdjmFxYw1ikwhC2HZUOuWz5Cq0MPxOovWdz
         yhhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8VO+oM0QDWTbNCK3vHh8vKkyHctw1iYfjukD9K+7qQ0=;
        b=TMH8RMmzhYBzSCEtwV1oSgX2tlkkIy2vWkmYWyTnV8e3vMqRlZCc5Vuz6N9+yD9cTs
         ZEqjND9+qpWaGYEsU5cLtaZGzJcjPpQube1lGQ/Ed+TaoIaCq/8pyQ/Oh3uRlFTe8o/A
         HLS2kKugGs6AmKX9mszqZMPqH6KY7Px2REoxeZvWxwkUa/eR8n6kia4XJe4OmwRbDGjZ
         dv1iyG2weYrPwtxRjWhw4EVelvueRcZ/VneDhVWA1KChDdeA2qExaajauMu9kJ4fMygp
         cHNVuBp8LcFEYaceh9yYt1/T5ImhZ+Hq9OH5HK9He+wE+LHEcClOqc4qK2reIZsF4fqz
         vm0g==
X-Gm-Message-State: APt69E2pjyNX+0lD8hr+45s742udGrD6UoLe7BKskvw+roroHgonpT0n
        HxPVmglhh6VXEgrjHPc6vcQvsw==
X-Google-Smtp-Source: AAOMgpe97hRA4zksGMlA0NI70vcJTV17qDlDHcv0PiMzaHl6b05eIlmTwej0bFeMjCrVkl2kHAoGqQ==
X-Received: by 2002:a25:f510:: with SMTP id a16-v6mr8055455ybe.36.1530996254617;
        Sat, 07 Jul 2018 13:44:14 -0700 (PDT)
Received: from tiger.attlocal.net ([2602:30a:2c28:20f0:7c1a:85e3:2ea9:5d7e])
        by smtp.gmail.com with ESMTPSA id u4-v6sm4535058ywd.21.2018.07.07.13.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Jul 2018 13:44:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/3] t7405: add a directory/submodule conflict
Date:   Sat,  7 Jul 2018 13:44:03 -0700
Message-Id: <20180707204404.7208-3-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.134.gafc206209.dirty
In-Reply-To: <20180707204404.7208-1-newren@gmail.com>
References: <20180707204404.7208-1-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a directory/submodule conflict, we want contents from both the
directory and the submodule to be present for the user to use to resolve
the conflict, but we do not want paths under the directory being written
into the submodule and we do not want the merge being confused by paths
under the submodule being in the way.  Add testcases for these situations.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7405-submodule-merge.sh | 91 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
index 95fd05d83..6cb51c966 100755
--- a/t/t7405-submodule-merge.sh
+++ b/t/t7405-submodule-merge.sh
@@ -335,4 +335,95 @@ test_expect_failure 'file/submodule conflict' '
 	)
 '
 
+# Directory/submodule conflict
+#   Commit O: <empty>
+#   Commit A: path (submodule), with sole tracked file named 'world'
+#   Commit B1: path/file
+#   Commit B2: path/world
+#
+#   Expected from merge of A & B1:
+#     Contents under path/ from commit B1 are renamed elsewhere; we do not
+#     want to write files from one of our tracked directories into a submodule
+#
+#   Expected from merge of A & B2:
+#     Similar to last merge, but with a slight twist: we don't want paths
+#     under the submodule to be treated as untracked or in the way.
+
+test_expect_success 'setup directory/submodule conflict' '
+	test_create_repo directory-submodule &&
+	(
+		cd directory-submodule &&
+
+		git commit --allow-empty -m O &&
+
+		git branch A &&
+		git branch B1 &&
+		git branch B2 &&
+
+		git checkout B1 &&
+		mkdir path &&
+		echo contents >path/file &&
+		git add path/file &&
+		git commit -m B1 &&
+
+		git checkout B2 &&
+		mkdir path &&
+		echo contents >path/world &&
+		git add path/world &&
+		git commit -m B2 &&
+
+		git checkout A &&
+		test_create_repo path &&
+		(
+			cd path &&
+
+			echo hello >world &&
+			git add world &&
+			git commit -m "submodule"
+		) &&
+		git add path &&
+		git commit -m A
+	)
+'
+
+test_expect_failure 'directory/submodule conflict; keep submodule clean' '
+	test_when_finished "git -C directory-submodule reset --hard" &&
+	(
+		cd directory-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B1^0 &&
+
+		git ls-files -s >out &&
+		test_line_count = 2 out &&
+		git ls-files -u >out &&
+		test_line_count = 1 out &&
+
+		# path/ is still a submodule
+		test_path_is_dir path/.git &&
+
+		echo Checking if contents from B1:path/file showed up &&
+		# Would rather use grep -r, but that is GNU extension...
+		git ls-files -co | xargs grep -q contents 2>/dev/null &&
+		test_path_is_missing path/file
+	)
+'
+
+test_expect_failure 'directory/submodule conflict; should not treat submodule files as untracked or in the way' '
+	test_when_finished "git -C directory-submodule/path reset --hard" &&
+	test_when_finished "git -C directory-submodule reset --hard" &&
+	(
+		cd directory-submodule &&
+
+		git checkout A^0 &&
+		test_must_fail git merge B2^0 >out 2>err &&
+
+		# We do not want files within the submodule to prevent the
+		# merge from starting; we should not be writing to such paths
+		# anyway.
+		test_i18ngrep ! "refusing to lose untracked file at" err
+
+	)
+'
+
 test_done
-- 
2.18.0.134.gafc206209.dirty

