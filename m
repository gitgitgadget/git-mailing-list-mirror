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
	by dcvr.yhbt.net (Postfix) with ESMTP id C98CB1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 20:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393333AbfIYUiz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 16:38:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40225 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfIYUiz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 16:38:55 -0400
Received: by mail-wm1-f68.google.com with SMTP id b24so160808wmj.5
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 13:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNJHXHwCYA7mJJNicjzFnF9BaMIk3HB8BKl0Qp+0du0=;
        b=t4l7Z7dihYYeJzB9bUYoyo2OcFEtoH1WJvWwh+LMeSesVnlB4FcOhLBUru6XdOUzOU
         5QE0kuvRr/ESvHU+YZvjmtHUBuR/L2SEkUd4Zmb+fNuqVuFQTImX/kxMLPL4hkveHZGa
         LBALQhCabmKVR1COriL5ohNPG6KIAT6yVSZ431unMbuUV1VzJr/tWr/z4B1VEjp3W5/R
         FxZSDJbc5PFhxjTbSjzXkm6jvlLkPA0lEIYTOaihxOz9a+nuBdqsjUoJd4Avz36baodI
         vq2oJ0F+QzX6xkfCcXTBgTL0VZMZdrrOLEGNlKRGVIgBSdT3DmvHOzv6RCv4XPT156EL
         ODfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lNJHXHwCYA7mJJNicjzFnF9BaMIk3HB8BKl0Qp+0du0=;
        b=iwpEZ5AprcpY8byyjTW4/m/40rVpLcTCQk3hQIpFDwySs3lJ+TFc5p1oy4Mb2OeYlP
         iNrh7TA2VACgxgbpH4Hd14wyl5q32avJhUgb310eq6jE+3rF1hBRiWpPzTRrYRLH3pE+
         QyzcQb7baLw9bMvcOljwXE7DLOPBm8C4qJpBI+uF8l00y5tek9byXTTpeyX5yPGdgwMx
         YWYZ5s/0KzqKHirHjRqWKZuiJ9DMotMDfEHLjU7fkJJQcjVfX0QAzGIOd1XlSy21gKGP
         YSUTuo4KDL6HIbloINLpWH0BH6teTmIDhE7TX1kOd3S/jnb2P/G+sQ3HHIQ7hNWWPHcn
         b5MQ==
X-Gm-Message-State: APjAAAXGMCMu8G+cYSHULYpnP+Rd3S08e2BAuT2xYlQZpIF5GS6xm9fw
        pFC+9ttp90wUKZ/0++M=
X-Google-Smtp-Source: APXvYqx4BfiTa/RhQZTGZifjD2FWaWWcveDREffwJc7ktuHSDceiTEsuiBzItjMYmmRybyuQVtp3fA==
X-Received: by 2002:a05:600c:2308:: with SMTP id 8mr78509wmo.67.1569443933320;
        Wed, 25 Sep 2019 13:38:53 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id t4sm122153wrm.13.2019.09.25.13.38.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Sep 2019 13:38:52 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH 1/2] git-gui: use existing interface to query a path's attribute
Date:   Wed, 25 Sep 2019 22:38:50 +0200
Message-Id: <97013a71289857767100d6a4adcb39ca99b2b21b.1569443729.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the hand-coded call to git check-attr with the already provided one.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/diff.tcl | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 958a0fa..0fd4600 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -270,19 +270,6 @@ proc show_other_diff {path w m cont_info} {
 	}
 }
 
-proc get_conflict_marker_size {path} {
-	set size 7
-	catch {
-		set fd_rc [eval [list git_read check-attr "conflict-marker-size" -- $path]]
-		set ret [gets $fd_rc line]
-		close $fd_rc
-		if {$ret > 0} {
-			regexp {.*: conflict-marker-size: (\d+)$} $line line size
-		}
-	}
-	return $size
-}
-
 proc start_show_diff {cont_info {add_opts {}}} {
 	global file_states file_lists
 	global is_3way_diff is_submodule_diff diff_active repo_config
@@ -298,7 +285,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	set is_submodule_diff 0
 	set diff_active 1
 	set current_diff_header {}
-	set conflict_size [get_conflict_marker_size $path]
+	set conflict_size [gitattr $path conflict-marker-size 7]
 
 	set cmd [list]
 	if {$w eq $ui_index} {
-- 
2.21.0.789.ga095d9d866

