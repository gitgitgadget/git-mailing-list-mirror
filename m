Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23CA120401
	for <e@80x24.org>; Tue, 20 Jun 2017 07:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbdFTH4Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Jun 2017 03:56:25 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34364 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdFTH4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2017 03:56:20 -0400
Received: by mail-wr0-f196.google.com with SMTP id y25so14132508wrd.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2017 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I7Odl3VgcAFYAxvOy/EHa0BEnmsOpoNCskHCLE8i9LM=;
        b=Yoej3OEiVFveXhKL8pgPFa3r6E3VcpbHIfOHoX9UT1fJFa9kq+HBrldRfo6IApYAnW
         xSAVc7IF4Q2pEpI/ycJH52xN8YFtYaHe5zAJuQk9P7+vjPcJ2UUYlHlbYjDGg+P/cBrH
         eFoHJXJhrShEH9ZOJDQ3sv183uq9bQZrG8pQ4RHbURnhZHQEGnPs/VGFD6AiO2LZ0isf
         E4okFLAoY1poTS3Xb69OlrQScW+SIXpb3kXg5tScsx69XUqMmF3FnoNfe45Lnw0JwfAD
         eZL+sScPpwiSz/sL1e8OtLh73hp2F5DhBKORbmypTqmggnbyGtLRbfyGPKwjW612xmVs
         PquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I7Odl3VgcAFYAxvOy/EHa0BEnmsOpoNCskHCLE8i9LM=;
        b=kyRtbujtAx/cMqbN+2fdLaeFuiYMfnNgP6iaOxrUNuTEQl3B0kum22g+VGxAQzZecA
         bR8mdk35PfPSOv6QgPgk/yOTaJ/sbIe9s4OfP8GZ4+TFr5t/fbMDGWc30nX98o4nMKkx
         HqFCgGwyr7R9iMg1Kr0awjCfuWbWW4zBH9fY9fqT8ConO3wwMIZBWYcpLvu/AtweBEge
         h4Uwoi/SLrF4KgLBYS7mr/vKy9fDFK6yNBrfUJFiLDWqBEci8lAE9ShtCAzBJs3EOfqP
         OqYPIJy4k3YRl4F/+rD8HTSlTL5VWvNOE6zZACETJO8hMP2isO2a3PT/eONzdOqx+Bj3
         Vvcg==
X-Gm-Message-State: AKS2vOznj1vP/9bT12GqAGuAzh2dI10WqiIiemulIJhGn4Q48zEakwCp
        0adTM70QjOmubYog
X-Received: by 10.223.147.98 with SMTP id 89mr18296889wro.103.1497945374209;
        Tue, 20 Jun 2017 00:56:14 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id k86sm11577890wmi.16.2017.06.20.00.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 20 Jun 2017 00:56:13 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH v4 19/49] lib-httpd: add list.sh
Date:   Tue, 20 Jun 2017 09:54:53 +0200
Message-Id: <20170620075523.26961-20-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.1.565.gbfcd7a9048
In-Reply-To: <20170620075523.26961-1-chriscool@tuxfamily.org>
References: <20170620075523.26961-1-chriscool@tuxfamily.org>
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
 t/lib-httpd/list.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)
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
index 0000000000..7e520e507a
--- /dev/null
+++ b/t/lib-httpd/list.sh
@@ -0,0 +1,41 @@
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
+if test -d "$FILES_DIR"
+then
+    if test -z "$sha1"
+    then
+	echo 'Status: 200 OK'
+	echo
+	ls "$FILES_DIR" | tr '-' ' '
+    else
+	if test -f "$FILES_DIR/$sha1"-*
+	then
+	    echo 'Status: 200 OK'
+	    echo
+	    cat "$FILES_DIR/$sha1"-*
+	else
+	    echo 'Status: 404 Not Found'
+	    echo
+	fi
+    fi
+fi
-- 
2.13.1.565.gbfcd7a9048

