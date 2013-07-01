From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] merge: allow using --no-ff and --ff-only at the same time
Date: Mon, 1 Jul 2013 18:10:09 +0200
Message-ID: <20130701161009.GI17269@suse.cz>
References: <20130701070143.GB17269@suse.cz>
 <51D197AD.1070502@alum.mit.edu>
 <7vmwq6i93m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fckbADODYWZD5TdN"
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 01 18:10:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UtggM-0002Kk-Oi
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jul 2013 18:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498Ab3GAQKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jul 2013 12:10:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36699 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966Ab3GAQKR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jul 2013 12:10:17 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 2B55EA52D9;
	Mon,  1 Jul 2013 18:10:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vmwq6i93m.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229303>


--fckbADODYWZD5TdN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 01, 2013 at 08:38:21AM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> As to "--no-ff" vs "--ff-only", "--ff-only" has always meant "only
> fast-forward updates are allowed.  We do not want to create a merge
> commit with this operation."  I do agree with you that the proposed
> patch changes the established semantis and may be too disruptive a
> thing to do at this point.

Hmm, one way around this may be to add a new option that is basically
the same as --no-ff --ff-only (with the patch), except it has a
different name, so it's not confusing. 'git merge --rebase' could be
used for this, but such a name is misleading as well. Anyone has a
better naming idea? :-)

> If one were designing Git merge from scratch today, however, I could
> see one may have designed these as two orthogonal switches.
>=20
>  - Precondition on the shape of histories being merged ("fail unless
>    fast forward" does not have to be the only criteria);
>=20
>  - How the update is done ("fast forward to the other head", "always
>    create a merge", "fast forward if possible, otherwise merge" do
>    not have to be the only three choices).
>=20
> I do not fundamentally oppose to such a new feature, but they have
> to interact sanely with the current "--ff=3D{only,only,never}".

OK, so if I get it right, the problem is that users got used to that
the --ff-only not only means a precondition for the merge, but also
means "either don't create a merge commit or fail", while my patch would
change this second behaviour.

I could imagine then new switches, like 'git merge --pre=3Dff
--update=3Dno-ff" could provide these, though I'm not sure if it makes
sense to add such generic switches till the only user is "ff".

--fckbADODYWZD5TdN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlHRqeEACgkQe81tAgORUJYkjwCfcmwyhrxlgCI3r5JLnqxY7LQF
6W4An2938mzM80cx+nlXG5RLlGJCQphg
=f9Ac
-----END PGP SIGNATURE-----

--fckbADODYWZD5TdN--
