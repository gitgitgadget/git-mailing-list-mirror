From: Stephen Rothwell <git@ozlabs.org>
Subject: bug in git-fsck-cache?
Date: Wed, 31 Aug 2005 16:15:29 +1000
Message-ID: <20050831161529.327a7957.git@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Aug 31 08:16:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EALsj-0007Ru-FC
	for gcvg-git@gmane.org; Wed, 31 Aug 2005 08:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVHaGPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 02:15:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbVHaGPY
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 02:15:24 -0400
Received: from ozlabs.org ([203.10.76.45]:45254 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932380AbVHaGPX (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Aug 2005 02:15:23 -0400
Received: from oak (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1E10968140
	for <git@vger.kernel.org>; Wed, 31 Aug 2005 16:15:22 +1000 (EST)
To: git@vger.kernel.org
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7970>

Hi all,

I have a tree that is a copy of Linus' git kernel tree in which I have
been doing development and pulling updates and rebasing my patches etc.

It now does this:

$ git fsck-cache
dangling tree 34d23b379f39922dff3cee671e28d41f3be56167
dangling blob 3eab2290b12a2cb683e4eadc20253bde37c84859
dangling blob 578e30193b7b67b71da1bdf0e822b8d783d8c245
dangling blob 7798f01f77b4aeacfd14586e9847deee1bf7ca74
dangling blob 81e94f8aa84684862edacb2fafff9cf9dca6878d
dangling blob 85420bb37d581bc725d07c34254e4a3a1a834038
dangling tree 908ef958d87158278502966ed4f941478e18c5d7
dangling blob 93c437a0911b9d00d4ce76be30686144e8063f5e
dangling tree 9c14b3618c3977e7ea58d25632585543e56f5e09
dangling tree b8c7a5af99058a82dab51eb7b27ad81987ffa5df
dangling tree c004aeb8be7b0520174174e574d2655a610844a8
dangling commit c594adad5653491813959277fb87a2fef54c4e05
dangling blob d0960a82708cad4196c2d44f0a16cb3e80f77c00
dangling tree ed4e5baf7854719c19177988eb864b9be5867fa7
dangling tree ede09c2983717a0ad040e9c79f37dcb801fe49b6
dangling tree f0f3c408b22634fbd5c6409610c566ae7c92ddc3
$ git prune
$ git fsck-cache
dangling tree 34d23b379f39922dff3cee671e28d41f3be56167
dangling blob 3eab2290b12a2cb683e4eadc20253bde37c84859
dangling blob 578e30193b7b67b71da1bdf0e822b8d783d8c245
dangling blob 7798f01f77b4aeacfd14586e9847deee1bf7ca74
dangling blob 81e94f8aa84684862edacb2fafff9cf9dca6878d
dangling blob 85420bb37d581bc725d07c34254e4a3a1a834038
dangling tree 908ef958d87158278502966ed4f941478e18c5d7
dangling blob 93c437a0911b9d00d4ce76be30686144e8063f5e
dangling tree 9c14b3618c3977e7ea58d25632585543e56f5e09
dangling tree b8c7a5af99058a82dab51eb7b27ad81987ffa5df
dangling tree c004aeb8be7b0520174174e574d2655a610844a8
dangling commit c594adad5653491813959277fb87a2fef54c4e05
dangling blob d0960a82708cad4196c2d44f0a16cb3e80f77c00
dangling tree ed4e5baf7854719c19177988eb864b9be5867fa7
dangling tree ede09c2983717a0ad040e9c79f37dcb801fe49b6
dangling tree f0f3c408b22634fbd5c6409610c566ae7c92ddc3
$

The commit c594adad5653491813959277fb87a2fef54c4e05 is shown as
"connected" (in Linus' tree, not one of my patches) by gitk, so I am happy
that git prune did not get rid of it, but why does fsck-cache report it as
dangling?

Even stranger, I actually pull Linus' tree into another tree that I have
never otherwise modified and I pull updates to my work tree from it.
fsck-cache finds not problems in the pristine tree.

Cheers,
Stephen Rothwell
