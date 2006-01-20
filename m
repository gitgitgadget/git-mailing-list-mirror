From: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
Subject: [PATCH] fix generation of "humanish" part of source repo
Date: Fri, 20 Jan 2006 07:47:39 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20060120064739.GA2306@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 20 07:48:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ezq47-0004ZQ-0K
	for gcvg-git@gmane.org; Fri, 20 Jan 2006 07:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161233AbWATGrn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jan 2006 01:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161250AbWATGrn
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jan 2006 01:47:43 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:27553 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S1161233AbWATGrm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2006 01:47:42 -0500
Received: from juno.informatik.uni-freiburg.de ([132.230.151.45])
	by atlas.informatik.uni-freiburg.de with esmtp (Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1Ezq3h-0001Bh-0H
	for git@vger.kernel.org; Fri, 20 Jan 2006 07:47:41 +0100
Received: from juno.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11) with ESMTP id k0K6ldKi002337
	for <git@vger.kernel.org>; Fri, 20 Jan 2006 07:47:39 +0100 (MET)
Received: (from zeisberg@localhost)
	by juno.informatik.uni-freiburg.de (8.12.11/8.12.11/Submit) id k0K6ldqR002336
	for git@vger.kernel.org; Fri, 20 Jan 2006 07:47:39 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14954>

If repo has the form <host>:<path> and <path> doesn't contain a slash, the
cloned repository is named "<host>:<path>", instead of "<path>" only.

Signed-off-by: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>

---

 git-clone.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

3aa74cf5b61fdd2f75ebda942e839a3ecc1e1f9c
diff --git a/git-clone.sh b/git-clone.sh
index f99e0ad..0504ba4 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -97,7 +97,7 @@ fi
 
 dir="$2"
 # Try using "humanish" part of source repo if user didn't specify one
-[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*/||g')
+[ -z "$dir" ] && dir=$(echo "$repo" | sed -e 's|/$||' -e 's|:*/*\.git$||' -e 's|.*[/:]||g')
 [ -e "$dir" ] && $(echo "$dir already exists."; usage)
 mkdir -p "$dir" &&
 D=$(
-- 
1.0.8

Best regards
Uwe

-- 
Uwe Zeisberger

http://www.google.com/search?q=Planck%27s+constant%3D
