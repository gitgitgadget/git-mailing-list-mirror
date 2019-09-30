Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E2981F463
	for <e@80x24.org>; Mon, 30 Sep 2019 12:20:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfI3MUL (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 08:20:11 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44265 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729603AbfI3MUL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 08:20:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id i18so11021188wru.11
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 05:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GVRNYReK5e+xaXYbkIkUPkbpyuBe8XxSH6w5AcRiMg=;
        b=tRprH+dpPmTjqNliNuj0I0HbY8NvL+Z9okH0S5OKLYrU5n1idg+vJjEaTCn4wK10Xa
         WXzsk2dwQDw2ll48jNmQxj3ag7tu4rYKC4U972KqDzkpw1h2V/kYceyzF92/jUWynpAj
         eWQV0aQ0TIFh9VGphc/ZsLAq0XusR9vp/YRqQUCKEs/fWBd/7VL+TCOAukWYdiuXp5Hg
         sJQuJjIjcT4mKvGt91gEx4j9WwHdcm/Vyz0CqE2FU2vAAeBeIED3l8ctNBnkrG3G38fv
         Mb7i+sg2e/deuicF8n1dkxbMD0qrd+A8CVRyoaI15hib+yTFFOYrlUjb/9QdkeqOOTTa
         TKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7GVRNYReK5e+xaXYbkIkUPkbpyuBe8XxSH6w5AcRiMg=;
        b=gpW0iXSm4vWPxFxbvIhNgOUoB+EPLuphLItd99KwHRUjl9EBn3XInkG16WjclA6cAd
         ihG7qK83oxa+V7RmJ8ZZlSQvuZkydtOrl2EzxMaYmjHsBacUVOxBAKzRobXtrk86Q+Nd
         JJjpTiL3tYswnU3N60gzGPMkwS2/TEC1eAHCSgjc+zrkv2WChP0JGcbUP4zrXqCVzDRL
         3GaivrkofvOofKNXAUlUB7NQRUAb0gU7wqizb2SMnL4bGTEluqskBFiUCUkk3Y/BHRBw
         DWzcVL51DhOByqdMpfp+dV8faDmjqsCBiS2W//pYJ1r4O5/o2KIkPDeJhu1qkBtlOVHs
         N3oA==
X-Gm-Message-State: APjAAAULisSm+JCkOoZZYohDI75sshMY3m0fDDl3S8d79WyUV9TJ6ykg
        coSr4E2C1Wl0i7JAT9Y=
X-Google-Smtp-Source: APXvYqwYBgWj0zQ+IPfCe8p0hHI/NDSeH8E7xzSyjNUe7RXYgKkD3ybsOhHoSb5BwcSetM1MY2eKGw==
X-Received: by 2002:adf:bb8e:: with SMTP id q14mr14204710wrg.74.1569846009099;
        Mon, 30 Sep 2019 05:20:09 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id a192sm14578755wma.1.2019.09.30.05.20.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 05:20:08 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH v2 1/2] git-gui: use existing interface to query a path's attribute
Date:   Mon, 30 Sep 2019 14:20:06 +0200
Message-Id: <97013a71289857767100d6a4adcb39ca99b2b21b.1569845908.git.bert.wesarg@googlemail.com>
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

