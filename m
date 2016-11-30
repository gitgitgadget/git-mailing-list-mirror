Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E289C1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753929AbcK3V5i (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:57:38 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35333 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753242AbcK3V5h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:57:37 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so31481637wme.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ojzA+6DFTheTPpBxW4U20eQyqAMiE9jWyN64sj0rwE=;
        b=YGyrlGj9L+QdV+7JUo1iHxDRpF2vYlpGqffJY7pplgtmeMm3ov9QFB14HajWddf9xC
         Y5vhDv+sYGZVZ0MFzpQVinpEFRr9hhDRXeEHkcC1miF3ulcooDf056+ueRI8a0GyKOXq
         2YBGz/KIKWjqjShPiHaWWIEe2twfuQZG1EleVnYeUwvTVvotM0+3Rz+gfaGTFpDxZgVl
         7jVcnSGWDf3Vtn6K/CuAqfsHKY//H67OibvUGJHysjSZVNVuUzTWW5LuQm4sVQIXmHMn
         KrV9koBQTWZtSl4FmkP5XqlSqVrGDgnMME7eNFlCOKk2Hy6Oi9ZaY6xxah0HtM2s02CA
         pvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ojzA+6DFTheTPpBxW4U20eQyqAMiE9jWyN64sj0rwE=;
        b=VJJkWnMew/ZjWnsTOHd463n0pNoys4S1XhniBJeothEEVF7K99KLScTtrydTgF8DWL
         QDvSDNOopzIh6raCm3oUTuTUhWOa0uVDxHxzvEN0B1lfob3rBEm52zFzcod54Hg0uccl
         zE5VoJtHKw/Ba015oeWGVicWv0KBhSj/071iwx6+Gt83CIwATtSmm7B8pRwDb0AMpMzf
         twxfAao68zGmNuel2hoEBVp1hg25FZ5DgU7Gr6whBdMc8jvg3G85BwO2i6suLR41tsgy
         wgmvlp2slYCRAd9r+Nw3wXRzFPZb3KkImlVMXHTc8bpBjgKPkBRdcsU2WqzapQHVVRcg
         cKOg==
X-Gm-Message-State: AKaTC00exmgGukceHbsZHMCN9iZ7jwuPALE8y4Lz/xRjo9QMilMA5JPeFzGnJ6TRbCgK4A==
X-Received: by 10.28.132.193 with SMTP id g184mr28647512wmd.130.1480539904857;
        Wed, 30 Nov 2016 13:05:04 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:03 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 10/16] Add t0410 to test external ODB transfer
Date:   Wed, 30 Nov 2016 22:04:14 +0100
Message-Id: <20161130210420.15982-11-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
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
2.11.0.rc2.37.geb49ca6

