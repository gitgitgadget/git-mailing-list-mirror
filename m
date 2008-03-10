From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: git history order strange
Date: Mon, 10 Mar 2008 03:17:26 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803100306420.21961@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 10 03:18:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYXaw-0007j0-UZ
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 03:18:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753264AbYCJCRl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Mar 2008 22:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753241AbYCJCRk
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Mar 2008 22:17:40 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:47199 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237AbYCJCR1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Mar 2008 22:17:27 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 6EB6F184AEBEF; Mon, 10 Mar 2008 03:17:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 622241C019AC2
	for <git@vger.kernel.org>; Mon, 10 Mar 2008 03:17:26 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76691>

Hi,



I have noticed that git-rev-list can output commit IDs in the wrong 
order. Steps to reproduce:

	git-clone git://git.kernel.org/pub/scm/git/git.git
	git-rev-list 3bddd7d

this will output

	...lots of IDs...
	8e1454b5ad285ec5dd25758e799c589045aff9d4
	6b7d25d97bdb8a26719f90d17ff5c9720be68762
	...lots of more IDs...

but this order seems to be the wrong way around, as 8e14 is the parent 
of 6b7d:

	git-log --pretty=raw 6b7d25d
	commit 6b7d25d97bdb8a26719f90d17ff5c9720be68762
	tree 661dce6a7e0f319fa1c53eb94c34585ee52190e4
	parent 8e1454b5ad285ec5dd25758e799c589045aff9d4

To be noted that it only happens with `git-rev-list`, but not with 
`git-rev-list --date-order` or `git-rev-list --topo-order`.
Is it a bug in git-rev-list w/o arguments, or do I have to expect
commits in random reverse order?


thanks,
Jan
