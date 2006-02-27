From: Karl =?ISO-8859-1?Q?=20Hasselstr=F6m?= <kha@treskal.com>
Subject: [PATCH 1/2] Let git-svnimport's author file use same syntax as git-cvsimport's
Date: Tue, 28 Feb 2006 00:08:15 +0100
Message-ID: <20060227230814.12298.63006.stgit@backpacker.hemma.treskal.com>
References: <440195D4.7080905@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Feb 28 00:08:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDrTe-0001Fy-Mi
	for gcvg-git@gmane.org; Tue, 28 Feb 2006 00:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWB0XIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 18:08:22 -0500
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbWB0XIW
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 18:08:22 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:24521 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S1751838AbWB0XIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 18:08:21 -0500
Received: from backpacker.hemma.treskal.com ([83.227.180.148] [83.227.180.148])
          by mxfep01.bredband.com with ESMTP
          id <20060227230815.ODAA16046.mxfep01.bredband.com@backpacker.hemma.treskal.com>
          for <git@vger.kernel.org>; Tue, 28 Feb 2006 00:08:15 +0100
Received: from backpacker.hemma.treskal.com (localhost.localdomain [127.0.0.1])
	by backpacker.hemma.treskal.com (Postfix) with ESMTP id 4B2F71854
	for <git@vger.kernel.org>; Tue, 28 Feb 2006 00:08:15 +0100 (CET)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <440195D4.7080905@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16890>

git-cvsimport uses a username =3D> Full Name <email@addr.es> mapping
file with this syntax:

  kha=3DKarl Hasselstr=F6m <kha@treskal.com>

Since there is no reason to use another format for git-svnimport, use
the same format.

Signed-off-by: Karl Hasselstr=F6m <kha@treskal.com>

---

 Documentation/git-svnimport.txt |    4 ++--
 git-svnimport.perl              |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-svnimport.txt b/Documentation/git-svnimp=
ort.txt
index e0e3a5d..912a808 100644
--- a/Documentation/git-svnimport.txt
+++ b/Documentation/git-svnimport.txt
@@ -75,9 +75,9 @@ When importing incrementally, you might=20
 -A <author_file>::
 	Read a file with lines on the form
=20
-	  username User's Full Name <email@addres.org>
+	  username =3D User's Full Name <email@addr.es>
=20
-	and use "User's Full Name <email@addres.org>" as the GIT
+	and use "User's Full Name <email@addr.es>" as the GIT
 	author and committer for Subversion commits made by
 	"username". If encountering a commit made by a user not in the
 	list, abort.
diff --git a/git-svnimport.perl b/git-svnimport.perl
index 75ce8e0..86837ed 100755
--- a/git-svnimport.perl
+++ b/git-svnimport.perl
@@ -74,7 +74,7 @@ if ($opt_A) {
 	open(my $authors,$opt_A);
 	while(<$authors>) {
 		chomp;
-		next unless /^(\S+)\s+(.+?)\s+<(\S+)>$/;
+		next unless /^(\S+?)\s*=3D\s*(.+?)\s*<(.+)>\s*$/;
 		(my $user,my $name,my $email) =3D ($1,$2,$3);
 		$users{$user} =3D [$name,$email];
 	}
