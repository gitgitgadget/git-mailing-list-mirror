From: Lee Marlow <lee.marlow@gmail.com>
Subject: [PATCH 3/8] bash completion: Add completion for 'git init'
Date: Mon,  4 Aug 2008 23:50:33 -0600
Message-ID: <1217915438-6838-4-git-send-email-lee.marlow@gmail.com>
References: <1217915438-6838-1-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-2-git-send-email-lee.marlow@gmail.com>
 <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
Cc: git@vger.kernel.org, Lee Marlow <lee.marlow@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 05 07:52:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQFT6-0007dV-Sa
	for gcvg-git-2@gmane.org; Tue, 05 Aug 2008 07:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbYHEFuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Aug 2008 01:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754899AbYHEFuu
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Aug 2008 01:50:50 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:55154 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753108AbYHEFup (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Aug 2008 01:50:45 -0400
Received: by wf-out-1314.google.com with SMTP id 27so3753944wfd.4
        for <git@vger.kernel.org>; Mon, 04 Aug 2008 22:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=x3tP8m8cZ/KNgooZbjGG8xL8vpgkDr+B0xRI5NugTNE=;
        b=ZSQKZ9XwEGiK7PZ2FryOkC9IRTO3hClUHtCfO2z5XzUKZTrK53DQeN70qkEBBcQE7z
         0wjgiCmE+NiOsuDguxkSUgC3/kaG6U/hmVuq9CtubXONiC/sgyj1LCf+9KAw/TgjlQYp
         36Fqdh6l1nKF9+CJLIifLua5sAZ0saTjwBNgE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=PIoUSPnFiz6tD8K1VO+2R+/VA1mogmoloqfTf1KjApusyWeEg7nITDUs3SKpIhYI/y
         5Wgr+03Ape6I/MZyznqDug1qlxK4A1YlepTExulC8iPSt923/g01PZzOKxMqW5aLjfVd
         sVufXx/abq5sLEfARoJcEkDcnQrxmRhMwJErs=
Received: by 10.142.72.4 with SMTP id u4mr5277548wfa.269.1217915444492;
        Mon, 04 Aug 2008 22:50:44 -0700 (PDT)
Received: from localhost.localdomain ( [75.71.41.234])
        by mx.google.com with ESMTPS id 32sm10686014wfc.12.2008.08.04.22.50.42
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 04 Aug 2008 22:50:43 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.rc1.48.g2b6032
In-Reply-To: <1217915438-6838-3-git-send-email-lee.marlow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91425>

Added completions for all long options specified in the docs
        --quiet --bare --template= --shared
        --shared={false|true|umask|group|all|world|everybody}

Signed-off-by: Lee Marlow <lee.marlow@gmail.com>
---
 contrib/completion/git-completion.bash |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 72be4f1..c7a6d92 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -842,6 +842,24 @@ _git_help ()
 	__gitcomp "$(__git_all_commands)"
 }
 
+_git_init ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--shared=*)
+		__gitcomp "
+			false true umask group all world everybody
+			" "" "${cur##--shared=}"
+		return
+		;;
+	--*)
+		__gitcomp "--quiet --bare --template= --shared --shared="
+		return
+		;;
+	esac
+	COMPREPLY=()
+}
+
 _git_ls_remote ()
 {
 	__gitcomp "$(__git_remotes)"
@@ -1524,6 +1542,7 @@ _git ()
 	format-patch) _git_format_patch ;;
 	gc)          _git_gc ;;
 	help)        _git_help ;;
+	init)        _git_init ;;
 	log)         _git_log ;;
 	ls-remote)   _git_ls_remote ;;
 	ls-tree)     _git_ls_tree ;;
-- 
1.6.0.rc1.48.g2b6032
