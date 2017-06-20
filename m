Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCDA720D12
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdFTH4P (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:15 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35839 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751969AbdFTH4M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id d64so21284761wmf.2
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gd4Nns9NhhuyVM3aa67j6iGIVYfTDL3o1glR03g+z2M=;
        b=IZbPOkCPv0vNoK/JEvFMYHTfIezm1S5Oo2VPSX3kMoGhXLOMaLZZeL2qPuSt2Un53o
         wh3d/V+GdKw8VI4+ce4kCZl+G56luI4w5epWHP6It57VbjYz7RBA4H6THiq2pW/9n72q
         +jgp4Hf/ib28ezYmRmfClZcez3/s6MCG4BcDHevQ1ZSBOTOKvmCLcPXizBqE8spyQbvr
         KlXqeEh+RF1fGPk8lsPPmxZY+1Obiwnxgg9cLOR9UTxQP+LGuZeGhgQyOxGP4b2W/144
         12UcG8TtrjZZofxIkZQiXLOBNtlDC7qkfwlZdrvKkH73Jz/ubqEdxtAngbOv6ktMxU8B
         5dnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gd4Nns9NhhuyVM3aa67j6iGIVYfTDL3o1glR03g+z2M=;
        b=WvAezjQpCW1LLPWNi1weU1w6aJsD31823eeI7iteJedDdM1+54kHPflIYS1596M6qY
         zwqZ8OZW9ptbraJZJsxZ+6Qu8VPD57U/WZMHa66XvAGbO39cdDpiPlkDmpyQ87UbTX1L
         HiCInCcfgCyTVfOJaeFPlYSLjCglpTi1WBVUsZ0H2c8umlg+tBi1k0GlD4avX9O5yH84
         gvsiYVOB+B6m7kBPts0pxPORyb2wJ/FHfOw5l8yc0SK0NiJpNE5fTaPzA59sDGIxR0/s
         NhEScLvzrs2cAbvZcHzsbF9vxbfR1peesZU8laQfMBfoQRqkAZuh/Fzx778fu2jXmK6+
         uiuA==
X-Gm-Message-State: AKS2vOwCMcbZLdepqv3rIKA7bUN865hWkqVzs411DKf2ffH1Eukbs/c+
        lVtwAH6YXWlh7sJu
X-Received: by 10.28.129.149 with SMTP id c143mr1595532wmd.47.1497945370392;
        Tue, 20 Jun 2017 00:56:10 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:09 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 16/49] Add t0410 to test external ODB transfer
Date:   Tue, 20 Jun 2017 09:54:50 +0200
Message-Id: <20170620075523.26961-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-transfer-e-odb.sh | 136 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100755 t/t0410-transfer-e-odb.sh

