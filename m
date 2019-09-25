Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDAA1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393338AbfIYUi5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:38:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54995 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732671AbfIYUi5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:38:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id p7so155573wmp.4
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JdsctYWXuuXXqEOzB63lpFiHupXhaM+lS9/RkB/3n9s=;
        b=YimI5ZsE4aqMZmcsJY9KYcr0zSD6QeoKrVWPLZVVkGmIWqlMz7kuYNr99bPiz24BzG
         IGMi/rTQyF+kVDBOWAwEZbVHTtaMrfxb6ahFXDmLCuDm7TDAnaGL8migxsUdTIO4Omve
         4OmXqQJEJFFS2fgXJ+i5YEVb07grrAyhmguSOsb5+7TcHkGGJYiqSZM6gi3NaOG/apnv
         hOcPRe+e0OY7Cu6EbxpGFEbLxHY2mfsy5ptquxdH8yBW8ZHu/3fNZO2fD8Anrucm7uy/
         eRGZAyyl7tcl61D0XQF36IOExN+++9SDHhAHnN1j5z7PBsZkCHfrhrG6UrnR6p9dV/+U
         i81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JdsctYWXuuXXqEOzB63lpFiHupXhaM+lS9/RkB/3n9s=;
        b=KyFqZj7+Xy4KpZ3Mf0X8NJePexNpjI+PBf5/4zFU1aU/oNBRFhMg9Imk2WbegYkJzs
         eGHcKB326yPvz95fAPlP9W8LBkdaEIas2h4p7OjBlx+PG0T3ZjkYq9wiB4pTNxrWhHtd
         tvEzIIuC7tW0uhNI8rSvtqiKUE9fOrgVmrBpsO4fZRSThEI2BhOu0V3Fpkh2K11rptOz
         XKMkdP1ez4QwrboZf9SGR+OTy0hft7efVc4tCbcfGxiguO6TnfmjcWWsXm/E0XE4nZgP
         16I4xqwfoYI8+ulGsMtiGViPGyMy1fwuV5Zb4UtwKi6VVty0LITMjhgHRZetJIpyck9f
         fb0g==
X-Gm-Message-State: APjAAAWgoX8t7mYdf03UXvbCtqVlgolK9SPDhyR6nZRG7aEUYgMKz155
        wRhxhhP2rUBrbswCIX4=
X-Google-Smtp-Source: APXvYqwQu4oN04EoKs6p9rhDpdk1bOSo1mFE8vcFaVXFQhpd7uxQVnbgxwBcfR78L9KkT1NgRUrp1Q==
X-Received: by 2002:a05:600c:210b:: with SMTP id u11mr80023wml.29.1569443934569;
        Wed, 25 Sep 2019 13:38:54 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id c18sm252870wrn.45.2019.09.25.13.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 13:38:54 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH 2/2] git-gui: support for diff3 conflict style
Date:   Wed, 25 Sep 2019 22:38:51 +0200
Message-Id: <f1477ba53a03484a0440202065a5293c8795d3b7.1569443729.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
In-Reply-To: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
References: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds highlight support for the diff3 conflict style.

The common pre-image will be reversed to --, because it has been removed
and either replaced with ours or theirs side.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh   |  3 +++
 lib/diff.tcl | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/git-gui.sh b/git-gui.sh
index fd476b6..6d80f82 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3581,6 +3581,9 @@ $ui_diff tag conf d_s- \
 $ui_diff tag conf d< \
 	-foreground orange \
 	-font font_diffbold
+$ui_diff tag conf d| \
+	-foreground orange \
+	-font font_diffbold
 $ui_diff tag conf d= \
 	-foreground orange \
 	-font font_diffbold
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 0fd4600..6caf4e7 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -347,6 +347,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	set ::current_diff_inheader 1
+	set ::conflict_state {CONTEXT}
 	fconfigure $fd \
 		-blocking 0 \
 		-encoding [get_path_encoding $path] \
@@ -450,10 +451,28 @@ proc read_diff {fd conflict_size cont_info} {
 			{++} {
 				set regexp [string map [list %conflict_size $conflict_size]\
 								{^\+\+([<>=]){%conflict_size}(?: |$)}]
+				set regexp_pre_image [string map [list %conflict_size $conflict_size]\
+								{^\+\+\|{%conflict_size}(?: |$)}]
 				if {[regexp $regexp $line _g op]} {
 					set is_conflict_diff 1
 					set line [string replace $line 0 1 {  }]
+					set markup {}
 					set tags d$op
+					switch -exact -- $op {
+					< { set ::conflict_state {OURS} }
+					= { set ::conflict_state {THEIRS} }
+					> { set ::conflict_state {CONTEXT} }
+					}
+				} elseif {[regexp $regexp_pre_image $line]} {
+					set is_conflict_diff 1
+					set line [string replace $line 0 1 {  }]
+					set markup {}
+					set tags d|
+					set ::conflict_state {BASE}
+				} elseif {$::conflict_state eq {BASE}} {
+					set line [string replace $line 0 1 {--}]
+					set markup {}
+					set tags d_--
 				} else {
 					set tags d_++
 				}
@@ -505,6 +524,9 @@ proc read_diff {fd conflict_size cont_info} {
 			}
 		}
 		set mark [$ui_diff index "end - 1 line linestart"]
+		if {[llength $markup] > 0} {
+			set tags {}
+		}
 		$ui_diff insert end $line $tags
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
-- 
2.21.0.789.ga095d9d866

