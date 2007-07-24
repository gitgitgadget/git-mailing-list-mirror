From: Jan Engelhardt <jengelh@computergmbh.de>
Subject: rfe: bisecting with a tristate
Date: Tue, 24 Jul 2007 15:21:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0707241459460.18990@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 24 15:21:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKKK-0000hK-Cq
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753345AbXGXNVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752397AbXGXNVU
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:21:20 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:48489 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbXGXNVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:21:20 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 30FF018094B5D; Tue, 24 Jul 2007 15:21:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 2A2CE1C0853D1
	for <git@vger.kernel.org>; Tue, 24 Jul 2007 15:21:19 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53584>

Hi,


I have an idea about handling commits that do not compile at 
all in git-bisect.
For example:

git bisect start
git bisect bad v2.6.23-rc1
# bad: [f695baf2df9e0413d3521661070103711545207a] Linux 2.6.23-rc1
git bisect good v2.6.22
# good: [098fd16f00005f665d3baa7e682d8cb3d7c0fe6f] Linux 2.6.22

Then 1f1c2881f673671539b25686df463518d69c4649 will be the next commit 
git bisect hands out. Now let's assume this commit would not compile. 
What would the user do? git-bisect good or git-bisect bad?

Assume a commit previous to 1f..49 caused an oops (but the user does not 
know yet), and the user said 'good' on 1f..49 because he did not know 
what to say (since it did not compile). Then bisect would go the wrong 
way, marking all left to 1f..49 as good.


Ideally, there should be like "git bisect dunno-try-left" and "git 
bisect dunno-try-right", which allow the user to skip checking 1f..49 
and instead try the next commit left or right of 1f..49 (to either go to 
a commit before the compile failure, or after it).

[ What's `git-bisect next` for? ]



	Jan
-- 
