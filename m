Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F72C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AF616137C
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 11:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbhJSLlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbhJSLlg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 07:41:36 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5091FC061745
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:24 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t7so4636378pgl.9
        for <git@vger.kernel.org>; Tue, 19 Oct 2021 04:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=doN6CEkNOv1ViKl2YU/8DQz+fwXACOsiBPv2p14nJ0o=;
        b=lWyBWxdoHYenyWDZwI2m9vzCrPifA9l9MHE1qs7sE+8qMUCQvFJfYI1yjgLyhUKips
         lOK0TG7lfF+g2iPpJxwGW6bPHq2KCdBMQJjRTUvCTBRCEqz4YhNsAI6gjNyjbYFIwMTm
         pUTWYdqAZON6RiHHl81+MAMPIG53XDFaufTHEL/wNYlocM2a8o34QpJBds0AkPHnvLzJ
         Qh2DNaMF0SA96IeJC5Oi9Mz8r/1l/WKkzciHkVt+xO6Pn96xy+IE5X7vVxsq3ka74ec0
         jCzI4lY7A9J4788Y65MQYCAkTgx1U9tNxUzCXPTiWkJvqtwYW3ONA9nzSf7WqA9+/9R5
         q8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=doN6CEkNOv1ViKl2YU/8DQz+fwXACOsiBPv2p14nJ0o=;
        b=sb2pjAIF9y7JWXnGJffBeGviJ45It/Gw73LZWT3BPHGjWG3n3RQmchU/1EO66jO119
         qglEfXLCS1WsuXgyaEGY1GvqCCNhcXkZXG7+nZAb6B2XTYW6NCFSkfyVFCByYmoOzASo
         xvgsgD6cmrNzDH8Euqw9gsRZZSQjao8cgSVUMkvwXGY1p2519zpBEpngLsoN0aToetvE
         sHOgU8TayH3dqk1GbK1barTyS7Ol7JP9oWtMsjLZOQ3IaFW8eELHuzVZ1LwcBXqPB68W
         aUb6m/QTtihHoP38733lTaoVgxnxyO786yaUPLAwPnKa9wh8puUoZhheKDJvIBuWmfbt
         Oq8w==
X-Gm-Message-State: AOAM532EwBPZbtdstAYur40FzWPdlgFQ4GTLDROp6XMXpxErhcAxVu9V
        lBAIjtrLuhxs+R2qMd2LzsFCQD4jz1Y=
X-Google-Smtp-Source: ABdhPJwraTNgOHa9k9gyN7cBIpLnTl+9c4NnZ0ShjQtzK2XEbtFnxyNBf4U/SnyPlEkZQ96Qdi+8ZA==
X-Received: by 2002:a63:9f12:: with SMTP id g18mr18768884pge.322.1634643563536;
        Tue, 19 Oct 2021 04:39:23 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id l207sm16430861pfd.199.2021.10.19.04.39.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Oct 2021 04:39:23 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong@alibaba-inc.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, jonathantanmy@google.com,
        bagasdotme@gmail.com, adlternative@gmail.com, stolee@gmail.com,
        Teng Long <tenglong@alibaba-inc.com>
Subject: [PATCH v6 05/12] t5702: test cases for `uploadpack.excludeobject`
Date:   Tue, 19 Oct 2021 19:38:29 +0800
Message-Id: <f643db3c71f3e6425326b8877586dd8cff544769.1634634814.git.tenglong@alibaba-inc.com>
X-Mailer: git-send-email 2.31.1.453.g945ddc3a74.dirty
In-Reply-To: <cover.1634634814.git.tenglong@alibaba-inc.com>
References: <cover.1634634814.git.tenglong@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit expends the function `configure_exclusion` to support new
excluding type: commit, tree and tag.

Signed-off-by: Teng Long <tenglong@alibaba-inc.com>
---
 t/t5702-protocol-v2.sh | 146 +++++++++++++++++++++++++++--------------
 1 file changed, 98 insertions(+), 48 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40..ccd3678311 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -824,17 +824,63 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 '
 
 configure_exclusion () {
-	git -C "$1" hash-object "$2" >objh &&
-	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
-	git -C "$1" config --add \
-		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
-	cat objh
+	objt="$1"
+	P="$2"
+	oid="$3"
+	version="$4"
+	excluding_type="$5"
+
+	oldc="uploadpack.blobpackfileuri"
+	newc="uploadpack.excludeobject"
+	configkey=""
+
+	if test "$version" = "old"
+	then
+		configkey="$oldc"
+	else
+		configkey="$newc"
+	fi
+
+	if test "$objt" = "blob"
+	then
+		excluding_type="0"
+		git -C "$P" hash-object "$oid" >objh &&
+		git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+		if test "$version" = "old"
+		then
+			git -C "$P" config --add \
+            			"$configkey" \
+            			"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack"
+        else
+        	git -C "$P" config --add \
+						"$configkey" \
+						"$(cat objh) $excluding_type $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack"
+		fi &&
+		cat objh
+	elif test "$objt" = "commit" || test "$objt" = "tree" || test "$objt" = "tag"
+	then
+		echo "$oid" >objh &&
+		if test "$excluding_type" = "0"
+		then
+			git -C "$P" pack-objects  "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh
+		else
+			git -C "$P" pack-objects --revs "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh
+		fi &&
+
+		git -C "$P" config --add \
+        			"$configkey" \
+        			"$(cat objh) $excluding_type $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+		cat objh
+	else
+		echo "unsupported object type in configure_exclusion (got $objt)"
+	fi
 }
 
