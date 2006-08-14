From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: RFC: git pull <remote> making an octopus?
Date: Mon, 14 Aug 2006 10:53:05 +0300
Message-ID: <20060814075305.GH21963@mellanox.co.il>
References: <7vac67g5t5.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 09:51:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCXE5-0001wK-UT
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 09:51:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751922AbWHNHvE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 03:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751923AbWHNHvE
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 03:51:04 -0400
Received: from mxl145v66.mxlogic.net ([208.65.145.66]:19648 "EHLO
	p02c11o143.mxlogic.net") by vger.kernel.org with ESMTP
	id S1751922AbWHNHvC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 03:51:02 -0400
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o143.mxlogic.net (mxl_mta-3.0.0-12)
	with ESMTP id 66b20e44.2063948720.16563.00-001.p02c11o143.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Mon, 14 Aug 2006 01:51:02 -0600 (MDT)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 14 Aug 2006 10:57:03 +0300
Received: by mellanox.co.il (sSMTP sendmail emulation); Mon, 14 Aug 2006 10:53:05 +0300
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vac67g5t5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Aug 2006 07:57:03.0718 (UTC) FILETIME=[3AEBC060:01C6BF77]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25331>

Quoting r. Junio C Hamano <junkio@cox.net>:
> Are you by any chance running a version of git that has some
> unofficial patches that affect the generation of not-for-merge
> markers?

No, I just reproduced this on plain 1.4.2.
My .git/remotes/origin has:

URL: /mswg/git/infiniband/.git
Pull: refs/heads/ofed_1_1:refs/heads/ofed_1_1
Pull: refs/heads/cma_branch:refs/heads/cma_branch
Pull: refs/heads/linus_master:refs/heads/linus_master
Pull: refs/heads/master:refs/heads/master
Pull: refs/heads/mst_sdp:refs/heads/mst_sdp
Pull: refs/heads/ofed_addons:refs/heads/origin

Moving the last line
Pull: refs/heads/ofed_addons:refs/heads/origin
to be the first, like this

Pull: refs/heads/ofed_addons:refs/heads/origin
Pull: refs/heads/ofed_1_1:refs/heads/ofed_1_1
Pull: refs/heads/cma_branch:refs/heads/cma_branch
Pull: refs/heads/linus_master:refs/heads/linus_master
Pull: refs/heads/master:refs/heads/master
Pull: refs/heads/mst_sdp:refs/heads/mst_sdp

fixes the issue.

So it seems git pull behaves differently depending on whether
the origin pull line is first or not?

-- 
MST
