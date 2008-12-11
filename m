From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted
	.git/objects/pack))
Date: Wed, 10 Dec 2008 16:24:22 -0800
Organization: Slide, Inc.
Message-ID: <1228955062.27061.36.camel@starfruit.local>
References: <1228867861.14165.19.camel@starfruit.local>
	 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
	 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
	 <1228949523.27061.20.camel@starfruit.local>
	 <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-donjSPsBH/t3dY3Dw1Q0"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:25:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAZND-0001Wi-Ni
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 01:25:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbYLKAY2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 19:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753088AbYLKAY1
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 19:24:27 -0500
Received: from mx0.slide.com ([208.76.68.7]:33013 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752903AbYLKAY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 19:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=G
	OA0Uu8N76BTOZE0D5w4l6uE7BqfsVbS28ZbD3nD7k0=; b=x95denh0JUhmfV5ki
	Vwg6JFlavl8vrYZn56PfFXi8eovQVKrYKQXDN5+EYOa0cd91K7C4fRAu8DNAtyIn
	lx98AIUye6GQnYDnfjq3JCfwGdeXiD3yc1Q9lqFzNDuFgxxqagzpJUQT9CkdtmF0
	9/BAm/A5Sh0xyxIzxB+Rahw/ho=
Received: from nat3.slide.com ([208.76.69.126]:56543 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LAZLs-0004uo-Fq; Wed, 10 Dec 2008 16:24:24 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 72E59A6F0002;
	Wed, 10 Dec 2008 16:24:24 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.003
X-Spam-Level: 
X-Spam-Status: No, score=-3.003 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599, MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 67VWc-nD-RyF; Wed, 10 Dec 2008 16:24:24 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 1BE67A6F0001;
	Wed, 10 Dec 2008 16:24:24 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102752>


--=-donjSPsBH/t3dY3Dw1Q0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-12-10 at 15:40 -0800, Linus Torvalds wrote:
>=20
> Wow. You even got _gdb_ to segfault.
>=20
> You're my hero. If it can break, you will do it.

You have no idea :) So much so that a coworker got me a "FAIL" stamp for
my birthday:
http://agentdero.cachefly.net/pictotweet.com//saved/6f217a5ababb06185d5e4ca=
1398e743c/PIC-012835841677481.jpg )

Anyways..

>=20
> That stupid fsck commit walker walks the parents recursively. That's=20
> horribly bogus. So you have a recursion that goes from the top-level=20
> commit all the way to the root, doing
>=20
> 	fsck_walk_commit -> walk(parent) -> fsck_walk-commit -> ..
>=20
> and you have a fairly deep commit tree.=20

This repository is ~3 years old and ~7.1GB small, when we finally cut
over from Subversion we were in the 130,000 revision range.=20

> Anyway, with a 8M stack-size I can fsck the kernel repo without any=20
> problem, but while the kernel repo has something like 120k commits in it,=
=20
> it's a very "bushy" repository (lots of parallelism and merges), and the=20
> path from the top parent to the root is actually much shorter, at just 27=
k=20
> commits.

The stack size is 8M as you assumed, I'm curious as to how the kernel
handles a process that exceeds the ulimit(2) stacksize. I know from our
experience with this repository that when Git runs up against the
address space (ulimit -v) that an ENOMEM or something similar is
returned. Is there an E_NOSTACK? :) (figured I'd ask, given your
apparent knowledge on the subject ;))

>=20
> I take it that your project has a very long and linear history, which is=20
> why you have a long path from your HEAD to your root.
>=20
> (You can do something like
>=20
> 	git rev-list --first-parent HEAD | wc -l

tyler@ccnet:~/source/slide/brian_main>  git rev-list --first-parent HEAD
| wc -l
46751=20
tyler@ccnet:~/source/slide/brian_main> uname -a
Linux ccnet 2.6.25.18-0.2-default #1 SMP 2008-10-21 16:30:26 +0200
x86_64 x86_64 x86_64 GNU/Linux
tyler@ccnet:~/source/slide/brian_main> git --version
git version 1.6.0.2


>=20
> But we should definitely fix this braindamage in fsck. Rather than=20
> recursively walk the commits, we should add them to a commit list and jus=
t=20
> walk the list iteratively.

Given that this issue affects our internal (proprietary) repository, I
can't very well give access to it or publish a clone, but I'm willing to
help in any way I can. We maintain an internal fork of the Git tree, so
I can apply any changes you'd like to an internal 1.6.0.4 or 1.6.0.5
build. For obvious reasons I ran the fsck against an upstream maintained
(stable) build of Git.


Cheers


p.s. If you find yourself in downtown San Francisco, we'd be honored to
buy you a drink here at Slide :)
--=20
-R. Tyler Ballance
Slide, Inc.

--=-donjSPsBH/t3dY3Dw1Q0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklAXbYACgkQFCbH3D9R4W9ntQCdG0qN5fqbqLUgtPyiHpEWCjCc
tJwAnjcUNDZ4WSn0ZrsRbjs1IycpZv8s
=W4To
-----END PGP SIGNATURE-----

--=-donjSPsBH/t3dY3Dw1Q0--
