Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDDEC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC36060F47
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 09:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhGZJGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbhGZJGd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 05:06:33 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FB8C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:46:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso10459141pjq.2
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 02:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Odcx45o3b4enTI8p7oPgydXXWElZ/cv26e0EFJ3wiXc=;
        b=bzShULjk0iVzEWAB9mkGjI2IJdK4dXfInOLjsPDZ8F14nUSpZnSnePt497W+B65AfD
         +AzxAOChrQUDKtl6JHoAVj/txYzYdewYHFaVicrdpzSoRZaZ6tIyBp60Qx1s0L9tj2vZ
         ky42L5S1uNakKgYqrfWXFMVEpQO2DA8g4emrbQDCD5e9OWmkyKJPjl3n6AmtrM2an9a3
         UPAGwG6+ERwpbD9ntaVNirTBVf/hk9TextnjsKlrTdYi9Iwyd+D/LdVbLlS+mLCQpzqQ
         tt/4szHkzg69h6HrzL8FLVVLYgooK3XZRTwFkMWHMq1ctTITlw3IEgy193Ph9FGdNjDR
         1WEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Odcx45o3b4enTI8p7oPgydXXWElZ/cv26e0EFJ3wiXc=;
        b=SlxtGix70+PYE3WZ+QaHJp2iXkQ6wZd3v+tTm9beMiS4nH1xiyjghRxemBldSx1M1w
         1xiW9lskmW0f9YafuhCmqygiS4aDvF11nuvm+1jgDi4oDh/1eZ3Ecx7xKGHyhKHnL02i
         fWsesHfIZg30GFr0LgMS/f7wS0eEwAq8rJWuUWRWIg+I1W/6g1S5MxaSC3cPPfu0sXrd
         sWOF/FacFtUnMBHc44iS7HnXPZ53Nwv0/nVmz5+RHnFFWZyYPCWeaJ8JRwneoLSH+LYo
         3RKl1fMaE5ZhljDDYUqIRWCJPoanrcCsJ/7xdvjDW5aFHBsGE9g0v86DOwZZLLiOpv+d
         ZKXQ==
X-Gm-Message-State: AOAM531nRyiJKDGG8ep5ZVQMMeUCeh45kjfj1a7ulSoBLDFkTfKueX1P
        LEvDUjcyKwj7B4TfFI89lzquKUZoFhISECjNGVM=
X-Google-Smtp-Source: ABdhPJxAwb1ciu/yU1YpK/GLIOJnrxZyYbG/d75NloAgrXgFhUvrDyd+2NgThLRWO/yGNFgvP/9WZQ==
X-Received: by 2002:aa7:8b4b:0:b029:30c:1be6:b92a with SMTP id i11-20020aa78b4b0000b029030c1be6b92amr16911328pfd.56.1627292818200;
        Mon, 26 Jul 2021 02:46:58 -0700 (PDT)
Received: from localhost.localdomain ([115.227.76.17])
        by smtp.gmail.com with ESMTPSA id g13sm42522319pfo.112.2021.07.26.02.46.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Jul 2021 02:46:57 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, avarab@gmail.com,
        Teng Long <dyroneteng@gmail.com>
Subject: [PATCH v3 2/3] t5702: support for excluding commit objects
Date:   Mon, 26 Jul 2021 17:46:13 +0800
Message-Id: <92def8c72b8df57a41df3b53216e193b5d05a1d6.1627292425.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1.443.g55c63af4c9.dirty
In-Reply-To: <cover.1627292424.git.dyroneteng@gmail.com>
References: <cover.1627292424.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 t/t5702-protocol-v2.sh | 166 +++++++++++++++++++++++++++++++++--------
 1 file changed, 133 insertions(+), 33 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 2e1243ca40..bcf21e1445 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -753,7 +753,7 @@ test_expect_success 'ls-remote with v2 http sends only one POST' '
 '
 
 test_expect_success 'push with http:// and a config of v2 does not request v2' '
-	test_when_finished "rm -f log" &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 	# Till v2 for push is designed, make sure that if a client has
 	# protocol.version configured to use v2, that the client instead falls
 	# back and uses v0.
@@ -776,7 +776,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 '
 
 test_expect_success 'when server sends "ready", expect DELIM' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -796,7 +796,7 @@ test_expect_success 'when server sends "ready", expect DELIM' '
 '
 
 test_expect_success 'when server does not send "ready", expect FLUSH' '
-	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
+	test_when_finished "rm -rf \"$HTTPD_DOCUMENT_ROOT_PATH/http_parent\" http_child log" &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
 	test_commit -C "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" one &&
@@ -824,17 +824,44 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 '
 
 configure_exclusion () {
-	git -C "$1" hash-object "$2" >objh &&
-	git -C "$1" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
-	git -C "$1" config --add \
-		"uploadpack.blobpackfileuri" \
-		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
-	cat objh
+    objt="$1"
+    P="$2"
+	version="$3"
+
+    oldc="uploadpack.blobpackfileuri"
+    newc="uploadpack.excludeobject"
+	configkey=""
+	if test "$version" = "0"
+    then
+    	configkey="$oldc"
+    else
+    	configkey="$newc"
+	fi
+
+    if test "$objt" = "blob"
+    then
+        git -C "$P" hash-object "$3" >objh &&
+        git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
+        git -C "$P" config --add \
+                "$configkey" \
+                "$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+        cat objh
+    elif test "$objt" = "commit" || test "$objt" = "tag"
+    then
+        echo "$3" >objh
+		git -C "$2" pack-objects --revs "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh
+        git -C "$P" config --add \
+                "$configkey" \
+                "$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
+        cat objh
+    else
+        echo "unsupported object type in configure_exclusion (got $objt)"
+    fi
 }
 
 test_expect_success 'part of packfile response provided as URI' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -843,10 +870,10 @@ test_expect_success 'part of packfile response provided as URI' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
