From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH/RFC] Allow writing loose objects that are corrupted in
 a pack file
Date: Tue, 06 Jan 2009 17:39:20 -0800
Organization: Slide, Inc.
Message-ID: <1231292360.8870.61.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-ZlqGm2lwCicai0WiX6si"
Cc: Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 07 02:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKNPf-0007wF-GF
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 02:40:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755431AbZAGBj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 20:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755341AbZAGBj0
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 20:39:26 -0500
Received: from mx0.slide.com ([208.76.68.7]:42352 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755336AbZAGBjZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 20:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=2
	knkOMXwFpZbSXDhXPq61dvi+IaMCn5pL9P0fMVS4+4=; b=S5KJovMofDdzBDtR6
	wFr15xtIL8UM7HyCj7Y3Mk9kl9LyqlpPNjOyBsgqNoBHG7mURfHZ5DHZsEoWLb1C
	Y1mXOMARdiaQCbVDaba/75JQchmppYE6yo85ZMw02h64b7sqMO8KI61hfChZ9S3W
	YgyZ3RNHjHHefC1tys9j9DqWQc=
Received: from nat3.slide.com ([208.76.69.126]:45361 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKNOD-00032i-2z; Tue, 06 Jan 2009 17:39:21 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 124EEA6F0002;
	Tue,  6 Jan 2009 17:39:21 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.37
X-Spam-Level: 
X-Spam-Status: No, score=-3.37 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=1.029, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nDJuYk0S7eAx; Tue,  6 Jan 2009 17:39:20 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id B5C9DA6F0001;
	Tue,  6 Jan 2009 17:39:20 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104744>


--=-ZlqGm2lwCicai0WiX6si
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-01-06 at 20:25 -0500, Nicolas Pitre wrote:
> On Tue, 6 Jan 2009, R. Tyler Ballance wrote:
>=20
> > On Tue, 2008-12-09 at 09:36 +0100, Jan Kr=C3=BCger wrote:
> > > For fixing a corrupted repository by using backup copies of individua=
l
> > > files, allow write_sha1_file() to write loose files even if the objec=
t
> > > already exists in a pack file, but only if the existing entry is mark=
ed
> > > as corrupted.
> >=20
> > I figured I'd reply to this again, since the issue cropped up again.
> >=20
> > We started experiencing *large* numbers of corruptions like the ones
> > that started the thread (one developer was receiving them once or twice
> > a day) with v1.6.0.4
> >=20
> > We went ahead and upgraded to a custom build of v1.6.1 with Jan's patch
> > (below) and the issues /seem/ to have resolved themselves. I'm not
> > certain whether Jan's patch was really responsible, or if there was
> > another issue that caused this to correct itself in v1.6.1.=20

I'll back the patch out and redeploy, it's worth mentioning that a
coworker of mine just got the issue as well (on 1.6.1). He was able to
`git pull` and the error went away, but I doubt that it "magically fixed
itself"


> Please back it out.  As it stands, that patch is a no op because of the=20
> way git is used, and even if the patch was to work as intended, its=20
> purpose is not to magically fix corruptions without special action from=20
> your part.  If you have corruption problems coming back only because of=20
> the removal of this patch then something is really really fishy and I=20
> would really like to know about it.
>=20
> There were indeed many changes between v1.6.0.4 and v1.6.1: the exact=20
> number is 1029.  A couple of them are especially addressing increased=20
> robustness against some kind of pack corruptions.  But in any case you=20
> still should see error messages appearing about them.
>=20
> And don't underestimate the power of disk corruptions.  I started to=20
> work on git corruption resilience simply because I ended up with a=20
> corrupted pack at some point.  Then a while later I got another=20
> corrupted pack.  Then another while later I lost my filesystem entirely=20
> and had to reinstall my system (after buying a new disk).  Turns out=20
> that my old disk is silently corrupting data without signaling any=20
> errors to the host.

I highly doubt this, I've got the issue appearing on at least 7
different development boxes (not workstations, 2U quad-core ECC RAM, etc
machines), while that doesn't mean that they all don't have issues, the
probability of them *all* having disk issues, and it somehow only
manifesting itself with Git usage, is low ;)

I've tarred one of the repositories that had it in a reproducible state
so I can create a build and extract the tar and run against that to
verify any patches anybody might have, but unfortunately at 7GB of
company code and assets, I can't exactly share ;)


Cheers


--=20
-R. Tyler Ballance
Slide, Inc.

--=-ZlqGm2lwCicai0WiX6si
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklkB8gACgkQFCbH3D9R4W8RQgCgl+lDqnSXpF4WjnEza6s4jPAg
gvkAnRXEyjZMem7FlgjmdblQDncPgYk4
=1bgv
-----END PGP SIGNATURE-----

--=-ZlqGm2lwCicai0WiX6si--
