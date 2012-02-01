From: Thomas Dickey <dickey@his.com>
Subject: Re: [PATCH] Correct singular form in diff summary line for human
	interaction
Date: Wed, 01 Feb 2012 04:40:06 -0500
Message-ID: <20120201094006.GA3989@debian50-32.invisible-island.net>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <20120131152028.GA10717@burratino> <7vvcnr92y0.fsf@alter.siamese.dyndns.org>
 <CACsJy8Dd4_Pnvzxww38EfZt8NgRow+qxCReohc45XoNpfJCbYg@mail.gmail.com>
 <20120201015606.GA24482@debian50-32.invisible-island.net>
 <7vk4475k5s.fsf@alter.siamese.dyndns.org>
Reply-To: dickey@his.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=X1bOJ3K7DJ5YkBrT
Cc: dickey@his.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 10:40:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsWg7-0001e1-Rv
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 10:40:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756079Ab2BAJk1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 04:40:27 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:52860 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756072Ab2BAJkV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 04:40:21 -0500
Received: from par-debian50-32.invisible-island.net
 ([unknown] [96.241.212.238]) by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LYP00FXRK6VM420@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 01 Feb 2012 03:40:08 -0600 (CST)
Received: from par-debian50-32.invisible-island.net (localhost [127.0.0.1])
	by par-debian50-32.invisible-island.net (8.14.3/8.14.3/Debian-5+lenny1)
 with ESMTP id q119e6PE004832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT); Wed,
 01 Feb 2012 04:40:07 -0500
Received: (from tom@localhost)	by par-debian50-32.invisible-island.net
 (8.14.3/8.14.3/Submit) id q119e6UV004831; Wed, 01 Feb 2012 04:40:06 -0500
Content-disposition: inline
In-reply-to: <7vk4475k5s.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189505>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 31, 2012 at 07:04:15PM -0800, Junio C Hamano wrote:
> Thomas Dickey <dickey@his.com> writes:
>=20
> > On Wed, Feb 01, 2012 at 08:32:43AM +0700, Nguyen Thai Ngoc Duy wrote:
> >> On Wed, Feb 1, 2012 at 12:50 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> >> >> If there is an environment variable to say "I don't want to see
> >> >> variations on strings intended for humans", can it be spelled as
> >> >> LC_ALL=3DC?
> >> >
> >> >  ...
> >
> > ... diffstat (google helped find context)
>=20
> When we show diffstat from "git diff --stat" (or "git apply --stat"), we
> currently do not do any singular/plural on the last line of the output
> that summarizes the graph, ending up with:
>=20
> 	1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> when there is a single line insertion to a file and nothing else.
>=20
> My recollection is that our behaviour originally came from our desire to
> be as close as what "diffstat" produces, but that does not seem to be the
> case.  I observed that the output from recent versions of "diffstat" is
> much more human friendly.  We get these, depending on the input, from
> "diffstat" version 1.53:

I added the PLURAL() macro in 1.22, in 1996/3/16, which was a few months
before Tony Nugent commented that it was being used by other people.  Since
I'd been sending patches with diffstat's since mid-1994, it's possible
that there were a few copies using the form without plurals.  But it's
been quite a while.  Also, it was in 1998/1/17 that I modified the
copyright notice (1.26) at the request of someone in the Linux group, so
I'd assume that they would have started using the newer version.

Except for later applying PLURAL to the number of files changed (which Jean
Delvare pointed out in 2005), the message construction has not changed since
then.  The insert/delete/modify parts of the message were optional as you s=
ee in
my earliest version (1.3) from 1993/10/23:

	printf("%d files changed", num_files);
	if (total_ins) printf(", %d insertions", total_ins);
	if (total_del) printf(", %d deletions", total_del);
	if (total_mod) printf(", %d modifications", total_mod);
	printf("\n");
=20
>         1 file changed, 1 insertion(+)
>         1 file changed, 1 deletion(-)
> 	0 files changed
> 	2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> Namely, it does singular/plural correctly, and omits unnecessary "0
> deletions(-)" and "0 insertions(+)".
>=20
> I was wondering if you remember what the behaviour of older versions of
> "diffstat" was, and if it was changed to be more human friendly over
> time. It is very possible that I am misremembering this and "diffstat" has
> always done the singular/plural correctly and omitted useless "0 lines".

I have back to 1.3 in my archive. I use rcshist to look for things like thi=
s.
(also, for small things like this, I have a script that pulls all versions,
with proper timestamps to make it simpler to sort the files by date).
=20
> Somehow it seems hard to get hold of older versions of "diffstat", and I
> was hoping that I could get that information straight out of the current
> maintainer.

I can provide the information.

Actually a couple of weeks ago I was experimenting with rcs-fast-export, but
found that would need more work to export diffstat (I use branches a lot)
I'm using "conflict" as a test-case for the changes that I'm making to supp=
ort
exporting mawk.

> Thanks for responding and sorry for the lack of context of the original
> message.

no problem - google was helpful ;-)

--=20
Thomas E. Dickey <dickey@invisible-island.net>
http://invisible-island.net
ftp://invisible-island.net

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk8pCHYACgkQcCNT4PfkjtujrwCgwjV/vJE/6EQ9C5L3em5eIk8Q
fZ4An37MPbbTMJTmMo8nijK92EdLIcUm
=kkEV
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
