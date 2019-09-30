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
	by dcvr.yhbt.net (Postfix) with ESMTP id B251F1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 12:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfI3MUM (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 08:20:12 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42016 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfI3MUM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 08:20:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id n14so11037250wrw.9
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g7nWw8WPCUBImKMyvtDQlNwmDAeftb7FOsYAMucgmpY=;
        b=PaGSq4zouID7UK1+zr+cuNYywv6yLOwcT7TlZ2vxqk3uJSMyH3BWdElQ/6W4EHlpSz
         UQlz3wlighGwRDiI4M0cC9qMgJFz19X6lCwrTbBYDwU3gzV3zadZilz9CvS/IBF57YVW
         97l1Zpt0stNeA98zs5BHrw7lvNS9Jm7drFaRic3rySc02FacqtBJ4CFKXJlBoJW+MIgL
         20XSs9ZQrnbDojj5beXLfKXq+wPSEtc5pq4EjoZ6uR4vyRoywDShpQanZ6fkUfWz8GNH
         eJvwfd+3pWhBMeNMiRZ6zZfG0tvRkfQ/J4AZr3ALYgF85mH4MZ99hajXJnazVQJeB8G+
         FQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g7nWw8WPCUBImKMyvtDQlNwmDAeftb7FOsYAMucgmpY=;
        b=rvg+sEUaUqNPfpAl7HP+Abv3zZ06YqxfShGjSw2eTltvsp216jyMF3YocTXRFApHH0
         zfvVxlLnhAQ2BC9YoXEzCP75oK814Y4gx+/ueuJsLryf/KVirlU5f+39P6eI8M8SY3xE
         nXXbWalH/4y5o5g5IbEziBZZa/0ITFrPO7ATtV9hsVMxi8ct7pjufCKxdyNsvpkf4sOT
         h8am2echyTRUCNhL+y6R8ucQBSPWNQ3olmdQmbAfvPHX0XO1jRPgjWQsqxeKorI/bjms
         rxBSs80z1TuDanlzgCvYT6snN9sBAbqKMfivPGtIgMZRvU777zxpVWcz/YP7JvFOJByQ
         Ns8w==
X-Gm-Message-State: APjAAAVsliXU9GcTGthZjs9Fh4bdu6os0Ht8noilUdjJLR5l02AYtp3P
        Wp46nByftDDuTm3VrUQ=
X-Google-Smtp-Source: APXvYqy5NQLTDiC0bnn4LBe8mUD3gl2V1CvZvDodqC6+iIVk3WY8kDAdsYLjwyg00aFhAJmf5g3fIw==
X-Received: by 2002:adf:ef12:: with SMTP id e18mr1111285wro.65.1569846010618;
        Mon, 30 Sep 2019 05:20:10 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id o22sm34023947wra.96.2019.09.30.05.20.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 05:20:09 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v2 2/2] git-gui: support for diff3 conflict style
Date:   Mon, 30 Sep 2019 14:20:07 +0200
Message-Id: <14754a59ecf15194dccc659072e2bc180280d097.1569845908.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
In-Reply-To: <97013a71289857767100d6a4adcb39ca99b2b21b.1569845908.git.bert.wesarg@googlemail.com>
References: <CAKPyHN3nOL6qy4RhwwHrh2m3EJuJ1-rt-8+0+=z2oJi96Nigpw@mail.gmail.com>
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
index 0fd4600..6459cfb 100644
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
+					set ::conflict_in_pre_image [expr {$op eq {|}}
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

