From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: add --date option
Date: Wed, 2 Dec 2009 22:07:51 +0100
Message-ID: <20091202210751.GC31763@genesis.frugalware.org>
References: <1259627252-21615-1-git-send-email-vmiklos@frugalware.org>
 <20091202192614.GD30778@coredump.intra.peff.net>
 <7vpr6xcgki.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CLLB+19uC8aeq76E"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 02 22:08:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwQe-0005g2-U3
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754301AbZLBVHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbZLBVHq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:07:46 -0500
Received: from virgo.iok.hu ([212.40.97.103]:46551 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753016AbZLBVHq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:07:46 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 490115809B;
	Wed,  2 Dec 2009 22:07:52 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 07C6242F0A;
	Wed,  2 Dec 2009 22:07:52 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id C63D81240011; Wed,  2 Dec 2009 22:07:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vpr6xcgki.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134400>


--CLLB+19uC8aeq76E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 02, 2009 at 11:38:05AM -0800, Junio C Hamano <gitster@pobox.com> wrote:
>  - We should honor GIT_AUTHOR_DATE if --reset-author is given.

This is already a situation, as far as I see.

>  - I _think_ we should ignore GIT_AUTHOR_DATE if --reset-author is not
>    given, as --amend/-c/-C is stronger for being command line options than
>    an environment variable.

We already ignore GIT_AUTHOR_DATE if --reset-author is not given, also
when I change it like this:

diff --git a/builtin-commit.c b/builtin-commit.c
index e93a647..7234c7d 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -397,7 +397,8 @@ static void determine_author_info(void)

                name = xstrndup(a + 8, lb - (a + 8));
                email = xstrndup(lb + 2, rb - (lb + 2));
-               date = xstrndup(rb + 2, eol - (rb + 2));
+               if (!date)
+                       date = xstrndup(rb + 2, eol - (rb + 2));
        }

        if (force_author) {

tests 27, 33, 38 and 39 fail in t7501-commit.sh.

--CLLB+19uC8aeq76E
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAksW1ycACgkQe81tAgORUJYxngCglzQla+wr5lzC0Jz6etlCCMUz
lTIAoKM3+zfGcu9ujVCRcgKdcoI0PwJy
=oRL6
-----END PGP SIGNATURE-----

--CLLB+19uC8aeq76E--
