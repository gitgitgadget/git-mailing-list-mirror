Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22D271F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 07:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfJBHgG (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 03:36:06 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34959 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbfJBHgF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 03:36:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id y21so5788665wmi.0
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 00:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tFnttCed13jYBuJxShS3UDdAo0SwnChsGPD7bTLyt90=;
        b=CD5MQAB6blVbxL0/bHxm3tpQOXoZpucUvE7Vv+CNhVLwgX243tXRA3AmsKBr/IsUGW
         B4qF2chmQ8uDat/s+VygGYWnTzWcac/iravB1WJWM/W+AlV12Kn7Gy7Aspz01CK9Fe8I
         IFGlYDNsvSntzLRBFgoatQa4ruoJFCqlB//APkn439o4njXyhpKuC/D7JJ2Jnd2UYG49
         Q7+yn0kmTEBRdNTHKgebmZkkpXagGt4bCOWO4+dAm0NHF98OgjpSsdmQXXaCosj0IoCW
         n053/iQ38hUqX05i0d+DrFPPyFJM6uJQb7I/cLcearaofv8aElVDbBCoY5cK+fxKqW+w
         kR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tFnttCed13jYBuJxShS3UDdAo0SwnChsGPD7bTLyt90=;
        b=tx8A36xmoyXnXFaorr4LeuFJPsojxUM+lReZFpsZQR9LiGyvAyiQO3YBp62+86yTrb
         Yto3JCw6j7WhVs9J/kQiaC7tDey2kolB6xlNzNacooElmt00+no4tj5o1/Wzw99M+Q7m
         hba/uiXzjMUVYNPEQvThBcOQrr6WwANk09C0AcVTxQevVJYzJHvHu0yGfBYp8apFrIOY
         gqPOsxLCgUYHksA5Unu09ftkalPHIwQxDrD3MtwK0PG+ssuFEi+R45YUd7mRHzTMW/Kc
         OXWv4Vbuxc2txtPLzkIQqR++/RmNvpH0r0gS5H1tgTRLTIJgZ4zH6wsYsMzYkm8Yq26B
         bHfw==
X-Gm-Message-State: APjAAAWg5vwE19N8zNiyYEp5XN9/HvqBndyV4Ce1tJBs59JDBziRi2cH
        tCU0In3foWyNb9fB/fxAbw==
X-Google-Smtp-Source: APXvYqw+n2aEIiKuBRAZhJW5AtzxOG3pcmdv9H4i5tkquDAn5OZ1ea4K5S2vPzb1HeI8o80yyMp4tA==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr1544530wmc.23.1570001763737;
        Wed, 02 Oct 2019 00:36:03 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id a10sm20108186wrm.52.2019.10.02.00.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Oct 2019 00:36:03 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v3 2/2] git-gui: support for diff3 conflict style
Date:   Wed,  2 Oct 2019 09:36:02 +0200
Message-Id: <a7cff5097eaf29a80c822cb37b537b3859d06ad7.1569873171.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
In-Reply-To: <97013a71289857767100d6a4adcb39ca99b2b21b.1569873171.git.bert.wesarg@googlemail.com>
References: <14754a59ecf15194dccc659072e2bc180280d097.1569845908.git.bert.wesarg@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds highlight support for the diff3 conflict style.

The common pre-image will be reversed to --, because it has been removed
and replaced with ours or theirs side respectively.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh   |  3 +++
 lib/diff.tcl | 17 ++++++++++++++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

--- 

v3: Fixed a syntax error

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
index 0fd4600..dacdda2 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -347,6 +347,10 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	set ::current_diff_inheader 1
+	# detect pre-image lines of the diff3 conflict-style, they are just '++'
+	# lines which is not bijective, thus we need to maintain a state across
+	# lines
+	set ::conflict_in_pre_image 0
 	fconfigure $fd \
 		-blocking 0 \
 		-encoding [get_path_encoding $path] \
@@ -449,11 +453,22 @@ proc read_diff {fd conflict_size cont_info} {
 			{--} {set tags d_--}
 			{++} {
 				set regexp [string map [list %conflict_size $conflict_size]\
-								{^\+\+([<>=]){%conflict_size}(?: |$)}]
+								{^\+\+([<>=|]){%conflict_size}(?: |$)}]
 				if {[regexp $regexp $line _g op]} {
 					set is_conflict_diff 1
 					set line [string replace $line 0 1 {  }]
 					set tags d$op
+					# the ||| conflict-marker marks the start of the pre-image,
+					# all those lines are also prefixed with '++', thus we need
+					# to maintain this state
+					set ::conflict_in_pre_image [expr {$op eq {|}}]
+				} elseif {$::conflict_in_pre_image} {
+					# this is a pre-image line, it is the one which both sides
+					# are based on. As it has also the '++' line start, it is
+					# normally shown as 'added', invert this to '--' to make
+					# it a 'removed' line
+					set line [string replace $line 0 1 {--}]
+					set tags d_--
 				} else {
 					set tags d_++
 				}
-- 
2.23.0.11.g242cf7f110

