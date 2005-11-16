From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: fix git-pack-redundant crashing sometimes
Date: Wed, 16 Nov 2005 22:11:28 +0100
Message-ID: <20051116211128.GA13975@steel.home>
References: <81b0412b0511150749g5672158v7b39c02ffdf13e08@mail.gmail.com> <20051115213442.GA4256@steel.home> <437A560E.8020500@etek.chalmers.se> <20051115223340.GA3951@steel.home> <437A6B8A.8060905@etek.chalmers.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Nov 16 22:15:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcUZL-000884-TX
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 22:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVKPVLt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 Nov 2005 16:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVKPVLt
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 16:11:49 -0500
Received: from devrace.com ([198.63.210.113]:47378 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932608AbVKPVLs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Nov 2005 16:11:48 -0500
Received: from tigra.home (p54A0CE2A.dip.t-dialin.net [84.160.206.42])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAGLBU0V097836;
	Wed, 16 Nov 2005 15:11:31 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EcUYz-0000WQ-00; Wed, 16 Nov 2005 22:11:29 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EcUYy-0003zZ-Uy; Wed, 16 Nov 2005 22:11:28 +0100
To: Lukas =?iso-8859-15?Q?Sandstr=F6m?= <lukass@etek.chalmers.se>
Content-Disposition: inline
In-Reply-To: <437A6B8A.8060905@etek.chalmers.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12058>

Lukas Sandstr=F6m, Wed, Nov 16, 2005 00:13:14 +0100:
> After giving it a quick look, I don't think it locks up. It is just h=
orribly
> slow. get_all_permutations returns (nice ASCII-art follows)
>=20
>     ___n___
>     \
>      \ ____1____
> n! * /  k!(n-k)!
>     /______
>       k=3D1
>=20
> permutations, which for your case (22 packs) adds up to 4194303.
>=20
> I'll look into an optimization so we won't have to call is_superset
> for every one of them.
>=20
> OTOH, I might be wrong and it could very well be an infinite loop.
> Mind running it over the night? I won't look further into this in
> 20 hours or so anyway.

It doesn't lock up:

$ time git-pack-redundant --all --alt-odb
=2Egit/objects/pack/pack-3c5133604508466855453f3e609428f4bbba9131.idx
=2Egit/objects/pack/pack-3c5133604508466855453f3e609428f4bbba9131.pack
=2E..

real    24m55.277s
user    24m50.778s
sys     0m0.582s

Now I shall be called "too impatient", perhaps?
