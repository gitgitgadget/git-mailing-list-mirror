Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5A7C4742C
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C2620825
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs5p5F5J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbgKDRrj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730805AbgKDRrh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:37 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68EC0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:36 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id m143so13695728oig.7
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZSEo5aeV0sJZOZP2IvzEgVHSf/5Q3duWx5U/yZ1p6g=;
        b=Cs5p5F5J6Ai4oxoGEVs1bwpc0dl86h9vcP50X5MVI/qj2zgA7AjKMcjXngdXfZbEly
         jKJwv5UH+2/S76J3T9bqwLYVySyRmYJbnx3pPQc+BT0vTJpKZoy//as4Bg/8oqAu4Biu
         lUIqoWlFMohE93aOJR0v3jgwgCIiSRZKTW8VWDvVwYWYzDYPUFltf1DECTvIvxVSsM1g
         3OJhQUjsMVteQT1AIb3aH/s9TbPq3KzOUqGb0wJ+kL9uzlGqTokfZ4k/CM0DA9Yc/7CG
         PEg0d2Ijl6rr0UOKXvHHJX6CakkfEbOHyatUe0vorOcWR85VK5lQNUYsmSgkYgiE/qPO
         JBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kZSEo5aeV0sJZOZP2IvzEgVHSf/5Q3duWx5U/yZ1p6g=;
        b=Cczu9DvIVwsrQanAQX9Tiyc0VRMCgJoR4ObXNKvIRHnIvX2lXTo4Xe2yXsqNpIQwb4
         hdHoFc8gzE6fUTiMZMuUqYDPCqcS7E3Ay9qfnkpB7WrLbEkKMgU0mv985DzslZjCPqMV
         RY0FwkZm0CEu+/ArreHWIPADkmbdiX4W7mx7Y9ab9F/H8W7NYSoHTMMr3+Fvws7pPcq1
         r/tjMMFq1oNmJpgb9ohXGk/R+Jq5tOcXoEOfVYBsr52hVSqkYhUeOfpq27p/eUjG2oJT
         VihmMf80VuQNa/vZj2Ns4n/CFtySanxMVKnN6Xj3Yz6nY4f8u+3rPkbkmg3ZJv6hTCun
         wDnQ==
X-Gm-Message-State: AOAM533RN7EvzDL254ciH6B/BY4VuZDcR4DdRikAY76jFpKAbIpHUjJw
        dMsgdgNn4PndkK+FOuo5Q6258OGDpTbmGg==
X-Google-Smtp-Source: ABdhPJw1HCMxn9YjEtREnZtfDx0gl3GJUcpagZSW6TiKbmqmXefIfjuAN8D9HMUY4/uc90GnCU0tpw==
X-Received: by 2002:aca:4b82:: with SMTP id y124mr3124258oia.35.1604512055841;
        Wed, 04 Nov 2020 09:47:35 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u16sm453045ooj.8.2020.11.04.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:35 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/10] completion: bash: move _get_comp_words_by_ref()
Date:   Wed,  4 Nov 2020 11:47:16 -0600
Message-Id: <20201104174716.783348-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's only used in one place, rename it, and use it even if
bash-completion's inefficient and buggy _get_comp_words_by_ref() is
available.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 184 ++++++++++++-------------
 t/t9902-completion.sh                  |   2 +-
 2 files changed, 92 insertions(+), 94 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b4e6f82c66..e0e44bdf75 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -159,98 +159,6 @@ __git_dequote ()
 	done
 }
 
