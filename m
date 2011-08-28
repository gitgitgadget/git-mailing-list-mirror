From: Brian Gernhardt <benji@silverinsanity.com>
Subject: t0300-credentials: poll failed: invalid argument
Date: Sun, 28 Aug 2011 00:40:56 -0400
Message-ID: <5C993C44-D045-4344-95C1-94D3E6DB0316@silverinsanity.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Aug 28 06:54:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxXOZ-0003MA-Cx
	for gcvg-git-2@lo.gmane.org; Sun, 28 Aug 2011 06:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812Ab1H1EtI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Aug 2011 00:49:08 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:46892 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763Ab1H1EtH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 28 Aug 2011 00:49:07 -0400
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Sun, 28 Aug 2011 00:49:06 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id EAE151FFC166; Sun, 28 Aug 2011 04:40:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id 383851FFC0EE
	for <git@vger.kernel.org>; Sun, 28 Aug 2011 04:40:46 +0000 (UTC)
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180255>

The only usage of poll I see in the credentials system is:

credentials-cache--daemon.c
177:	if (poll(&pfd, 1, 1000 * wakeup) < 0) {

My guess is that (1000 * wakeup) is more than INT_MAX and is becoming negative as the man page for poll seems to indicate that it will fail if timeout < -1.

Does anyone familiar with the credentials daemon want to try to figure out a reasonable fix?

~~ Brian
