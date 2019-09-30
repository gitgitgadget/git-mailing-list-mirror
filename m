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
	by dcvr.yhbt.net (Postfix) with ESMTP id 57A391F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732495AbfI3VEA (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:04:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46825 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfI3VD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:03:59 -0400
Received: by mail-ed1-f66.google.com with SMTP id t3so9894732edw.13
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GVRNYReK5e+xaXYbkIkUPkbpyuBe8XxSH6w5AcRiMg=;
        b=r7BRjTMMHWsbmmO7EscXvtx/ZEeg26O/uZHDm+AQjzZXhpqXzWxG887YpnMxC4OIZb
         78n4oCDTgNjdyqpmH7J5rxozjcS6XNmEmTlDQNLUE0eyPt52eKmCCmW1B1uutS1ErT/U
         a+GcsSd+yGshVsvZO7atL4TTP2JzNZ9SoyiVHvhjeQtbbLcUFsMRrYrv3R250zBGQYXj
         f7lc+VzSRXMgVm0XhVLnfkpM4fWfDzcTsIxdNcSg0Uqsvolp41qPbWz71+B+VTLarTtw
         SS5eMCDaLRdmcVvHP2p7v7YOI4oFYWqbtEf1Q0Uqc90BO/FDDAkRdkUGoj1iNuKrAVY0
         9Zrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GVRNYReK5e+xaXYbkIkUPkbpyuBe8XxSH6w5AcRiMg=;
        b=MD1Vpk1bJkvfOMpPfIXN8iqjnaeKf6Ck6R2ziEIENjcc+2RZa6qhGTD2/0yp2xJWsA
         aq3z7HbMiP8r3LiNICZMBkuWduTrXUeILaDKn3gNOOPFIN/hjZqrAHbuZ/n1WkxH4xQc
         Wz2zjeabJIrt/Irp7C3riyeXplRmNu5OSWlDD9fBaXl9O8V05dXMjnYxvU6Oc/iA7eY+
         30KXPtUTF/E48ou+KQnrX9POR0LXT8APmMORpPmzgV4lBF0Scp9PyADzIoeEsPiPcJ59
         mTNmmxibEOkN2EqbunMhFEOe6a7dffP6PUi9+aUbL4xejeQQngBKywYgi1pRmaJXJpnY
         Fhwg==
X-Gm-Message-State: APjAAAWy8HvqIWIxs4IcgPZ7Ktf5/v7dnT/AE8t1xsQEDcAOYXB+z7f2
        5eJ7/ug9xLYBU9iCHo0=
X-Google-Smtp-Source: APXvYqzL94hFgMVpHtN5IL/oEJMEypOJoPSoWFWbAj2CosGcAgEB1AK9R70jYtu0fKBI2PVd/mRYuQ==
X-Received: by 2002:aa7:c343:: with SMTP id j3mr21830139edr.187.1569873294926;
        Mon, 30 Sep 2019 12:54:54 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id k22sm1565575eja.56.2019.09.30.12.54.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 12:54:54 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v3 1/2] git-gui: use existing interface to query a path's attribute
Date:   Mon, 30 Sep 2019 21:54:52 +0200
Message-Id: <97013a71289857767100d6a4adcb39ca99b2b21b.1569873171.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
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
2.23.0.11.g242cf7f110

