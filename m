Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D501F404
	for <e@80x24.org>; Wed, 24 Jan 2018 13:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933594AbeAXNJL (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 08:09:11 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41906 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933305AbeAXNJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 08:09:09 -0500
Received: by mail-lf0-f66.google.com with SMTP id f136so5145028lff.8
        for <git@vger.kernel.org>; Wed, 24 Jan 2018 05:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=gaRGy20NAt90FdYUDbpfJYGqSyHBLPOVd8knVAYfMK4=;
        b=FH9X0Xk0qWT5u0ADdq0Am8vKW/uU6FMfcEjGZjhq0UsPZ7KjD7KFhHCmNNWHX0un8y
         5LXfUyHfwPAhpYoDrtbgn6n9JZPtlHZy9SgTV/6EVlsExXhGgl8Ck+seJxbtrpu0M1vt
         PfkQ9qZInMeONc41gt/9SHgN3BGZcoRn34mgPVLVglUTkIyKaHAD/NJCIz7Zr20TXyHE
         42vScAScGOLy+BTPbTInQmmRdgVITFvFPGo1q8KQgXVtdeH0PLgqTRqvxYd9c/FzCjV+
         /XifTfJpVSemQagrPMQVY0WUieigi5bWtpbn6forN9acmXuhg/VsaFJ4qbobFrNKCEeJ
         z+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gaRGy20NAt90FdYUDbpfJYGqSyHBLPOVd8knVAYfMK4=;
        b=iA/SdWycKoLCBLinrg4f/q1nNYx72RLZ9JcRGMYP7xp/S0YgdkNb6BjFA1dyKfsa+K
         P4/UrfyQYwtF69sZbm3yonJDSsf2YidvZFAzlzYMIibbFyD17C5bcZisg1LoI5B09tYA
         oCBDjXq80h9zG4zZCEQ9mb/832HepRgmeSG5WIVRdAMhCDGZCIX/0AMhHafcDW75ilZs
         Xo3kByuZXUf2hBGRmGZNHR3c8xh6NMTbAW/PVJ0SB702uXoD2kCw75JsxiR7WOvRBoJ7
         ugmZktVg7fmdF99HRKj6j3I7gu1k3yGkHpHxQ1pwH5ih5+fcd0T08jvExXreLKi4KAod
         yNig==
X-Gm-Message-State: AKwxytdZB984uSxY/QSf4LHJRq+F5gqbK+Csnxi47PDjuMzCAKdpb2W3
        eORgkNkEfbuEf677ureRyWuA6emY
X-Google-Smtp-Source: AH8x227kz8tNO56pRKmMgcsbG+DSM7XYZQDXPvnYjCos1i3STex7MgXE1UBeLZF6K/pEL98O0pWxoA==
X-Received: by 10.25.80.92 with SMTP id z28mr3245609lfj.34.1516799347607;
        Wed, 24 Jan 2018 05:09:07 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id z16sm59223ljc.73.2018.01.24.05.09.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jan 2018 05:09:06 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] setup: recognise extensions.objectFormat
Date:   Wed, 24 Jan 2018 14:09:05 +0100
Message-Id: <66fb698096ed14ee58b2611f41f2e3e5dfa49059.1516798941.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
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
---
 Documentation/technical/repository-version.txt |  8 ++++++++
 setup.c                                        | 27 ++++++++++++++++++++++++++
 t/t1302-repo-version.sh                        | 15 ++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/Documentation/technical/repository-version.txt b/Documentation/technical/repository-version.txt
index 00ad37986e..14a75a7fee 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -86,3 +86,11 @@ for testing format-1 compatibility.
 When the config key `extensions.preciousObjects` is set to `true`,
 objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
 `git repack -d`).
+
+`objectFormat`
+~~~~~~~~~~~~~~
+
+This extension instructs Git to use a specific algorithm for addressing
+and interpreting objects in the object store. Currently, the only
+supported object format is `sha-1`.  See `hash-function-transition.txt`
+document for more detailed explanation.
diff --git a/setup.c b/setup.c
index 8cc34186ce..b48a90d9ce 100644
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
+		die("invalid repository format version");
+
+	data->hash_algo = find_object_format(value);
+	if (data->hash_algo == GIT_HASH_UNKNOWN) {
+		char object_format[25];
+		xsnprintf(object_format, sizeof(object_format),
+			  "objectformat = %s", value);
+		string_list_append(&data->unknown_extensions, object_format);
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

base-commit: 5be1f00a9a701532232f57958efab4be8c959a29
-- 
2.14.3

