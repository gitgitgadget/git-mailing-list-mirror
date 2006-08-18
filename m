From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb: use common parameter parsing and generation for "o", too.
Date: Fri, 18 Aug 2006 22:20:13 +0200
Message-ID: <20060818202013.GB30022@admingilde.org>
References: <11557673213372-git-send-email-tali@admingilde.org> <ec1d6q$823$2@sea.gmane.org> <20060817191300.GA11477@admingilde.org> <200608172134.38751.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 18 22:20:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEApJ-0004JJ-B1
	for gcvg-git@gmane.org; Fri, 18 Aug 2006 22:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWHRUUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Aug 2006 16:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbWHRUUR
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 16:20:17 -0400
Received: from agent.admingilde.org ([213.95.21.5]:1670 "EHLO
	mail.admingilde.org") by vger.kernel.org with ESMTP id S932506AbWHRUUP
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 16:20:15 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1GEApC-0008Ny-0D; Fri, 18 Aug 2006 22:20:14 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200608172134.38751.jnareb@gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25694>


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Thu, Aug 17, 2006 at 09:34:38PM +0200, Jakub Narebski wrote:
> > Perhaps we can agree that only the validation should be coupled with the
> > actual user?  E.g. use normal validate_input() for it and then check
> > for actual values inside git_project_list (which is already done now).
>=20
> The validate_input() function has too generic name and is too widely used:
> it should be split into validate_ref() and validate_path(); perhaps "o"
> should be validate with $order =3D~ m/^[a-zA-Z]$/=20

agreed.

> But I was thinking about moving parameter parsing to the "action" functio=
ns
> which use them, the opposite of what you want to do...

but only short-term.

I think we both agree on the same target:
we need some simple to pass parameters to a function which should only
be called if the user clicks on a specific link.

Now lets talk about the interface to do this.

We need one interface for generating the URL (stub in RPC talk)
and one for calling the function once the link is clicked (skeleton).
We now have the href() function which is not so bad for the stub side.
We now need a nice generic skeleton.

Perhaps introduce a new function which is used to access the parameters?
This new function could check the URL or CGI->param or whatever and then
return the requested value.

Then the action functions could get all parameters they need, validate
them themselves and then act on them.
This would suit my "break out parameter parsing from actions" and your
"validate parameters in the action function".
(And I really interpret your sentence in such a way that you only want
to move the _validation_, not the actual parsing (which is done inside
CGI->param at the moment.)

--=20
Martin Waitz

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE5iD9j/Eaxd/oD7IRAuATAJ9Qoj2fjt8DyNhASdOSP9LT2VIgHQCfVFQv
9ePbaOdwyzorhoH/Yc2u6bQ=
=du2Q
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
