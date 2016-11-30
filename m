Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E12641FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756500AbcK3WQE (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:16:04 -0500
Received: from mail-wj0-f196.google.com ([209.85.210.196]:34529 "EHLO
        mail-wj0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbcK3WQD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:16:03 -0500
Received: by mail-wj0-f196.google.com with SMTP id xy5so24168812wjc.1
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 14:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=msRT1bFAYB2LNcHwswHiGeStaOZuY9hG+AsLwaocGN0=;
        b=ekWWAFQuj/VGjonGUr9mkyP61p5vOaOxfPDC04qWG51EYIhIiHe4bVTVF0cJ/Z/LBr
         pGUfGyPrDftaPqtv6wQuTTHjncVTzrBYlDsJVaD5EMw04ttMEARUO4ScMDhhFHkYyMXC
         gkTe/RqVnBYGUlIXYy3NtrlG57mwlBWFynsQZ5S05HtoOzJ6lZLmPL9OJAWfKuBdAUat
         8OtmW8haTSIvW3JXxcz39q9SpbonskBNek1s8Q731M5Vnid55cpzXc8cIKDFIZlen+qL
         RxIWbBnylehSDzshR4kfo+sRFiDHnd2sioET49srCyIBXDAPvY+kcMEYq1r8r/XWe4T4
         kTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=msRT1bFAYB2LNcHwswHiGeStaOZuY9hG+AsLwaocGN0=;
        b=PTvRm7QUBbfUJutYsRs5uftPk1lJNLLZDXVKKRE1qw6O0MjNQxXoUp+MV1lzlHpj09
         vv+UOewNGDtiAeWZdqtrAw/15aqltfzmRxUYwF2Gppz1D4rqppvKt/EpzFZebooOsDrN
         0fcTQ97fP5fDPNLHwYUYdkMcGeKx6MwHx6K5RBwMAbAskvlXtcp6NhZ1tHD4T/PYqnNa
         LpM0PeF+Np6Fqa/upxbw4bH+KkBd+yrCXcVdL7WkEpIqwKu6dmU3o9qZw2N2ee6aXmCt
         UaVe3HxyVioPSaOLV3caDqxs9xdMakmN6W19CIYbs/KCusu+iek0CjVGhTfbhLOmN8aL
         NNxA==
X-Gm-Message-State: AKaTC01+lRYf0KLpa0KMnPh7fSNbzdCY1qxq4uE3yOF/ekFgsj/SkADG+QdeBmILpFDY1A==
X-Received: by 10.194.191.201 with SMTP id ha9mr30138391wjc.205.1480539908927;
        Wed, 30 Nov 2016 13:05:08 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:08 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 12/16] lib-httpd: add upload.sh
Date:   Wed, 30 Nov 2016 22:04:16 +0100
Message-Id: <20161130210420.15982-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cgi will be used to upload objects to, or to delete
objects from, an apache web server.

This way the apache server can work as an external object
database.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd.sh        |  1 +
 t/lib-httpd/upload.sh | 45 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 t/lib-httpd/upload.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index 2e659a8ee2..d80b004549 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -132,6 +132,7 @@ prepare_httpd() {
 	cp "$TEST_PATH"/passwd "$HTTPD_ROOT_PATH"
 	install_script broken-smart-http.sh
 	install_script error.sh
+	install_script upload.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/upload.sh b/t/lib-httpd/upload.sh
new file mode 100644
index 0000000000..172be0f73f
--- /dev/null
+++ b/t/lib-httpd/upload.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+# In part from http://codereview.stackexchange.com/questions/79549/bash-cgi-upload-file
+
+FILES_DIR="www/files"
+
+OLDIFS="$IFS"
+IFS='&'
+set -- $QUERY_STRING
+IFS="$OLDIFS"
+
+while test $# -gt 0
+do
+    key=${1%=*}
+    val=${1#*=}
+
+    case "$key" in
+	"sha1") sha1="$val" ;;
+	"type") type="$val" ;;
+	"size") size="$val" ;;
+	"delete") delete=1 ;;
+	*) echo >&2 "unknown key '$key'" ;;
+    esac
+
+    shift
+done
+
+case "$REQUEST_METHOD" in
+  POST)
+    if test "$delete" = "1"
+    then
+	rm -f "$FILES_DIR/$sha1-$size-$type"
+    else
+	mkdir -p "$FILES_DIR"
+	cat >"$FILES_DIR/$sha1-$size-$type"
+    fi
+
+    echo 'Status: 204 No Content'
+    echo
+    ;;
+
+  *)
+    echo 'Status: 405 Method Not Allowed'
+    echo
+esac
-- 
2.11.0.rc2.37.geb49ca6

