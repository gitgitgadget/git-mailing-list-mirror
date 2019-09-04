Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBCEB1F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729890AbfIDUK1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:10:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:53797 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfIDUK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:10:27 -0400
Received: by mail-wm1-f66.google.com with SMTP id q19so144965wmc.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQI/CX+6goGxeN+fvOEdGestwrQV6fklFPnHMlqJhrk=;
        b=ibDl1aKRQC1CPEerI1MpsaT/CdEYvVOQ2ADA8S1/M2zgwxZmnURIg7vcyGUNFDtmNv
         kJG2naWchHpLRvHaE0TR2UB83oeUC74Bi2xks+rqCBCO91zNYgHwipyeU/7E2NVdhMPY
         R6z/q4M16OM3nQ0tubP2qjEXl5+tINpf35V6wuyM6kVnShuLQYfz8r9M5U4EzYqLHZYb
         OWRGBNbw6prrHTc1kUPSghExwbA27AVTzGEgWjc51Buv4d1fzqZDQLPcoYZXldPzyDYw
         nF83wVZv3nR7KWZQ3/aS+8CfiA7SAmE/4t616KLDwIrimkcEhMxhx2tMGlqU649GImN3
         /HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hQI/CX+6goGxeN+fvOEdGestwrQV6fklFPnHMlqJhrk=;
        b=V9xh7OrVT3DWuNydg5B7dR8q7pdgtOdC+PZJYbriWwor/WErvmOFmWiCcIiZNWau30
         GPgMhvuYYJJMe5uuc6im3SYSFceMEw4FrHibHh2WaPFCw67b2YDNnBMnzbhUc2id8uGZ
         8Wvll49+XcO59HW2i4Seyztj80A+cDbFAtDZBIYHcVfmnKc7M4lC9C6dl+37BEJbzkM8
         TZSgAwjrxvCGVeyGLSu/2NAVh0d8eTkxHeL5GjB05wx8anA83oCsEiCIR0C8Zn5+Xxdz
         t0n1h09JpNySYVv9MbDVaFat2QJB1OGqWwMGDSgSS0GPynQgy+Qepc3LC2kdM9t61+MA
         Gfhg==
X-Gm-Message-State: APjAAAXCMw3dGDXY73dqltM7aFViO6CIBFbXELMpRsCX1rWPvyVmvafD
        uDHfABPVpaVx0DE8zFloxw==
X-Google-Smtp-Source: APXvYqzoJBfiGJeOEm39ptx5hSEGrrLZV6TQa1vQhfaSozXkOoE6PAf519NbPXdWaQuQAUgGa69SFA==
X-Received: by 2002:a7b:ca43:: with SMTP id m3mr59312wml.20.1567627824759;
        Wed, 04 Sep 2019 13:10:24 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:e18b:2076:d6e6:a85d])
        by smtp.gmail.com with ESMTPSA id d28sm23746744wrb.95.2019.09.04.13.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Sep 2019 13:10:24 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     me@yadavpratyush.com,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/2] git-gui: warn if the commit message contains lines longer than the set limit
Date:   Wed,  4 Sep 2019 22:10:22 +0200
Message-Id: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.21.0.789.ga095d9d866
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit message widget does not wrap the next and has a configurable
fixed width to avoid creating too wide commit messages. Though this was
only enforced in the GUI. Now we also check the commit message at commit
time for long lines and ask the author for confirmation if it exceeds the
configured line length.

Needs Tcl 8.6 because of `lmap`.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh     |  4 ++--
 lib/commit.tcl | 10 ++++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..a491085 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -31,8 +31,8 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA}]
 ##
 ## Tcl/Tk sanity check
 
-if {[catch {package require Tcl 8.4} err]
- || [catch {package require Tk  8.4} err]
+if {[catch {package require Tcl 8.6} err]
+ || [catch {package require Tk  8.6} err]
 } {
 	catch {wm withdraw .}
 	tk_messageBox \
diff --git a/lib/commit.tcl b/lib/commit.tcl
index 83620b7..fa9760b 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -215,6 +215,16 @@ A good commit message has the following format:
 		unlock_index
 		return
 	}
+	if {[tcl::mathfunc::max {*}[lmap x [split $msg "\n"] {string length $x}]] >= $repo_config(gui.commitmsgwidth) \
+	    && [ask_popup "Commit message contains lines longer than $repo_config(gui.commitmsgwidth) characters.
+
+You may change this limit in the options.
+
+Continue to commit?
+"] ne yes} {
+		unlock_index
+		return
+	}
 
 	# -- Build the message file.
 	#
-- 
2.21.0.789.ga095d9d866

