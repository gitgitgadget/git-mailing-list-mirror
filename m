From: Keith Packard <keithp@keithp.com>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 11:02:05 -0700
Message-ID: <1150480925.6983.15.camel@neko.keithp.com>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
	 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
	 <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
	 <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
	 <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
	 <1150478968.6983.7.camel@neko.keithp.com>
	 <9e4733910606161044h736c9675kc91ff77904c5a1d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MgqxIL/A9Yw8pNxao9E1"
Cc: keithp@keithp.com, Linus Torvalds <torvalds@osdl.org>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 20:03:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrIeX-0007hR-FM
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 20:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWFPSCg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 14:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750878AbWFPSCg
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 14:02:36 -0400
Received: from home.keithp.com ([63.227.221.253]:59140 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750783AbWFPSCf (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Jun 2006 14:02:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 676FD13001F;
	Fri, 16 Jun 2006 11:02:34 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 23547-01; Fri, 16 Jun 2006 11:02:32 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id C28FE13001E; Fri, 16 Jun 2006 11:02:31 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id E8E6814002;
	Fri, 16 Jun 2006 11:02:30 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id F06C7542B2; Fri, 16 Jun 2006 11:02:05 -0700 (PDT)
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606161044h736c9675kc91ff77904c5a1d0@mail.gmail.com>
X-Mailer: Evolution 2.6.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21959>


--=-MgqxIL/A9Yw8pNxao9E1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-06-16 at 13:44 -0400, Jon Smirl wrote:

> I've been extracting versions from cvs and adding them to git now for
> 2.5 days and the process still isn't finished. It is completely CPU
> bound. It's just a loop of cvs co, add it to git, make tree, commit,
> etc.

To do all of mozilla using parsecvs (even with the quadratic algorithm)
takes about three hours on annarchy.freedesktop.org (two dual-core
Opteron with 4GB memory), including all conversion to packs. The pack
time is a tiny fraction of that.

> What about the cvs2svn algorithm described in the attachment? A ram
> based version could be faster. Compression could be acheived by
> switching from using the full path to a version to the sha1 for it.

Yes, parsecvs currently keeps everything in memory when doing the tree
conversion, which means it grows to a huge size to compute the full tree
of revisions. Computing git tree objects from the top down, then
computing commit objects from the bottom up should allow us to free most
of that during the full branch history computation process. I'm starting
a rewrite of parsecvs to try this approach and see how well it works.

If you've looked at the parsecvs source code, you'll notice it's a mess
at present; I started by attempting to do pair-wise tree merges in a
mistaken attempt to convert a linear term to log. Hacking that code into
its present form should be viewed more as a demonstration of how the
overall process can work, not as an optimal expression of the algorithm.

--=20
keith.packard@intel.com

--=-MgqxIL/A9Yw8pNxao9E1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEkvIdQp8BWwlsTdMRAvQ+AJ98+qALObg4ynkyiVnWAhTydMb8jwCeLBbA
CDm8SHiTcESeMZqR+36Ahpc=
=PMoV
-----END PGP SIGNATURE-----

--=-MgqxIL/A9Yw8pNxao9E1--
