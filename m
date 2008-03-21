From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Path filtered history not maximally simplified
Date: Fri, 21 Mar 2008 13:46:48 +0100
Message-ID: <47E3AE38.5060405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 21 13:47:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcgem-0005Qq-P7
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 13:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998AbYCUMqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 08:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754011AbYCUMqv
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 08:46:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:7730 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754892AbYCUMqu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 08:46:50 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JcgdC-0000zo-4Y
	for git@vger.kernel.org; Fri, 21 Mar 2008 13:45:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 5B856AFCC
	for <git@vger.kernel.org>; Fri, 21 Mar 2008 13:46:48 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77735>

While investigating a path-filtered history in gitk, I noticed a layout
like this:

     --A---------M--4--N
        \       /     /
         1--2--3-----5

There are no commits displayed on the upper line between A and M.
Shouldn't this have been simplified to:

                  4--N
                 /  /
     --A--1--2--3--5

The gitk command used is simply:

     $ gitk some/file

and if I run

     $ git log some/file

then M is reported with two parents (so it's not gitk's fault). The above
is just the most recent part of the history; there's a lot more older
history, and it is non-trivial with numerous merges (in the complete
history). In particular, there _are_ commits on the upper branch between A
and M, but none of them touches some/file.

Do I need to adjust my expectations or does this look like a bug?

-- Hannes

PS: This is with 1.5.5.rc0.21.g740fd.
