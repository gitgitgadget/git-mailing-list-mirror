From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 2/2] builtin-merge: avoid run_command_v_opt() for
	recursive
Date: Mon, 11 Aug 2008 22:45:11 +0200
Message-ID: <20080811204511.GV18960@genesis.frugalware.org>
References: <cover.1218374062.git.vmiklos@frugalware.org> <3db5bd9a8fa1fefb9bd188cc148db826b77fec12.1218374062.git.vmiklos@frugalware.org> <ea5b9868df7c17c55cd091b4408f08a310bed641.1218374062.git.vmiklos@frugalware.org> <7vhc9rxuc4.fsf@gitster.siamese.dyndns.org> <20080811190705.GQ18960@genesis.frugalware.org> <7vvdy7wc8j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XG0jWBK27HhJN4nS"
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 22:46:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSeHa-0001zX-Sg
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 22:46:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbYHKUpE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 16:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753051AbYHKUpE
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 16:45:04 -0400
Received: from virgo.iok.hu ([193.202.89.103]:60881 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858AbYHKUpD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 16:45:03 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 849871B2530;
	Mon, 11 Aug 2008 22:45:00 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7ABDF4465E;
	Mon, 11 Aug 2008 21:53:04 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 8FE921190002; Mon, 11 Aug 2008 22:45:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vvdy7wc8j.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91997>


--XG0jWBK27HhJN4nS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2008 at 01:03:24PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> I was not worried too much about "the other strategy will" case, but isn't
> the general structure of git-merge driver be:
>=20
>     - do some set-up computation, and leave info in .git/
>     - call strategy
>     - depending on how it exits, perform further operation (such as
>       writing out tree out of index and updating HEAD) using the info in
>       .git it left before it called strategy, and clean up whatever was
>       done in the first step (things like "drop the index lock"?).

atexit() will take care of this. I'll send a testcase for this in a bit,
I just wrote it because I was not exactly sure about this.

> Dying in the strategy and not allowing the clean-up was what I was worried
> about.  If you can guarantee that you are not going to leave the
> repository in a wedged state, calling merge-recursive internally is
> perfectly fine, but the codepaths involved need to be carefully vetted for
> that.

As far as I see there are no such codepaths, but I may be wrong; in that
case new tests will be needed as well, since the current 'make test'
output is happy. ;-)

--XG0jWBK27HhJN4nS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkigpNcACgkQe81tAgORUJaamQCfR67lUA3p95fI3EXuUHhJuP6E
rNQAn2bs0Nk6ushi838PdxIufMPjLiAi
=hy6m
-----END PGP SIGNATURE-----

--XG0jWBK27HhJN4nS--
