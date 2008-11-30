From: David Bryson <david@statichacks.org>
Subject: Re: Managing websites with git
Date: Sun, 30 Nov 2008 09:07:22 -0800
Message-ID: <20081130170722.GJ6572@eratosthenes.sbcglobal.net>
References: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Cc: git@vger.kernel.org
To: Felix Andersen <felix@nibbo.se>
X-From: git-owner@vger.kernel.org Sun Nov 30 18:10:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6poM-0001kp-TT
	for gcvg-git-2@gmane.org; Sun, 30 Nov 2008 18:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751912AbYK3RIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2008 12:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751890AbYK3RIq
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Nov 2008 12:08:46 -0500
Received: from cryptobackpack.org ([64.105.32.74]:43972 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751805AbYK3RIp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2008 12:08:45 -0500
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 2764210D0243; Sun, 30 Nov 2008 09:08:45 -0800 (PST)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 3FA6910D0032;
	Sun, 30 Nov 2008 09:08:44 -0800 (PST)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 3B92A1A83C9; Sun, 30 Nov 2008 09:07:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <fe5a74300811300830x850d81csc5cf1f9b367bac11@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101978>


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Nov 30, 2008 at 05:30:30PM +0100 or thereabouts, Felix Andersen wro=
te:
> Hi!
>=20
> Is it a bad idea to manage websites (php/xhtml/css) by having a origin
> non-bare repo in the hosted dir with the hook mentioned here:
> http://git.or.cz/gitwiki/GitFaq#head-b96f48bc9c925074be9f95c0fce69bcece5f=
6e73.
> I was thinking about any security issues with the .git dir being
> hosted. Or is that even the right way to do it?
>=20

One really should not push to a non-bare repo.  IIRC there was a patch
recently to disallow it, but I do not remember if it was merged into
HEAD.

Since I knew the patch was coming I rewrote my scripts to use a bare
repo in /var/git, and push the changes to /var/www whenever I push to
the remote repo.

I wrote my post-update to be something like the following.

#!/bin/bash
LIVE=3D"/var/www/statichacks/blosxom"

ref=3D$1

cd $GIT_DIR
echo "Pushing updates to $LIVE..."
git archive --format=3Dtar $ref | tar -C $LIVE --atime-preserve -xpf -

There may be an easier way to do it, but that script took me about 5
minutes to write and test.

Dave


--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkyyEkACgkQLfsM4nS2FiAGDwCeJvZe9ASQ9hMXmmj3eu7yTQuB
oV4An0PGe3gPxgOpc5973DWEBPjDMl/h
=U+av
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
