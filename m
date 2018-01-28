Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C841F404
	for <e@80x24.org>; Sun, 28 Jan 2018 00:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752767AbeA1AgX (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 19:36:23 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:45889 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752626AbeA1AgW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jan 2018 19:36:22 -0500
Received: by mail-lf0-f67.google.com with SMTP id x196so5043136lfd.12
        for <git@vger.kernel.org>; Sat, 27 Jan 2018 16:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=N7GZcOXvhimkQRUTGnYZXqUm1p68lF/giwCHd8uBHTc=;
        b=ZydaSrY0cvEc8wshVNQ9L7ZJEqbVCU21PpGTGOmAdJoJ3KVveDr/DQzIzY+wNMCBwA
         XhSfpK87uJ9ncVD547Qwccm3fWROxRuVCIpHOgeB4BaKSssgWn2MiV4dqpYdENn/vo5m
         UoWdB6Pi7K74xUnYXA/gvNTzYA0jrfuZXtg6wnYK0T5xpXBNc4LoXW0dWsc5yYZ5xWFw
         A20sShRIuxWFFwh5363rgnlq7Yzgn8yRmwNA/466/mLo2srTVaWYv0qbuh1Tdpo6AYCB
         Hn/7w7glCyehOg8V67c2v0fDOYWcC3oUDB/KLaXzcnyaee4sU/IHwQuaK7486dygLP8L
         roUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=N7GZcOXvhimkQRUTGnYZXqUm1p68lF/giwCHd8uBHTc=;
        b=t/ng0aa1b2w4poN93zLRsKVo+QwTMVLA8d0koQsi0t6Cdxrg+TYiGCjXH6J+48k5e2
         PRuwzBc6JvPl7rnbtJvWR1qwAcHO+5gFFz5jgxM8dmeB3xl20pRi8d7wpLnBtNcEaO0X
         27XHTYwNND0QCPNPNM8q/bWWmyF337sHAq7A7AvCJ46/UchDaQG/u4kWXksD2N/c6bgy
         OZZEGTDYJ9iWMmbk72awXmM4WKLssAi1IbN90DAxuyefc/f46liGse12GHLyQidrCGdd
         +BtP54jqLg6JBalApyYPYcl+4HgbcPv9Df0mWkopG1VB8MqeE2smwNfN5P1LwY/x61Rg
         Enxg==
X-Gm-Message-State: AKwxytcnM0dOxkpDAdbOq0FU0H9QQB6c+MdF27OmzinFD+uUhph4PEij
        1ZcjhhN2aWgFCs+9ra4sLbZs4RYd
X-Google-Smtp-Source: AH8x227hWoyjjExaHG1lkqA+iZJRQrBH29cJvPeWOALNYFpZ8cLv4Ys8m9xBIG6389td9DO5e23WDw==
X-Received: by 10.25.74.87 with SMTP id x84mr10998552lfa.109.1517099780746;
        Sat, 27 Jan 2018 16:36:20 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id h78sm2132437lfk.31.2018.01.27.16.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Jan 2018 16:36:19 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, sbeller@google.com,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 1/1] setup: recognise extensions.objectFormat
Date:   Sun, 28 Jan 2018 01:36:17 +0100
Message-Id: <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1517098675.git.patryk.obara@gmail.com>
References: <af22d7feb8a8448fa3953c66e69a8257460bff07.1516800711.git.patryk.obara@gmail.com>
 <cover.1517098675.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1517098675.git.patryk.obara@gmail.com>
References: <cover.1517098675.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This extension selects which hashing algorithm from vtable should be
used for reading and writing objects in the object store.  At the moment
supports only single value (sha-1).

In case value of objectFormat is an unknown hashing algorithm, Git
command will fail with following message:

  fatal: unknown repository extensions found:
	  objectformat = <value>

To indicate, that this specific objectFormat value is not recognised.

The objectFormat extension is not allowed in repository marked as
version 0 to prevent any possibility of accidentally writing a NewHash
object in the sha-1 object store. This extension behaviour is different
than preciousObjects extension (which is allowed in repo version 0).

Add tests and documentation note about new extension.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 Documentation/technical/repository-version.txt | 12 ++++++++++++
 setup.c                                        | 27 ++++++++++++++++++++++++++
 t/t1302-repo-version.sh                        | 15 ++++++++++++++
 3 files changed, 54 insertions(+)

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad37986e..7e2b832603 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,15 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`objectFormat`
+~~~~~~~~~~~~~~
+
+This extension instructs Git to use a specific algorithm for addressing
+and interpreting objects in the object store. Currently, the only
+supported object format is `sha-1`. At the moment, the primary purpose
+of this option is to enable Git developers to experiment with different
+hashing algorithms without re-compilation of git client.
+
+See `hash-function-transition.txt` document for more detailed explanation.
+
diff --git a/setup.c b/setup.c
index 8cc34186ce..9b9993a14e 100644
--- a/setup.c
+++ b/setup.c
@@ -405,6 +405,31 @@ void setup_work_tree(void)
 	initialized = 1;
 }
 
+static int find_object_format(const char *value)
+{
+	int i;
+	for (i = GIT_HASH_SHA1; i < GIT_HASH_NALGOS; ++i) {
+		if (strcmp(value, hash_algos[i].name) == 0)
+			return i;
+	}
+	return GIT_HASH_UNKNOWN;
+}
+
+static void detect_object_format(struct repository_format *data,
+				 const char *value)
+{
+	if (data->version == 0)
+		die(_("invalid repository format version '%d'"), data->version);
+
+	data->hash_algo = find_object_format(value);
+	if (data->hash_algo == GIT_HASH_UNKNOWN) {
+		struct strbuf object_format = STRBUF_INIT;
+		strbuf_addf(&object_format, "objectformat = %s", value);
+		string_list_append(&data->unknown_extensions, object_format.buf);
+		strbuf_release(&object_format);
+	}
+}
+
 static int check_repo_format(const char *var, const char *value, void *vdata)
 {
 	struct repository_format *data = vdata;
@@ -422,6 +447,8 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
+		else if (!strcmp(ext, "objectformat"))
+			detect_object_format(data, value);
 		else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
diff --git a/t/t1302-repo-version.sh b/t/t1302-repo-version.sh
index ce4cff13bb..227b397ff2 100755
--- a/t/t1302-repo-version.sh
+++ b/t/t1302-repo-version.sh
@@ -107,4 +107,19 @@ test_expect_success 'gc runs without complaint' '
 	git gc
 '
 
+test_expect_success 'object-format not allowed in repo version=0' '
+	mkconfig 0 "objectFormat = sha-1" >.git/config &&
+	check_abort
+'
+
+test_expect_success 'object-format=sha-1 allowed' '
+	mkconfig 1 "objectFormat = sha-1" >.git/config &&
+	check_allow
+'
+
+test_expect_success 'object-format=foo unsupported' '
+	mkconfig 1 "objectFormat = foo" >.git/config &&
+	check_abort
+'
+
 test_done
-- 
2.14.3