-# The following function is based on code from:
-#
-#   bash_completion - programmable completion functions for bash 3.2+
-#
-#   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>
-#             © 2009-2010, Bash Completion Maintainers
-#                     <bash-completion-devel@lists.alioth.debian.org>
-#
-#   This program is free software; you can redistribute it and/or modify
-#   it under the terms of the GNU General Public License as published by
-#   the Free Software Foundation; either version 2, or (at your option)
-#   any later version.
-#
-#   This program is distributed in the hope that it will be useful,
-#   but WITHOUT ANY WARRANTY; without even the implied warranty of
-#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#   GNU General Public License for more details.
-#
-#   You should have received a copy of the GNU General Public License
-#   along with this program; if not, see <http://www.gnu.org/licenses/>.
-#
-#   The latest version of this software can be obtained here:
-#
-#   http://bash-completion.alioth.debian.org/
-#
-#   RELEASE: 2.x
-
-# This function reorganizes the words on the command line to be processed by
-# the rest of the script.
-#
-# This is roughly equivalent to going back in time and setting
-# COMP_WORDBREAKS to exclude '=' and ':'.  The intent is to
-# make option types like --date=<type> and <rev>:<path> easy to
-# recognize by treating each shell word as a single token.
-#
-# It is best not to set COMP_WORDBREAKS directly because the value is
-# shared with other completion scripts.  By the time the completion
-# function gets called, COMP_WORDS has already been populated so local
-# changes to COMP_WORDBREAKS have no effect.
-
-if ! type _get_comp_words_by_ref >/dev/null 2>&1; then
-_get_comp_words_by_ref ()
-{
-	local exclude i j first
-
-	# Which word separators to exclude?
-	exclude="${COMP_WORDBREAKS//[^=:]}"
-	cword=$COMP_CWORD
-	if [ -n "$exclude" ]; then
-		# List of word completion separators has shrunk;
-		# re-assemble words to complete.
-		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
-			# Append each nonempty word consisting of just
-			# word separator characters to the current word.
-			first=t
-			while
-				[ $i -gt 0 ] &&
-				[ -n "${COMP_WORDS[$i]}" ] &&
-				# word consists of excluded word separators
-				[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
-			do
-				# Attach to the previous token,
-				# unless the previous token is the command name.
-				if [ $j -ge 2 ] && [ -n "$first" ]; then
-					((j--))
-				fi
-				first=
-				words[$j]=${words[j]}${COMP_WORDS[i]}
-				if [ $i = $COMP_CWORD ]; then
-					cword=$j
-				fi
-				if (($i < ${#COMP_WORDS[@]} - 1)); then
-					((i++))
-				else
-					# Done.
-					break 2
-				fi
-			done
-			words[$j]=${words[j]}${COMP_WORDS[i]}
-			if [ $i = $COMP_CWORD ]; then
-				cword=$j
-			fi
-		done
-	else
-		words=("${COMP_WORDS[@]}")
-	fi
-
-	cur=${words[cword]}
-	prev=${words[cword-1]}
-}
-fi
-
 # Appends prefiltered words to COMPREPLY without any additional processing.
 # Callers must take care of providing only words that match the current word
 # to be completed and adding any prefix and/or suffix (trailing space!), if
@@ -3474,10 +3382,100 @@ if [[ -n ${ZSH_VERSION-} ]] &&
 	return
 fi
 
+# The following function is based on code from:
+#
+#   bash_completion - programmable completion functions for bash 3.2+
+#
+#   Copyright © 2006-2008, Ian Macdonald <ian@caliban.org>
+#             © 2009-2010, Bash Completion Maintainers
+#                     <bash-completion-devel@lists.alioth.debian.org>
+#
+#   This program is free software; you can redistribute it and/or modify
+#   it under the terms of the GNU General Public License as published by
+#   the Free Software Foundation; either version 2, or (at your option)
+#   any later version.
+#
+#   This program is distributed in the hope that it will be useful,
+#   but WITHOUT ANY WARRANTY; without even the implied warranty of
+#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#   GNU General Public License for more details.
+#
+#   You should have received a copy of the GNU General Public License
+#   along with this program; if not, see <http://www.gnu.org/licenses/>.
+#
+#   The latest version of this software can be obtained here:
+#
+#   http://bash-completion.alioth.debian.org/
+#
+#   RELEASE: 2.x
+
+# This function reorganizes the words on the command line to be processed by
+# the rest of the script.
+#
+# This is roughly equivalent to going back in time and setting
+# COMP_WORDBREAKS to exclude '=' and ':'.  The intent is to
+# make option types like --date=<type> and <rev>:<path> easy to
+# recognize by treating each shell word as a single token.
+#
+# It is best not to set COMP_WORDBREAKS directly because the value is
+# shared with other completion scripts.  By the time the completion
+# function gets called, COMP_WORDS has already been populated so local
+# changes to COMP_WORDBREAKS have no effect.
+
+__git_get_comp_words_by_ref ()
+{
+	local exclude i j first
+
+	# Which word separators to exclude?
+	exclude="${COMP_WORDBREAKS//[^=:]}"
+	cword=$COMP_CWORD
+	if [ -n "$exclude" ]; then
+		# List of word completion separators has shrunk;
+		# re-assemble words to complete.
+		for ((i=0, j=0; i < ${#COMP_WORDS[@]}; i++, j++)); do
+			# Append each nonempty word consisting of just
+			# word separator characters to the current word.
+			first=t
+			while
+				[ $i -gt 0 ] &&
+				[ -n "${COMP_WORDS[$i]}" ] &&
+				# word consists of excluded word separators
+				[ "${COMP_WORDS[$i]//[^$exclude]}" = "${COMP_WORDS[$i]}" ]
+			do
+				# Attach to the previous token,
+				# unless the previous token is the command name.
+				if [ $j -ge 2 ] && [ -n "$first" ]; then
+					((j--))
+				fi
+				first=
+				words[$j]=${words[j]}${COMP_WORDS[i]}
+				if [ $i = $COMP_CWORD ]; then
+					cword=$j
+				fi
+				if (($i < ${#COMP_WORDS[@]} - 1)); then
+					((i++))
+				else
+					# Done.
+					break 2
+				fi
+			done
+			words[$j]=${words[j]}${COMP_WORDS[i]}
+			if [ $i = $COMP_CWORD ]; then
+				cword=$j
+			fi
+		done
+	else
+		words=("${COMP_WORDS[@]}")
+	fi
+
+	cur=${words[cword]}
+	prev=${words[cword-1]}
+}
+
 __git_func_wrap ()
 {
 	local cur words cword prev
-	_get_comp_words_by_ref -n =: cur words cword prev
+	__git_get_comp_words_by_ref
 	$1
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index bc18bd4b68..b8dfeb82bf 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -38,7 +38,7 @@ GIT_TESTING_PORCELAIN_COMMAND_LIST='add checkout rebase'
 # We don't need this function to actually join words or do anything special.
 # Also, it's cleaner to avoid touching bash's internal completion variables.
 # So let's override it with a minimal version for testing purposes.
-_get_comp_words_by_ref ()
+__git_get_comp_words_by_ref ()
 {
 	cword=$_cword
 	cur=${_words[cword]}
-- 
2.29.2

