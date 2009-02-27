From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: git-svn woes
Date: Fri, 27 Feb 2009 16:02:14 -0500
Message-ID: <1235768206-sup-2071@ntdws12.chass.utoronto.ca>
References: <alpine.LFD.2.00.0902271442270.5511@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; boundary="=-1235768536-405280-26579-8860-70-="; micalg="pgp-sha1"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	normalperson <normalperson@yhbt.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:03:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ld9s4-0002zw-QJ
	for gcvg-git-2@gmane.org; Fri, 27 Feb 2009 22:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754185AbZB0VCW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Feb 2009 16:02:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754061AbZB0VCV
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Feb 2009 16:02:21 -0500
Received: from [192.82.128.5] ([192.82.128.5]:36559 "EHLO
	www.cquest.utoronto.ca" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753576AbZB0VCU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2009 16:02:20 -0500
Received: from ntdws12.chass.utoronto.ca ([128.100.160.253] ident=93)
	by www.cquest.utoronto.ca with esmtp (Exim 4.43)
	id 1Ld9qb-0003pq-Th; Fri, 27 Feb 2009 16:02:17 -0500
Received: from localhost
	([127.0.0.1] helo=ntdws12.chass.utoronto.ca ident=505)
	by ntdws12.chass.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Ld9qb-0002lt-R3; Fri, 27 Feb 2009 16:02:17 -0500
Received: (from bwalton@localhost)
	by ntdws12.chass.utoronto.ca (8.13.8/8.13.8/Submit) id n1RL2Gos010653;
	Fri, 27 Feb 2009 16:02:16 -0500
In-Reply-To: <alpine.LFD.2.00.0902271442270.5511@xanadu.home>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111716>


--=-1235768536-405280-26579-8860-70-=
Content-Type: text/plain; charset=UTF-8

Excerpts from Nicolas Pitre's message of Fri Feb 27 15:37:16 -0500 2009:
> |Use of uninitialized value $lc_author in concatenation (.) or string at /home/nico/libexec/git-core/git-svn line 964.
> |Use of uninitialized value $lc_rev in concatenation (.) or string at /home/nico/libexec/git-core/git-svn line 965.
> |Use of uninitialized value $t in gmtime at /home/nico/libexec/git-core/git-svn line 4743.
> |Use of uninitialized value $t in numeric comparison (<=>) at /home/nico/libexec/git-core/git-svn line 4744.
> |Use of uninitialized value $t in subtraction (-) at /home/nico/libexec/git-core/git-svn line 4745.
> |Use of uninitialized value $t in localtime at /home/nico/libexec/git-core/git-svn line 4746.

All of the $t references are due to the patch I kicked in a few days
back.  $t is set to the first function argument, which in this case
was passed as a null reference.  Should $t default to time() in this
circumstance?  That would match the previous behaviour when
localtime(shift) was used, although it may mask errors like this...?

If so, I'll submit a small patch for that asap.

As for why it's getting a null reference if it shouldn't be, I'll
leave that for the people that know the svn part of this.

HTH.
-Ben
-- 
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302

GPG Key Id: 8E89F6D2; Key Server: pgp.mit.edu
Contact me to arrange for a CAcert assurance meeting.

--=-1235768536-405280-26579-8860-70-=
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFJqFTY8vuMHY6J9tIRAkAQAJoC1GE0IrbY84fTBAIIpy9syi+bfwCfXzEn
W9WMuHVoeMgSH6ju3tSeY68=
=Mcyb
-----END PGP SIGNATURE-----

--=-1235768536-405280-26579-8860-70-=--
