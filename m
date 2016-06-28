Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 058662018A
	for <e@80x24.org>; Tue, 28 Jun 2016 18:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbcF1SUV (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 14:20:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36491 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbcF1SUT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2016 14:20:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id c82so7985174wme.3
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 11:20:05 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rSzEvqAbi0DGLsAJqZGU3iPtS+2a/FvFV2zgy4NZseI=;
        b=Ytv0apo1JqExdShjn/wOgrk4gFhvmw5DFy8Wyst6VnobS1iHLCwkAlf9z3QTZ9XiAY
         6WMBI/fcTmL3eERsEDPAdckud73zRrm4KOJ7uDU9BYED2AVQoFqpLbU1THumrN6lIMXu
         AgOdoLZaWB15c3P5e/uXJ5jp425sEH0syC4/KBYXFNiynnDrqU8meKU6m3QFmlKrxKBM
         4Xc3hud8QsxVLQBlW2HpcC1kbqvpiW9wu67nZooTafUGmha6D7DlThiSm54lhavAMytT
         979E05mNV8BWKc6nLURXDxKf4nvzto5L4lYZcP5J0uqEduU4p1L8S4M4LaunMI1Dvc6J
         smCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rSzEvqAbi0DGLsAJqZGU3iPtS+2a/FvFV2zgy4NZseI=;
        b=IVVfbgZ19Zu9V3dW4RMUtA8XNhxF+ny+/Wvg+gG7fs8QBhDDXyIBcygVF4jc65lKCd
         ggF7g00awD5ZgbsGP7HGCJTg9FNcw9ktyE3LwNZfpamcGHORpuGXnlye8mK4eNxxfsB3
         Texvo7YeDq4mdh6TMdpYlqnDb9n4fMHzEBAJmSSwDUMRdNNPRB9EjYrFarrocnpBzAi/
         Ox5Gn6OS3GWkLable7upV4eCEnswG8j+JPj2iDlX5VHUFps+AMXg5kP65ZS6uZs3vWF0
         Z5Bx5Ecxd0sOUjxHevMeCR7O06kmVT+2uB5JtdeADxI5EGfTH7VbfRnTERssTDnDqta2
         XW4A==
X-Gm-Message-State: ALyK8tL6b6GhyWsJVMl7I4C288FQhQFB1C0H9qFvDqIlMRCemulxRaLJCjbt3mUDFUCIUQ==
X-Received: by 10.28.158.132 with SMTP id h126mr16775048wme.43.1467137999676;
        Tue, 28 Jun 2016 11:19:59 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id yr4sm2061048wjc.18.2016.06.28.11.19.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Jun 2016 11:19:59 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Mike Hommey <mh@glandium.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v2 10/10] Add t0410 to test external ODB transfer
Date:	Tue, 28 Jun 2016 20:19:33 +0200
Message-Id: <20160628181933.24620-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.11.g990c140
In-Reply-To: <20160628181933.24620-1-chriscool@tuxfamily.org>
References: <20160628181933.24620-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0410-transfer-e-odb.sh | 136 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)
 create mode 100755 t/t0410-transfer-e-odb.sh

diff --git a/t/t0410-transfer-e-odb.sh b/t/t0410-transfer-e-odb.sh
new file mode 100755
index 0000000..868b55d
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
2.9.0.rc2.11.g990c140

