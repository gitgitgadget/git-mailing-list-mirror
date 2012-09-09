From: "Maris, Rob" <maris.rob@ingenieur.de>
Subject: git checkout -b following git reset --hard pitfall
Date: Sun, 09 Sep 2012 15:25:48 +0200
Message-ID: <op.wkdd9andsuzgrs@rob-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 15:42:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAhmW-00054i-Ea
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 15:42:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753027Ab2IINm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 09:42:27 -0400
Received: from sfmail10.siteforum.com ([213.239.250.193]:53430 "EHLO
	sfmail10.siteforum.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843Ab2IINmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 09:42:25 -0400
X-Greylist: delayed 993 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Sep 2012 09:42:25 EDT
User-Agent: Opera Mail/10.63 (Linux)
X-SITEFORUM-Received-Auth: from [212.255.39.128] (helo=rob-desktop)
	by sfmail10.siteforum.com with esmtpa (Exim 4.75)
	(envelope-from <maris.rob@ingenieur.de>)
	id 1TAhWG-0004mo-PU
	for git@vger.kernel.org; Sun, 09 Sep 2012 15:25:49 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205077>

Normally, when there are modifications in the working tree not yet added  
resp. committed, git will refuse to change to another branch.
However, when I create a new branch on the fly, using git checkout -b  
<branch>, there is no complaint appearing. After doing so, I executed a  
git reset --hard in once case, just thinking that the previous "modified"  
branch status was preserved. Of course, this notion is incorrect. But I  
realised this after a bit of thinking about it. Actually, the modified  
status of git related to both branches after git checkout -b can have  
following consequences:

- it is lost definitely when git reset -hard is executed
- if committed, it is committed into the newly created branch

This actually constitutes an asymmetric response (perceived double  
deletion vs. single preservation).
I'd wish that git checkout displays *at least* a warning when a "modified"  
state is not committed:  "warning: Your local changes to the following  
files are no longer associated with the previous branch:"

-Rob

git version 1.7.11
