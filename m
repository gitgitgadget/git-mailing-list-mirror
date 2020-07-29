Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C12C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DED6B2070B
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skylittlesystem-org.20150623.gappssmtp.com header.i=@skylittlesystem-org.20150623.gappssmtp.com header.b="tquuZ3I1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgG2Vcu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgG2Vct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:32:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6481DC061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:32:49 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id z18so19404682wrm.12
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skylittlesystem-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVN70BfKPTDYe1i9iW9mYQSbcYLtR6qqcYw0E7xz2mw=;
        b=tquuZ3I1GpPzgyYSp4T1VMK3fmTG/Kl+qBE7Ta5buMW+VcuXKHeumW4W8KVHZJKijz
         niEsbvPfvpWIjDoJNK8Fg9Aj9138YsDlK8JoW19qm7MpY18Bwa9LH9ot9rC2O6QPQsgn
         kubT1CihGHMX1arEfrMrTeSZ8Azwc0vkE+s+5Z6K8ZBL1pxzAFHRWGlPtUCZw/e9LQiV
         f+WLpNC6A+2yE5sks1P2JFWI/4u9mUIC88/djdj51kEtKtuVGt9Wr6OpJjpKkGcDk5Hr
         A5un0FFlsYm05Cz682tThrTD1u7FkjvmlHlvDBgMamHYrhOdh6rem13piZRCxWJaB2DR
         8FFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVN70BfKPTDYe1i9iW9mYQSbcYLtR6qqcYw0E7xz2mw=;
        b=T6C4iNjSinH9oOuW24HKMU9c63woElfSZhdD22AxZJzyGaCSbLSQjuW9eoMH70FDuw
         aTO7dXqVkt0/RUkC6o4D0Ns1urQlPc+VEDrkE8rOwASM/gBT8OjwR+L41arXPODVLCOI
         SrGr/DTBtguiaIXjYI1Pwxiqlbnd7Y693RQwq2mkB09OLqM8V/StIRqnvJIJizE8dldH
         OU8KfJuWKqy+xuuXLDB9wTbcujvs1TtDKJmY8HuIp00d9jvSBUFMjR0wUGcG+R2BTA3+
         tGBbVUIn5VJnbN844ZOSWmu8Tagxi8tXzJ99hQFcnjaakqgfnLo6ho0hEP8b8n60lC+F
         M2Ug==
X-Gm-Message-State: AOAM532yTy/AOYvJycJkkVCS3+h66UYJ7Bd3WrUgWxnCUq8N6qlagdma
        sr03qS6JSlDiRcHs61I1mzDtfpFkJ+c=
X-Google-Smtp-Source: ABdhPJzbS0+LJYgAHToXeknnVuMvJ/OPN49pf5YaRUM6SBw7FEkTSRCer+OYz/isr29yY/nfvRHVUQ==
X-Received: by 2002:adf:bbc1:: with SMTP id z1mr30810587wrg.173.1596058367795;
        Wed, 29 Jul 2020 14:32:47 -0700 (PDT)
Received: from localhost.localdomain (cpc110667-lewi19-2-0-cust284.2-4.cable.virginm.net. [80.7.253.29])
        by smtp.gmail.com with ESMTPSA id z8sm6402057wmf.42.2020.07.29.14.32.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 14:32:47 -0700 (PDT)
From:   pudinha <rogi@skylittlesystem.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        pudinha <rogi@skylittlesystem.org>
Subject: [PATCH v3 1/2] mergetool--lib: improve support for vimdiff-style tool variants
Date:   Wed, 29 Jul 2020 22:31:12 +0100
Message-Id: <20200729213113.15927-2-rogi@skylittlesystem.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200729213113.15927-1-rogi@skylittlesystem.org>
References: <20200719042335.3913-1-rogi@skylittlesystem.org>
 <20200729213113.15927-1-rogi@skylittlesystem.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge tools vimdiff2, vimdiff3, gvimdiff2, gvimdiff3 and bc3 are all
variants of the main tools vimdiff and bc. They are implemented in the
main and a one-liner script that just sources it exist for each.

Allow variants ending in [0-9] to be correctly wired without the need
for such one-liners, so instead of 5 scripts, only 1 (gvimdiff) is
needed.

