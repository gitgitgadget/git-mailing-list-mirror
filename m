Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79F2D1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 21:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755069AbcK3VSp (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 16:18:45 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35646 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbcK3VSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 16:18:43 -0500
Received: by mail-wj0-f194.google.com with SMTP id he10so9772672wjc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 13:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ODFaJ8T0ifddBvhojt3/YYY7+2U7PRdmJEuk10R2ysQ=;
        b=iSk2BwhPWOBGa97C7siTArlR4JKLvU4bOPntGHunEU6Xcw1PqOfPeR5SuC6id6OHYf
         Taic0SeOrACLKCMhf8++B/eO01VEPwO6TiNczyA4YsKV3YAzawGSINGhjJUGFElahqI6
         U4QRNsKg1litmW2RObKW3ApZ0ZJbp1yGo/2rXl3xwRLvA0bZPB1cQlCI5lewi+V00LKB
         yuEtHENlp6Nl2MDY0wnCc2/oU+1GaXBQKDUIZwQBtQ8Fut66x+wqn8Z+gO4Tar1J8ITd
         blXFFVLvy4CU4R5xCkeOdjiBE8ry9+xRPR6TdkM+/0K4xC9q+sTFn+1zNZ+dqdOxP6tT
         GkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ODFaJ8T0ifddBvhojt3/YYY7+2U7PRdmJEuk10R2ysQ=;
        b=eYDmi1b0iJurTBBidWdvN2BmVm6wlGGFWRFNNZhEkZKC11xD6trJ+e06CP//aV8Iib
         rqZW2BAKi0ChlhnfmHPciRKy4AZ9n6g1c8Q96axJoLSlreaad1o1vowSE6pvxrjm4K3x
         bv3cUAH9hKkXpZPiD5yOLU+AYL0o3HUyssF/QRz0LbN3iKu2kcEpoUktnHIg1DouyFC8
         CPDggSlV4zSjDaH0eZ2+LZv/LDEeo11QOy2gw5SWD72DK1RxcHtDkfuDNjjzNsEIpRVR
         qQ4iJ0G3NNGX8jdwAOXaLwCDg984NthDRJoiGasF5lmaaKvI+VSAAV3wVvRdC5DE8YWq
         5MTg==
X-Gm-Message-State: AKaTC01pUSGmBM11lR5Mb5kCQGaby0230CbB2ctKOK9n+NE/naGgXynlHJVc2rdDRiP38w==
X-Received: by 10.194.126.38 with SMTP id mv6mr29729999wjb.142.1480539918555;
        Wed, 30 Nov 2016 13:05:18 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:17 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 16/16] t0420: add test with HTTP external odb
Date:   Wed, 30 Nov 2016 22:04:20 +0100
Message-Id: <20161130210420.15982-17-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tests that an apache web server can be used as an
external object database and store files in their native
format instead of converting them to a Git object.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0420-transfer-http-e-odb.sh | 118 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100755 t/t0420-transfer-http-e-odb.sh

diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
new file mode 100755
index 0000000000..9fb84877b5
--- /dev/null
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -0,0 +1,118 @@
+#!/bin/sh
+
+test_description='tests for transfering external objects to an HTTPD server'
+
+. ./test-lib.sh
+
+# If we don't specify a port, the current test number will be used
+# which will not work as it is less than 1024, so it can only be used by root.
+LIB_HTTPD_PORT=$(expr ${this_test#t} + 12000)
+
+. "$TEST_DIRECTORY"/lib-httpd.sh
+
+start_httpd apache-e-odb.conf
+
+# odb helper script must see this
+export HTTPD_URL
+
+write_script odb-http-helper <<\EOF
+die() {
+	printf >&2 "%s\n" "$@"
+	exit 1
+}
+echo >&2 "odb-http-helper args:" "$@"
+case "$1" in
+have)
+	list_url="$HTTPD_URL/list/"
+	curl "$list_url" ||
+	die "curl '$list_url' failed"
+	;;
+get)
+	get_url="$HTTPD_URL/list/?sha1=$2"
+	curl "$get_url" ||
+	die "curl '$get_url' failed"
+	;;
+put)
+	sha1="$2"
+	size="$3"
+	kind="$4"
+	upload_url="$HTTPD_URL/upload/?sha1=$sha1&size=$size&type=$kind"
+	curl --data-binary @- --include "$upload_url" >out ||
+	die "curl '$upload_url' failed"
+	ref_hash=$(echo "$sha1 $size $kind" | GIT_NO_EXTERNAL_ODB=1 git hash-object -w -t blob --stdin) || exit
+	git update-ref refs/odbs/magic/"$sha1" "$ref_hash"
+	;;
+*)
+	die "unknown command '$1'"
+	;;
+esac
+EOF
+HELPER="\"$PWD\"/odb-http-helper"
+
+
+test_expect_success 'setup repo with a root commit and the helper' '
+	test_commit zero &&
+	git config odb.magic.command "$HELPER" &&
+	git config odb.magic.plainObjects "true"
+'
+
+test_expect_success 'setup another repo from the first one' '
+	git init other-repo &&
+	(cd other-repo &&
+	 git remote add origin .. &&
+	 git pull origin master &&
+	 git checkout master &&
+	 git log)
+'
+
+UPLOADFILENAME="hello_apache_upload.txt"
+
+UPLOAD_URL="$HTTPD_URL/upload/?sha1=$UPLOADFILENAME&size=123&type=blob"
+
+test_expect_success 'can upload a file' '
+	echo "Hello Apache World!" >hello_to_send.txt &&
+	echo "How are you?" >>hello_to_send.txt &&
+	curl --data-binary @hello_to_send.txt --include "$UPLOAD_URL" >out_upload
+'
+
+LIST_URL="$HTTPD_URL/list/"
+
+test_expect_success 'can list uploaded files' '
+	curl --include "$LIST_URL" >out_list &&
+	grep "$UPLOADFILENAME" out_list
+'
+
+test_expect_success 'can delete uploaded files' '
+	curl --data "delete" --include "$UPLOAD_URL&delete=1" >out_delete &&
+	curl --include "$LIST_URL" >out_list2 &&
+	! grep "$UPLOADFILENAME" out_list2
+'
+
+FILES_DIR="httpd/www/files"
+
+test_expect_success 'new blobs are transfered to the http server' '
+	test_commit one &&
+	hash1=$(git ls-tree HEAD | grep one.t | cut -f1 | cut -d\  -f3) &&
+	echo "$hash1-4-blob" >expected &&
+	ls "$FILES_DIR" >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'blobs can be retrieved from the http server' '
+	git cat-file blob "$hash1" &&
+	git log -p >expected
+'
+
+test_expect_success 'update other repo from the first one' '
+	(cd other-repo &&
+	 git fetch origin "refs/odbs/magic/*:refs/odbs/magic/*" &&
+	 test_must_fail git cat-file blob "$hash1" &&
+	 git config odb.magic.command "$HELPER" &&
+	 git config odb.magic.plainObjects "true" &&
+	 git cat-file blob "$hash1" &&
+	 git pull origin master)
+'
+
+stop_httpd
+
+test_done
-- 
2.11.0.rc2.37.geb49ca6

