Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12842C76196
	for <git@archiver.kernel.org>; Sat,  1 Apr 2023 08:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjDAIt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Apr 2023 04:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjDAItM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2023 04:49:12 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE9E24AC9
        for <git@vger.kernel.org>; Sat,  1 Apr 2023 01:47:36 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id n6-20020a4abd06000000b0053b59893660so3893004oop.0
        for <git@vger.kernel.org>; Sat, 01 Apr 2023 01:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680338855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FboxFHXAvuHAXLLLcpnPIgT5TfNRdtF5ghQt1JU/Hsk=;
        b=JHEbmOlKahCbZcSXY8pZR1PWyX9k5tVxTehHJrl+fdMJE5aUqKqY8bvtHjYA7RmskK
         Bfb5gmoU6vEskANodcJgPJNkEtvKhJ2mMTltSvXbh+jtJQY41jtrgvz4HfULkCNUBWGO
         N9XJhMxN9fD1MM+E1y7/rdfcq9z6HLdCR1UL9cNPkU13cZ49Fdcyn/PC/vPza/4/po8P
         a4Ny6VRWBvJyclvjrN8f2enhhbH9hytZgf6aEjAvJsBjin87b9MGACYIaI60Jdrgl8FF
         ax5Q8cS0n+vI40vge3u/EcD5RxL61g2/k3JL2iEEBcQ2uQdfiAxXqhvzKK09DP4RMejX
         qHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680338855;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FboxFHXAvuHAXLLLcpnPIgT5TfNRdtF5ghQt1JU/Hsk=;
        b=CgPpRk3ssD1txrFRN40LUfZJHTwxBRihYg1lRx9qEsbiDk2DNtUWVThNElYkJtKppn
         nARqt02OWi3Rz2t3DEAORqUcxO/cfxxfhXYCXhh9SwyJnV4IDnrtmPXJTtzOc/TzgPUY
         VpT6rMsZC0tgXMnLi7QzkEemttUdeEkO4b0+D3Q/L4ThEb4eMtDL0YLlxzzU6K5w/rfS
         nRCdII0EhyFBOUfB0wXA17yLNV6VB4oUyuYEqqmuvMSjrBQfRgFvqnBEYHGrPy1PxANH
         eHj7Dvu8dyQ6EfmZwJ2GQc6qpaM9OoHKe4E6ASu7bRhhKBUAJ+sDEB1+SCZnfFXwjntx
         CSHg==
X-Gm-Message-State: AAQBX9fVY93A0oPV+E0IGalYesbjjNRTYgGHkkoc+gD/xEmKFpiVt64g
        hQJmlLOol8IcUjUDS1HJQ6GxEgkM1Mo=
X-Google-Smtp-Source: AKy350beyBr9EdJRPvLlQlyU8m3ufz2SR8AIhfxJ1hhX6nfqKpJKgObJ/fejSpIzranqS5xX2aThSQ==
X-Received: by 2002:a4a:e591:0:b0:53e:1b5f:1b63 with SMTP id o17-20020a4ae591000000b0053e1b5f1b63mr5469074oov.0.1680338855026;
        Sat, 01 Apr 2023 01:47:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k125-20020acaba83000000b003876369bd0asm1867296oif.19.2023.04.01.01.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Apr 2023 01:47:34 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 49/49] completion: bash: rename _get_comp_words_by_ref()
Date:   Sat,  1 Apr 2023 02:46:26 -0600
Message-Id: <20230401084626.304356-50-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230401084626.304356-1-felipe.contreras@gmail.com>
References: <20230401084626.304356-1-felipe.contreras@gmail.com>
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
index 912e9bace0..b36db3f845 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -318,98 +318,6 @@ __git_dequote ()
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
@@ -3497,10 +3405,102 @@ if [[ -n ${ZSH_VERSION-} && -z ${GIT_SOURCING_ZSH_COMPLETION-} ]]; then
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
index fdc81d5d3f..18f88133de 100755
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
2.33.0

