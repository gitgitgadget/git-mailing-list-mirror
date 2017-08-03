Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09CB1208D7
	for <e@80x24.org>; Thu,  3 Aug 2017 09:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752057AbdHCJUO (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 05:20:14 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:35545 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbdHCJUC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 05:20:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id c24so577921wra.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 02:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oe9arJcYnJrGTqI1I4Rf88QX3+qPVgAUekUPL2Lovv4=;
        b=I6NL0fTvZruXFrG8ISCOmYDBmzHhUaq7wJoJKHV8aUxg1C+FjV3SvI7TwbcYRzvOtP
         BG7USm5QUPhFUXRHmKiqZ0juYm8M8vxx+KS9ybFwebifet69GcqRrdf3Ni2bYPnkTF3N
         5WdLDpjT9Zb8sbMyLppF3XV5l/tTOgokicWV6fLcbinrxr/xEqajOHBsLd2d1YwhCkJh
         66Ltod+lTrDCL+RkNP0gLKxm8dGtefrxm3eLGe1AwmGjgXWZ0OfuV+Zhwp6lPzhWeg2q
         Vbx3zKxBtnSSa8Yq87E6YwGXnXdLYJY6rvU3s0/35qT6Tcf5YWjk8eiQczhzCGybVk3w
         HEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oe9arJcYnJrGTqI1I4Rf88QX3+qPVgAUekUPL2Lovv4=;
        b=LuHaqPB9vdviP2hXk++L8Xu3osQeq1DYOB69SsC20qjU045Fi6KEalw27a5DaInWm9
         acUXq/BBMH7ZZ4o8kniDDIOav+vJfTaBzwNxpFyWPLZnWOEM42mUEcaBM3n5R8vHcp8Y
         BebJL+TGE/+zAMxAFHURXkdlSOtNm2+CK03vhzOx8i0AKD0fTKAq9NDhbmklXM0Wimdc
         n5XF9EYr0mLZ7FMKL34VVGC/KxyBFQ5lJYolFphlVY9/MmiYJYJHo44Tj7hj2z3osFQq
         RBSRV7edTnTt6D3ufB87fHKMUyDqHHdmeZPgptqR9sYZIiJEn1wMXTIJUI+6lruE9weq
         Kwqg==
X-Gm-Message-State: AIVw113EXQ9/aeohCclEqjWerFg7V5PoBAYE0rcc5nQuO2FoRrnKIVMA
        zJFPGAeyqG6d8tvg
X-Received: by 10.223.144.38 with SMTP id h35mr900473wrh.114.1501752000708;
        Thu, 03 Aug 2017 02:20:00 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id n184sm1308051wme.33.2017.08.03.02.19.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 02:20:00 -0700 (PDT)
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
Subject: [PATCH v5 19/40] lib-httpd: add upload.sh
Date:   Thu,  3 Aug 2017 11:19:05 +0200
Message-Id: <20170803091926.1755-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.0.rc1.52.gf02fb0ddac.dirty
In-Reply-To: <20170803091926.1755-1-chriscool@tuxfamily.org>
References: <20170803091926.1755-1-chriscool@tuxfamily.org>
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
2.14.0.rc1.52.gf02fb0ddac.dirty

