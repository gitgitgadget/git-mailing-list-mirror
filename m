Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4157620A21
	for <e@80x24.org>; Sat, 16 Sep 2017 08:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbdIPIJb (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Sep 2017 04:09:31 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:46924 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751347AbdIPIIK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Sep 2017 04:08:10 -0400
Received: by mail-wr0-f171.google.com with SMTP id o42so3171694wrb.3
        for <git@vger.kernel.org>; Sat, 16 Sep 2017 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wmjF+o7WXSXn+qn4DySUwz68nD/wjjRnoOMqml1R4Ws=;
        b=E8duzFHofvQ5Df/l74VWOXBgD9MqFoMx6grGNVa1dC5hS5Q+eVq0JmZx1pH2MbaPBn
         5xR0CDAIwTEJ4wjrBd13p25JRYLX9BKKjDHVClXER+9yFWDGObHt+uCh+P30V/yU3VQk
         X8CajAkyzRT78AhN3l6+gbVgfdHgUaEa4smZ5/KSaBdT79Bx2qg+l8/IZfN34ATtxzl7
         7lvthpbxwoTWunh+odnxEfeyLK7tmJFhKB/vLtYx30gcQnqeos8VMhEjjDyKCRcF9RGf
         /DXTjkZLnX3lehLkB3KCRl3bKufHg3mtETkw9nmPDr8C1mWsdAc8RTawPsngNd+z5bLw
         fL3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wmjF+o7WXSXn+qn4DySUwz68nD/wjjRnoOMqml1R4Ws=;
        b=ZWfDXc8QnJNefu6Mps11YG11RDKpZJsfN6Fw1SWixaNiUHMKHDxMzoHWKSmFTDtTHs
         7flSkf3eH6nZhpR6Qt1erl9E4ochneHV+ChFGbrd7nE8X31/Crxi3FT6K/jKJo2bBu6T
         qyJWIQpOX9qTnS+cpCotBkPong9l3LK8kw/5GbBQ8rO/PPKpLpwweGKd0KiTageeGu+G
         Jthak0kAAIMOr3cgWE8A7VdXQ0AjB3UvERfSdek5FZEV8yYmaIfmtwnGiPb9w9rBKcau
         raDdE39alRaTW50/qabqgWgJYoz7shsseLyzwFmcApAufX5aZPZan2eKFVlQGfoNoRnB
         4D4Q==
X-Gm-Message-State: AHPjjUjCmQlkSJ9ruXMmgddEJJAdQJ8UDUx3LksaaVXVUkW/maqRZsPL
        de7lFXf0XKEtkgxz
X-Google-Smtp-Source: AOwi7QDNdPTHnLaoj7JsDauJLu8TcYs4gsfjG+gWu9MOq1SF0oWnDjJVcCG3ETKff59KyrzoFUAfpg==
X-Received: by 10.223.156.17 with SMTP id f17mr25201217wrc.203.1505549288505;
        Sat, 16 Sep 2017 01:08:08 -0700 (PDT)
Received: from localhost.localdomain (sud35-h04-89-95-107-230.dsl.sta.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id l126sm2814641wmd.1.2017.09.16.01.08.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 16 Sep 2017 01:08:07 -0700 (PDT)
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
Subject: [PATCH v6 18/40] lib-httpd: add upload.sh
Date:   Sat, 16 Sep 2017 10:07:09 +0200
Message-Id: <20170916080731.13925-19-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.14.1.576.g3f707d88cd
In-Reply-To: <20170916080731.13925-1-chriscool@tuxfamily.org>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
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
index 0000000000..64d3f31c31
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
+	key=${1%%=*}
+	val=${1#*=}
+
+	case "$key" in
+	"sha1") sha1="$val" ;;
+	"type") type="$val" ;;
+	"size") size="$val" ;;
+	"delete") delete=1 ;;
+	*) echo >&2 "unknown key '$key'" ;;
+	esac
+
+	shift
+done
+
+case "$REQUEST_METHOD" in
+POST)
+	if test "$delete" = "1"
+	then
+		rm -f "$FILES_DIR/$sha1-$size-$type"
+	else
+		mkdir -p "$FILES_DIR"
+		cat >"$FILES_DIR/$sha1-$size-$type"
+	fi
+
+	echo 'Status: 204 No Content'
+	echo
+	;;
+
+*)
+	echo 'Status: 405 Method Not Allowed'
+	echo
+esac
-- 
2.14.1.576.g3f707d88cd

