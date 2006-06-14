From: Keith Packard <keithp@keithp.com>
Subject: Re: Repacking many disconnected blobs
Date: Wed, 14 Jun 2006 14:05:15 -0700
Message-ID: <1150319115.30681.54.camel@neko.keithp.com>
References: <1150269478.20536.150.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0606140826200.5498@g5.osdl.org>
	 <1150307715.20536.166.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0606141113130.5498@g5.osdl.org>
	 <1150311567.30681.28.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0606141514000.2703@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MUhB75UBcXH3WrLTTdgv"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 14 23:06:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqcYa-0002k0-EF
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWFNVFj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Jun 2006 17:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWFNVFj
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jun 2006 17:05:39 -0400
Received: from home.keithp.com ([63.227.221.253]:16138 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S932291AbWFNVFi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Jun 2006 17:05:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id B707613001F;
	Wed, 14 Jun 2006 14:05:37 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 08776-02-2; Wed, 14 Jun 2006 14:05:37 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 7BB9A13001E; Wed, 14 Jun 2006 14:05:37 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 3DE5E14001;
	Wed, 14 Jun 2006 14:05:37 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id 207E554337; Wed, 14 Jun 2006 14:05:16 -0700 (PDT)
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606141514000.2703@localhost.localdomain>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21863>


--=-MUhB75UBcXH3WrLTTdgv
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-06-14 at 15:25 -0400, Nicolas Pitre wrote:

> The only advantage of feeding object names from latest to oldest has to=20
> do with the delta direction.  In doing so the delta are backward such=20
> that objects with deeper delta chain are further back in history and=20
> this is what you want in the final pack for faster access to the latest=20
> revision.

Ok, so I'm feeding them from latest to oldest along each branch, which
optimizes only the 'master' branch, leaving other branches much further
down in the data file. That should mean repacking will help a lot for
repositories with many active branches.

> In that case it=20
> might be preferable that the reuse of already deltified data is made of=20
> backward delta which is the reason you might consider feeding object in=20
> the prefered order up front.

Hmm. As I'm deltafying along branches, the delta data should actually be
fairly good; the only 'bad' result will be the sub-optimal object
ordering in the pack files. I'll experiment with some larger trees to
see how much additional savings the various repack options yield.

--=20
keith.packard@intel.com

--=-MUhB75UBcXH3WrLTTdgv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkHoLQp8BWwlsTdMRArjoAJ0csRQKLbM13RMEag7VOkidRzyjSwCgqESG
f4fAuCb0Ma1ciPdR7lDcK+E=
=3ZZy
-----END PGP SIGNATURE-----

--=-MUhB75UBcXH3WrLTTdgv--
