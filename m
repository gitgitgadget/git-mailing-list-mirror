Return-Path: <SRS0=m+L4=A6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE7FC433DF
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 04:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC89A2076A
	for <git@archiver.kernel.org>; Sun, 19 Jul 2020 04:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skylittlesystem-org.20150623.gappssmtp.com header.i=@skylittlesystem-org.20150623.gappssmtp.com header.b="JWJrWt8M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgGSEZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jul 2020 00:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgGSEZz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jul 2020 00:25:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20639C0619D2
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 21:25:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q5so14724132wru.6
        for <git@vger.kernel.org>; Sat, 18 Jul 2020 21:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skylittlesystem-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k1p6TLPLnsU+yZf9ty2/EWyq8QldAftstvlqV0pCMlQ=;
        b=JWJrWt8Mc3PP1jUnkh9ED/M7jMW9iGCKnAQhbyi9oYCNWm3cURHFhWd1NHmjpIpIxQ
         PJwDlez5JnaPEdzmjFEm9+RxKG1CnzuXGlEP8rappZd9Xm4QCVteOHvfk5HzHQ6zpPde
         eQfKcojAjg+UjDGw1hTEpes9vIGblHwwKQGnHnl8iMFRJgBeuEZmMq6A0kdUF7iP/7mi
         IxatGOK/yVhNbJcgixpx1c5Tnn6kaY4yeQLdkQps1EkgaT1upgg4/OX9TeDfiB15lUZb
         AqPyM5S5d4FMIXAXamyYXuXoM4M10xnSofyfi3cvhp11szxv7hmopLEbn9sXbOXX/mE/
         K9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k1p6TLPLnsU+yZf9ty2/EWyq8QldAftstvlqV0pCMlQ=;
        b=WGkZToWx2uI5EUZvvHrqdBDviQKfrCmk+GoeeDt/UTasSZ0FO2h+O+C3ITQqqYp94x
         JUmeUSfL85DrHhwhn/uSkwF7dOX3oD8QYLnSfYXs+ICqZ7zwAf9XtTusmZj0IpcDajfV
         DNK8CYe+3jLDWN8mFU5UvzhEiaOpqhm5yGioY0jdzLhixY6MkCWU5BoW6QAU7D+07Ecd
         s0ufY3nzvuW8GA4D6vAygeA5d1MNhh3Mpjnf8SD440/FnRnrY1pfSmTs9R/UwIl+JxAv
         1IE7LIDDxpUXCWhWS1g4/I2B+sUTe3ARqiEQqE+FjpTTw9KxP1t3nDsbItcbjDq/Ghd8
         Qaig==
X-Gm-Message-State: AOAM531pp7uqllMfdyzdcb8Td7W6NydTI0n1jvjHffgBcgi1I7q46031
        l6CU+QKVGObYTk2EXUUjh6NLzsu592w=
X-Google-Smtp-Source: ABdhPJxejdfIScPqwS5P3Ljy+3HWkxFi/UWC7cO+OmPH0Gf0bUAllWA0KrB0/+WexzM0qKNU46dWxQ==
X-Received: by 2002:adf:c185:: with SMTP id x5mr18062582wre.403.1595132753297;
        Sat, 18 Jul 2020 21:25:53 -0700 (PDT)
Received: from localhost.localdomain (cpc110667-lewi19-2-0-cust284.2-4.cable.virginm.net. [80.7.253.29])
        by smtp.gmail.com with ESMTPSA id z16sm23571965wrr.35.2020.07.18.21.25.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 21:25:52 -0700 (PDT)
From:   pudinha <rogi@skylittlesystem.org>
To:     git@vger.kernel.org
Cc:     pudinha <rogi@skylittlesystem.org>
Subject: [PATCH v2 1/2] Refactor vimdiff and bc merge tool variants
Date:   Sun, 19 Jul 2020 05:23:37 +0100
Message-Id: <20200719042335.3913-2-rogi@skylittlesystem.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200718192001.27434-1-rogi@skylittlesystem.org>
References: <20200718192001.27434-1-rogi@skylittlesystem.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The merge tools vimdiff2, vimdiff3, gvimdiff2, gvimdiff3 and bc3 are all
variants of the main tools vimdiff and bc. They are implemented in the
main and a one-liner script that just sources it exist for each.

This patch allows variants ending in [0-9] to be correctly wired without
the need for such one-liners, so instead of 5 scripts, only 1 (gvimdiff)
is needed.
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
2.27.0

