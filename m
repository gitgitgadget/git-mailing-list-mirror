Return-Path: <SRS0=BQqG=A5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FD6C433E1
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 19:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0803020724
	for <git@archiver.kernel.org>; Sat, 18 Jul 2020 19:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skylittlesystem-org.20150623.gappssmtp.com header.i=@skylittlesystem-org.20150623.gappssmtp.com header.b="ngYJVyXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgGRT1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jul 2020 15:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgGRT1N (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jul 2020 15:27:13 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62123C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 12:27:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c80so18750782wme.0
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 12:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skylittlesystem-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tGTzoZxZ/QGsYBYBX4Dcm58NPFXQSvwOAXIf8P/0H4=;
        b=ngYJVyXEu/DXWHQ+VcSNbJneVl2hheIWbcSVMxhT1csEX+MftsD/VoTFNmO5+izTt1
         33U8jgSnqtpFXzllV21Ixheqx8ur1xg0L8+uLlkBvC4MMOMiav3vxK0/hd7jhNctSUeM
         JrfqgbPgbv57cmNaqc6c1Ofq2gYgyvTmnTchgq7snBzOqb0ha1I839F01VefKJJQaLGx
         Y0YqqtuYuRcxAVXgTD7+FJJ3bVHuUB5Mj3bx4sKs/xOZHml7cSfzHbr84Kpf9whlxNB3
         7bsIlVRd1wZcRJTDyr02A5Jz4qLYdFoAz3OvM2PWCNcc17pLWcC/wJox5pVOta26ocfw
         zYWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+tGTzoZxZ/QGsYBYBX4Dcm58NPFXQSvwOAXIf8P/0H4=;
        b=Y5q5ioa5iXGaMn514DHuS8fvc+G84BQCA7P8VqL1F7Yjulh4NbHdrxtcbpJD075Udu
         RDeSB0yzNsMMsPFpzVpAVNAT1UKhbtcWr/2wrqr3ck/kCNqP5DG0qXAigEJp9IwkOCXQ
         RwE2Zdz/GDgzunUU/iTbMIWkM+c/eXeLi4KMAK5VV25iM1vrMM94SjDOV9buzUiRJpaR
         GSi0/up+ZQoSzZkqhcTTc1g6IfW+qmg6Hl1Geke+dk2bKRa81rLBw3/f2yPZH+o1alaB
         +fdJaCVWPGv3tQgygAM/IK4UhdhO51KULElyxInMcXEHvp0MzELsLi7YFc0pjvcsg15S
         rd4A==
X-Gm-Message-State: AOAM530bEgcHJRQ25EtfHEJmatLvugIJQxaJGICIaUOQ0M8kDr1Fj6Kh
        O45jLodk/yc6gOm0xqcKOEiwVH1IGc0=
X-Google-Smtp-Source: ABdhPJx7/BGymrMOLUr07mbUK2E9ZBmYjNRQNYrVJTIjbzEn9QcDMTGFHGUfTC+tK+QLRuSS4ucJWw==
X-Received: by 2002:a1c:28a:: with SMTP id 132mr14443220wmc.109.1595100431751;
        Sat, 18 Jul 2020 12:27:11 -0700 (PDT)
Received: from localhost.localdomain (cpc110667-lewi19-2-0-cust284.2-4.cable.virginm.net. [80.7.253.29])
        by smtp.gmail.com with ESMTPSA id g145sm27423531wmg.23.2020.07.18.12.27.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 12:27:11 -0700 (PDT)
From:   pudinha <rogi@skylittlesystem.org>
To:     git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>
Subject: [PATCH] Support nvim as mergetool
Date:   Sat, 18 Jul 2020 20:20:02 +0100
Message-Id: <20200718192001.27434-1-rogi@skylittlesystem.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
Hello giters! Hope you are well!

I made this little patch to support nvim as a merge tool. What do you
think?

Best regards,
Pudinha <3

 mergetools/nvimdiff  | 1 +
 mergetools/nvimdiff2 | 1 +
 mergetools/nvimdiff3 | 1 +
 mergetools/vimdiff   | 9 ++++++---
 4 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 mergetools/nvimdiff
 create mode 100644 mergetools/nvimdiff2
 create mode 100644 mergetools/nvimdiff3

diff --git a/mergetools/nvimdiff b/mergetools/nvimdiff
new file mode 100644
index 0000000000..04a5bb0ea8
--- /dev/null
+++ b/mergetools/nvimdiff
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/nvimdiff2 b/mergetools/nvimdiff2
new file mode 100644
index 0000000000..04a5bb0ea8
--- /dev/null
+++ b/mergetools/nvimdiff2
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/nvimdiff3 b/mergetools/nvimdiff3
new file mode 100644
index 0000000000..04a5bb0ea8
--- /dev/null
+++ b/mergetools/nvimdiff3
@@ -0,0 +1 @@
+. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 10d86f3e19..be559062ee 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -5,7 +5,7 @@ diff_cmd () {
 
 merge_cmd () {
 	case "$1" in
-	gvimdiff|vimdiff)
+	nvimdiff|gvimdiff|vimdiff)
 		if $base_present
 		then
 			"$merge_tool_path" -f -d -c '4wincmd w | wincmd J' \
@@ -15,11 +15,11 @@ merge_cmd () {
 				"$LOCAL" "$MERGED" "$REMOTE"
 		fi
 		;;
-	gvimdiff2|vimdiff2)
+	nvimdiff2|gvimdiff2|vimdiff2)
 		"$merge_tool_path" -f -d -c 'wincmd l' \
 			"$LOCAL" "$MERGED" "$REMOTE"
 		;;
-	gvimdiff3|vimdiff3)
+	nvimdiff3|gvimdiff3|vimdiff3)
 		if $base_present
 		then
 			"$merge_tool_path" -f -d -c 'hid | hid | hid' \
@@ -34,6 +34,9 @@ merge_cmd () {
 
 translate_merge_tool_path() {
 	case "$1" in
+	nvimdiff|nvimdiff2|nvimdiff3)
+		echo nvim
+		;;
 	gvimdiff|gvimdiff2|gvimdiff3)
 		echo gvim
 		;;
-- 
2.27.0

