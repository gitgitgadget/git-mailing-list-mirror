From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 12:59:32 +0100
Message-ID: <1266839972.4575.38.camel@ganieda>
References: <1266599485.29753.54.camel@ganieda>
	 <1266687636-sup-7641@ben-laptop>
	 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
	 <20100221063433.GA2840@coredump.intra.peff.net>
	 <1266754646.12035.23.camel@ganieda>
	 <20100222051748.GB10191@dpotapov.dyndns.org>
	 <1266832607.31769.37.camel@ganieda>
	 <20100222112845.GE10191@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-8VSuhiJ5dxGgotjQ9VDA"
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 14:29:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjWwx-0004MW-Qz
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 12:59:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab0BVL7j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 06:59:39 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:56269 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752402Ab0BVL7i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 06:59:38 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id A263B265F8;
	Mon, 22 Feb 2010 12:01:01 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id 196D914094E; Mon, 22 Feb 2010 12:59:32 +0100 (CET)
In-Reply-To: <20100222112845.GE10191@dpotapov.dyndns.org>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140678>


--=-8VSuhiJ5dxGgotjQ9VDA
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-02-22 at 14:28 +0300, Dmitry Potapov wrote:
> On Mon, Feb 22, 2010 at 10:56:47AM +0100, Jelmer Vernooij wrote:
> >=20
> > There is no need for that data to be added later for revisions that did
> > not originate from Bazaar. All of the metadata that has to be stored
> > will be known at the time the commit is created. Those commits that wer=
e
> > made in Git later will not have any metadata that can not be represente=
d
> > in Git (they were made with Git, after all).
> If so, I do not see why any metadata should be stored in Git at all. If
> you can work without them then why do you want to add to Git? And then
> how about commit that originated in Git then exported to Bazaar and then
> imported back at Git? It is still originated in Git and thus should not
> have any metadata despite being imported from Bazaar.
Commits that originated in Git do not contain any Bazaar-specific
metadata, even if they also lived in Bazaar at some point, because they
could not have been set by Git at commit time.=20

We would only add the metadata for revisions that did not come out of
Git originally.=20

We'd like to have the extra metadata in Git so that we can push Bazaar
commits into a Git repository losslessly. If we can't do this losslessly
then the identity of the commit changes just like it does in git if you
aren't able to produce the same tree, blob and commit objects.

> > Having a bzr/master ref means that the extra metadata will not always b=
e
> > copied around (unless git is patched), so if I push my work from Bazaar
> > into Git, somebody works on it in Git and pushes a derived branch and
> > then somebody else clones that derived Git branch into Bazaar again, I
> > will not be able to communicate with that person's branch.
> No matter how many times a branch was cloned, it is exactly same branch
> (i.e. it consists of commits having exactly the same id). So, if you can
> work with the original branch, you can work with any cloned branch. So,
> I see no need to copy this data around for people who do not work with
> Bazaar directly.
The original branch is a Bazaar branch here, so that's not true. You can
only work with any cloned branch if the matching bzr/ branch is also
around. If it isn't then you won't be able to find the original commit.=20

hg-git already does something similar by putting a --HG-- line followed
by hg-git specific metadata in the commit message when it pushes into
Git. I'd like to find a place to put this data that's not as intruisive
for users.

Cheers,

Jelmer

--=-8VSuhiJ5dxGgotjQ9VDA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLgnGYAAoJEACAbyvXKaRX8mwQAIsry8fFYyGlzTxo5Diw9E4j
uOsh6AXqJYi2W3K6nVplzO604pCWkcs99OHF8ETlr9tYu4YKhMZcDJIIIw9N3jnr
6XtkRE9zcH9tm2foIdlcKXzhbInRf74z9RE3bAPl63Fqbo5ZTyNikQ66Gq2ohfKj
exlDsne0rmE/zL5X7Ze3Y9f0XB/C2s38BDpT2lTgqEQqMzQZHXGRTtXqu/HaNQhe
h7mWNZ3P2X7bhxwUR/YmL8fOkfWF0lIC+vN/UpSrgcM0+OFKGMRKQHvIuucTi7sl
i8ZBEJtheX9dasgkmOIrEcSDwLgVPABGWNcSmVOxb6LtbhbDlSVIHIM1xF3BbTZl
JVJZx6I5/lTNajJGIOmwViCY/27sFIbvz9zeIuHnFfkvACrFZLIitcm7F4YDTl8S
golN7co1uVbJdjV6BLxN7tp1zyRfqYK/aU+XiksixgpJg+dWLiMgGuPVbVWr8D/p
5ss55z0MLQaBnIzdVy91FkkMDZM8HMukm8ymvoUizeteWMuZguRyCxasqwfqdV+p
1zt1u45HAFS8Lo4krbz8Ouz7B7Sk4YGJ861tAnZQAyCs0x7E6/o+pIziDrT0mg66
BYWSTnYNDn6uH22Xj49VmsiyHikJP3XE1leAX8rn91i+NzeVGyLkwX6+VE19xs1i
5ziVkxkOOYESAmuLz4vm
=SjKM
-----END PGP SIGNATURE-----

--=-8VSuhiJ5dxGgotjQ9VDA--
