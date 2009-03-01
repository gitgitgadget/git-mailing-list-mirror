From: David Miller <davem@davemloft.net>
Subject: rogue tree objects, how to diagnose?
Date: Sat, 28 Feb 2009 19:12:06 -0800 (PST)
Message-ID: <20090228.191206.75012167.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 01 04:13:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ldc7o-00031N-LZ
	for gcvg-git-2@gmane.org; Sun, 01 Mar 2009 04:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbZCADMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Feb 2009 22:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755276AbZCADMZ
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Feb 2009 22:12:25 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:40764
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1755280AbZCADMY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Feb 2009 22:12:24 -0500
Received: from localhost (localhost [127.0.0.1])
	by sunset.davemloft.net (Postfix) with ESMTP id 1582735C009
	for <git@vger.kernel.org>; Sat, 28 Feb 2009 19:12:06 -0800 (PST)
X-Mailer: Mew version 6.1 on Emacs 22.1 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111808>


I've got this weird problem.

In my local net-next-2.6 tree I tries to pull from a
colleague and this resulted in:

davem@sunset:~/src/GIT/net-next-2.6$ git pull git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-next-2.6.git master
 ...
From git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-next-2.6
 * branch            master     -> FETCH_HEAD
fatal: unable to read tree c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
davem@sunset:~/src/GIT/net-next-2.6$ git show c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
fatal: bad object c9ee57c5c20c3b7a2d7784a4172aef8b34c3a844
davem@sunset:~/src/GIT/net-next-2.6$ 

Now, what's funny is that this tree object does exist in my
tree on master.kernel.org:

[davem@hera net-next-2.6.git]$ git ls-tree c9ee57c
100644 blob ffa0efce0aed06aa51be310e14dfe4b5bac8c3b4    Kconfig
100644 blob be8f287aa398f0a9697f9af30d4cda25b95ea1f0    Makefile
100644 blob dbb912574569ef49375866a5053e429bf6d38831    cm4000_cs.c
100644 blob 4f0723b07974615f5177134b49deb671580e8813    cm4040_cs.c
100644 blob 9a8b805c5095487a8f59ac22475d417d6436ac23    cm4040_cs.h
040000 tree 1314476b63b18a2c4f6dc84dd00c4ed25b7fccd9    ipwireless
100644 blob 5608a1e5a3b3416fa44e44e504c9a2817d1c3c2c    synclink_cs.c
[davem@hera net-next-2.6.git]$ 

And if I do a full clone of my master.kernel.org tree I get the
tree object.

Now, I have done a by-hand revert in this tree a long time ago
(by just by-hand changing the SHA1 ID in 'master') so that may
have contributed to this happening.

But anyways, if I pull into ~/src/GIT/net-next-2.6 locally , I don't
get that tree object.

I don't understand how this can happen, and I'd like to be able
to diagnose this intelligently.

So, what is an easy way to figure out what commit references tree
object X?

Thanks!
