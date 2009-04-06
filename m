From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 12/14] bash completion: add git-difftool
Date: Mon,  6 Apr 2009 01:31:27 -0700
Message-ID: <1239006689-14695-13-git-send-email-davvid@gmail.com>
References: <1239006689-14695-1-git-send-email-davvid@gmail.com>
 <1239006689-14695-2-git-send-email-davvid@gmail.com>
 <1239006689-14695-3-git-send-email-davvid@gmail.com>
 <1239006689-14695-4-git-send-email-davvid@gmail.com>
 <1239006689-14695-5-git-send-email-davvid@gmail.com>
 <1239006689-14695-6-git-send-email-davvid@gmail.com>
 <1239006689-14695-7-git-send-email-davvid@gmail.com>
 <1239006689-14695-8-git-send-email-davvid@gmail.com>
 <1239006689-14695-9-git-send-email-davvid@gmail.com>
 <1239006689-14695-10-git-send-email-davvid@gmail.com>
 <1239006689-14695-11-git-send-email-davvid@gmail.com>
 <1239006689-14695-12-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, charles@hashpling.org,
	markus.heidelberg@web.de, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 06 10:35:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqkIJ-0002l9-VG
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 10:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbZDFIcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 04:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754748AbZDFIcL
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 04:32:11 -0400
Received: from rv-out-0506.google.com ([209.85.198.231]:11551 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbZDFIcI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 04:32:08 -0400
Received: by rv-out-0506.google.com with SMTP id f9so2100137rvb.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 01:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5qI8NL4HMbze0cB/CogAZQN5RvUOr+hTgf01irnY7iA=;
        b=TJPHWIxempACgo+D8CXlC2mBg8hZczwmKxqmFbzCc92Qn6uvZCuMWjqul81gkoB9CF
         yXZzXSbjvXdqQxQL2lsgu6TstDo43W6oo2qmVVOtp/Z9PDp7W/WTDU0U4VQLYF1AaS5h
         9/owc0JFF6xZZzXTeA6Q/qvxSK+NjEwcJI854=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YwjZ6kQ3okR3Mq9axAioNpdn8qnq4f7qkZKMdcOzDfU+BUQJ/HwpipDgB7ZN/ZTQmi
         QcBOJXS8EGpG/xg931XKoAuJba0/Vp12koVnaf9RtbQx4nuTmIuiEPFw8pgp5CubgiYk
         IXKXvZ/Hc0kISJtCSfkRhUoQDMAR0TG/oDWnA=
Received: by 10.114.181.6 with SMTP id d6mr2156407waf.94.1239006726603;
        Mon, 06 Apr 2009 01:32:06 -0700 (PDT)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id m30sm5181240wag.47.2009.04.06.01.32.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 06 Apr 2009 01:32:06 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.414.g81aa9
In-Reply-To: <1239006689-14695-12-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115794>

This adds completion for difftool's --tool flag.
The known diff tool names were also consolidated into
a single variable.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 contrib/completion/git-completion.bash |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 4fcd77a..551e33e 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -909,6 +909,26 @@ _git_diff ()
 	__git_complete_file
 }
 
+__git_mergetools_common="diffuse ecmerge emerge kdiff3 meld opendiff
+			tkdiff vimdiff gvimdiff xxdiff
+"
+
+_git_difftool ()
+{
+	local cur="${COMP_WORDS[COMP_CWORD]}"
+	case "$cur" in
+	--tool=*)
+		__gitcomp "$__git_mergetools_common kompare" "" "${cur##--tool=}"
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
 __git_fetch_options="
 	--quiet --verbose --append --upload-pack --force --keep --depth=
 	--tags --no-tags
@@ -1171,11 +1191,7 @@ _git_mergetool ()
 	local cur="${COMP_WORDS[COMP_CWORD]}"
 	case "$cur" in
 	--tool=*)
-		__gitcomp "
-			kdiff3 tkdiff meld xxdiff emerge
-			vimdiff gvimdiff ecmerge diffuse
-			opendiff
-			" "" "${cur##--tool=}"
+		__gitcomp "$__git_mergetools_common tortoisemerge" "" "${cur##--tool=}"
 		return
 		;;
 	--*)
@@ -1900,6 +1916,7 @@ _git ()
 	config)      _git_config ;;
 	describe)    _git_describe ;;
 	diff)        _git_diff ;;
+	difftool)    _git_difftool ;;
 	fetch)       _git_fetch ;;
 	format-patch) _git_format_patch ;;
 	fsck)        _git_fsck ;;
-- 
1.6.2.2.414.g81aa9
