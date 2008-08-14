From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 1/2] bash completion: Add completion for 'git mergetool'
Date: Thu, 14 Aug 2008 16:41:10 -0600
Message-ID: <1218753671-58099-2-git-send-email-lee.marlow@gmail.com>
References: <1218753671-58099-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 00:42:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTlWN-00081i-RU
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 00:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYHNWlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 18:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbYHNWlT
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 18:41:19 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:36028 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbYHNWlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 18:41:18 -0400
Received: by rv-out-0506.google.com with SMTP id k40so635822rvb.1
        for <git@vger.kernel.org>; Thu, 14 Aug 2008 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Kn6NApYdiOYl8toxkTAF/YQJ2lp511ffxnhEuskJ9ck=;
        b=VDOLc8NAmq/b+p8vbGkSVm+Tndlr27UfsXRlB0u48xhJG8O3hqULYvgual9IwokgvV
         Xm8XELBRpb3F9HgPdzMcD5go7LbhlZsuodaMD8T31sitx+RVPsXzIkdYtWHRfTc69Uov
         H9xcXY8G5q59xivyHdaW387WrWF7z/PmNCcL8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=DezniiaIYaI7f2F5Tnb+6RE4wVPZdsuxR7qxOyRaC0k73RkT6mKWVqtCsOs08uhl1Q
         R6qh2fS0009g8hCjb9kVjohscVQDVeKc0Q8iWqFqph09l/eEIFHNa/FmAUiU0IWUc6h/
         YV3SFzANglGv13eOKWYKjr0rgIXmD4LmWLiUE=
Received: by 10.141.163.12 with SMTP id q12mr1069025rvo.265.1218753677698;
        Thu, 14 Aug 2008 15:41:17 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id f21sm2511657rvb.5.2008.08.14.15.41.15
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Aug 2008 15:41:16 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc3.6.ga0653
In-Reply-To: <1218753671-58099-1-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92427>

The --tool= long option can be completed with
	kdiff3 tkdiff meld xxdiff emerge
	vimdiff gvimdiff ecmerge opendiff

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 78189c1..4089670 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1001,6 +1001,25 @@ _git_merge ()
 	__gitcomp "$(__git_refs)"
 }
 
+_git_mergetool ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--tool=*)
+		__gitcomp "
+			kdiff3 tkdiff meld xxdiff emerge
+			vimdiff gvimdiff ecmerge opendiff
+			" "" "${cur##--tool=}"
+		return
+		;;
+	--*)
+		__gitcomp "--tool="
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_merge_base ()
 {
 	__gitcomp "$(__git_refs)"
@@ -1650,6 +1669,7 @@ _git ()
 	ls-remote)   _git_ls_remote ;;
 	ls-tree)     _git_ls_tree ;;
 	merge)       _git_merge;;
+	mergetool)   _git_mergetool;;
 	merge-base)  _git_merge_base ;;
 	mv)          _git_mv ;;
 	name-rev)    _git_name_rev ;;
-- 
1.6.0.rc3.6.ga0653
