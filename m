From: Johannes Sixt <j.sixt@viscovery.net>
Subject: git stash apply usability issues
Date: Thu, 18 Oct 2007 10:32:33 +0200
Message-ID: <47171A21.9030003@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 18 10:32:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiQoB-0000RS-Df
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 10:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755893AbXJRIcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 04:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755940AbXJRIcg
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 04:32:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:46363 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755395AbXJRIcf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 04:32:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IiQnk-0000VQ-N3
	for git@vger.kernel.org; Thu, 18 Oct 2007 10:32:21 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP id 4F02A4E4
	for <git@vger.kernel.org>; Thu, 18 Oct 2007 10:32:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61505>

(1) Looking at git-stash.sh I see a few uses of 'git diff' in apply_stash(). 
Shouldn't these use one of git-diff-{tree,index,files)? The reason is that 
porcelain 'git diff' invokes custom diff drivers (that in my case run a UI 
program), whereas the plumbing does not.

Is there a particular reason to use porcelain 'git diff'?

(2) when 'git stash apply' runs merge-recursive, it treats the current state 
as 'ours' and the stash as 'theirs'. IMHO it should be the other way round: 
I have stashed away changes to a binary file. Then committed a different 
modification to it, and now want to apply the stash. This results in a 
conflict that leaves the current state in the working tree, but I had 
preferred that the stashed binary file were in the working tree now.

What do other git-stash users think about changing the order?

-- Hannes
