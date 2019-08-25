Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 210C51F461
	for <e@80x24.org>; Sun, 25 Aug 2019 18:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfHYS70 (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Aug 2019 14:59:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37236 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbfHYS7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Aug 2019 14:59:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so13239870wrt.4
        for <git@vger.kernel.org>; Sun, 25 Aug 2019 11:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGItKpIFJgEkbOcz6/stHtk7JFePxAjBHaToQtg5KQo=;
        b=dxHrXoquzNSHtBBtnLPocwxpQ6KST0ikVC6HThq2LiCJKJ1zaAWb2iJMCDxCOlFCsm
         U0I2QSb80j6O3ZtR2NIHddLGEAlegsv+fi8MeLjdJahR1bAB2g/fomMWTonQmaphW88m
         3MwGfHY5oLj8bQA0ElKc8ZGE80XssZQ+C963tyq4LE+dHmgEXFl7tORFyImY1N3brweq
         u24kSVlLAtAxHVrDqkAwlqH/HxwdkBXzYWWYkyZrHhnQcloIMYV1mpBg5EpKdNGWxY5v
         I0iEa2+Jsy/bGBaEEEvym9w2L2JG+unxUAzDhfIPjYRPTJOmPopVNOIbjpYEr8hvrGMQ
         eTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WGItKpIFJgEkbOcz6/stHtk7JFePxAjBHaToQtg5KQo=;
        b=i8nT1uMOAumOrKPMxOa6Jrpd0YtiFA+2I1Vfugf4ZN6s8c+fsvBB5mTDrtCfx5Au/q
         V5l/GzfWokwmomeE7Z+cDm4YrsyfbC2GyxUQ//RPkYgq6HLWz2/xLsIdCsTp5s4FQWOG
         P4WGlsVE+OlOE9Bc9mzji/KiIkXv8oa7QUZzHVLwthP/Li6SCgs3XfxdDE4pathmi8wD
         ohOw3gzQOnFwryyn6EiTzJXk+DsiNRX1+PMoQ1H+LIqehn88946Pakngs2XZsWBPh8CL
         3uH3vxA9yN2zzRfUnbdkKZZNDyFH6pl5RjilSe4GUV/FjkCkFDwOSTD5wL1w9EQv/Hb8
         jGJw==
X-Gm-Message-State: APjAAAXCzamwb5G1OJ+W0woWElh/ZRYsLhwu7qwLa20dFxzw0Aqt77mZ
        2oxnqof8GlM8Mq/8sNzAYdc=
X-Google-Smtp-Source: APXvYqyIf1o9Qx5cZ4msX/99R9ZHGUWR1Vufuh4U6YKpQFxwiAHPORwMHxuowSF0ruHKpD5dCDDwXw==
X-Received: by 2002:a5d:4946:: with SMTP id r6mr18811933wrs.266.1566759563850;
        Sun, 25 Aug 2019 11:59:23 -0700 (PDT)
Received: from localhost.localdomain (x4db347f6.dyn.telefonica.de. [77.179.71.246])
        by smtp.gmail.com with ESMTPSA id i5sm11966547wrn.48.2019.08.25.11.59.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Aug 2019 11:59:23 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Samuel Lijin <sxlijin@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] t7300-clean: demonstrate deleting nested repo with an ignored file breakage
Date:   Sun, 25 Aug 2019 20:59:18 +0200
Message-Id: <20190825185918.3909-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git clean -fd' must not delete an untracked directory if it belongs
to a different Git repository or worktree.  Unfortunately, if a
'.gitignore' rule in the outer repository happens to match a file in a
nested repository or worktree, then something goes awry and 'git clean
-fd' does delete the content of the nested repository's worktree
except that ignored file, potentially leading to data loss.

Add a test to 't7300-clean.sh' to demonstrate this breakage.

This issue is a regression introduced in 6b1db43109 (clean: teach
clean -d to preserve ignored paths, 2017-05-23).

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

BEWARE: Our toplevel '.gitignore' currently contains the '*.manifest'
rule [1], which ignores the file 'compat/win32/git.manifest' [2], so
if you use nested worktrees in your git repo, then a 'git clean -fd'
will delete them.

[1] 516dfb8416 (.gitignore: touch up the entries regarding Visual
    Studio, 2019-07-29)
[2] fe90397604 (mingw: embed a manifest to trick UAC into Doing The
    Right Thing, 2019-06-27)


 t/t7300-clean.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index a2c45d1902..d01fd120ab 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,6 +669,28 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
+test_expect_failure 'git clean -d skips nested repo containing ignored files' '
+	test_when_finished "rm -rf nested-repo-with-ignored-file" &&
+
+	git init nested-repo-with-ignored-file &&
+	(
+		cd nested-repo-with-ignored-file &&
+		>file &&
+		git add file &&
+		git commit -m Initial &&
+
+		# This file is ignored by a .gitignore rule in the outer repo
+		# added in the previous test.
+		>ignoreme
+	) &&
+
+	git clean -fd &&
+
+	test_path_is_file nested-repo-with-ignored-file/.git/index &&
+	test_path_is_file nested-repo-with-ignored-file/ignoreme &&
+	test_path_is_file nested-repo-with-ignored-file/file
+'
+
 test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_config core.longpaths false &&
 	a50=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa &&
-- 
2.23.0.331.g4e51dcdf11

