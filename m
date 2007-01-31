From: =?us-ascii?Q?=3D=3Futf-8=3Fq=3FDavid=5FK=3DC3=3DA5gedal=3F=3D?= 
	<davidk@lysator.liu.se>
Subject: [PATCH] Improved error message from git-rebase
Date: Wed, 31 Jan 2007 17:12:03 +0100
Message-ID: <873b5r2mya.fsf@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 31 17:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCI7T-0008PJ-JQ
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 17:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030225AbXAaQPc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 31 Jan 2007 11:15:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbXAaQPc
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 11:15:32 -0500
Received: from main.gmane.org ([80.91.229.2]:50606 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030225AbXAaQPb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 11:15:31 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HCI6l-0006Rs-PS
	for git@vger.kernel.org; Wed, 31 Jan 2007 17:14:51 +0100
Received: from vtab.com ([62.20.90.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:14:51 +0100
Received: from davidk by vtab.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Jan 2007 17:14:51 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: vtab.com
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/21.4 (gnu/linux)
Cancel-Lock: sha1:kUxN9c/dhQKw7U+TPTNlPC8kuBA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38268>

If the index wasn't clean, git-rebase would simply show the output from
git-diff-index with no further comment to the user.
---
 git-rebase.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

git-rebase sometimes fails without giving a useful error message.  Try
this:

  $ touch asdf
  $ git add asdf
  $ git rebase origin/master
  A       asdf
  $=20

diff --git a/git-rebase.sh b/git-rebase.sh
index 99cedad..9d2f71d 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -249,7 +249,8 @@ fi
 git-update-index --refresh || exit
 diff=3D$(git-diff-index --cached --name-status -r HEAD)
 case "$diff" in
-?*)	echo "$diff"
+?*)	echo "cannot rebase: your index is not up-to-date"
+	echo "$diff"
 	exit 1
 	;;
 esac
--=20
1.5.0.rc2.86.gf4f4f-dirty


--=20
David K=C3=A5gedal