Signed-off-by: pudinha <rogi@skylittlesystem.org>
---
 git-mergetool--lib.sh | 28 +++++++++++++++++++++++-----
 mergetools/bc         |  5 +++++
 mergetools/bc3        |  1 -
 mergetools/gvimdiff2  |  1 -
 mergetools/gvimdiff3  |  1 -
 mergetools/vimdiff    |  8 ++++++++
 mergetools/vimdiff2   |  1 -
 mergetools/vimdiff3   |  1 -
 8 files changed, 36 insertions(+), 10 deletions(-)
 delete mode 100644 mergetools/bc3
 delete mode 100644 mergetools/gvimdiff2
 delete mode 100644 mergetools/gvimdiff3
 delete mode 100644 mergetools/vimdiff2
 delete mode 100644 mergetools/vimdiff3

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 204a5acd66..29fecc340f 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -43,7 +43,14 @@ show_tool_names () {
 
 	shown_any=
 	( cd "$MERGE_TOOLS_DIR" && ls ) | {
-		while read toolname
+		while read scriptname
+		do
+			setup_tool "$scriptname" 2>/dev/null
+			variants="$variants$(list_tool_variants)\n"
+		done
+		variants="$(echo "$variants" | sort | uniq)"
+
+		for toolname in $variants
 		do
 			if setup_tool "$toolname" 2>/dev/null &&
 				(eval "$condition" "$toolname")
@@ -157,6 +164,10 @@ setup_tool () {
 		echo "$1"
 	}
 
+	list_tool_variants () {
+		echo "$tool"
+	}
+
 	# Most tools' exit codes cannot be trusted, so By default we ignore
 	# their exit code and check the merged file's modification time in
 	# check_unchanged() to determine whether or not the merge was
@@ -178,19 +189,26 @@ setup_tool () {
 		false
 	}
 
-
-	if ! test -f "$MERGE_TOOLS_DIR/$tool"
+	if test -f "$MERGE_TOOLS_DIR/$tool"
 	then
+		. "$MERGE_TOOLS_DIR/$tool"
+	elif test -f "$MERGE_TOOLS_DIR/${tool%[0-9]}"
+	then
+		. "$MERGE_TOOLS_DIR/${tool%[0-9]}"
+	else
 		setup_user_tool
 		return $?
 	fi
 
-	# Load the redefined functions
-	. "$MERGE_TOOLS_DIR/$tool"
 	# Now let the user override the default command for the tool.  If
 	# they have not done so then this will return 1 which we ignore.
 	setup_user_tool
 
+	if ! list_tool_variants | grep -q "^$tool$"
+	then
+		return 1
+	fi
+
 	if merge_mode && ! can_merge
 	then
 		echo "error: '$tool' can not be used to resolve merges" >&2
diff --git a/mergetools/bc b/mergetools/bc
index 3a69e60faa..a89086ee72 100644
--- a/mergetools/bc
+++ b/mergetools/bc
@@ -21,3 +21,8 @@ translate_merge_tool_path() {
 		echo bcompare
 	fi
 }
+
+list_tool_variants () {
+	echo bc
+	echo bc3
+}
diff --git a/mergetools/bc3 b/mergetools/bc3
deleted file mode 100644
index 5d8dd48184..0000000000
--- a/mergetools/bc3
+++ /dev/null
@@ -1 +0,0 @@
-. "$MERGE_TOOLS_DIR/bc"
diff --git a/mergetools/gvimdiff2 b/mergetools/gvimdiff2
deleted file mode 100644
index 04a5bb0ea8..0000000000
--- a/mergetools/gvimdiff2
+++ /dev/null
@@ -1 +0,0 @@
-. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/gvimdiff3 b/mergetools/gvimdiff3
deleted file mode 100644
index 04a5bb0ea8..0000000000
--- a/mergetools/gvimdiff3
+++ /dev/null
@@ -1 +0,0 @@
-. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/vimdiff b/mergetools/vimdiff
index 10d86f3e19..3925e1fc3e 100644
--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -46,3 +46,11 @@ translate_merge_tool_path() {
 exit_code_trustable () {
 	true
 }
+
+list_tool_variants () {
+	for prefix in '' g; do
+		for suffix in '' 2 3; do
+			echo "${prefix}vimdiff${suffix}"
+		done
+	done
+}
diff --git a/mergetools/vimdiff2 b/mergetools/vimdiff2
deleted file mode 100644
index 04a5bb0ea8..0000000000
--- a/mergetools/vimdiff2
+++ /dev/null
@@ -1 +0,0 @@
-. "$MERGE_TOOLS_DIR/vimdiff"
diff --git a/mergetools/vimdiff3 b/mergetools/vimdiff3
deleted file mode 100644
index 04a5bb0ea8..0000000000
--- a/mergetools/vimdiff3
+++ /dev/null
@@ -1 +0,0 @@
-. "$MERGE_TOOLS_DIR/vimdiff"
-- 
2.28.0

