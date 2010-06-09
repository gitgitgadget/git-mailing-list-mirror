From: Carl Worth <cworth@cworth.org>
Subject: Re: [PATCH] format-patch: Properly escape From_ lines when creating an mbox.
Date: Wed, 09 Jun 2010 00:04:06 -0700
Message-ID: <87bpbkit5l.fsf@yoom.home.cworth.org>
References: <1276045305-20743-1-git-send-email-cworth@cworth.org> <7vljaorhjq.fsf@alter.siamese.dyndns.org> <4C0F2B3C.4060203@zytor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git <git@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 09 09:04:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OMFKr-0006Od-4q
	for gcvg-git-2@lo.gmane.org; Wed, 09 Jun 2010 09:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755422Ab0FIHEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jun 2010 03:04:20 -0400
Received: from u15218177.onlinehome-server.com ([74.208.220.233]:58443 "EHLO
	olra.theworths.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755354Ab0FIHES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jun 2010 03:04:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id BE7344196F2;
	Wed,  9 Jun 2010 00:04:17 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at olra.theworths.org
Received: from olra.theworths.org ([127.0.0.1])
	by localhost (olra.theworths.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZyWR8SPz1Pv6; Wed,  9 Jun 2010 00:04:06 -0700 (PDT)
Received: from yoom.home.cworth.org (localhost [127.0.0.1])
	by olra.theworths.org (Postfix) with ESMTP id 8B047431FC1;
	Wed,  9 Jun 2010 00:04:06 -0700 (PDT)
Received: by yoom.home.cworth.org (Postfix, from userid 1000)
	id 74229568FE2; Wed,  9 Jun 2010 00:04:06 -0700 (PDT)
In-Reply-To: <4C0F2B3C.4060203@zytor.com>
User-Agent: Notmuch/0.3.1-54-g42e146a (http://notmuchmail.org) Emacs/23.1.1 (i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148745>

--=-=-=
Content-Transfer-Encoding: quoted-printable

On Tue, 08 Jun 2010 22:48:44 -0700, "H. Peter Anvin" <hpa@zytor.com> wrote:
> > Perhaps perfect is an enemy of good?
>=20
> For production perhaps we should do the MIME-escape thing?
>=20
> For consumption, it's not so clear...

I suggest as a first step accepting the following:

	format-patch: Emit bare email rather than mbox for single messages.
	<id:1276040615-26008-1-git-send-email-cworth@cworth.org>

That patch should be entirely uncontroversial since it doesn't introduce
any new escaping, neither on the production nor on the consumption side.

It has the tremendous benefit of removing the mbox format entirely from
the "git send-email" workflow, (which will just use bare messages
instead).

With that patch in place, the only place that git will still generate
mbox files is "format-patch --stdout". And the most common use of that
is within git-rebase. For git-rebase, it doesn't matter what kind of
mbox is used as long as it's consistent, since it's practically
guaranteed that git-rebase will be using consistent versions of both
"git format-patch" and "git am".

At that point, I think discussion of confusion from new format-patch and
old am becomes almost meaningless as such interaction will most likely
be happening through bare messages rather than mbox files. When an mbox
file *is* involved I think it will be even more likely to happen through
some external program, (such as an MUA collecting a thread of
git-send-email messages and presenting them to "git am" as an mbox).

=2DCarl

=2D-=20
carl.d.worth@intel.com

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iD8DBQFMDzzm6JDdNq8qSWgRAkLzAJ9k3hqnFB17+WNNyW8A2fcBEu7ICACghT6l
4M+/Pq6Exn5Cz+QEBM5lWwg=
=N8V6
-----END PGP SIGNATURE-----
--=-=-=--