diff --git a/t/t0410-transfer-e-odb.sh b/t/t0410-transfer-e-odb.sh
new file mode 100755
index 0000000000..868b55db94
--- /dev/null
+++ b/t/t0410-transfer-e-odb.sh
@@ -0,0 +1,136 @@
+#!/bin/sh
+
+test_description='basic tests for transfering external ODBs'
+
+. ./test-lib.sh
+
+ORIG_SOURCE="$PWD/.git"
+export ORIG_SOURCE
+
+ALT_SOURCE1="$PWD/alt-repo1/.git"
+export ALT_SOURCE1
+write_script odb-helper1 <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+GIT_DIR=$ALT_SOURCE1; export GIT_DIR
+case "$1" in
+have)
+	git cat-file --batch-check --batch-all-objects |
+	awk '{print $1 " " $3 " " $2}'
+	;;
+get)
+	cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
+	;;
+put)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	writen=$(git hash-object -w -t "$kind" --stdin)
+	test "$writen" = "$sha1" || die "bad sha1 passed '$sha1' vs writen '$writen'"
+	ref_hash=$(echo "$sha1 $size $kind" | GIT_DIR=$ORIG_SOURCE GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) || exit
+	GIT_DIR=$ORIG_SOURCE git update-ref refs/odbs/magic/"$sha1" "$ref_hash"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER1="\"$PWD\"/odb-helper1"
+
+OTHER_SOURCE="$PWD/.git"
+export OTHER_SOURCE
+
+ALT_SOURCE2="$PWD/alt-repo2/.git"
+export ALT_SOURCE2
+write_script odb-helper2 <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+GIT_DIR=$ALT_SOURCE2; export GIT_DIR
+case "$1" in
+have)
+	GIT_DIR=$OTHER_SOURCE git for-each-ref --format='%(objectname)' refs/odbs/magic/ | GIT_DIR=$OTHER_SOURCE xargs git show
+	;;
+get)
+	OBJ_FILE="$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
+	if ! test -f "$OBJ_FILE"
+	then
+		# "Download" the missing object by copying it from alt-repo1
+		OBJ_DIR=$(echo $2 | sed 's/\(..\).*/\1/')
+		OBJ_BASE=$(basename "$OBJ_FILE")
+		ALT_OBJ_DIR1="$ALT_SOURCE1/objects/$OBJ_DIR"
+		ALT_OBJ_DIR2="$ALT_SOURCE2/objects/$OBJ_DIR"
+		mkdir -p "$ALT_OBJ_DIR2" || die "Could not mkdir '$ALT_OBJ_DIR2'"
+		OBJ_SRC="$ALT_OBJ_DIR1/$OBJ_BASE"
+		cp "$OBJ_SRC" "$ALT_OBJ_DIR2" ||
+		die "Could not cp '$OBJ_SRC' into '$ALT_OBJ_DIR2'"
+	fi
+	cat "$OBJ_FILE" || die "Could not cat '$OBJ_FILE'"
+	;;
+put)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	writen=$(git hash-object -w -t "$kind" --stdin)
+	test "$writen" = "$sha1" || die "bad sha1 passed '$sha1' vs writen '$writen'"
+	ref_hash=$(echo "$sha1 $size $kind" | GIT_DIR=$OTHER_SOURCE GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) || exit
+	GIT_DIR=$OTHER_SOURCE git update-ref refs/odbs/magic/"$sha1" "$ref_hash"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER2="\"$PWD\"/odb-helper2"
+
+test_expect_success 'setup first alternate repo' '
+	git init alt-repo1 &&
+	test_commit zero &&
+	git config odb.magic.command "$HELPER1"
+'
+
+test_expect_success 'setup other repo and its alternate repo' '
+	git init other-repo &&
+	git init alt-repo2 &&
+	(cd other-repo &&
+	 git remote add origin .. &&
+	 git pull origin master &&
+	 git checkout master &&
+	 git log)
+'
+
+test_expect_success 'new blobs are put in first object store' '
+	test_commit one &&
+	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo1 && git show "$hash1") &&
+	test "$content" = "one" &&
+	test_commit two &&
+	hash2=$(git ls-tree HEAD | grep two.t | cut -f1 | cut -d\  -f3) &&
+	content=$(cd alt-repo1 && git show "$hash2") &&
+	test "$content" = "two"
+'
+
+test_expect_success 'other repo gets the blobs from object store' '
+	(cd other-repo &&
+	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
+	 test_must_fail git cat-file blob "$hash1" &&
+	 test_must_fail git cat-file blob "$hash2" &&
+	 git config odb.magic.command "$HELPER2" &&
+	 git cat-file blob "$hash1" &&
+	 git cat-file blob "$hash2"
+	)
+'
+
+test_expect_success 'other repo gets everything else' '
+	(cd other-repo &&
+	 git fetch origin &&
+	 content=$(git show "$hash1") &&
+	 test "$content" = "one" &&
+	 content=$(git show "$hash2") &&
+	 test "$content" = "two")
+'
+
+test_done
-- 
2.13.1.565.gbfcd7a9048

