From: Luke Mewburn <luke@mewburn.net>
Subject: Re: [PATCH] compat/mingw: stubs for getpgid() and tcgetpgrp()
Date: Fri, 17 Apr 2015 11:25:41 +1000
Message-ID: <20150417012541.GI23475@mewburn.net>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net>
 <552EAE0A.3040208@kdbg.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Thv7PGoFpDPJ7Oar"
Cc: Luke Mewburn <luke@mewburn.net>, Nicolas Pitre <nico@fluxnic.net>,
	git@vger.kernel.org, msysGit <msysgit@googlegroups.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 03:25:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yiv2T-0004z7-P0
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 03:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbbDQBZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 21:25:45 -0400
Received: from home.mewburn.net ([121.127.199.9]:44152 "EHLO home.mewburn.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbbDQBZo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 21:25:44 -0400
Received: by home.mewburn.net (Postfix, from userid 1001)
	id 5F9BD61208; Fri, 17 Apr 2015 11:25:41 +1000 (AEST)
Content-Disposition: inline
In-Reply-To: <552EAE0A.3040208@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267344>


--Thv7PGoFpDPJ7Oar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 08:29:30PM +0200, Johannes Sixt wrote:
  | Windows does not have process groups. It is, therefore, the simplest
  | to pretend that each process is in its own process group.
  |=20
  |  [...]
  |=20
  | diff --git a/compat/mingw.h b/compat/mingw.h
  | index 7b523cf..a552026 100644
  | @@ -118,6 +116,12 @@ static inline int sigaddset(sigset_t *set, int sig=
num)
  |  #define SIG_UNBLOCK 0
  |  static inline int sigprocmask(int how, const sigset_t *set, sigset_t *=
oldset)
  |  { return 0; }
  | +static inline pid_t getppid(void)
  | +{ return 1; }
  | +static inline pid_t getpgid(pid_t pid)
  | +{ return pid =3D=3D 0 ? getpid() : pid; }
  | +static inline pid_t tcgetpgrp(int fd)
  | +{ return getpid(); }


This appears to be similar to the approach that tcsh uses too;
return the current process ID for the process group ID.
See https://github.com/tcsh-org/tcsh/blob/master/win32/ntport.h
for tcsh's implementation of getpgrp() (a variation of getpgid())
and tcgetpgrp().


regards,
Luke.

--Thv7PGoFpDPJ7Oar
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)

iEYEARECAAYFAlUwYRUACgkQpBhtmn8zJHLTmgCg1q8OwY7A2uiBS9mYADK0HPh3
GuYAn1uthK8gpabY7GH4sZRSoTQ14Ydo
=NJXN
-----END PGP SIGNATURE-----

--Thv7PGoFpDPJ7Oar--
