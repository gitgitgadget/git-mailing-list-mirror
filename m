From: Ted Pavlic <ted@tedpavlic.com>
Subject: [PATCH 3/3] Adds a #!bash to the top of bash completions so that
 editors can recognize, it as a bash script. Also adds a few simple comments
 above commands that, take arguments. The comments are meant to remind editors
 of potential, problems that can occur when the script is sourced on systems
 with "set, -u."
Date: Tue, 13 Jan 2009 11:11:03 -0500
Message-ID: <496CBD17.3000207@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 13 17:12:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMlsW-0006X1-RQ
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 17:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbZAMQLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 11:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752124AbZAMQLH
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 11:11:07 -0500
Received: from gallifrey.ece.ohio-state.edu ([164.107.167.66]:45393 "EHLO
	gallifrey.ece.ohio-state.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751914AbZAMQLG (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jan 2009 11:11:06 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id C9A6680D8038;
	Tue, 13 Jan 2009 11:05:21 -0500 (EST)
X-Virus-Scanned: amavisd-new at gallifrey.ece.ohio-state.edu
Received: from gallifrey.ece.ohio-state.edu ([127.0.0.1])
	by localhost (gallifrey.ece.ohio-state.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YOBOPKjAoHPv; Tue, 13 Jan 2009 11:05:21 -0500 (EST)
Received: from tedbook.mshome.net (tedpc.ece.ohio-state.edu [164.107.164.122])
	by gallifrey.ece.ohio-state.edu (Postfix) with ESMTP id AEF0E80D801B;
	Tue, 13 Jan 2009 11:05:21 -0500 (EST)
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8) Gecko/20051201 Thunderbird/1.5 Mnenhy/0.7.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105506>


Third in a series of patches that make bash completions more robust to
different interactive shell configurations and editors.

[PATCH 3/3] Adds a #!bash to the top of bash completions so that editors 
can recognize
  it as a bash script. Also adds a few simple comments above commands that
  take arguments. The comments are meant to remind editors of potential
  problems that can occur when the script is sourced on systems with "set
  -u."

Signed-off-by: Ted Pavlic <ted@tedpavlic.com>
---
  contrib/completion/git-completion.bash |   15 +++++++++++++++
  1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash 
b/contrib/completion/git-completion.bash
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
