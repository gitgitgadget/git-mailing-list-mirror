From: martin f krafft <madduck@debian.org>
Subject: Re: [topgit] tg update error
Date: Fri, 13 Feb 2009 07:28:18 +0100
Organization: The Debian project
Message-ID: <20090213062818.GB16434@piper.oerlikon.madduck.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker> <20090212125621.GB5397@sigill.intra.peff.net> <7veiy3l689.fsf@gitster.siamese.dyndns.org> <20090212214106.GC26573@piper.oerlikon.madduck.net> <7vocx7i6xh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PEIAKu/WMn1b1Hv9"
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
	Aneesh Kumar <aneesh.kumar@gmail.com>, git@vger.kernel.org,
	pasky@suse.cz
X-From: git-owner@vger.kernel.org Fri Feb 13 07:30:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXrYu-0006y3-Lr
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 07:30:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbZBMG2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 01:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbZBMG2l
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 01:28:41 -0500
Received: from clegg.madduck.net ([193.242.105.96]:45034 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbZBMG2k (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 01:28:40 -0500
Received: from wall.oerlikon.madduck.net (wall.oerlikon.madduck.net [IPv6:2001:41e0:ff12::1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 7C6771D409B;
	Fri, 13 Feb 2009 07:28:19 +0100 (CET)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [IPv6:2001:41e0:ff12:0:211:2fff:fe6b:c869])
	by wall.oerlikon.madduck.net (Postfix) with ESMTPS id AE1689F13D;
	Fri, 13 Feb 2009 07:28:18 +0100 (CET)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 6A0BA4463; Fri, 13 Feb 2009 07:28:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vocx7i6xh.fsf@gitster.siamese.dyndns.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux 5.0 kernel 2.6.26-1-amd64 x86_64
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.2/8985/Thu Feb 12 23:11:57 2009 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109711>


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Junio C Hamano <gitster@pobox.com> [2009.02.13.0014 +0100]:
> > TopGit would need to make a proper branch, merge the bases into
> > it, merge that branch into the topic branch, and the probably
> > delete the branch pointer, as it's no longer needed and would
> > only pollute the refs/heads/* namespace.
>=20
> So it happens purely inside TopGit and the end user never sees
> a state that HEAD points outside refs/heads/, right?

Yes.

> Why can't the base flipping operation you descibed be done on
> detached HEAD?  Perhaps with a shell variable or two that hold
> commit object names you need to keep track of while it is doing is
> work?

I am not sure I understand. Isn't that what's currently happening?

Have a look at line 110 of tg-update.sh:

  http://git.debian.org/?p=3Dcollab-maint/topgit.git;a=3Dblob;f=3Dtg-update=
=2Esh;hb=3DHEAD#l110

> But the end users don't.  If TopGit dies (or killed) during the base
> flipping operation, doesn't the end user left in a funny state (granted, a
> detached HEAD is also a funny state, but it is already a known funny state
> they are familiar with.  HEAD that is a symref but points outside
> refs/heads/ is a lot funnier).

If topgit is killed, yes, then the repo could be left in a funny
state. I suppose this could be addressed by putting proper traps in
place.

If the merge fails, however, then the user is advised what to do;
see lines 114ff.

> You did not actually answer a larger question.

It wasn't asked to me before... ;)

> What other undocumented features/restrictions does the code depend
> on, that tightening them to help normal git users inadvertently
> may cause breakages similar to this one in TopGit?

I think Petr would need to help out answering this.

I agree that it would be good to address each such occurrence in
turn and replace it with a method that only makes use of the public
API. Up until now, however,

  git checkout -q "refs/top-bases/$name"

was not really something undocmented or restricted. I find it rather
difficult to separate
public-as-in-every-user-can-and-should-use-this features from
restricted-better-be-left-alone-unless-you-really-know-what-you-are-doing
features with Git. This has gotten *a lot* better, but the fact that
I can still call e.g. git update-ref (as opposed to e.g. git
_update-ref)  and potentially turn my repository upside down
exemplifies this.

Maybe Petr remembers all the instances when he sneakily used tricks
to make things work, and then we can look at each of them in turn.

Maybe some of you could go through the code (which isn't /that/
much), looking for instances of not-so-public API abuse and help us
identify them too.

Cheers,

--=20
 .''`.   martin f. krafft <madduck@d.o>      Related projects:
: :'  :  proud Debian developer               http://debiansystem.info
`. `'`   http://people.debian.org/~madduck    http://vcs-pkg.org
  `-  Debian - when you have better things to do than fixing systems
=20
"without music, life would be a mistake."
                                                 - friedrich nietzsche

--PEIAKu/WMn1b1Hv9
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkmVEwIACgkQIgvIgzMMSnUR8wCg2aBz7scHHx3Cs7NotIP1D2Nr
03MAn0K0Xyp8xRKo1dsifN6nbl5y/ZD1
=Zc8i
-----END PGP SIGNATURE-----

--PEIAKu/WMn1b1Hv9--
