From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git'ing a non-labeled set of sources
Date: Thu, 9 Aug 2007 22:02:18 +0200
Message-ID: <20070809200218.GA4567@efreet.light.src>
References: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: git@vger.kernel.org
To: "Sparks, Sam" <SSparks@twacs.com>
X-From: git-owner@vger.kernel.org Thu Aug 09 22:02:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJEDb-0003XV-TD
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 22:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757336AbXHIUCb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Aug 2007 16:02:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755700AbXHIUCb
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 16:02:31 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:46217 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756178AbXHIUCa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2007 16:02:30 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 783E55748B;
	Thu,  9 Aug 2007 22:02:28 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id VaazYdqeOYMX; Thu,  9 Aug 2007 22:02:24 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 83D3B5745A;
	Thu,  9 Aug 2007 22:02:24 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IJED4-00032J-Rz; Thu, 09 Aug 2007 22:02:18 +0200
Content-Disposition: inline
In-Reply-To: <CF7E46FCFF66AD478BB72724345289EC170CE4@twx-exch01.twacs.local>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55469>


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 08, 2007 at 13:59:38 -0500, Sparks, Sam wrote:
> Hello All,
>=20
> Please excuse me if this is an ignorant question; I'm new to git and my
> have overlooked something in the documentation.
>=20
> I'm attempting to obtain a snapshot of source code from an unlabeled git
> branch in a public repository. I've found in the documentation that a
> timestamp cannot be used to specify a particular version of source code,
> but I believe I can work with the commit value as returned by 'git
> show'.

Clone and pull, over git protocol, only ask the server for objects referenc=
ed
by any refs -- plus all objects those depend on. Which does not necessarily
mean all commits, because references may be removed.

If a branch (ie. ref in refs/heads) is removed or rewound (moved to point to
commit that is not descendant of what it pointed to before), some commits m=
ay
become dangling. Clone and pull won't know such commits exist and therefore
won't be able to ask server to provide them.

> However, I have been unsuccessful in my attempts to use this identifier
> to clone or checkout the associated source tree. Has anyone been
> successful in using git to successfully replicate an unlabeled version
> of sources in a repository?
>=20
> Here is my latest attempt:
> /dir_i_want_to_replicate $ git show --pretty=3Dshort
> commit 5b1313fb2758ffce8b624457f777d8cc6709608d
> Author: ....

I bet that if you do 'git lost-found' here, it will find something and this
commit will be among the finds, or predecessor of one of them.

> /replication_dir $ git clone git://www.denx.de/git/u-boot.git
> u-boot-mpc83xx
> Blah blah blah..
>  100% (4378/4378) done
> /replication_dir/u-boot-mpc83xx/ $ git checkout
> 5b1313fb2758ffce8b624457f777d8cc6709608d
> error: pathspec '5b1313fb2758ffce8b624457f777d8cc6709608d' did not match
> any.=20

It seems that git pull only accepts refs as arguments. So you'll have to
create a branch at that commit in the origin to get it over to destination.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGu3LKRel1vVwhjGURAulOAKDMPs8fdgt7nRm/ThEQN3/Q08hn2gCfaWv4
DZ74HFDlv65QVapSzLpQzoI=
=q+f5
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
