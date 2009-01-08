From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Thu, 08 Jan 2009 12:37:33 -0800
Organization: Slide, Inc.
Message-ID: <1231447053.8870.665.camel@starfruit>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
	 <1231368935.8870.584.camel@starfruit>
	 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
	 <1231374514.8870.621.camel@starfruit>
	 <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
	 <20090108030115.GF10790@spearce.org>
	 <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>
	 <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org>
	 <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
	 <1231438552.8870.645.camel@starfruit>
	 <alpine.LFD.2.00.0901081216060.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-HjWSDv7BOA8XX22GtVZc"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 21:56:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LL1f7-00054b-Fc
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 21:39:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761898AbZAHUhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 15:37:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761102AbZAHUhr
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 15:37:47 -0500
Received: from mx0.slide.com ([208.76.68.7]:39513 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600AbZAHUhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 15:37:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=z
	nuLzLgup9VY1XEhEtV9wHKgsOFZZ5evk1SURVIaGZw=; b=rw79EN0wIKfUmnJ1B
	UVAf9L+UhwOVf78HfZZtVAcRQHD2CtYSQQH2ok6i6Whl7Wp4IjkLD7OvHw483n5w
	aqceUodEFntdIgvTMumPKEd9fJmcZWwI13S+OlVjZQkxMCyts64x7COtjjRS8FzO
	mgLg+Utj9Mg23ohd7pRpCZIJt0=
Received: from nat3.slide.com ([208.76.69.126]:37034 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LL1dG-0003KQ-Pr; Thu, 08 Jan 2009 12:37:34 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id BD15C3898319;
	Thu,  8 Jan 2009 12:37:34 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.011
X-Spam-Level: 
X-Spam-Status: No, score=-3.011 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=-0.008, BAYES_00=-2.599,
	MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HVMbeIMXezM6; Thu,  8 Jan 2009 12:37:34 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 768C938980BE;
	Thu,  8 Jan 2009 12:37:34 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901081216060.3283@localhost.localdomain>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104962>


--=-HjWSDv7BOA8XX22GtVZc
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2009-01-08 at 12:22 -0800, Linus Torvalds wrote:
>=20
> On Thu, 8 Jan 2009, R. Tyler Ballance wrote:
> > >=20
> > > Tyler - does this make the corruption errors go away, and be replaced=
 by=20
> > > hard failures with "out of memory" reporting?
> >=20
> > Yeah, looks like it:
>=20
> Well, I was hoping that you'd have a confirmation from your own huge repo=
,=20
> but I do suspect it's all the same thing, so I guess this counts as=20
> confirmation too.

I never got a real solid "consistent" reproduction case with our
repository, just a lot of users that experienced the issue. I think the
Linux repro case is a far better example, and yeah, it's sorta
confirmation (waiting for operations here to deploy the patched 1.6.1 to
dev machines).

>=20
> > > This patch is potentially pretty noisy, on purpose. I didn't remove t=
he=20
> > > reporting from places that already do so - some of them have stricter=
=20
> > > errors than this.
> >=20
> > I'm assuming this patch is going to be reworked, if so, I'll back it ou=
t
> > of our internal 1.6.1 build and anxiously await The Real Deal(tm)
>=20
> Oh, it shouldn't be any noisier under _normal_ load - it's more that=20
> certain real corruption cases will now report the error twice. That said,=
=20
> the new errors should actually be more informative than the old ones, so=20
> even that isn't necessarily all bad.
>=20
> Junio - I think we should apply this, and likely to the stable branch too=
.=20
> Add the re-trying the inflateInit() after shrinking pack windows on top o=
f=20
> it.

I really appreciate this guys, this is one of the longer threads I've
participated (spanning over a month) and I'm glad you guys were finally
able to track the issue down.

=46rom now moving forward, I'll try to get a reproduction case with the
kernel tree or something equally big since I know it's frustrating to
play the game of telephone with a proprietary code base ("try this? what
does that do? okay, then this?").

Linus, I'll have a chance to look at your comments on my "variable
packed git window size" patch this weekend, and I'll follow-up in the
appropriate thread.


I'm relatively certain that after this witch hunt, I can get Slide to
cover a round of beers at LinuxWorld or the nearest GitTogether ;)


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-HjWSDv7BOA8XX22GtVZc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklmZA0ACgkQFCbH3D9R4W/PwgCgkgdj3Fj3SbtqaHKqIuF+9fiY
I9MAn2kv7nUdIilbbL6GWXb+c+GIFOer
=2eNG
-----END PGP SIGNATURE-----

--=-HjWSDv7BOA8XX22GtVZc--
