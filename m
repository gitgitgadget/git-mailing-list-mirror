From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] Authenticate push via PGP signature, not SSH
Date: Thu, 31 Jan 2008 10:25:27 +0100
Message-ID: <20080131092527.GC24403@artemis.madism.org>
References: <479D5611.4010205@vilain.net> <20080128081258.GE24004@spearce.org> <479E5021.7010404@vilain.net> <20080129041000.GK24004@spearce.org> <20080129190845.GC30093@artemis.madism.org> <20080130042201.GO24004@spearce.org> <20080130083315.GB8698@artemis.madism.org> <20080131043056.GX24004@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="uh9ZiVrAOUUm9fzH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:26:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVgK-0008R5-PH
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbYAaJZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbYAaJZc
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:25:32 -0500
Received: from pan.madism.org ([88.191.52.104]:34057 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbYAaJZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:25:29 -0500
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 495C531696;
	Thu, 31 Jan 2008 10:25:27 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3FFB74DF486; Thu, 31 Jan 2008 10:25:27 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080131043056.GX24004@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72110>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 31, 2008 at 04:30:56AM +0000, Shawn O. Pearce wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> >   It is, we have since recently the princple of "Debian Maintainers",
> > people that are only allowed to upload their own package, and the
> > keyring used for that purpose is versionned using a custom development
> > of ours called jetring (by Joey Hess and al.), I suppose the sources are
> > somewhere around, and it has an internal ascii-armored database IIRC
> > _and_ a gpg-usable keyring, I think. Or is able to generate the keyring
> > at least.
>=20
> I looked at jetring earlier today, after you posted the URL in
> your other email.  Its an interesting tool for distributed keyring
> management.  I can see why the Debian folks use it, but it does seem
> a little awkward if one has to create those change files by hand.

  Well, *I* don't use it, it's just a fancy tool that replaces the fully
manual (sigh) Debian keyring management for the DM keyring, so that it
can be used by multiple people at the same time. I just pointed to it,
as like you said, reinventing the wheel sucks. Though Joey will probably
be open to improvements if needed :)

> >   But for the case I discussed, indeed, I'd use
> > /usr/share/keyrings/debian-keyring.gpg anyways, and won't be the one
> > updating it. That's why your developpement should be able to allow
> > checking against another keyring. IOW I'm less and less sure that you
> > want to manage the keyring _necessarily_ inside the git tree, and that
> > allowing any external way to manage a keyring (inside a git tree beeing
> > one of the options) is the most flexible way.
>=20
> Of this you have convinced me.
>=20
> If we get any sort of push authorization based upon PGP signatures
> implemented we should be validating against a keyring that is
> configured by a receive.keyring configuration option, and that
> defaults to $GIT_DIR/receive-keyring.gpg or something suitable.
> If you want to point receive-pack at an existing keyring on your
> system, you can and should do so.

  Full ACK. Another issue that I didn't saw in the first place, is that
if you want to store your keyring in git itself, then it brings the
issue that you would have to write ACLs to protect the branch where it's
stored, whereas it's usually _way_ more easy to just decorrelate both.
IOW it's weak wrt security.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHoZQHvGr7W6HudhwRAvhJAJoD1gH+d8U5WLyzxS0P6HFVLnUIbQCcCFfs
e301WKYb/PGfPEUAMsvgLmk=
=CYOD
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