-	configure_exclusion "$P" other-blob >h2 &&
+	configure_exclusion blob "$P" my-blob 0 >h &&
+	configure_exclusion blob "$P" other-blob 0 >h2 &&
 
 	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \
 	git -c protocol.version=2 \
@@ -881,18 +908,40 @@ test_expect_success 'part of packfile response provided as URI' '
 	test_line_count = 6 filelist
 '
 
-test_expect_success 'packfile URIs with fetch instead of clone' '
+test_expect_success 'blobs packfile URIs with fetch instead of clone' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
+
+	configure_exclusion blob "$P" my-blob >h &&
+
+	git init http_child &&
+
+	GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch "$HTTPD_URL/smart/http_parent"
+'
+
+test_expect_success 'blobs packfile URIs(Compatible with the old) with fetch instead of clone' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	# with the old "uploadpack.blobpackfileuri" configure
+	configure_exclusion blob "$P" my-blob 0 >h &&
 
 	git init http_child &&
 
@@ -902,9 +951,60 @@ test_expect_success 'packfile URIs with fetch instead of clone' '
 		fetch "$HTTPD_URL/smart/http_parent"
 '
 
+test_expect_success 'commits packfile URIs with fetch instead of clone' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
+
+	mycommit=$(git -C "$P" rev-parse A) &&
+	echo other-blob >"$P/other-blob" &&
+    git -C "$P" add other-blob &&
+	test_commit -C "$P" B &&
+	othercommit=$(git -C "$P" rev-parse B) &&
+
+	configure_exclusion commit "$P" "$mycommit" >h2 &&
+	configure_exclusion commit "$P" "$othercommit" >h2 &&
+
+	git init http_child &&
+
+	GIT_TRACE=1 GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch "$HTTPD_URL/smart/http_parent"
+'
+
+test_expect_success 'tags packfile URIs with fetch instead of clone' '
+	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
+ 	test_when_finished "rm -rf \"$P\" http_child log" &&
+
+	git init "$P" &&
+	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
+
+	echo my-blob >"$P/my-blob" &&
+	git -C "$P" add my-blob &&
+	test_commit -C "$P" A &&
+	git -C "$P" tag -a -m "annotated_tag" tagA &&
+	tagObj=$(git -C "$P" rev-parse tagA) &&
+
+	configure_exclusion tag "$P" "$tagObj" >h2 &&
+
+	git init http_child &&
+
+	GIT_TRACE=1 GIT_TRACE_PACKET=1 GIT_TEST_SIDEBAND_ALL=1 \
+	git -C http_child -c protocol.version=2 \
+		-c fetch.uriprotocols=http,https \
+		fetch --tags "$HTTPD_URL/smart/http_parent"
+'
+
 test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -913,9 +1013,9 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" add my-blob &&
 	echo other-blob >"$P/other-blob" &&
 	git -C "$P" add other-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 	# Configure a URL for other-blob. Just reuse the hash of the object as
 	# the hash of the packfile, since the hash does not matter for this
 	# test as long as it is not the hash of the pack, and it is of the
@@ -923,7 +1023,7 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	git -C "$P" hash-object other-blob >objh &&
 	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
 	git -C "$P" config --add \
-		"uploadpack.blobpackfileuri" \
+		"uploadpack.excludeobject" \
 		"$(cat objh) $(cat objh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
 
 	test_must_fail env GIT_TEST_SIDEBAND_ALL=1 \
@@ -933,18 +1033,18 @@ test_expect_success 'fetching with valid packfile URI but invalid hash fails' '
 	test_i18ngrep "pack downloaded from.*does not match expected hash" err
 '
 
+
 test_expect_success 'packfile-uri with transfer.fsckobjects' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
-
-	configure_exclusion "$P" my-blob >h &&
+	test_commit -C "$P" A &&
+	configure_exclusion blob "$P" my-blob >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -959,7 +1059,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects' '
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child log &&
+	test_when_finished "rm -rf \"$P\" http_child log" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -976,9 +1076,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 	echo my-blob >"$P/my-blob" &&
 	git -C "$P" add my-blob &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" my-blob >h &&
+	configure_exclusion blob "$P" my-blob >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -989,7 +1089,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails on bad object'
 
 test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmodules is separate from tree' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child &&
+	test_when_finished "rm -rf \"$P\" http_child" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1000,7 +1100,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 	git -C "$P" add .gitmodules &&
 	git -C "$P" commit -m x &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	git -c protocol.version=2 -c transfer.fsckobjects=1 \
@@ -1015,7 +1115,7 @@ test_expect_success 'packfile-uri with transfer.fsckobjects succeeds when .gitmo
 
 test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodules separate from tree is invalid' '
 	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
-	rm -rf "$P" http_child err &&
+	test_when_finished "rm -rf \"$P\" http_child err" &&
 
 	git init "$P" &&
 	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
@@ -1024,9 +1124,9 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
 	echo "path = include/foo" >>"$P/.gitmodules" &&
 	echo "url = git://example.com/git/lib.git" >>"$P/.gitmodules" &&
 	git -C "$P" add .gitmodules &&
-	git -C "$P" commit -m x &&
+	test_commit -C "$P" A &&
 
-	configure_exclusion "$P" .gitmodules >h &&
+	configure_exclusion blob "$P" .gitmodules >h &&
 
 	sane_unset GIT_TEST_SIDEBAND_ALL &&
 	test_must_fail git -c protocol.version=2 -c transfer.fsckobjects=1 \
-- 
2.31.1.443.g55c63af4c9.dirty

