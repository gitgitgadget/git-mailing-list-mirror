From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: epic fsck SIGSEGV! (was Recovering from epic fail (deleted
	.git/objects/pack))
Date: Wed, 10 Dec 2008 17:21:08 -0800
Organization: Slide, Inc.
Message-ID: <1228958468.27061.48.camel@starfruit.local>
References: <1228867861.14165.19.camel@starfruit.local>
	 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
	 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
	 <1228949523.27061.20.camel@starfruit.local>
	 <alpine.LFD.2.00.0812101523570.3340@localhost.localdomain>
	 <1228955062.27061.36.camel@starfruit.local>
	 <alpine.LFD.2.00.0812101636351.3340@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WmVfsJNjjg4ys6/1tBcM"
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Dec 11 02:22:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAaG7-00018T-Tu
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 02:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783AbYLKBVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 20:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753625AbYLKBVO
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 20:21:14 -0500
Received: from mx0.slide.com ([208.76.68.7]:33217 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753192AbYLKBVN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 20:21:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=y
	blnE30y2JBExAPT73brB8weRZIXNxf5aW3WtuHNOr0=; b=oHjpVe6IccjRhP1xn
	o9h4w6N9xJY5wK6hu7XchZ7BB6W3R+EJyhYtP1ymWspRCgf1PIkYyECZ/vRe+e0D
	wthWx5aXyEOGkFzUDUEYbjr6kEDg/2a7BxKELNw9tP0+mhoD0t3Ku3a6S9cMv8zM
	tF53/KC0kDTT6Nvvt7V3VvlrKI=
Received: from nat3.slide.com ([208.76.69.126]:48687 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LAaEo-0003dW-EQ; Wed, 10 Dec 2008 17:21:10 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 6950BA6F0002;
	Wed, 10 Dec 2008 17:21:10 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.003
X-Spam-Level: 
X-Spam-Status: No, score=-3.003 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599, MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1FlaSrQzEG2J; Wed, 10 Dec 2008 17:21:09 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id EF4D4A6F0001;
	Wed, 10 Dec 2008 17:21:09 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812101636351.3340@localhost.localdomain>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102763>


--=-WmVfsJNjjg4ys6/1tBcM
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-12-10 at 16:45 -0800, Linus Torvalds wrote:
>=20
> On Wed, 10 Dec 2008, R. Tyler Ballance wrote:
> >
> > The stack size is 8M as you assumed, I'm curious as to how the kernel
> > handles a process that exceeds the ulimit(2) stacksize. I know from our
> > experience with this repository that when Git runs up against the
> > address space (ulimit -v) that an ENOMEM or something similar is
> > returned. Is there an E_NOSTACK? :) (figured I'd ask, given your
> > apparent knowledge on the subject ;))
>=20
> Since stack expansion doesn't involve any system calls, and since there i=
s=20
> no way to recover from it anyway, the kernel has no choice: it just sends=
=20
> a SIGSEGV.
>=20
> An application that wants to _can_ handle this case by installing a signa=
l=20
> handler, but since signal handling needs some stack-space too, a regular=20
> "sigaction(SIGSEGV..)" isn't sufficient. You also need to set up a=20
> separate signal stack ..

Interesting, thanks for the explanation :)


> Can you try with a bigger stack? Just do
>=20
> 	ulimit -s 16384

Looks like that'll do it :) Transcript below. I'll lower the limit with
a build with Boyd's impending patch, though I assume you can probably
recreate this with a stacksize that's less than 2x your commit count.=20


>=20
> and then re-try the fsck. Just to verify that this is it. If nothing else=
,=20
> it will at least give you a working fsck, even if it's obviously not the=20
> "correct" solution.

