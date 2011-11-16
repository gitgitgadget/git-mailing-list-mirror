From: Tim Walberg <twalberg@comcast.net>
Subject: Re: odd name-rev behavior?
Date: Tue, 15 Nov 2011 19:48:42 -0600
Message-ID: <20111116014842.GF27706@comcast.net>
References: <20111115211514.GE27706@comcast.net> <7vpqgtt1kb.fsf@alter.siamese.dyndns.org> <7vlirht1fw.fsf@alter.siamese.dyndns.org>
Reply-To: Tim Walberg <twalberg@comcast.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 16 02:54:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQUht-0001Ii-JR
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 02:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932906Ab1KPBy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 20:54:29 -0500
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:53805
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932834Ab1KPBy2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2011 20:54:28 -0500
X-Greylist: delayed 344 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Nov 2011 20:54:28 EST
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta07.westchester.pa.mail.comcast.net with comcast
	id xdoe1h00E0cZkys57dolFo; Wed, 16 Nov 2011 01:48:45 +0000
Received: from beta.localdomain ([67.184.156.247])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id xdok1h00V5LYcRf3WdokGC; Wed, 16 Nov 2011 01:48:45 +0000
Received: from calvin.localdomain ([10.0.0.8])
	by beta.localdomain with esmtp (Exim 4.69)
	(envelope-from <twalberg@comcast.net>)
	id 1RQUcE-0005Ee-TX; Tue, 15 Nov 2011 19:48:42 -0600
Received: from tew by calvin.localdomain with local (Exim 4.69)
	(envelope-from <tew@calvin.localdomain>)
	id 1RQUcE-00023a-OS; Tue, 15 Nov 2011 19:48:42 -0600
Content-Disposition: inline
In-Reply-To: <7vlirht1fw.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185503>


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

That does indeed seem to work on first try. Not sure it was
a particularly critical issue - just unexpected. For what I
was using it for it was simple to work around. But thanks
for the quick fix!

			tw


On 11/15/2011 15:23 -0800, Junio C Hamano wrote:
>>	Junio C Hamano <gitster@pobox.com> writes:
>>=09
>>	> Tim Walberg <twalberg@comcast.net> writes:
>>	>
>>	>> Never noticed this before - is this expected? It doesn't seem to
>>	>> match documentation, in any case...
>>	>>
>>	>> Basically, 'git name-rev --all' lists a lot of lines that are
>>	>> marked as "undefined", and most, if not all, of the objects
>>	>> represented are trees, not commits... I wouldn't have expected
>>	>> name-rev to follow the link from a commit to a tree and try to
>>	>> process that result...
>>	>
>>	> I wouldn't either, but this does not look like a recent breakage. v1.6=
=2E0
>>	> seems to show the same broken behaviour.
>>=09
>>	And this one-liner should be sufficient (untested).
>>=09
>>	 builtin/name-rev.c |    2 +-
>>	 1 files changed, 1 insertions(+), 1 deletions(-)
>>=09
>>	diff --git a/builtin/name-rev.c b/builtin/name-rev.c
>>	index 7864056..1b37458 100644
>>	--- a/builtin/name-rev.c
>>	+++ b/builtin/name-rev.c
>>	@@ -291,7 +291,7 @@ int cmd_name_rev(int argc, const char **argv, const =
char *prefix)
>>	 		max =3D get_max_object_index();
>>	 		for (i =3D 0; i < max; i++) {
>>	 			struct object *obj =3D get_indexed_object(i);
>>	-			if (!obj)
>>	+			if (!obj || obj->type !=3D OBJ_COMMIT)
>>	 				continue;
>>	 			show_name(obj, NULL,
>>	 				  always, allow_undefined, data.name_only);
End of included message



--=20
+----------------------+
| Tim Walberg          |
| 830 Carriage Dr.     |
| Algonquin, IL 60102  |
| twalberg@comcast.net |
+----------------------+

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAk7DFnoACgkQw+Wcj22rJWYbRgCgyDdr6uExaWb8xrLcMENChNnJ
jYsAnjGVwKfVaONztoBWPXAk6xnLEu4L
=0pf+
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
