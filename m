From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] autoconf: Set mandir in config.mak.in and export variables not in Makefile
Date: Thu, 29 Jun 2006 19:47:48 +0200
Message-ID: <200606291947.50980.jnareb@gmail.com>
References: <200606290301.51657.jnareb@gmail.com> <200606291704.27677.jnareb@gmail.com> <200606291835.53788.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Jun 29 19:47:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw0cK-0001wk-VV
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 19:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWF2Rru convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 29 Jun 2006 13:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbWF2Rrt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 13:47:49 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:51217 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751107AbWF2Rrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 13:47:49 -0400
Received: by ug-out-1314.google.com with SMTP id a2so469844ugf
        for <git@vger.kernel.org>; Thu, 29 Jun 2006 10:47:47 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=EswKGrQo//wvamlzfDiFqolnWhiHliXyRmeO8TqdNzTrZ8Y6b2BTzUsHxXdOGyRsYl1QAU8lkaOEdM6K8SEzN0eFh5BB6q678MXT5G+jAbDz9JOb1cpVrqpSfniuK+jodTnlzxf2JNzRSeqY2Dk4kK0ynY3C2w7q8mcfgxFmAqU=
Received: by 10.66.244.10 with SMTP id r10mr2152203ugh;
        Thu, 29 Jun 2006 10:47:47 -0700 (PDT)
Received: from host-81-190-27-124.torun.mm.pl ( [81.190.27.124])
        by mx.gmail.com with ESMTP id h1sm696188ugf.2006.06.29.10.47.46;
        Thu, 29 Jun 2006 10:47:47 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200606291835.53788.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22876>

This patch with the previous "[PATCH] Allow INSTALL, bindir, mandir to
be set in main Makefile" patch allows ./configure script to set where
manpages will be installed using --mandir=3DDIR (./configure defaults t=
o
PREFIX/man).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---

Uwe Zeisberger wrote:
> autoconf does to much things, even with that little configure.ac.
> (But I agree, it's much better than automake :-)
>
> E.g.
>
> =A0=A0=A0=A0=A0=A0=A0=A0./configure --prefix=3D$HOME/usr --mandir=3D$=
HOME/usr/share/man
>
> is supported by the configure script, but the manpages are installed
> in $HOME/usr/man all the same.
>
> BTW: Even if I specify mandir=3D... in config.mak, it is not respecte=
d,
> because only the toplevel Makefile includes config.mak. =A0(I didn't
> test it, but I think I could export mandir in config.mak ...)

This patch and previous one adressess this.

 config.mak.in |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/config.mak.in b/config.mak.in
index 82d80e2..82c9781 100644
--- a/config.mak.in
+++ b/config.mak.in
@@ -8,5 +8,11 @@ #gitexecdir =3D @libexecdir@/git-core/
 template_dir =3D @datadir@/git-core/templates/
 GIT_PYTHON_DIR =3D @datadir@/git-core/python
=20
+mandir=3D@mandir@
+
 srcdir =3D @srcdir@
 VPATH =3D @srcdir@
+
+export exec_prefix mandir
+export srcdir VPATH
+
--=20
1.4.0