-test_expect_success 'part of packfile response provided as URI' '
+part_of_packfile_response_verify() {
+
+	config="$1" &&
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log *found" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -843,10 +889,10 @@ test_expect_success 'part of packfile response provided as URI' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
-	configure_exclusion "$P" other-blob >h2 &&
+	configure_exclusion blob "$P" my-blob "$config" >h &&
+	configure_exclusion blob "$P" other-blob "$config" >h2 &&
 
 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
 	git -c protocol.version=2 \
@@ -879,20 +925,22 @@ test_expect_success 'part of packfile response provided as URI' '
 	ls http_child/.git/objects/pack/*.pack \
 	    http_child/.git/objects/pack/*.idx >filelist &&
 	test_line_count = 6 filelist
-'
+}
+
+blobpackfileuri_fetch () {
+	config="$1"
 
-test_expect_success 'packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob $config >h &&
 
 	git init http_child &&
 
@@ -900,12 +948,28 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 	git -C http_child -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
 		fetch "$HTTPD_URL/smart/http_parent"
+}
+
+test_expect_success 'blob-exclusion (using uploadpack.blobpackfileuri): part of packfile response provided as URI' '
+	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+	part_of_packfile_response_verify old
+'
+
+test_expect_success 'blob-exclusion (using uploadpack.excludeobject): part of packfile response provided as URI' '
+	part_of_packfile_response_verify new
+'
+
+test_expect_success 'blob-exclusion (using uploadpack.blobpackfileuri): packfile URIs with fetch instead of clone' '
+	blobpackfileuri_fetch old
+'
+
+test_expect_success 'blob-exclusion (using uploadpack.excludeobject): packfile URIs with fetch instead of clone' '
+	blobpackfileuri_fetch new
 '
 
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
-
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
@@ -913,9 +977,8 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" my-blob >h &&
+	test_commit -C "$P" A &&
+	configure_exclusion blob "$P" my-blob >h &&
 	# Configure a URL for other-blob. Just reuse the hash of the object as
 	# the hash of the packfile, since the hash does not matter for this
 	# test as long as it is not the hash of the pack, and it is of the
@@ -923,9 +986,8 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" hash-object other-blob >objh &&
 	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
 	git -C "$P" config --add \
-		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
-
+		"uploadpack.excludeobject" \
+		"$(cat objh) 0 $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
 	test_must_fail env GIT_TEST_SIDEBAND_ALL=1 \
 		git -c protocol.version=2 \
 		-c fetch.uriprotocols=http,https \
@@ -935,17 +997,14 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
-
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" my-blob >h &&
-
+	test_commit -C "$P" A &&
+	configure_exclusion blob "$P" my-blob >h &&
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
 		-c fetch.uriprotocols=http,https \
@@ -959,8 +1018,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
-
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
@@ -976,10 +1034,8 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" my-blob >h &&
-
+	test_commit -C "$P" A &&
+	configure_exclusion blob "$P" my-blob >h &&
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
 		-c fetch.uriprotocols=http,https \
@@ -989,8 +1045,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmodules is separate from tree' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child &&
-
+	test_when_finished "rm -rf \"$P\" http_child" &&
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
@@ -999,9 +1054,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 	echo "url = git://example.com/git/lib.git" >>"$P/.gitmodules" &&
 	git -C "$P" add .gitmodules &&
 	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" .gitmodules >h &&
-
+	configure_exclusion blob "$P" .gitmodules >h &&
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
 		-c fetch.uriprotocols=http,https \
@@ -1015,8 +1068,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodules separate from tree is invalid' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child err &&
-
+	test_when_finished "rm -rf \"$P\" http_child err" &&
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
@@ -1024,10 +1076,8 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	echo "path = include/foo" >>"$P/.gitmodules" &&
 	echo "url = git://example.com/git/lib.git" >>"$P/.gitmodules" &&
 	git -C "$P" add .gitmodules &&
-	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" .gitmodules >h &&
-
+	test_commit -C "$P" A &&
+	configure_exclusion blob "$P" .gitmodules >h &&
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
 		-c fetch.uriprotocols=http,https \
@@ -1038,4 +1088,4 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 # DO NOT add non-httpd-specific tests here, because the last part of this
 # test script is only executed when httpd is available and enabled.
 
-test_done
+test_done
\ No newline at end of file
-- 
2.31.1.453.g945ddc3a74.dirty

