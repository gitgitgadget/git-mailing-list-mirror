Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BE0C43334
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbiF1KGg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiF1KG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:28 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF82E9E1
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:22 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n1so16877866wrg.12
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c61ciYxPKYhdTlmclwFq+h1XrzaT0dRndfQht84ZoWU=;
        b=A2NCKLqfalQzWvFsOfhflKp/Bf1JpRfIiP67ePYpVn/Gx9dHNIuEN7HCdSFFaDxlKr
         vsOQBwTfWwfoTflZ52whP9IOHdX0ytaZzHJRJ/8kLxR6bzPAtyHu9urhsMKqO8Ta1dk7
         W4xVKuw0CXLoU/PFEDK+xpg3rr14RVVf1wZeeKzoVlo3VvjoKaiRpbJF1AeZDqEUMbjL
         JAliZI/C1dXnc3it8TJCQGDrngSrkoUz4A7qLocs7OlHph2Kr9GW2gLCTTDuOdJixTDo
         Ra/U9iEltybFmFGKat1oMAWNpgpDqSimMibTBLn2GKPQpP4spbOLDRe1VZywccgue7FN
         1zgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c61ciYxPKYhdTlmclwFq+h1XrzaT0dRndfQht84ZoWU=;
        b=YEHYh66sqorGd7jpZuhtn/ZMpijz5PAaWrGBy+PweUo0OuQUIN4I1lYAW4AGcBKxA7
         NC1C9DVYj7h9BV6fZ8yWTVj358ODu9Cl+JPbu+tZ0z5EEGKmI1Itt/M5U+H8Y4/hHD5O
         w9J0czhemi9jKqVV2HwYA2yVMQuxMpXveEGDBVDR7+9lv+AyzBAVnr6yD43zL5RnnsdQ
         gVVRo48LwTUCdn7ZhFug95cBlZOZSElXET3qKqXzs40DiwDQ2y47KMs8FxgHiygLVubo
         uE4T2m1wgynbFEZdxgQmsvSkBEVA7NFzM0wvLdYhGlbe7ESJOf0dRwHopUguMu1CRYY9
         +9BA==
X-Gm-Message-State: AJIora8ABxi8MyQpBSwFM7RsZ83mdanb4gtU7dCw+BX7uMEoi8P/Ngxy
        Baqs9gvq4Hv5D731Hn5b8tgspYGX77e8WA==
X-Google-Smtp-Source: AGRyM1vNdevjf1GTfp5Roej6O2Ip8WHt0Bn/x23UdbcvwGLXbL5O0rtRgZcUhzTKP7WZmnXhN6ykCg==
X-Received: by 2002:adf:e196:0:b0:219:f3c7:fd88 with SMTP id az22-20020adfe196000000b00219f3c7fd88mr16500311wrb.402.1656410780616;
        Tue, 28 Jun 2022 03:06:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 12/12] git-sh-setup.sh: remove "say" function, change last users
Date:   Tue, 28 Jun 2022 12:05:34 +0200
Message-Id: <patch-v4-12.12-f8f332f3c0a-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "say" function, with various rewrites of the remaining
git-*.sh code to C and the preceding change to have git-submodule.sh
stop using the GIT_QUIET variable there were only four uses in
git-subtree.sh. Let's have it use an "arg_quiet" variable instead, and
move the "say" function over to it.

The only other use was a trivial message in git-instaweb.sh, since it
has never supported the --quiet option (or similar) that code added in
0b624b4ceee (instaweb: restart server if already running, 2009-11-22)
can simply use "echo" instead.

The remaining in-tree hits from "say" are all for the sibling function
defined in t/test-lib.sh. It's safe to remove this function since it
has never been documented in Documentation/git-sh-setup.txt.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/subtree/git-subtree.sh | 15 ++++++++++++---
 git-instaweb.sh                |  2 +-
 git-sh-setup.sh                |  9 ---------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 1af1d9653e9..7562a395c24 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -50,6 +50,14 @@ m,message=    use the given message as the commit message for the merge commit
 
 indent=0
 
+# Usage: say [MSG...]
+say () {
+	if test -z "$arg_quiet"
+	then
+		printf '%s\n' "$*"
+	fi
+}
+
 # Usage: debug [MSG...]
 debug () {
 	if test -n "$arg_debug"
@@ -60,7 +68,7 @@ debug () {
 
 # Usage: progress [MSG...]
 progress () {
-	if test -z "$GIT_QUIET"
+	if test -z "$arg_quiet"
 	then
 		if test -z "$arg_debug"
 		then
@@ -146,6 +154,7 @@ main () {
 	eval "$set_args"
 
 	# Begin "real" flag parsing.
+	arg_quiet=
 	arg_debug=
 	arg_prefix=
 	arg_split_branch=
@@ -161,7 +170,7 @@ main () {
 
 		case "$opt" in
 		-q)
-			GIT_QUIET=1
+			arg_quiet=1
 			;;
 		-d)
 			arg_debug=1
@@ -252,7 +261,7 @@ main () {
 	dir="$(dirname "$arg_prefix/.")"
 
 	debug "command: {$arg_command}"
-	debug "quiet: {$GIT_QUIET}"
+	debug "quiet: {$arg_quiet}"
 	debug "dir: {$dir}"
 	debug "opts: {$*}"
 	debug
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 4349566c891..c68f49454cd 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -102,7 +102,7 @@ resolve_full_httpd () {
 
 start_httpd () {
 	if test -f "$fqgitdir/pid"; then
-		say "Instance already running. Restarting..."
+		echo "Instance already running. Restarting..."
 		stop_httpd
 	fi
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ecb60d9e3cb..ce273fe0e48 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -57,15 +57,6 @@ die_with_status () {
 	exit "$status"
 }
 
-GIT_QUIET=
-
-say () {
-	if test -z "$GIT_QUIET"
-	then
-		printf '%s\n' "$*"
-	fi
-}
-
 if test -n "$OPTIONS_SPEC"; then
 	usage() {
 		"$0" -h
-- 
2.37.0.880.gf07d56b18ba

