From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] rebase: pass --signoff option to git am
Date: Sat, 27 Nov 2010 12:15:42 +0100
Message-ID: <1290856542-6070-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 27 12:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMIl5-00057s-Ro
	for gcvg-git-2@lo.gmane.org; Sat, 27 Nov 2010 12:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752327Ab0K0LPv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Nov 2010 06:15:51 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:50588 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab0K0LPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Nov 2010 06:15:51 -0500
Received: by wwa36 with SMTP id 36so2957675wwa.1
        for <git@vger.kernel.org>; Sat, 27 Nov 2010 03:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YSHHVzPkZt6JdpaO2nDNDyaKRsYvWfBVHXUKuY6UGOk=;
        b=AtQicq7Uuw9QqgyUvC/HP89SB6w7wlCTGN6CA1R+gksxch0+g9i2P7SOcq9fGQVqzP
         J2Yc1aJU1aUzRhMbPCUjMLGupGr+O3pNUJN2Dt78afU/MGL45/EsQfhBm0zn4VJVX+88
         9yQeTBxbBFb/D+jlVp/scdrEysMPkcDwxpZIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=YrsBnaYhc8h+vFdGLLCT8JM8O6wBwx7mewIhCu2I2NZH9PWYgZZGchzZUcInEK0CwO
         htXUmKNn9C3A4eh1kNkkn5MEAEUkHuo9GRhz+hNHi0KwLr3/4kckkHknIL/hIYtJxKsO
         k2wmsbRlVgJ2eHthwfxDlKxhD2H3L7CTIR+pc=
Received: by 10.227.141.130 with SMTP id m2mr3520557wbu.125.1290856549313;
        Sat, 27 Nov 2010 03:15:49 -0800 (PST)
Received: from localhost ([151.60.176.40])
        by mx.google.com with ESMTPS id ga16sm1983253wbb.19.2010.11.27.03.15.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Nov 2010 03:15:47 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.184.gecaee
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162306>

This allows people (like me) that forget to sign off their commits to do
a single rebase pass e.g. while preparing the patchset for submission.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 Documentation/git-rebase.txt |    6 ++++++
 git-rebase.sh                |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 30e5c0e..d513e42 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -320,6 +320,12 @@ link:howto/revert-a-faulty-merge.txt[revert-a-faulty-merge How-To] for details).
 -p::
 --preserve-merges::
 	Instead of ignoring merges, try to recreate them.
+
+--signoff::
+	This flag is passed to 'git am' to sign off all the rebased
+	commits (see linkgit:git-am[1]).
+	Incompatible with the --interactive option.
+
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
diff --git a/git-rebase.sh b/git-rebase.sh
index 0e9d52a..9de03ee 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -354,7 +354,7 @@ do
 	--ignore-whitespace)
 		git_am_opt="$git_am_opt $1"
 		;;
-	--committer-date-is-author-date|--ignore-date)
+	--committer-date-is-author-date|--ignore-date|--signoff)
 		git_am_opt="$git_am_opt $1"
 		force_rebase=t
 		;;
-- 
1.7.3.2.184.gecaee
