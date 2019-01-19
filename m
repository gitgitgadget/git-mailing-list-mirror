Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6B2FE1F453
	for <e@80x24.org>; Sat, 19 Jan 2019 23:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729795AbfASXY2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 Jan 2019 18:24:28 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39714 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729766AbfASXY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Jan 2019 18:24:27 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so17623596otl.6
        for <git@vger.kernel.org>; Sat, 19 Jan 2019 15:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrQJ6Ebd3VtzSPWqslP5PzREESXV3sNQcopcYazD8tA=;
        b=JDFWXEVhW+Vhfh5TgI1xHLQoa8mfeE+MgBsd3AyafuAU5GfZudRY4lnsTC8tn80ON5
         YKqY5q61eAUW0QyOVI/k1zq1/YYFj67ZoAv16Zz5up8gh7yFZ5iw/PVMDRmXhkd93Atu
         s/Sp10OoaHbC7VWyhZui2rUjfScJXQhDzdfrU1jnwQUDVgifBTeawaYw9bf3nj5htoI6
         IWaT4n8EGrHD9neUtpXxBytJYdcDPh2l/UbtXs5uvw4Yh4iPcXGN47iqWN56QOCSbwtv
         JGZfTAkVqd+fm9W5NNtRSAtmt53Njnx1GBsIsWVBWjlbm5bW9fA3eKetHxWgV9LVmhwt
         WyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrQJ6Ebd3VtzSPWqslP5PzREESXV3sNQcopcYazD8tA=;
        b=nHCj4S1IuZTrz9PJeJQkDdD9N5jOTyVNilZE5BDYVWHMd7Qgd8kyGOnkq+/rVWIhEI
         WHskqcYaOooAYVKKpN4eyN4ZveWft5MDoujEIu00bLoavxXMYfwRqWOe/J31mNVMS2XI
         NhG6ukVOTqlauKhMhT/TkUB0Bg9c674iXLLzfVcKLkHapIbSR4Ig3OQxadBQbem0ezFi
         vIwxkwMoeq3eqz4f3PB125qvPldJqsU+fGBoj2V+HtDGc4nRecQepxN7cxP5nIRN/G0T
         lhnLUh0VmetrswfGSHKxYiYLfRCIx4oKOrWeysEnqJX1FmYp/pBYFgNKvpwK2dvEeDWI
         64sA==
X-Gm-Message-State: AJcUukc7TKYEfwyF0MhZPWTt5hTKQXa21+LoqWU0JMTCb8mjWrES/2tW
        bu9k0rUoP/5plLIQ/MliVz8j/v7o+4x3AQ==
X-Google-Smtp-Source: ALg8bN67XzSgxTxoWhyD23wBJPwFJ+CqLkSl5Et//zLiightL19H8BfZ1hQ/VXJN9woOQvsxneENTw==
X-Received: by 2002:a9d:51c2:: with SMTP id d2mr16221822oth.0.1547940266605;
        Sat, 19 Jan 2019 15:24:26 -0800 (PST)
Received: from localhost.localdomain ([165.231.210.5])
        by smtp.gmail.com with ESMTPSA id q131sm4217385oih.1.2019.01.19.15.24.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 19 Jan 2019 15:24:26 -0800 (PST)
From:   Brandon Richardson <brandon1024.br@gmail.com>
To:     git@vger.kernel.org, martin.agren@gmail.com, gitster@pobox.com
Cc:     Brandon Richardson <brandon1024.br@gmail.com>
Subject: [PATCH v4 2/2] commit-tree: add missing --gpg-sign flag
Date:   Sat, 19 Jan 2019 19:23:34 -0400
Message-Id: <20190119232334.31646-2-brandon1024.br@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190119232334.31646-1-brandon1024.br@gmail.com>
References: <20190119232334.31646-1-brandon1024.br@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add --gpg-sign option in commit-tree, which was documented, but not
implemented, in 55ca3f99ae. Add tests for the --gpg-sign option.

Signed-off-by: Brandon Richardson <brandon1024.br@gmail.com>
---
 builtin/commit-tree.c    |  8 +++++++-
 t/t7510-signed-commit.sh | 15 ++++++++++++---
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 9ec36a82b..12cc403bd 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -66,7 +66,13 @@ int cmd_commit_tree(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
-		if (skip_prefix(arg, "-S", &sign_commit))
+		if (!strcmp(arg, "--gpg-sign")) {
+		    sign_commit = "";
+		    continue;
+		}
+
+		if (skip_prefix(arg, "-S", &sign_commit) ||
+			skip_prefix(arg, "--gpg-sign=", &sign_commit))
 			continue;
 
 		if (!strcmp(arg, "--no-gpg-sign")) {
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 58f528b98..682b23a06 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -55,13 +55,22 @@ test_expect_success GPG 'create signed commits' '
 	# explicit -S of course must sign.
 	echo 10 | git commit-tree -S HEAD^{tree} >oid &&
 	test_line_count = 1 oid &&
-	git tag tenth-signed $(cat oid)
+	git tag tenth-signed $(cat oid) &&
+
+	# --gpg-sign[=<key-id>] must sign.
+	echo 11 | git commit-tree --gpg-sign HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag eleventh-signed $(cat oid) &&
+	echo 12 | git commit-tree --gpg-sign=B7227189 HEAD^{tree} >oid &&
+	test_line_count = 1 oid &&
+	git tag twelfth-signed-alt $(cat oid)
 '
 
 test_expect_success GPG 'verify and show signatures' '
 	(
 		for commit in initial second merge fourth-signed \
-			fifth-signed sixth-signed seventh-signed tenth-signed
+			fifth-signed sixth-signed seventh-signed tenth-signed \
+			eleventh-signed
 		do
 			git verify-commit $commit &&
 			git show --pretty=short --show-signature $commit >actual &&
@@ -82,7 +91,7 @@ test_expect_success GPG 'verify and show signatures' '
 		done
 	) &&
 	(
-		for commit in eighth-signed-alt
+		for commit in eighth-signed-alt twelfth-signed-alt
 		do
 			git show --pretty=short --show-signature $commit >actual &&
 			grep "Good signature from" actual &&
-- 
2.20.1

