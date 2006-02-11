From: Andrey Borzenkov <arvidjaar@newmail.ru>
Subject: stg branch switch causes unnecessary recompilation
Date: Sat, 11 Feb 2006 16:07:27 +0300
Message-ID: <200602111607.27631.arvidjaar@newmail.ru>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Feb 11 14:07:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7uTd-000512-Qe
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 14:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbWBKNHr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Feb 2006 08:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWBKNHr
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Feb 2006 08:07:47 -0500
Received: from flock1.newmail.ru ([80.68.241.157]:56467 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S1751421AbWBKNHr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2006 08:07:47 -0500
Received: (qmail 11065 invoked from network); 11 Feb 2006 13:07:28 -0000
Received: from unknown (HELO cooker.local) (arvidjaar@newmail.ru@83.237.13.127)
  by smtpd.newmail.ru with SMTP; 11 Feb 2006 13:07:28 -0000
To: git@vger.kernel.org
User-Agent: KMail/1.9.1
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15942>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

{pts/1}% stg version
Stacked GIT 0.8.1
git version 1.1.6
Python version 2.4.2 (#2, Jan 30 2006, 18:33:58)
[GCC 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1)]


Apparently stg branch is implemented as

- - pop all patches
- - do git checkout branch
- - push all patches

unfortunately it results in changing timestamp of all patched files causing 
sometimes long recompilations. What I just had was:

- - I have several local patches for kernel that I keep in separate branches; I 
also have one branch that I pick patches into and that I keep in sync with 
upstream.

- - I pulled 2.6.15.4 stable and recompiled. In the process I noticed a trivial 
error in one file

- - I created new branch, put fix in there, switched to my main branch, picked 
patch and did make. It resulted in recompilation of *everything* that was 
touched by *any* patch.

Sometimes it may be quite time consuming. Notice that git checkout does not 
have this problem - it sets timestamp exactly to the one in index. It would 
be nice if stg did the same.

regards

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD7eGPR6LMutpd94wRAmGEAJ49maPpI6VjGyp8sIOwPBKQNuUeZgCePOoN
C9bqat7QEA5Pt6bzegW0q2E=
=0JHo
-----END PGP SIGNATURE-----
