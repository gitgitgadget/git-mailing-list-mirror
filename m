From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 7 Feb 2007 22:05:08 +0200
Message-ID: <20070207200508.GE12140@mellanox.co.il>
References: <7vr6t17ohb.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEt23-0006h2-He
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:04:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161435AbXBGUEk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 7 Feb 2007 15:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbXBGUEk
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:04:40 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:51111 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161435AbXBGUEj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Feb 2007 15:04:39 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 6d03ac54.1966611376.50953.00-008.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Wed, 07 Feb 2007 13:04:38 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Feb 2007 22:06:46 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed,  7 Feb 2007 22:02:27 +0200
Content-Disposition: inline
In-Reply-To: <7vr6t17ohb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 07 Feb 2007 20:06:46.0080 (UTC) FILETIME=[7E5BC400:01C74AF3]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14984.001
X-TM-AS-Result: No--16.509000-4.000000-31
X-Spam: [F=0.2841480236; S=0.284(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38957>

> Quoting Junio C Hamano <junkio@cox.net>:
> Subject: Re: git rebase: unexpected conflict
>=20
> "Michael S. Tsirkin" <mst@mellanox.co.il> writes:
>=20
> > When you have resolved this problem run "git rebase --continue".
> > If you would prefer to skip this patch, instead run "git rebase --s=
kip".
> > To restore the original branch and stop rebasing run "git rebase --=
abort".
> > --------------------------
> >
> > Sure enough, there are conflicts in drivers/mtd/nand/Kconfig:
> >
> > <<<<<<< HEAD:drivers/mtd/nand/Kconfig
> > config MTD_NAND_CAFE
> >        tristate "NAND support for OLPC CAF=C9 chip"
> >        depends on PCI
> >        help
> >          Use NAND flash attached to the CAF=C9 chip designed for th=
e $100
> >          laptop.
> > =3D=3D=3D=3D=3D=3D=3D
> > config MTD_NAND_AT91
> >         bool "Support for NAND Flash / SmartMedia on AT91"
> >         depends on MTD_NAND && ARCH_AT91
> >         help
> >           Enables support for NAND Flash / Smart Media Card interfa=
ce
> >           on Atmel AT91 processors.
> >>>>>>>> [MTD] NAND: AT91 NAND driver:drivers/mtd/nand/Kconfig
> >
> > But I don't really understand where do the conflicts come from:
> > The patch I skipped (9b3bfe5696aa417d38ce903eb345a03d65743dd2)
> > only touched the file drivers/infiniband/core/addr.c,
> > so why can't rebase replay all of the changes?
>=20
> That is because David Woodhouse has an evil merge at
> c45aa055c32b488fc3fd73c760df372b09acf69a.
>=20
> Running "git show" on that commit would tell you the story.

Sorry about being dense. What's evil there?
There seems to have been a merge, and a conflict was resolved.

mst@mst-lt:~/scm/linux-2.6$ git show c45aa055c32b488fc3fd73c760df372b09=
acf69a
commit c45aa055c32b488fc3fd73c760df372b09acf69a
Merge: 784f4d5... 8dd851d...
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Sun Oct 22 02:17:05 2006 +0100

    Merge git://git.infradead.org/~dwmw2/cafe-2.6

    Conflicts:

        drivers/mtd/nand/Kconfig

diff --cc drivers/mtd/nand/Kconfig
index b4b1656,5e97e63..564f79d
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@@ -219,6 -219,6 +219,13 @@@ config MTD_NAND_SHARPS
        tristate "Support for NAND Flash on Sharp SL Series (C7xx + oth=
ers)"
        depends on MTD_NAND && ARCH_PXA

++config MTD_NAND_CAFE
++       tristate "NAND support for OLPC CAF=C9 chip"
++       depends on PCI
++       help
++       Use NAND flash attached to the CAF=C9 chip designed for the $1=
00
++       laptop.
++
  config MTD_NAND_CS553X
        tristate "NAND support for CS5535/CS5536 (AMD Geode companion c=
hip)"
        depends on MTD_NAND && X86_32 && (X86_PC || X86_GENERICARCH)

--=20
MST
