From: ted@tedpavlic.com
Subject: [PATCH 3/3] bash-completion: Added comments to remind about required arguments
Date: Wed, 14 Jan 2009 15:02:22 -0500
Message-ID: <1231963342-24461-3-git-send-email-ted@tedpavlic.com>
References: <1231963342-24461-1-git-send-email-ted@tedpavlic.com>
 <1231963342-24461-2-git-send-email-ted@tedpavlic.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
	Ted Pavlic <ted@tedpavlic.com>
To: spearce@spearce.org
X-From: git-owner@vger.kernel.org Wed Jan 14 21:04:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNBy4-0006wS-JX
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 21:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180AbZANUCh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 15:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755058AbZANUCf
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 15:02:35 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:36008 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754691AbZANUCe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jan 2009 15:02:34 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id 3216980D806E;
	Wed, 14 Jan 2009 14:56:48 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FCusNlj7Cpdo; Wed, 14 Jan 2009 14:56:48 -0500 (EST)
Received: from localhost.localdomain (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id EDE6C80D80B2;
	Wed, 14 Jan 2009 14:56:47 -0500 (EST)
X-Mailer: git-send-email 1.6.1.87.g15624
In-Reply-To: <1231963342-24461-2-git-send-email-ted@tedpavlic.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105691>

From: Ted Pavlic <ted@tedpavlic.com>

  Adds a few simple comments above commands that take arguments. These
  comments are meant to remind developers of potential problems that can
  occur when the script is sourced on systems with "set -u." Any
  function which "requires" arguments really ought to be called with
  explicit arguments given.

  Also adds a #!bash to the top of bash completions so that editing
  software can always identify that the file is of sh type.

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
---
 contrib/completion/git-completion.bash |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 201f9a6..f8b845a 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1,3 +1,4 @@
+#!bash
 #
 # bash completion support for core Git.
 #
@@ -50,6 +51,8 @@ case "$COMP_WORDBREAKS" in
 *)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
 esac
 
+# __gitdir accepts 0 or 1 arguments (i.e., location)
+# returns location of .git repo
 __gitdir ()
 {
 	if [ -z "${1-}" ]; then
@@ -67,6 +70,8 @@ __gitdir ()
 	fi
 }
 
+# __git_ps1 accepts 0 or 1 arguments (i.e., format string)
+# returns text to add to bash PS1 prompt (includes branch name)
 __git_ps1 ()
 {
 	local g="$(git rev-parse --git-dir 2>/dev/null)"
@@ -119,6 +124,7 @@ __git_ps1 ()
 	fi
 }
 
+# __gitcomp_1 requires 2 arguments
 __gitcomp_1 ()
 {
 	local c IFS=' '$'\t'$'\n'
@@ -131,6 +137,8 @@ __gitcomp_1 ()
 	done
 }
 
+# __gitcomp accepts 1, 2, 3, or 4 arguments
+# generates completion reply with compgen
 __gitcomp ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -150,6 +158,7 @@ __gitcomp ()
 	esac
 }
 
+# __git_heads accepts 0 or 1 arguments (to pass to __gitdir)
 __git_heads ()
 {
 	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
@@ -168,6 +177,7 @@ __git_heads ()
 	done
 }
 
+# __git_tags accepts 0 or 1 arguments (to pass to __gitdir)
 __git_tags ()
 {
 	local cmd i is_hash=y dir="$(__gitdir "${1-}")"
@@ -186,6 +196,7 @@ __git_tags ()
 	done
 }
 
+# __git_refs accepts 0 or 1 arguments (to pass to __gitdir)
 __git_refs ()
 {
 	local i is_hash=y dir="$(__gitdir "${1-}")"
@@ -218,6 +229,7 @@ __git_refs ()
 	done
 }
 
+# __git_refs2 requires 1 argument (to pass to __git_refs)
 __git_refs2 ()
 {
 	local i
@@ -226,6 +238,7 @@ __git_refs2 ()
 	done
 }
 
+# __git_refs_remotes requires 1 argument (to pass to ls-remote)
 __git_refs_remotes ()
 {
 	local cmd i is_hash=y
@@ -470,6 +483,7 @@ __git_aliases ()
 	done
 }
 
+# __git_aliased_command requires 1 argument
 __git_aliased_command ()
 {
 	local word cmdline=$(git --git-dir="$(__gitdir)" \
@@ -482,6 +496,7 @@ __git_aliased_command ()
 	done
 }
 
+# __git_find_subcommand requires 1 argument
 __git_find_subcommand ()
 {
 	local word subcommand c=1
-- 
1.6.1.87.g15624
