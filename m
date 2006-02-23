From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: fix t5600-clone-fail-cleanup.sh on windows
Date: Thu, 23 Feb 2006 12:25:20 +0100
Message-ID: <81b0412b0602230325l309ab68fi900deb5fd3c77ffd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24267_19820224.1140693920687"
Cc: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Feb 23 12:25:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCEbR-0002fF-5a
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 12:25:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750874AbWBWLZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 06:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWBWLZX
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 06:25:23 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:38922 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750860AbWBWLZW (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Feb 2006 06:25:22 -0500
Received: by nproxy.gmail.com with SMTP id p77so16998nfc
        for <git@vger.kernel.org>; Thu, 23 Feb 2006 03:25:21 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type;
        b=g+FtBl84ZqTaGxbe/u9Y/KI5Ax0VP+1T4VDRl5SIxssT0ZIFa9vP62xiiPRHfc4EwC9tRI5MIiCh1zn+LAnwjlmu+7jd+2sCXLvNNKLxze2qGZT7OrUx7tEkxVIHG/LpA6LT8MIcpd3MQia9+17CHjmcqUBteKUGclm+HruSafA=
Received: by 10.49.32.11 with SMTP id k11mr2308357nfj;
        Thu, 23 Feb 2006 03:25:20 -0800 (PST)
Received: by 10.49.88.16 with HTTP; Thu, 23 Feb 2006 03:25:20 -0800 (PST)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16642>

------=_Part_24267_19820224.1140693920687
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

In windows you cannot remove current or opened directory,
an opened file, a running program, a loaded library, etc...

---
I still wonder how they managed to survive...

------=_Part_24267_19820224.1140693920687
Content-Type: text/plain; 
	name=0001-fix-t5600-clone-fail-cleanup.sh-on-windows-canot-remove-current-dir.txt; 
	charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_ek0znes4
Content-Disposition: attachment; filename="0001-fix-t5600-clone-fail-cleanup.sh-on-windows-canot-remove-current-dir.txt"

>From nobody Mon Sep 17 00:00:00 2001
From: Alex Riesen <raa.lkml@gmail.com>
Date: Thu Feb 23 11:49:31 2006 +0100
Subject: [PATCH] fix t5600-clone-fail-cleanup.sh on windows

---

 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3453c0df0d815580c5e7aaeb67bfc54b5b0954c6
diff --git a/git-clone.sh b/git-clone.sh
index dc0ad55..0c60e0b 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -118,7 +118,7 @@ dir="$2"
 [ -e "$dir" ] && echo "$dir already exists." && usage
 mkdir -p "$dir" &&
 D=$(cd "$dir" && pwd) &&
-trap 'err=$?; rm -r $D; exit $err' exit
+trap 'err=$?; cd ..; rm -r $D; exit $err' exit
 case "$bare" in
 yes) GIT_DIR="$D" ;;
 *) GIT_DIR="$D/.git" ;;
-- 
1.2.3.g6ae0e


------=_Part_24267_19820224.1140693920687--
