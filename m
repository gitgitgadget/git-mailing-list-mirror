From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: gitosis question: identifying/logging remote user
Date: Mon, 1 Jun 2009 23:31:58 -0700
Message-ID: <robbat2-20090602T062332-128740789Z@orbis-terrarum.net>
References: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
Cc: tv@eagain.net
To: Sitaram Chamarty <sitaramc@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 02 08:32:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBNY1-0000tG-71
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 08:32:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933AbZFBGcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 02:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753565AbZFBGcY
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 02:32:24 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:60826 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754680AbZFBGcY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 02:32:24 -0400
Received: (qmail 8513 invoked from network); 2 Jun 2009 06:32:23 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Tue, 02 Jun 2009 06:32:23 +0000
Received: (qmail 19579 invoked by uid 10000); 1 Jun 2009 23:31:58 -0700
Content-Disposition: inline
In-Reply-To: <2e24e5b90906012102y4e1e6281p437e4d88da517c08@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120496>


--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 02, 2009 at 09:32:40AM +0530, Sitaram Chamarty wrote:
> I want to be able to log the information that the post-receive hook
> receives, but I *also* want, along with that, the name of the pubkey
> that was used in this particular "push".
I've got a partial patch that I never finished for using this with the
gitosis-gentoo fork that powers git.overlays.gentoo.org. It needs
re-implementation from scratch, but here's the design notes:
1. Use the username to open the file in keydir again.
2. At the top, look for RFC822 headers with a leading "# " as padding:
   Examples from my own patch:
   # Full-Name: "Robin H. Johnson (robbat2)" <robbat2@gentoo.org>
   # cia-vc-username: robbat2
   The headers are followed by a blank line then further text is free-form
   and not parsed. Continuation lines are NOT supported.
3. The header field names are transformed to enviornoment variable names
   as follows:
   - y/[[:lower:]]/[[:upper:]]/g
   - s/-/_/g
4. Export the environment variables, named per above, with the full
   content of the rest of the line.

(We need to export the CIA.vc data, and also send off a commit mail).

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkokx14ACgkQPpIsIjIzwixkuQCeNb+6qKq4G911Vn/ek6oyxsUZ
gJsAnRfjrUjKfYUZ8HhJa7v9dMj8j3l1
=FFiW
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--
