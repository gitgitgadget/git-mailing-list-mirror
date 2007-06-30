From: walt <wa1ter@myrealbox.com>
Subject: Question about git-prune
Date: Sat, 30 Jun 2007 09:29:04 -0700
Organization: git-testers
Message-ID: <Pine.LNX.4.64.0706300915440.16800@x2.ybpnyarg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 30 18:29:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4fp8-0005r9-7a
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 18:29:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754624AbXF3Q3T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 12:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754652AbXF3Q3T
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 12:29:19 -0400
Received: from main.gmane.org ([80.91.229.2]:46157 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754238AbXF3Q3S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 12:29:18 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1I4fow-0006f8-RI
	for git@vger.kernel.org; Sat, 30 Jun 2007 18:29:14 +0200
Received: from adsl-69-234-198-180.dsl.irvnca.pacbell.net ([69.234.198.180])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 18:29:14 +0200
Received: from wa1ter by adsl-69-234-198-180.dsl.irvnca.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 18:29:14 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-69-234-198-180.dsl.irvnca.pacbell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51223>

I'm wondering why git-prune seems to work differently on the two git
repositories I track (Junio's and Linus's).

Specifically, when I use git-prune on Linus's kernel, all the dangling
objects disappear completely, and git-fsck shows no objects remaining.

But this is what happens with Junio's repository:

$cd src/git
$git-fsck
dangling tree c642c018aa55d39fff061183f58062de9d8375ac
dangling commit e1341abc3759950e891822088cb0163b71b316b3
dangling commit 9f38e1ef7e7992ca490b9b419f52fb4d11efb0e4
dangling commit b82871b3c32faa8a317007f343fdf2d0ddc9954e
$git-prune
$git-fsck
dangling tree c642c018aa55d39fff061183f58062de9d8375ac
dangling commit e1341abc3759950e891822088cb0163b71b316b3
dangling commit 9f38e1ef7e7992ca490b9b419f52fb4d11efb0e4
dangling commit b82871b3c32faa8a317007f343fdf2d0ddc9954e

And here is another puzzle:

$git-fsck --unreachable
unreachable commit f291504563a5c96862e600247d233f91572a005f
unreachable tree 0e925e128b7b83750e2b8b0d901d7d518cadbdaf
unreachable tree c642c018aa55d39fff061183f58062de9d8375ac
unreachable tree 0b43ac348827a25d54a6fc90c36c12c4c6bdd6c1
unreachable tree 4d43b9900856904cdfc69769124b1930435dae51
unreachable commit e1341abc3759950e891822088cb0163b71b316b3
unreachable blob 590533321a99bf4d00b872a839527f00616ed593
unreachable tree e355b3845361c5f0c829bd146c47c77867aa36a3
unreachable tree 7e08ac7c56e51ea94db1dd6525c26fe123537b07
unreachable commit 9f38e1ef7e7992ca490b9b419f52fb4d11efb0e4
unreachable commit b82871b3c32faa8a317007f343fdf2d0ddc9954e
unreachable commit 750f7b668f33c9e8decbdd8141115328992d6fea

git-prune is supposed to remove all the unreachable objects, IIUC,
so it seems that git-prune does nothing at all in Junio's repo.

Can anyone reproduce this behavior, or explain it?

Thanks.
