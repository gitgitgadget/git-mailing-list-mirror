Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CB42047F
	for <e@80x24.org>; Thu,  3 Aug 2017 09:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751701AbdHCJVw (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:21:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38202 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdHCJUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id g32so571598wrd.5
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XjICGp7PnxmsmAV5SQ3IUZQHjmn48zDhmcQsSFqX3rM=;
        b=HzrfKBQuA8M9FijsraXmJkQorqgrZOIGXzSNAn4cdAxCDs4jISwWln5pHJA8tzvbbo
         AdNX0Nrpbb1jVzj22WbY3rtkfAqAFurWVThcFYxurAMg858M0LpuD/IEBkgB5HPcfuJb
         l9bS+cFP/Tvo4gMUdTxKWa6c5tvKfYAgx7kWs+CfeWpVwDqYdJT1nVeHaEQ5XjqxBdGh
         bwm5frZ8u2T+A3Bs9dt/sjs8dc4EO0qM1vziorbNDQa/H/Rzy8Ltp1vpFcjYctXXuDuD
         YJdadyf1rovEXspumdZ+WnORywqUE3jFpPqqEI3zqWjk2XdVekEFwpY+YIs9l8CflMoU
         5gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XjICGp7PnxmsmAV5SQ3IUZQHjmn48zDhmcQsSFqX3rM=;
        b=qdFyzhl7Dal3zf9cKuiLUwVQqnySZ0PQaJDRMlktcHKgss4sbtMu+4oy/TsTuSo0pG
         iqf/eN4+OHMVMRkbbk7wn2B64qcbXDKaTDwvVnvTMpDjGh5AL9QU5LZUEdV1DPQP5Hk4
         qTid4xz9GXPg1xVCH6UhHNoNvRUcASa9mQ0LANcqjT+guaaiFOQoZn/k6n/2TSd/5qZy
         AnAbrNUxYPxQZONKe2k8OWELGq3ZCPgZ3TNXeVnE0ebf26rfojISy3PqCj3XK6+973FW
         zJIDa3CHDleakSpCe0PG29N5uRxee+N08tS3S1oZTYpOscELgOxbXuk1gav2cmx2YASW
         PcsQ==
X-Gm-Message-State: AIVw113rr0fhR4xTFdFhU3SkCtxa7ju8OB1iwLojJLbGTqcqUSc+kx6h
        MF/vHcqQu6RNwZTi
X-Received: by 10.223.169.68 with SMTP id u62mr752886wrc.285.1501752006617;
        Thu, 03 Aug 2017 02:20:06 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:06 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 24/40] Add t0420 to test transfer to HTTP external odb
Date:   Thu,  3 Aug 2017 11:19:10 +0200
Message-Id: <20170803091926.1755-25-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This tests that an apache web server can be used as an
external object database and store files in their native
format instead of converting them to a Git object.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t0420-transfer-http-e-odb.sh | 142 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100755 t/t0420-transfer-http-e-odb.sh

diff --git a/t/t0420-transfer-http-e-odb.sh b/t/t0420-transfer-http-e-odb.sh
new file mode 100755
index 0000000000..f84fe950ec
--- /dev/null
+++ b/t/t0420-transfer-http-e-odb.sh
@@ -0,0 +1,142 @@
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
+init)
+	echo "capability=get_raw_obj"
+	echo "capability=put_raw_obj"
+	echo "capability=have"
+	;;
+have)
+	list_url="$HTTPD_URL/list/"
+	curl "$list_url" ||
+	die "curl '$list_url' failed"
+	;;
+get_raw_obj)
+	get_url="$HTTPD_URL/list/?sha1=$2"
+	curl "$get_url" ||
+	die "curl '$get_url' failed"
+	;;
+put_raw_obj)
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
+test_expect_success 'setup repo with a root commit and the helper' '
+	test_commit zero &&
+	git config odb.magic.scriptCommand "$HELPER"
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
+	 git config odb.magic.scriptCommand "$HELPER" &&
+	 git cat-file blob "$hash1" &&
+	 git pull origin master)
+'
+
+test_expect_success 'local clone from the first repo' '
+	mkdir my-clone &&
+	(cd my-clone &&
+	 git clone .. . &&
+	 git cat-file blob "$hash1")
+'
+
+test_expect_success 'no-local clone from the first repo fails' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 test_must_fail git clone --no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+test_expect_success 'no-local clone from the first repo with helper succeeds' '
+	mkdir my-other-clone &&
+	(cd my-other-clone &&
+	 git clone -c odb.magic.scriptCommand="$HELPER" \
+		--no-local .. .) &&
+	rm -rf my-other-clone
+'
+
+stop_httpd
+
+test_done
-- 
2.14.0.rc1.52.gf02fb0ddac.dirty

