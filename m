From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: How to rebase after upstream was merged?
Date: Wed, 04 Jul 2007 14:24:46 +0200
Organization: eudaptics software gmbh
Message-ID: <468B918E.FBCADCB9@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 04 15:02:27 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64Uv-00074K-SG
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759351AbXGDNCS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759339AbXGDNCS
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:02:18 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:54014 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759212AbXGDNCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:02:17 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1I64Uq-0006dA-0I
	for git@vger.kernel.org; Wed, 04 Jul 2007 15:02:16 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP id CC54A6EF
	for <git@vger.kernel.org>; Wed,  4 Jul 2007 14:24:11 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.9 (+)
X-Spam-Report: AWL=-1.723, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51606>

I have this history:

o--o--o--o--o   <- origin
    \        \
     x--x--x--M--x--x  <- master (HEAD)

At this point I would like to rebase to straighten the history, but it
won't let me:

    $ git rebase origin
    Current branch master is up to date.

However, if there were additional commits on origin, it would work as
expected, i.e. all the 'x', but not 'M',  would be moved on top of
origin. The reason is that rebase checks whether the merge base of
origin and HEAD is origin, and exits early if it is.

I would like to extend the check to also check for linear history. How
can I do this most efficiently? My first try is along these lines:

  test $(git rev-list origin..HEAD | wc -l) = \
       $(git rev-list --no-merges origin..HEAD | wc -l)

Is there a better approach?

-- Hannes
