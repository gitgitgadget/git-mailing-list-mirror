From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: [PATCH] Re: cg-init bug -- identified
Date: Sun, 5 Jun 2005 14:22:17 -0500
Message-ID: <20050605192217.GC21345@immutable.crsr.net>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org> <20050605181042.GH17462@pasky.ji.cz> <20050605182912.GC6890@tumblerings.org> <20050605184341.GA21345@immutable.crsr.net> <20050605190938.GB21345@immutable.crsr.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 21:19:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df0eE-0006J2-F0
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 21:19:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVFETW1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 15:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVFETW1
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 15:22:27 -0400
Received: from [65.98.21.155] ([65.98.21.155]:52234 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S261604AbVFETWS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 15:22:18 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1Df0hN-0005bL-00; Sun, 05 Jun 2005 14:22:17 -0500
To: "Tommy M. McGuire" <mcguire@crsr.net>
Content-Disposition: inline
In-Reply-To: <20050605190938.GB21345@immutable.crsr.net>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Ok, so cg-mkpatch is nifty.  (Note: slightly diferent patch to avoid
extra space when listing the files.)

-- 
Tommy McGuire

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cg-add.patch"

Use -print0 with find and -0 with xargs to avoid problems with quotes,
etc., in filenames.

---
commit b106726cd681a9cb26343191afc74ccca5d4e351
tree a674424eddc66e19cf806113c70fd80e81879dd1
parent ac9f200795352b9330dcf3c18298ce3b738c7024
author Tommy M. McGuire <mcguire@crsr.net> Sun, 05 Jun 2005 14:17:37 -0500
committer Tommy M. McGuire <mcguire@crsr.net> Sun, 05 Jun 2005 14:17:37 -0500

 cg-add |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cg-add b/cg-add
--- a/cg-add
+++ b/cg-add
@@ -20,9 +20,9 @@ USAGE="cg-add FILE..."
 [ "$1" ] || usage
 
 TMPFILE=$(mktemp -t gitadd.XXXXXX)
-find "$@" -type f > $TMPFILE || die "not all files exist, nothing added"
+find "$@" -type f -print0 > $TMPFILE || die "not all files exist, nothing added"
 
-cat $TMPFILE | awk '{print "Adding file "  $0}'
-cat $TMPFILE | xargs git-update-cache --add --
+cat $TMPFILE | xargs -0l1 echo "Adding file"
+cat $TMPFILE | xargs -0 git-update-cache --add --
 
 rm $TMPFILE

--9amGYk9869ThD9tj--
