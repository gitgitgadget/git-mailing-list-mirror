From: martin f krafft <madduck@debian.org>
Subject: TopGit: problem with patch series generation
Date: Tue, 12 Aug 2008 13:18:54 -0300
Organization: The Debian project
Message-ID: <20080812161854.GB30067@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0765819825672679647=="
Cc: vcs distro packaging discussion list
	<vcs-pkg-discuss@lists.alioth.debian.org>
To: git discussion list <git@vger.kernel.org>
X-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org Tue Aug 12 18:19:16 2008
Return-path: <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcpv-vcs-pkg-discuss@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSwaX-0003Vu-S7
	for gcpv-vcs-pkg-discuss@m.gmane.org; Tue, 12 Aug 2008 18:19:13 +0200
Received: from localhost
	([127.0.0.1] helo=alioth.debian.org ident=list)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>)
	id 1KSwZb-0008IZ-TU
	for gcpv-vcs-pkg-discuss@m.gmane.org; Tue, 12 Aug 2008 16:18:15 +0000
Received: from clegg.madduck.net ([193.242.105.96])
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <madduck@lapse.rw.madduck.net>) id 1KSwZT-0008Hd-4d
	for vcs-pkg-discuss@lists.alioth.debian.org;
	Tue, 12 Aug 2008 16:18:13 +0000
Received: from lapse.rw.madduck.net (unknown [209.13.181.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 349461D40AD;
	Tue, 12 Aug 2008 18:17:52 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 7D09C80B5; Tue, 12 Aug 2008 13:18:54 -0300 (ART)
Mail-Followup-To: git discussion list <git@vger.kernel.org>, pasky@suse.cz,
	Manoj Srivastava <srivasta@debian.org>,
	vcs distro packaging discussion list
	<vcs-pkg-discuss@lists.alioth.debian.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.1/8018/Tue Aug 12 10:36:31 2008 on
	clegg.madduck.net
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=AWL,BAYES_00,URIBL_RED
	autolearn=ham version=3.2.3
X-BeenThere: vcs-pkg-discuss@lists.alioth.debian.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss@lists.alioth.debian.org>
List-Help: <mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=subscribe>
Mime-version: 1.0
Sender: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
Errors-To: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92109>


--===============0765819825672679647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi folks,

I am playing around with TopGit and encountered a (conceptual)
problem. I'd love to hear some input.

I want to use TopGit for distro packaging. Any of my packages have
one or more feature branches, some intended for upstream, some
distro-specific. As I am packaging TopGit for Debian, I encountered
the situation that two branches conflict with each other (they
change the same line), but there is no dependency between the
branches. Thus, when I squash the branches into a series, the
resulting patches will not apply (they both change the same original
line to something else).

Obviously, I can introduce a "fake" dependency to force TopGit to
create one patch based on another. However, this then prevents me
=66rom testing and developing the depending branch in isolation,
meaning that I always have to have the dependent branch applied when
I want to work on the second feature. Furthermore, it's not
trivially possible in this situation to cherry-pick only the second
patch.

I see that this is a hard problem with no obvious solution. The only
thing that comes to my mind is maintaining multiple patches for each
branch. In the above, if B "fake-depends" on A, which depends on
master, then I would have A and B depend on master only, but have
TopGit also manage B2 for me, which is a diff against A.

Doing this for all branches is polynomial, but then again, the
number of independent branches, or rather branch trees, is likely to
be pretty low in most cases.

As an alternative, it may be possible, however, to let TopGit know
about a "fake dependency" from B on A. When serialised, TopGit would
notice that there are multiple paths from master to B (master->B and
master->A->B) and use the longer one.

Do you see any other ways in which the situation could be handled?

Is the above something that TopGit could learn, Petr?

Cheers,

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
"with sufficient thrust, pigs fly just fine. however, this is not
 necessarily a good idea. it is hard to be sure where they are going
 to land, and it could be dangerous sitting under them as they fly
 overhead."
                                                           -- rfc 1925

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiht+4ACgkQIgvIgzMMSnV2lgCgy+zvLQ/5SEgk661as3OM6+xb
aosAn3MbzDFqYxjsYTGl3pSi48VAH0he
=1Lh8
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


--===============0765819825672679647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
