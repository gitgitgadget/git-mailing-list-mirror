From: Chuck Lever <cel@citi.umich.edu>
Subject: [PATCH] unneeded processing in forward_patches() ??
Date: Thu, 01 Dec 2005 19:11:41 -0500
Message-ID: <20051202001141.9140.23252.stgit@dexter.citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 02 01:17:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ehya4-0006ir-7S
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 01:15:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVLBAPN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 19:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbVLBAPM
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 19:15:12 -0500
Received: from citi.umich.edu ([141.211.133.111]:53006 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S932578AbVLBAPL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2005 19:15:11 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 67F891BACD;
	Thu,  1 Dec 2005 19:15:11 -0500 (EST)
To: catalin.marinas@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13091>

i was wondering why "stg push" takes so long to decide not to use
fast-forward.

it turns out that when forward_patches() has not been able to fast-
forward any patches, it still does a git.switch() and rewrites the
unapplied file even though nothing has changed.  on a big working
directory, this 'no-op' can take a while.

following is a simple patch that addresses the problem.  does this appear
to be a reasonable optimization (in terms of correctness)?

        -- Chuck Lever
--
corporate:    <cel at netapp dot com>
personal:     <chucklever at bigfoot dot com>
