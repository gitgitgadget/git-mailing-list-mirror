From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 1/4] builtin-clone: fix a memory leak in cmd_clone()
Date: Tue, 25 Nov 2008 23:40:05 +0100
Message-ID: <20081125224005.GG4746@genesis.frugalware.org>
References: <cover.1227227976.git.vmiklos@frugalware.org> <6bd31bceb3840f14d747972b4858e1c5b215744d.1227227976.git.vmiklos@frugalware.org> <7vabbpok6v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wmhq21yAGFMoSpeN"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 25 23:41:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L56b0-0005QF-9b
	for gcvg-git-2@gmane.org; Tue, 25 Nov 2008 23:41:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbYKYWkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 17:40:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYKYWkI
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 17:40:08 -0500
Received: from virgo.iok.hu ([212.40.97.103]:46045 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058AbYKYWkH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 17:40:07 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 817E65809E;
	Tue, 25 Nov 2008 23:40:05 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 66EB54465E;
	Tue, 25 Nov 2008 23:40:05 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2219011901A1; Tue, 25 Nov 2008 23:40:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vabbpok6v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101690>


--wmhq21yAGFMoSpeN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2008 at 07:51:36PM -0800, Junio C Hamano <gitster@pobox.com> wrote:
> Can't this be done much earlier?  This variable can potentially be
> assigned to work_tree, but after we set up the atexit handler neither dir
> nor work_tree are not used (it is a bit hard to see as this function
> itself is a bit too big to be maintainable).

Hm, reading the code again I think you should just drop 1/4.

work_tree is a pointer to dir, and junk_work_tree is a pointer to
work_tree. junk_work_tree is used in the signal handler, so it has to be
allocated during the whole clone.

I guess it was just an accident that my patch passed the tests.

Sorry for the mistake.

--wmhq21yAGFMoSpeN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkksfsUACgkQe81tAgORUJYzQQCgnm8VMDvMtcAtHjbxnfdmGze+
YZsAnipkp4Np+i8sIcjAh5znCGJQR59G
=PrLz
-----END PGP SIGNATURE-----

--wmhq21yAGFMoSpeN--
