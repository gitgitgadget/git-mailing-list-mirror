From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: git rebase: unexpected conflict
Date: Sun, 4 Feb 2007 21:05:19 +0200
Message-ID: <20070204190519.GB29029@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 04 20:04:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDmfW-0004XD-HF
	for gcvg-git@gmane.org; Sun, 04 Feb 2007 20:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbXBDTEx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 14:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752505AbXBDTEx
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 14:04:53 -0500
Received: from p02c11o143.mxlogic.net ([208.65.145.66]:60553 "EHLO
	p02c11o143.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492AbXBDTEw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Feb 2007 14:04:52 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 35e26c54.2676644784.69123.00-001.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 04 Feb 2007 12:04:51 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.50]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 4 Feb 2007 21:06:54 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun,  4 Feb 2007 21:04:48 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 04 Feb 2007 19:06:54.0393 (UTC) FILETIME=[A24E9290:01C7488F]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14974.000
X-TM-AS-Result: No--1.092700-4.000000-31
X-Spam: [F=0.3075861392; S=0.307(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38700>

git rebase seems to see conflicts where there shouldn't be any.

Example: I have a tree here:

git://git/openfabrics.org/~vlad/ofed_1_2/.git

and have efedfe57a21a134a65d951bcca73af46da609c5e
checked out (I think it moved since, but you can create
a branch if you like).

This is tree from Linus + some extra drivers added
(it's large (as kernel trees often are), so use
 Linus' tree as a reference if you want to clone it).

Now, I decided I don't like 9b3bfe5696aa417d38ce903eb345a03d65743dd2,
and since no one is likely to have a clone of this tree,
it should be OK to remove it from history with git rebase.

So I did:

git-rebase --onto 9b3bfe5696aa417d38ce903eb345a03d65743dd2~1 \
		9b3bfe5696aa417d38ce903eb345a03d65743dd2

and it starts replaying the changes I pulled from Linus' tree:

--------------------------
=46irst, rewinding head to replay your work on top of it...
HEAD is now at 6cc583d... IB/sdp: allow users via module parameter to b=
ound SDP's memory use

Applying '[JFFS2] kill warning RE debug-only variables'

Wrote tree 3a03db80ed42fda246e5e8420699e22cdd6fff89
Committed: c0427b1c39aeb86ea7b97a25ed7b623ac563b516

Applying '[MTD NAND] Initial import of CAF=C9 NAND driver.'

Adds trailing whitespace.
=2Edotest/patch:44:/*
Adds trailing whitespace.
=2Edotest/patch:93:
Adds trailing whitespace.
=2Edotest/patch:225:              /* Ignore the first command of a pair=
; the hardware
Adds trailing whitespace.
=2Edotest/patch:242:      dev_dbg(&cafe->pdev->dev, "dlen %x, ctl1 %x, =
ctl2 %x\n",
Adds trailing whitespace.
=2Edotest/patch:507:
warning: squelched 2 whitespace errors
warning: 7 lines add trailing whitespaces.
Wrote tree 18cdff711481cdb4c495a846a7776203198dfc87
Committed: 4cfaf4dd2573cd695603f31c404f3b66e1515487

Applying '[MTD] SSFDC must depend on BLOCK'

Wrote tree c91cb50928089c0968d40a14432085db58b12614
Committed: 60a9aa8868bab0821b8cdb05f711e7a812584800

Applying '[MTD NAND] OLPC CAF=C9 driver update'

Adds trailing whitespace.
=2Edotest/patch:119:      cafe_dev_dbg(&cafe->pdev->dev, "dlen %x, ctl1=
 %x, ctl2 %x\n",
Adds trailing whitespace.
=2Edotest/patch:198:/* Ick. The BBT code really ought to be able to wor=
k this bit out
warning: 2 lines add trailing whitespaces.
Wrote tree 3c7c72650eea2c613569ca51bc47775beca984c9
Committed: fc6406731b3fe302d630317593483fbde9abe8d4

Applying '[MTD] MAPS: Add parameter to amd76xrom to override rom window=
 size'

Wrote tree ae4567223d6b8ed5408ca0b63611b0f7962589aa
Committed: c4f773a7476520b5459ddbb83df5fe143eec4626

Applying '[MTD] CHIPS: Support for SST 49LF040B flash chip'

Wrote tree c5038d0ec22dbc4ba571c9a82697a43f8dd2bd9b
Committed: f19c8f26bc9849531b28d48430c09e0359976a3e

Applying '[MTD] MAPS: Support for BIOS flash chips on Intel ESB2 southb=
ridge'

Wrote tree 169159ae4017bc3838a01ad737fae53efa150a09
Committed: c6ec7ab7ef424713c6bf62fa436b95912c18db3a

Applying '[JFFS2] Use rb_first() and rb_last() cleanup'

Wrote tree 53862b25b4bbd4c7e57cc893025545ce235eb1b8
Committed: 0f45697d933b9db1edae3cac0a59284cdae5656f

Applying '[MTD] JEDEC probe: fix comment typo (devic)'

Wrote tree 82173259dd1c133e7f9c5879fd096ba658f69cb4
Committed: 2119a3d1d4af4bfbcb72494b994ce52d0d6ad08b

Applying '[MTD] MAPS: esb2rom: use hotplug safe interfaces'

Wrote tree cab550abb9f4d577243bb6492706922c58cd9a44
Committed: 4d7f42ad97194199da7ad4ec0ae80ce5399b7554

Applying '[JFFS2] Fix jffs2_follow_link() typo'

Wrote tree fe9d6afb990115817aae90716640e5588c79c7c6
Committed: 29cd2f5afa2aa8a8ea7842437f6cdd534605a70e

Applying '[MTD] NAND: AT91 NAND driver'

error: patch failed: drivers/mtd/nand/Kconfig:232
error: drivers/mtd/nand/Kconfig: patch does not apply
Using index info to reconstruct a base tree...
=46alling back to patching base and 3-way merge...
 100% (22053/22053) done
Auto-merged drivers/mtd/nand/Kconfig
CONFLICT (content): Merge conflict in drivers/mtd/nand/Kconfig
Auto-merged drivers/mtd/nand/Makefile
=46ailed to merge in the changes.
Patch failed at 0012.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip"=
=2E
To restore the original branch and stop rebasing run "git rebase --abor=
t".
--------------------------

Sure enough, there are conflicts in drivers/mtd/nand/Kconfig:

<<<<<<< HEAD:drivers/mtd/nand/Kconfig
config MTD_NAND_CAFE
       tristate "NAND support for OLPC CAF=C9 chip"
       depends on PCI
       help
         Use NAND flash attached to the CAF=C9 chip designed for the $1=
00
         laptop.
=3D=3D=3D=3D=3D=3D=3D
config MTD_NAND_AT91
        bool "Support for NAND Flash / SmartMedia on AT91"
        depends on MTD_NAND && ARCH_AT91
        help
          Enables support for NAND Flash / Smart Media Card interface
          on Atmel AT91 processors.
>>>>>>> [MTD] NAND: AT91 NAND driver:drivers/mtd/nand/Kconfig

But I don't really understand where do the conflicts come from:
The patch I skipped (9b3bfe5696aa417d38ce903eb345a03d65743dd2)
only touched the file drivers/infiniband/core/addr.c,
so why can't rebase replay all of the changes?

--=20
MST
