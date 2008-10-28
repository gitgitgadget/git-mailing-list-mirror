From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Tue, 28 Oct 2008 14:11:57 +0300
Message-ID: <20081028111157.GD1682@wo.int.altlinux.org>
References: <20080824202325.GA14930@eagain.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C1iGAkRnbeBonpVg"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 12:23:15 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KumeB-0005mW-O4
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 12:22:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbYJ1LUI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 07:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753947AbYJ1LUG
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 07:20:06 -0400
Received: from vint.altlinux.org ([194.107.17.35]:38371 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546AbYJ1LUB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 07:20:01 -0400
X-Greylist: delayed 482 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Oct 2008 07:20:01 EDT
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id 03BBE3F80026;
	Tue, 28 Oct 2008 14:11:58 +0300 (MSK)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id EC42C3F48C90; Tue, 28 Oct 2008 14:11:57 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <20080824202325.GA14930@eagain.net>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99282>


--C1iGAkRnbeBonpVg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please apply this compatibility fix (commit v1.6.0.1-90-g27a6ed4)
to maint as well.

On Sun, Aug 24, 2008 at 11:23:25PM +0300, Tommi Virtanen wrote:
> >From 8e7935231e8a91d470b3a4a2310803031ef49fc4 Mon Sep 17 00:00:00 2001
> From: Tommi Virtanen <tv@eagain.net>
> Date: Sun, 24 Aug 2008 23:20:33 +0300
> Subject: [PATCH] Install git-shell in bindir, again.
>=20
> /etc/passwd shell field must be something execable, you can't enter
> "/usr/bin/git shell" there. git-shell must be present as a separate
> executable, or it is useless.
>=20
> Signed-off-by: Tommi Virtanen <tv@eagain.net>
> ---
>=20
> Hi. Recent changes moved away from "git-foo" to "git foo", except for
> some commands that needed backwards compatibility. However, git-shell
> as a separate binary was removed. I hope you will reinstante git-shell
> as a publicly visible binary in bin. Here's why:
>=20
> The shell field in /etc/passwd is *exec*ed, not interpreted via sh -c
> or some such. For example, source of Debian's shadow, containing
> /bin/login:
>=20
> libmisc/shell.c:80:	execle (file, arg, (char *) 0, envp);
>=20
> I also tested this for real, and having a
>=20
> test:x:1001:1001:,,,:/home/test:/usr/bin/git-shell
>=20
> line works, and
>=20
> test:x:1001:1001:,,,:/home/test:/usr/bin/git shell
>=20
> just makes ssh loop asking for a password, logging
>=20
> "User test not allowed because shell /usr/bin/git shell does not exist"
>=20
> So, as far as I understand, as it currently is, "git shell" is utterly
> useless for what it was meant to do. Restoring "git-shell" will fix
> it.
>=20
>  Makefile |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/Makefile b/Makefile
> index 53ab4b5..24d5809 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1351,7 +1351,7 @@ install: all
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
> -	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archiv=
e$X '$(DESTDIR_SQ)$(bindir_SQ)'
> +	$(INSTALL) git$X git-upload-pack$X git-receive-pack$X git-upload-archiv=
e$X git-shell$X '$(DESTDIR_SQ)$(bindir_SQ)'
>  	$(MAKE) -C templates DESTDIR=3D'$(DESTDIR_SQ)' install
>  	$(MAKE) -C perl prefix=3D'$(prefix_SQ)' DESTDIR=3D'$(DESTDIR_SQ)' insta=
ll
>  ifndef NO_TCLTK
> --=20
> 1.6.0.2.g2ebc0.dirty


--=20
ldv

--C1iGAkRnbeBonpVg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkG830ACgkQfKvmrJ41Nh600gCbBTzCt8/yVOZsqVnkyp2NZCTI
//UAn2toe6oueLMUkkK5GIIqRw54OFWk
=zO/g
-----END PGP SIGNATURE-----

--C1iGAkRnbeBonpVg--