tyler@ccnet:~/source/slide/brian_main> gdb git
GNU gdb 6.8
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show
copying"
and "show warranty" for details.
This GDB was configured as "x86_64-suse-linux"...
(gdb) run fsck --full
Starting program: /usr/local/bin/git fsck --full
error: refs/remotes/origin/master-team-test does not point to a valid
object!
error: refs/remotes/origin/wip-test does not point to a valid object!
error: refs/tags/cooltag does not point to a valid object!
dangling commit 743db07961c5076511a6d04664536863da91920c
dangling commit 525660ad1268b208d440467cd3c083aa2375ee8f
dangling commit 6587b04ff81aaa43721f32f0e443bb3b0ef2be78
dangling commit 0498400f510c0bf3dc17d533d356e46ce19f0f6b
dangling commit 61af71c12f7e608d0e68b52c4d118d7fe4be9690
dangling commit aae5318412d1ca51912c71dca8f181d605928cfc
dangling commit df6522a65a3e40f50da695303cd146852cb13c3d
dangling commit fe6643635b89700f384f0d28acd247a411d52e1a
dangling commit 7e81536bfc7fb12e1f4576cb64f55e46e7e8042a
dangling commit 92ab13d2779f7a7d46736ce041e0d5a5cde16dfb
dangling commit 00b8a3ea6d294c43140f9277bf48bbe734ded10f
dangling commit 3883d47c6dffb6163989d7c54784edb08c5a8e42
dangling commit e39fb41aa5b7ce327d64938a241d055524d0425b
dangling blob 19ccb407e4f7629880e484d08bcfd805157820ee
dangling commit a135f5ae5c4cf5e3d87e63bb102c1f59c9bf2d98
dangling blob 2fa995576ce9cb7f04a4d302d0defb24468a78da
dangling commit 06d125abdf5dd002664a3b39f372713049495db7
dangling commit 26d50600da2954a71f1e985a24497be6f9ccd9bb
dangling commit 53da563adeefee480e2230bc01fedb703185e659
dangling commit 9c06e7fefb0bdfcf096439549e7f9bba4c1b5f1e
dangling commit 8d4a571f179f04a243367615e6e04a9d7437de8a
dangling commit 734b47a3329618deeb556150e161e040bc055e5e
dangling commit 038e08581164006168b38ae3b3632592ff243346
dangling commit 92f3286443b737fb2787a157479eff93b4ec1949
dangling commit 6700599d0bd0bb20b1eb611e377a9f9628272f93
dangling commit b668393e07e4c0b3cff47484084c6dad0fc6c67c
dangling commit 9777594bd3e5e9e66b22827266ee7c0d672e63d8
dangling commit a84a1a40bfebaced5be4160a37a754841ec6839d
dangling commit 41c29a41daa556b073be46401148b71864122f10
dangling commit e4caeabd7e0bdc28bacc14f5fc3f9b7f00678e9f
dangling commit 33ce1af2009bd9ccff27950af1e4faead0dcbaa9
dangling commit 2ded0a58779e02e7e07c861e541b5d75911b9ef6
dangling commit 2148fb15b79c3bab79859e80bba35ff8e9343e4d
dangling commit cfc3fb2e13a3f7b5e53ce77db26faa4badb42c06
dangling commit e3f8bbd1a0993f080355e297d4204bfd5a079d4c
dangling commit ed11cc08822d005d6f70ea9c059ee1b1ee28b5cb
dangling commit f61e3c6094df2ca7bd421853dad108b6cf0a6be7
dangling commit a730acaa6454e76bf033b3962d13b64fb0b03ca0
dangling commit 25689c64420b7e062931045919e452afa11940bc
dangling commit 8eda5c081ddf1ba5c926f47d8bd1b3c9643d8adf
dangling commit 76dbbca6603e2a630c2cac8b65ed5ec4c9f45abd
dangling commit 41e93c5564f2e06b61baf67d34da8774d84f463d
dangling commit f2038d93f67b95034c97a5895457062a6b0c96c4
dangling commit f54a0d30f3e62234941c80487b9dcbfaa10927ad
dangling commit 02a51d79b8ab6e7f396e8a0ee5f8768bf538d112
dangling commit 80a71dd3cd4b5a301931d44bee5ef4584fa1f2e9
dangling commit 2c05de9b6db8c9f392a0ee90b796efaf862dbcfe
dangling commit b465eebed0cf5538c124393df6b0cb35f98f7d3a
dangling commit 02246f3eb943a5b0868d386e39ed5719ab0d2ca9
dangling commit e6b97f34bc6f27f4ad48041b1eb3a88e18b87f18
dangling commit 7bc80fb7f429219310e5671f7191a4d6476a4bd9

Program exited normally.
(gdb)=20


--=20
-R. Tyler Ballance
Slide, Inc.

--=-WmVfsJNjjg4ys6/1tBcM
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklAawQACgkQFCbH3D9R4W+hAgCgqRq/UpXOkLW1t84wzh5F/56X
i7EAn0XW6TZbTsqDnZxjU5VebyN/GEiE
=laOe
-----END PGP SIGNATURE-----

--=-WmVfsJNjjg4ys6/1tBcM--
