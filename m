From: "R. Tyler Ballance" <tyler@slide.com>
Subject: epic fsck SIGSEGV! (was Recovering from epic fail (deleted
	.git/objects/pack))
Date: Wed, 10 Dec 2008 14:52:03 -0800
Organization: Slide, Inc.
Message-ID: <1228949523.27061.20.camel@starfruit.local>
References: <1228867861.14165.19.camel@starfruit.local>
	 <7vd4g051ax.fsf@gitster.siamese.dyndns.org>
	 <1228903606.4445.53.camel@starfruit.local> <493FAA5A.8070801@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-F4cEKsniW7a+6epHZ0XZ"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Dec 10 23:54:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAXvu-0004ZE-Ro
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 23:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752794AbYLJWwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 17:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752912AbYLJWwJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 17:52:09 -0500
Received: from mx0.slide.com ([208.76.68.7]:35918 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751697AbYLJWwH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2008 17:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=z
	VMuvbESNtTXtJfWDI6TLI2ZYro+RhfJcD/oFgCNpEU=; b=Rh136weu/Cu8wNMHa
	X9T5HDKiRxhB4xZJwdFQnpmfvqhixX61A1GWlqQ3MfwsG5BOypk4mFb08/e1mhGn
	reCTzt/1TiVq/M1XomvIxP12+KGcTM3qSkdk/4WcItQ/mnLJDWX+kPcSTuWFs1CU
	q1sVEmS7lUo61NEi/28nTdsUhE=
Received: from nat3.slide.com ([208.76.69.126]:51932 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LAXuX-0001WR-1m; Wed, 10 Dec 2008 14:52:05 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 015F1A6F0002;
	Wed, 10 Dec 2008 14:52:05 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.036
X-Spam-Level: 
X-Spam-Status: No, score=-4.036 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.363, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zZ8LTrsvQrwM; Wed, 10 Dec 2008 14:52:04 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id 98076A6F0001;
	Wed, 10 Dec 2008 14:52:04 -0800 (PST)
In-Reply-To: <493FAA5A.8070801@viscovery.net>
X-Mailer: Evolution 2.22.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102734>


--=-F4cEKsniW7a+6epHZ0XZ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2008-12-10 at 12:39 +0100, Johannes Sixt wrote:
> R. Tyler Ballance schrieb:
> > On Tue, 2008-12-09 at 16:19 -0800, Junio C Hamano wrote:
> >> See if "fsck --full" complains after that.  If the repository was not
> >> repacked during that period, all objects created by the activity by th=
e
> >> unfortunate developer would be loose, so ...
> >=20
> > tyler@ccnet:~/source/slide/brian_main> time git fsck --full
> > Segmentation fault
>=20
> Please make a backup (tarball) of the repository that shows this segfault=
.
> 'git fsck' is not supposed to segfault, no matter what garbage is thrown
> at it.
>=20
> Can you make a backtrace of this failing 'git fsck --full' invocation?

I decided to endure the 30 minutes long this took on machine, and ran
the operation in gdb. As a result, I got the SIGSEGV again, and a 13MB
stacktrace.

In fact, the stack trace was probably longer, but this happened while I
printed out `bt full`:
        #80496 0x00000000004244bc in fsck_handle_ref (refname=3D0x162aa61
        "refs/heads/master", sha1=3D0x162aa39 "S\236\024(f\210=EF=BF=BD=EF=
=BF=BDV\027=EF=BF=BD'=EF=BF=BDE
        \025=EF=BF=BDu=EF=BF=BDg",
            flag=3D<value optimized out>, cb_data=3D<value optimized out>)
        at builtin-fsck.c:118
                obj =3D <value optimized out>
        #80497 0x000000000047f61c in do_for_each_ref (base=3D0x4a7022
        "refs/", fn=3D0x424450 <fsck_handle_ref>, trim=3D0, cb_data=3D0x0) =
at
        refs.c:582
        [1]    29388 segmentation fault (core dumped)  gdb git
        tyler@ccnet:~/source/slide/brian_main>=20
       =20
The "full" trace is here:
http://pineapple.monkeypox.org/scratch/git-1.6.0.2-fsck-sigsegv.trace

I think I'm going to need to have a drink :-/

--=20
-R. Tyler Ballance
Slide, Inc.

--=-F4cEKsniW7a+6epHZ0XZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklASBMACgkQFCbH3D9R4W91tQCfUHzCBMmfa0YTL8b8+dsm7T0q
mKQAn06zHEb/ebrfn/zdevvgyqHLNKEw
=PTYt
-----END PGP SIGNATURE-----

--=-F4cEKsniW7a+6epHZ0XZ--
