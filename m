From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH] bash completion: Add completion for 'git grep'
Date: Fri,  1 Aug 2008 18:56:33 -0600
Message-ID: <1217638593-57321-1-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Aug 02 02:57:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KP5RI-0001rG-V2
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 02:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbYHBA4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 20:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751701AbYHBA4i
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 20:56:38 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:55433 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627AbYHBA4g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 20:56:36 -0400
Received: by wa-out-1112.google.com with SMTP id j37so810476waf.23
        for <git@vger.kernel.org>; Fri, 01 Aug 2008 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=M7qHA5YjsTCneuMpJRS2AfG/g8qY7wkFAyT85tSaC3g=;
        b=stqvkEJqO58Aq0da71w46zg9ac788pbYKST7cEzY8qm88aihQEUHqDtFIOIhEGV92u
         fhZy/sPb+sIvxZQx3xWIJlMfwdqZzTLrY1k4TC6kVVnQxT/Ku5lrJoh8zT2A6WKHFEXI
         7Y/r3aVGVtJ9CtgR1SnlSO1zSoj9xGQ/hIL5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Foafzm0sNJd0ngoy0fbFTzMxYftYqSstd91Je8+Ri/Tk/7QCyzezfnuaAalDqxnWq8
         di0DbaOjrOuQK2E1ew0nCISBukcMRZzHcMYH8w+ht2xz1yDVNVOrypKe6VI8rinAj3nL
         leKVUQxssJWSO1AGJCI0v7bnGYEjiEKqx88tM=
Received: by 10.114.157.3 with SMTP id f3mr12348010wae.40.1217638596460;
        Fri, 01 Aug 2008 17:56:36 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id t1sm4340601poh.9.2008.08.01.17.56.34
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Aug 2008 17:56:34 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.27.g9b6bf
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91126>

Added completions for all long options specified in the docs
	--cached
	--text --ignore-case --word-regexp --invert-match
	--full-name
	--extended-regexp --basic-regexp --fixed-strings
	--files-with-matches --name-only
	--files-without-match
	--count
	--and --or --not --all-match

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 30d8701..b28ac10 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -796,6 +796,29 @@ _git_gc ()
 	COMPREPLY=()
 }
 
+_git_grep ()
+{
+	__git_has_doubledash && return
+
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--*)
+		__gitcomp "
+			--cached
+			--text --ignore-case --word-regexp --invert-match
+			--full-name
+			--extended-regexp --basic-regexp --fixed-strings
+			--files-with-matches --name-only
+			--files-without-match
+			--count
+			--and --or --not --all-match
+			"
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_help ()
 {
 	local cur="${COMP_WORDS[COMP_CWORD]}"
@@ -1486,6 +1509,7 @@ _git ()
 	fetch)       _git_fetch ;;
 	format-patch) _git_format_patch ;;
 	gc)          _git_gc ;;
+	grep)        _git_grep ;;
 	help)        _git_help ;;
 	log)         _git_log ;;
 	ls-remote)   _git_ls_remote ;;
-- 
1.6.0.rc1.27.g9b6bf
