Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA4DD1FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 22:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752625AbcK3WBY (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 17:01:24 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:35617 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751937AbcK3WBX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 17:01:23 -0500
Received: by mail-wj0-f194.google.com with SMTP id he10so9887204wjc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 14:01:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TBtiqeo+CzWw5WAinwOONZ24dgm7CijfK//RXjS1RJ4=;
        b=lM9glL8EqWRIuuHgoVJUrn4fbniKX2b1g0/iKAaZTdLAJHxBUtpzScf1QStj8UM7jb
         Ip/u09ltNeAt2BYMO3LOw5p7JGvfTBgiQ1ZOzuqpapvOCkX+PGTQHKKDUmpYDx57XVUi
         WES45QlajJFo6EY4bPtLSvHNsKPYro+EX61ApYiosqnHtzS9nIo4r29KH0hO5+db1Zco
         A1OLyqyOogDUwzNxeWjAmkDdaxohCXf52EI6IvBJRunfrpqSL4o/vVE+zJDip7YfQJ44
         nfYM9j1TUTgzKbG//KaNnjGCBPmUpuNLlMgO9SjGqScad+5VHQguUbRwZyredtoqdDoa
         dB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TBtiqeo+CzWw5WAinwOONZ24dgm7CijfK//RXjS1RJ4=;
        b=SjMh3Dop4U/96XetISUt9tlTwP2Ai4awFNIsY00JF//xyvBzdDQyutgCV8q6tdQSzF
         6NjWO3hSKa+H62k7GFTkPh5ffEjHcWMQDXaPcz2UW4PJhzUOYW4aI757RnY7hKUztLxd
         wKrOtFtIM5PVEymMvBN/jysR2/DICMTHWE/9j/daA+8ZNJ1xiEXT6yhodUYHj/BOZ3Tl
         3vKnFl2RQHyCT+bj9BOcbNIQX5062liOPqOZCWsLa2rsgn5dfOJ/HekG04xG3x/jypJE
         PM3rvF8ES6W8hUkS1g5O57vBcjE/WYo4CQ27svpFxSj+7sRkuo8mcH/Ujy+RDJBeReDE
         aJYQ==
X-Gm-Message-State: AKaTC036g0jJYtILHEJMPH9aw21h0oPTeoAv0RxX8gdln/yMp56iK3HSp9rZv0znIE8ETA==
X-Received: by 10.194.117.134 with SMTP id ke6mr29907380wjb.123.1480539911051;
        Wed, 30 Nov 2016 13:05:11 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d64sm9802427wmh.3.2016.11.30.13.05.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Nov 2016 13:05:10 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v3 13/16] lib-httpd: add list.sh
Date:   Wed, 30 Nov 2016 22:04:17 +0100
Message-Id: <20161130210420.15982-14-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.rc2.37.geb49ca6
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cgi script can list Git objects that have been uploaded as
files to an apache web server. This script can also retrieve
the content of each of these files.

This will help make apache work as an external object database.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/lib-httpd.sh      |  1 +
 t/lib-httpd/list.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 t/lib-httpd/list.sh

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index d80b004549..f31ea261f5 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -133,6 +133,7 @@ prepare_httpd() {
 	install_script broken-smart-http.sh
 	install_script error.sh
 	install_script upload.sh
+	install_script list.sh
 
 	ln -s "$LIB_HTTPD_MODULE_PATH" "$HTTPD_ROOT_PATH/modules"
 
diff --git a/t/lib-httpd/list.sh b/t/lib-httpd/list.sh
new file mode 100644
index 0000000000..a54402558f
--- /dev/null
+++ b/t/lib-httpd/list.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
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
+	*) echo >&2 "unknown key '$key'" ;;
+    esac
+
+    shift
+done
+
+echo 'Status: 200 OK'
+echo
+
+if test -d "$FILES_DIR"
+then
+    if test -n "$sha1"
+    then
+	cat "$FILES_DIR/$sha1"-*
+    else
+	ls "$FILES_DIR" | tr '-' ' '
+    fi
+fi
-- 
2.11.0.rc2.37.geb49ca6

