From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: git rebase: unexpected conflict
Date: Wed, 7 Feb 2007 22:31:33 +0200
Message-ID: <20070207203133.GG12140@mellanox.co.il>
References: <7vired7mkw.fsf@assigned-by-dhcp.cox.net>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 21:31:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEtRh-0000PV-8s
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 21:31:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161437AbXBGUbG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 15:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161438AbXBGUbF
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 15:31:05 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:42288 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161437AbXBGUbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 15:31:04 -0500
Received: from unknown [194.90.237.34] (EHLO mtlexch01.mtl.com)
	by p02c11o146.mxlogic.net (mxl_mta-4.0.2-2)
	with ESMTP id 8073ac54.2045926320.6396.00-001.p02c11o146.mxlogic.net (envelope-from <mst@mellanox.co.il>);
	Wed, 07 Feb 2007 13:31:04 -0700 (MST)
Received: from mellanox.co.il ([10.4.4.6]) by mtlexch01.mtl.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 7 Feb 2007 22:33:10 +0200
Received: by mellanox.co.il (sSMTP sendmail emulation); Wed,  7 Feb 2007 22:28:52 +0200
Content-Disposition: inline
In-Reply-To: <7vired7mkw.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 07 Feb 2007 20:33:11.0079 (UTC) FILETIME=[2F176B70:01C74AF7]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14984.001
X-TM-AS-Result: No--10.444400-4.000000-2
X-Spam: [F=0.0100000000; S=0.010(2007010901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38963>

> Since git-rebase currently ignores merge commits

Ugh. This is the bit I did not know about.

So the following script is kind of equivalent to rebase -
it applies commits in range $1..$2 that touch files in list on top of current tree:

from=$1
shift
to=$1
shift
git-show --pretty=email `git-rev-list --no-merges $from..$to -- $* | tac` > box
../git-am box

And here I was hoping rebase will be smarter and help me out.

OK.

Questions about the above line now:

1. What is annoying in the above is that
git-show can not limit its output to just the part of patch
that affects the list of files I give, the way git-diff can.
Would such an extension be a good idea?

2. It's unfortunate that I need a temp file here.
Can git-am get stdin somehow?


-- 
MST
