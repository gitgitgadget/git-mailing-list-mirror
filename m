From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] Add git-filter-branch
Date: Wed, 06 Jun 2007 17:22:43 +0200
Organization: eudaptics software gmbh
Message-ID: <4666D143.32BC9693@eudaptics.com>
References: <Pine.LNX.4.64.0706030129110.4046@racer.site> <4663BCDA.F1BADDD8@eudaptics.com>
	   <Pine.LNX.4.64.0706041711500.4046@racer.site> <46643F2D.7C896CBC@eudaptics.com>
	  <Pine.LNX.4.64.0706041850350.4046@racer.site> <46650A58.4934C07C@eudaptics.com>
	 <Pine.LNX.4.64.0706051537360.4046@racer.site> <466665AD.CF5B85DF@eudaptics.com> <Pine.LNX.4.64.0706061600060.4046@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 06 17:21:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvxKW-00080j-Eb
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 17:21:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759680AbXFFPVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 11:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761482AbXFFPVe
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 11:21:34 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.24]:50729 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759680AbXFFPVd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 11:21:33 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtp (Exim 4.44)
	id 1HvxKF-0000v3-TM; Wed, 06 Jun 2007 17:21:32 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A3E6654D; Wed,  6 Jun 2007 17:21:31 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 0.0 (/)
X-Spam-Report: AWL=0.042
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49292>

Johannes Schindelin wrote:
> Of course, it would be even more so if the target branch name was
> "filtered", overrideable by "--target <name>".

My plan for this is:

1. run the rev-list args ("$@") through rev-parse
2. pick only the positive ones (/^[a-z0-9]{40}$/)
3. filter show-ref against the result of 2.
4. foreach ref in the result of 3. install a refs/rewritten/$ref
   with the mapped id if and only if the mapped id is different
   from the original id of $ref.

Then you can, for example, 'git filter-branch --all' to rewrite all
branches.

-- Hannes
