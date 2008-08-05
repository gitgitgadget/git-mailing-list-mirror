From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 7/8] bash completion: Add completion for 'git ls-files'
Date: Mon,  4 Aug 2008 23:50:37 -0600
Message-ID: <1217915438-6838-8-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-4-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-5-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-6-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-7-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:56:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFXH-0008V2-V7
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:56:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755124AbYHEFzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755099AbYHEFvE
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:51:04 -0400
Received: from wf-out-1314.google.com ([209.85.200.175]:58782 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754777AbYHEFut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:49 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753957wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=IZHAgkrdCwTLlVBLymxfgph9DChclrhiJTgf7UnKBEc=;
        b=xtQGEWKWOMNAf0mas2Xc6vSh7nP57fNyzr0TOAwQytCxV3DQdFvNHIU5hBf6YGAsZq
         szlxs5h6VR5e1NTOIE0BYYxTl/YqJVdRXyrtsG1RfOjREj7DkAnTD0OcZ6qgU5uYsT8h
         TZeldFEr6uXry5jPhjQ8+8W5lN+Usgah1N3P4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=cgCUGAUaD7ehBh4tOIlLQLqR5JngT8EL9vEkT4kArcZmD6KWSQJtkDkI0FxkHOZZ3n
         wYedCJ6mS/lUrGvnUpWKIazxA0yx3O7dP2P7lzgt0PW7s5VRWsRiwD5Gu/FkdalZdC3n
         EufokNrfssM45PYzn3dyyzVj8YVIzA4ByQHMQ=
Received: by 10.142.84.5 with SMTP id h5mr5264582wfb.339.1217915449435;
        Mon, 04 Aug 2008 22:50:49 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.48
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:48 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-7-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91427>

Added completions for all long options specified in the docs
	--cached --deleted --modified --others --ignored
	--stage --directory --no-empty-directory --unmerged
	--killed --exclude= --exclude-from=
	--exclude-per-directory= --exclude-standard
	--error-unmatch --with-tree= --full-name
	--abbrev --ignored --exclude-per-directory

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 61ea6d9..936cd35 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -883,6 +883,26 @@ _git_init ()
 	COMPREPLY=()
 }
 
+_git_ls_files ()
+{
+	__git_has_doubledash && return
+
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "--cached --deleted --modified --others --ignored
+			--stage --directory --no-empty-directory --unmerged
+			--killed --exclude= --exclude-from=
+			--exclude-per-directory= --exclude-standard
+			--error-unmatch --with-tree= --full-name
+			--abbrev --ignored --exclude-per-directory
+			"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_ls_remote ()
 {
 	__gitcomp "$(__git_remotes)"
@@ -1590,6 +1610,7 @@ _git ()
 	help)        _git_help ;;
 	init)        _git_init ;;
 	log)         _git_log ;;
+	ls-files)    _git_ls_files ;;
 	ls-remote)   _git_ls_remote ;;
 	ls-tree)     _git_ls_tree ;;
 	merge)       _git_merge;;
-- 
1.6.0.rc1.48.g2b6032
