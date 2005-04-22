From: Fabian Franz <FabianFranz@gmx.de>
Subject: [PATCH] git-pasky: Add .gitrc directory to allow command defaults like with .cvsrc
Date: Fri, 22 Apr 2005 18:28:48 +0200
Message-ID: <200504221828.51752.FabianFranz@gmx.de>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-From: git-owner@vger.kernel.org Fri Apr 22 18:29:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP119-0004oM-9m
	for gcvg-git@gmane.org; Fri, 22 Apr 2005 18:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVDVQcu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVDVQcu
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 12:32:50 -0400
Received: from imap.gmx.net ([213.165.64.20]:64705 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262059AbVDVQcr convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2005 12:32:47 -0400
Received: (qmail invoked by alias); 22 Apr 2005 16:32:45 -0000
Received: from p54A3EE36.dip.t-dialin.net (EHLO ff.cornils.net) [84.163.238.54]
  by mail.gmx.net (mp010) with SMTP; 22 Apr 2005 18:32:45 +0200
X-Authenticated: #590723
To: git@vger.kernel.org
User-Agent: KMail/1.5.4
Content-Description: clearsigned data
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

one thing I liked about CVS was its way to configure default parameters for 
commands.

And as I really like the colored log output, I wanted it as default.

While .cvsrc parsing would be quite expensive, using a directory + files 
should be fairly cheap and result just in one additional stat-call.

So I added "-c" to ~/.gitrc/log and some code to parse this.

Index: git
===================================================================
- --- 0a9ee5a4d947b998a7ce489242800b39f98eeee5/git  (mode:100755 
sha1:39969debd59ed51c57973c819cdcc3ca8a7da819)
+++ uncommitted/git  (mode:100755)
@@ -67,6 +67,7 @@
        exit 1
 fi

+[ -e "$HOME/.gitrc/$cmd" ] && set -- $(cat "$HOME/.gitrc/$cmd") "$@"

 case "$cmd" in
 "add")        gitadd.sh "$@";;

cu

Fabian

PS: Should the commandline parsing be cleaned up or do you want to do that 
after first release of cogito? And if yes, do you want to use "getopts" or 
would this be not supported on some systems?

PPS: I'm fairly new to git, how do I create a diff with the signed-by fields 
and with what do I need to sign it?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFCaSZDI0lSH7CXz7MRAoq8AJwM2lxPfl0ej32WU7q6bh6WIq5+EACgghGn
mvJzbvg6/bxWLFKfsP1ZEeI=
=03wm
-----END PGP SIGNATURE-----

