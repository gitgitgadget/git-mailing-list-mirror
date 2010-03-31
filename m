From: Jan =?UTF-8?B?U3TEmXBpZcWE?= <jan@stepien.cc>
Subject: Re: [PATCH] gitweb: The "Owner" column can be hidden
Date: Wed, 31 Mar 2010 15:16:48 +0200
Message-ID: <20100331151648.dbd8bd45.jan@stepien.cc>
References: <1270026409-29543-1-git-send-email-jstepien@users.sourceforge.net>
	<m3eij0iy5m.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 15:25:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwxuz-000668-Mf
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 15:25:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933291Ab0CaNZF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Mar 2010 09:25:05 -0400
Received: from r245-52.iq.pl ([86.111.245.52]:35113 "EHLO stepien.cc"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757451Ab0CaNZE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 09:25:04 -0400
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Mar 2010 09:25:03 EDT
Received: from localhost.localdomain (chello089078159032.chello.pl [89.78.159.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by stepien.cc (Postfix) with ESMTPSA id 2FC4C2A10358;
	Wed, 31 Mar 2010 15:16:55 +0200 (CEST)
In-Reply-To: <m3eij0iy5m.fsf@localhost.localdomain>
X-Mailer: Sylpheed 3.0.1 (GTK+ 2.18.9; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143672>

On Wed, 31 Mar 2010 03:28:24 -0700 (PDT)
Jakub Narebski <jnareb@gmail.com> wrote:
> Jan St=C4=99pie=C5=84  <jstepien@users.sourceforge.net> writes:
>=20
> > This commit adds $show_owner_column configuration variable which al=
lows
> > to hide the project list "Owner" column if desired.
> >
>=20
> This commit message is a bit lacking, in that it does not describe
> *why* one would want to hide "Owner" column in projects list page.
> It is not described either why "Owner" column is unique among all
> other columns, in that it is the only column that can be hidden.
>=20
> Besides for completeness you might want to hide "Owner" row in projec=
t
> summary page.
>=20

The reason why I think gitweb should allow hiding the "Owner" row are
situations when its used for displaying a single person's repositories.
In such situation repeating the owner's name in each row may be
unnecessary in one's point of view and an option for hiding the whole
column could be a solution.

> > Signed-off-by: Jan St=C4=99pie=C5=84 <jstepien@users.sourceforge.ne=
t>
> > ---
> >  gitweb/gitweb.perl |    9 ++++++---
> >  1 files changed, 6 insertions(+), 3 deletions(-)
>=20
> While "Gitweb config file variables" section in gitweb/README does no=
t
> need to include _all_ gitweb configuration variables, you should thin=
g
> about it whether to include description of '$show_owner_column' (or
> just '$show_owner') in gitweb/README, and whether to include note
> about this variable in "Projects list file format" in this file.
>=20

I agree with you on adding it to the "Gitweb config file variables"
section. On the other hand, I think that mentioning it in "Projects
list file format" isn't necessary unless '$show_owner' would affect the
way the projects list file would be parsed.

> >=20
> > diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> > index a2d2283..95f7f06 100755
> > --- a/gitweb/gitweb.perl
> > +++ b/gitweb/gitweb.perl
> > @@ -160,6 +160,9 @@ our @diff_opts =3D ('-M'); # taken from git_com=
mit
> >  # the gitweb domain.
> >  our $prevent_xss =3D 0;
> > =20
> > +# presense of the projects list "Owner" column
>=20
> I'd rather have here
>=20
> +# If false, hide "Owner" column on projects list page, and "Owner" r=
ow
> +# in the project summary page.
>=20

Yes, that sounds better.

> > +our $show_owner_column =3D 1;
>=20
> Perhaps it should be '$show_owner', or '$hide_owner'.
>=20

Agreed. Given that displaying owner information is the default behaviou=
r
I guess that "$hide_owner" or "$omit_owner" will be a better name for
it.

> BTW. if it would hide owner everywhere, you might want to skip
> generating / reading projects owners.
>=20

Broadening the scope of this variable and hiding owner information also
on the project info page is more than I initially thought of, but it
seems like a good idea. In this case I'll add skipping owner generation
to the next version of the patch.

Thanks for comments!

Cheers,
--=20
Jan St=C4=99pie=C5=84 <jan@stepien.cc>
