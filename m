From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 2/4] completion: Use consistent if [...] convention. No test.
Date: Wed, 11 Feb 2009 13:03:24 -0500
Message-ID: <1234375406-27099-3-git-send-email-ted@tedpavlic.com>
References: <1234375406-27099-1-git-send-email-ted@tedpavlic.com>
 <1234375406-27099-2-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Feb 11 19:06:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXJT8-0007U8-16
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 19:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757584AbZBKSDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 13:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757666AbZBKSDk
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 13:03:40 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:52785 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750730AbZBKSDi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2009 13:03:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id DFBDA80D808E;
	Wed, 11 Feb 2009 12:57:06 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ez8HxmW2pG0N; Wed, 11 Feb 2009 12:57:06 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id AC97280D808B;
	Wed, 11 Feb 2009 12:57:06 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.390.gba743
In-Reply-To: <1234375406-27099-2-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The local coding convention in bash completion is to use [...] rather
than test. Additionally,

    if [...]; then

is preferred over

    if [...]
    then

and so matching "if [...]\nthen" were changed accordingly.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
 contrib/completion/git-completion.bash |   31 +++++++++++--------------------
 1 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6bbe09a..7706170 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -84,39 +84,30 @@ __git_ps1 ()
 	if [ -n "$g" ]; then
 		local r
 		local b
-		if [ -d "$g/rebase-apply" ]
-		then
-			if test -f "$g/rebase-apply/rebasing"
-			then
+		if [ -d "$g/rebase-apply" ]; then
+			if [ -f "$g/rebase-apply/rebasing" ]; then
 				r="|REBASE"
-			elif test -f "$g/rebase-apply/applying"
-			then
+            elif [ -f "$g/rebase-apply/applying" ]; then
 				r="|AM"
 			else
 				r="|AM/REBASE"
 			fi
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
-		elif [ -f "$g/rebase-merge/interactive" ]
-		then
+		elif [ -f "$g/rebase-merge/interactive" ]; then
 			r="|REBASE-i"
 			b="$(cat "$g/rebase-merge/head-name")"
-		elif [ -d "$g/rebase-merge" ]
-		then
+		elif [ -d "$g/rebase-merge" ]; then
 			r="|REBASE-m"
 			b="$(cat "$g/rebase-merge/head-name")"
-		elif [ -f "$g/MERGE_HEAD" ]
-		then
+		elif [ -f "$g/MERGE_HEAD" ]; then
 			r="|MERGING"
 			b="$(git symbolic-ref HEAD 2>/dev/null)"
 		else
-			if [ -f "$g/BISECT_LOG" ]
-			then
+			if [ -f "$g/BISECT_LOG" ]; then
 				r="|BISECTING"
 			fi
-			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
-			then
-				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"
-				then
+			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"; then
+				if ! b="$(git describe --exact-match HEAD 2>/dev/null)"; then
 					b="$(cut -c1-7 "$g/HEAD")..."
 				fi
 			fi
@@ -125,8 +116,8 @@ __git_ps1 ()
 		local w
 		local i
 
-		if test -n "${GIT_PS1_SHOWDIRTYSTATE-}"; then
-			if test "$(git config --bool bash.showDirtyState)" != "false"; then
+		if [ -n "${GIT_PS1_SHOWDIRTYSTATE-}" ]; then
+			if [ "$(git config --bool bash.showDirtyState)" != "false" ]; then
 				git diff --no-ext-diff --ignore-submodules \
 					--quiet --exit-code || w="*"
 				if git rev-parse --quiet --verify HEAD >/dev/null; then
-- 
1.6.1.2.390.gba743
