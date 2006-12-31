From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: RFC: working with sparse work-copy: where to start?
Date: Sun, 31 Dec 2006 12:42:17 +0200
Message-ID: <20061231104217.GE26552@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 11:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0y8u-0003tH-MN
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 11:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933125AbWLaKmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 05:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933126AbWLaKmA
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 05:42:00 -0500
Received: from p02c11o144.mxlogic.net ([208.65.145.67]:37989 "EHLO
	p02c11o144.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933125AbWLaKl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 05:41:59 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o144.mxlogic.net (mxl_mta-4.0.1-5)
	with ESMTP id 7f397954.2104744880.29954.00-004.p02c11o144.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Sun, 31 Dec 2006 03:41:59 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Sun, 31 Dec 2006 12:44:13 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Sun, 31 Dec 2006 12:47:19 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 31 Dec 2006 10:44:13.0609 (UTC) FILETIME=[9C9EE990:01C72CC8]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--6.408200-4.000000-2
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35691>

Hi!
I've been thinking about working in a sparsely-populated work copy.
E.g. svn will let you do a checkout of a specific sub-directory
and do all your development there assuming you only care about
changes in that directory. Ideally, it would be possible to specify
a set of directories that I care about.

git does close to what I want if I do git-clone -n and then
git-checkout <subdirectory>.

However,
1. This re-creates the same directory structure that the repository has.
   Especially for when this directory resides deep in the original repo
   tree structure, it would be nice to be able relocate the directory anywhere.
2. The rest of the tree is checked-out whenever I pull from the central repo.
3. git-commit would list all files I didn't check out as removed.

I wonder how hard would it be to add such support?
I tried looking at 2 - is builtin-merge-file.c the only place where the checkout
is done on merge?

What other commands need to be fixed for this to work?

-- 
MST
