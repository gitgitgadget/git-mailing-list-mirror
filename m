From: =?UTF-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
Subject: Re: [PATCH 2/2] git-submodule: support 'rm' command.
Date: Thu, 28 Jun 2012 22:31:06 +0200
Organization: Gentoo
Message-ID: <20120628223106.5bc9735e@pomiocik.lan>
References: <1340621820-19448-1-git-send-email-mgorny@gentoo.org>
	<1340621820-19448-2-git-send-email-mgorny@gentoo.org>
	<4FE898BC.2020307@web.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA256;
 boundary="Sig_/0dZhIz.aHyFmoF=ilqPkx2U"; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jun 28 22:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SkLNM-0003Wh-7f
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jun 2012 22:31:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752923Ab2F1Ubd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jun 2012 16:31:33 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:52105 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab2F1Ubc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2012 16:31:32 -0400
Received: from pomiocik.lan (unknown [83.238.241.18])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: mgorny)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4B60A1B400C;
	Thu, 28 Jun 2012 20:31:31 +0000 (UTC)
In-Reply-To: <4FE898BC.2020307@web.de>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200795>

--Sig_/0dZhIz.aHyFmoF=ilqPkx2U
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Jun 2012 18:58:36 +0200
Jens Lehmann <Jens.Lehmann@web.de> wrote:

> Am 25.06.2012 12:57, schrieb Micha=C5=82 G=C3=B3rny:
> > Add an 'rm' command to git-submodule which provides means to
> > (semi-)easily remove git submodules.
> >=20
> > Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
> > ---
> > Right now, it requires the submodule checkout to be removed manually
> > first (so it does not remove unstaged commits), and just removes
> > the index entry and module information from config.
> >=20
> > I based it on 'cmd_add' code trying to preserve the original coding
> > standards.
>=20
> I really like the goal of this patch but would prefer that "git rm"
> learns how to remove submodules instead of adding more code to the
> git-submodule.sh script.

My main intent was, like Phil already pointed out, to provide
a counterpart to 'git submodule add'. I don't mind 'git rm' supporting
removing submodules but that's not exactly what I would consider...
friendly?

What I'm trying to express is that if I added a submodule using 'git
submodule add', I would expect to have 'git submodule rm'. Honestly, I
didn't even think about trying using 'git rm' on a submodule.
The correct results of such a call are hard to predict to me.

> Also it shouldn't be necessary for the user to remove the directory
> by hand before running "git rm". At least all files recorded in the
> submodule can be removed (and if the submodule uses a gitfile that
> can be removed too). Then all that is left are untracked files the
> user has to decide what to do with (which might be removed too when
> running "git rm --recurse-submodules=3Duntracked").

Except for the untracked files there may also be commits which were not
pushed anywhere. Honestly, I didn't want to get into that risky area in
the first patch.

As the next step, I'd see adding a '--force' option to actually enforce
removing the directory. But I'd like the basics to start working first,
then consider harder things.

> > ++
> > +This command removes the submodule from the current git index,
> > +the .gitmodules file and the local repository config.
>=20
> It should not be removed from .git/config by default. The user may
> have special settings there and the presence in .git/config shows
> he cared about having the submodule checked out, which should not
> be revoked by just removing the submodule from the work tree.
> Unless he removes the config from there himself he should get back
> a populated submodule when he checks out an earlier commit and says
> "git submodule update".

Ok, I will change that.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--Sig_/0dZhIz.aHyFmoF=ilqPkx2U
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAQEIAAYFAk/svwoACgkQfXuS5UK5QB0cfgP/drUIBH2bS3XdmL9UkXgC+FFQ
9TIIrK3CBIdpUeeQxHhfimL1TCPKtOKbWvroZZ8NpFepF3qJy7sr29lLVberRgEs
6992e6x6hj2CZAi1qjhqZQVlMyj5pzNkI/l986D8N3zsiU8jia03hyujks/ngNv3
47apWXve05TfA+1GFm0=
=Rl9U
-----END PGP SIGNATURE-----

--Sig_/0dZhIz.aHyFmoF=ilqPkx2U--
