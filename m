From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: Consolidate SHA1 object file close
Date: Thu, 12 Jun 2008 18:00:12 +0200
Message-ID: <20080612160012.GA13533@artemis.madism.org>
References: <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org> <alpine.LFD.1.10.0806110952290.3101@woody.linux-foundation.org> <alpine.LFD.1.10.0806101842460.3101@woody.linux-foundation.org> <20080611074309.GB28629@artemis.madism.org> <alpine.LFD.1.10.0806110755190.3101@woody.linux-foundation.org> <20080611154020.GE28629@artemis.madism.org> <alpine.LFD.1.10.0806111030580.3101@woody.linux-foundation.org> <20080611222534.GC16439@artemis.madism.org> <alpine.LFD.1.10.0806120758090.3041@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="8t9RHnE3ZwKMSgU+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jun 12 18:01:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6pEd-0008SF-G4
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 18:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753498AbYFLQAR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 12:00:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbYFLQAR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 12:00:17 -0400
Received: from pan.madism.org ([88.191.52.104]:41526 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751279AbYFLQAP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 12:00:15 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id D0F05356C1;
	Thu, 12 Jun 2008 18:00:13 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 98AD73A76; Thu, 12 Jun 2008 18:00:12 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Denis Bueno <dbueno@gmail.com>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806120758090.3041@woody.linux-foundation.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84764>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2008 at 03:33:53PM +0000, Linus Torvalds wrote:
> IOW, there are safety nets in place, but they tend to be fairly easily=20
> broken under certain circumstances.

  Right, though this is a LAN with really few switches between the
clients and the server, and the issue happens with any client with that
setup.

> Add to the above the possibility of just a kernel NFS bug (or a NFSd one)=
,=20
> and it would really be very interesting to hear:
>=20
>  - do the errors seem to happen more at certain clients than others?

  Not really, it happens more often with the script I inlined in one of
my mails, than with the one I attached to it. And people working on
_pure_ NFS have the issue a bit less than the ones using their workdir
on a separate local device. That's all I can tell for now.

  One of the developper told me that this pattern of use triggers the
problem more for him: he has a 'master' branch checkouted in his NFS
home, and a 'local' branch on his local hard drive workdir[0]. The issue
happens more when he's working on the two workdirs at the same time
(for a value of "at the same time" that is like in the same minute, not
at the same nanosecond of course, he never commits in both workdirs at
the same time).  When he only works in his NFS 'master' or the local
'local' branch, it happens really less often.

>    If it's a client-side problem, it really should happen more for certai=
n=20
>    kernel versions or certain hardware.

  It doesn't afaict. Clients are heterogenous in kernel versions (.18,
=2E22, .24, .25 for whate I've seen), and in hardware (all machines are
Dell computers, but from really different years, hence different mobos
and NICs. Some even have non Dell gigabit NICs in them).


>  - have you had any other anecdotal evidence of problems with non-git=20
>    usage? Unexplained SIGSEGV's if you have binaries over NFS, for=20
>    example? Strange syntax errors when compiling over NFS?

  Not really no. Our NFS server is remarkably stable with anything else
(it's also remarkably slow compared to local drives but that's not
really relevant ;p).

> I'm not discounting a git bug, but quite frankly, it really is worth=20
> checking that your network/NFS setup is solid.

  Well to date I'd say it's quite solid. We are a software company and
even have tested our software (that does heavy use of mmap, pread,
pwrite, and other things that NFS is not often dealing with very well)
on that very server without a glitch that could have been attributed to
NFS (I mean we've had tons of bugs, but it was always in our software in
the end ;p). Though we really rarely pread what we just pwrite-d or
things like that, so maybe we never triggered a possible kernel bug
either :)


  [0] the reason of that setup is that when we work on topic branches,
      we sometimes spot big bugs that are small to fix, and we use the
      "NFS" master branch to push those bugfixes as soon as we find
      them, whereas local is pushed only when the feature is ready.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkhRSAoACgkQvGr7W6HudhzLHgCgh3iGjpJ6l8rCOYCOQAyNoi4X
Sd0An2PZsL/NYwp4rcdTU4kgmKTAmEei
=yX92
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
