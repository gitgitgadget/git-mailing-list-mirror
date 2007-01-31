From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: git-kill: rewrite history removing a commit
Date: Wed, 31 Jan 2007 21:55:33 +0200
Message-ID: <20070131195533.GE21097@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 20:55:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCLYD-0006Q8-23
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 20:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbXAaTzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 14:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbXAaTzK
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 14:55:10 -0500
Received: from p02c11o142.mxlogic.net ([208.65.145.65]:40909 "EHLO
	p02c11o142.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbXAaTzI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 14:55:08 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o142.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id c14f0c54.2664577968.8493.00-028.p02c11o142.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Wed, 31 Jan 2007 12:55:08 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 31 Jan 2007 21:57:06 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed, 31 Jan 2007 21:54:31 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 31 Jan 2007 19:57:07.0126 (UTC) FILETIME=[FC622560:01C74571]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14968.003
X-TM-AS-Result: No--1.155600-4.000000-4
X-Spam: [F=0.0580210019; S=0.058(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38288>

Below is a simple script that rewrites history reverting a single commit.
This differs from git-revert in that a commit is completely removed,
and is especially useful before one has published a series of
commits.

Do you find this useful? Comments?
Drop me a line.

#!/bin/sh

commit=$1;
#git-rev-list $commit.. 
revlist=`git-rev-list $commit.. | tac`
git reset --hard $commit
git reset --hard HEAD~1
for rev in $revlist
do
	git-cherry-pick $rev
done
-- 
MST
