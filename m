Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDA6ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiH3Jfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbiH3Jen (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:34:43 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB76CE42D8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:11 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11f0fa892aeso7095327fac.7
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=1RE2RSEEhghTXbkXOzED//6m4mPFHl54s/c/PBl1dFU=;
        b=QHLceer1LM20xD/Tj/MDUoKtfxRfprqS9XAwy5TzXdkproKmfSnK6t6NqRWnVWVi8i
         MaN9GWrESeFDDGRxXVXV9lmCvjPwjdgL9ECzETfm/vzdVLpmz0INVnRhY+3z64r/h8W7
         V8d5mfKEKAIbNDqQa7E0vsGma4VH+avA0WHsRPyoR8Yf9RqPSRCYzdojBTxlwZtCfZYm
         EROmvdcZ4puh6UykGku5L7cLCzgqUZn9UzG8N95+sqz3/dBMvw2Rbw8ZwVgMQDPS7GG5
         zcKFW7t4hzsuesJoWis9+h/FDq2Yo9ygpivTIo+P7NZcmM0shvseT4TEG95sxzQFhTJc
         BmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=1RE2RSEEhghTXbkXOzED//6m4mPFHl54s/c/PBl1dFU=;
        b=1aIUMo/SFYbe5IDjLoY6OwVYkJ8uz94GyPjmHF8MrpzvWy3aQOxlF0xAGwSWzN4FEO
         OTjtythbLvaRZmTIUsnAoRIqh+Z6d2TIo8pvdBr3yEAZGoegCIFeZV8eIUyown3hSrl6
         U50ybLx4LKCCdBDN0IBi0KwVH0Lja8qen3fUX6CUexh2ooSTMPrQmUM3f3DI/HtI6rvL
         h6pQG2pYRmlp4bBHhu7n7WBU+NE/e3DjXCRYqSgYEW0zAdc7Y/2TmkNp8ukR+cTf+uld
         sUBdROUCvCXhoJG5KMVO/ejzQZq7lt2JGZF+xmS8YIL2UYifNR4rM2+PcJLgOzWzMCj3
         hLlg==
X-Gm-Message-State: ACgBeo3bb4e5Sd6dcdDeAaUH5kMw3QZdUQyMSITNcEIK1z1DU/CUccBf
        FlzPXpYmTIT14NtISxvm9HHdkoUAi3Y=
X-Google-Smtp-Source: AA6agR5dhMRPMgwwDZHe8G6FsCHsaREzXgV3dzIiPOQ2001YJDMxri2jjxWHV5Wrd6bFBD2wlCav6g==
X-Received: by 2002:a05:6870:51ca:b0:11b:98fa:432b with SMTP id b10-20020a05687051ca00b0011b98fa432bmr9790535oaj.109.1661851984415;
        Tue, 30 Aug 2022 02:33:04 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o32-20020a05687107a000b0011e37fb5493sm7583570oap.30.2022.08.30.02.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:33:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 49/51] completion: bash: rename _get_comp_words_by_ref()
Date:   Tue, 30 Aug 2022 04:31:36 -0500
Message-Id: <20220830093138.1581538-50-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's only used in one place, rename it, and use it even if
bash-completion's more inefficient version of _get_comp_words_by_ref()
is available.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 186 ++++++++++++-------------
 t/t9902-completion.sh                  |   2 +-
 2 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 395a356106..77a475e272 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -312,98 +312,6 @@ __git_dequote ()
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
 # Clear the variables caching builtins' options when (re-)sourcing
 # the completion script.
 if [[ -n ${ZSH_VERSION-} ]]; then
@@ -3477,10 +3385,102 @@ if [[ -n ${ZSH_VERSION-} && -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
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
+if ! type __git_get_comp_words_by_ref >/dev/null 2>&1; then
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
+fi
+
 __git_func_wrap ()
 {
 	local cur words cword prev __git_cmd_idx=0
-	_get_comp_words_by_ref -n =: cur words cword prev
+	__git_get_comp_words_by_ref
 	$1
 }
 
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index fc09bafa07..fff8451716 100755
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
2.37.2.351.g9bf691b78c.dirty

