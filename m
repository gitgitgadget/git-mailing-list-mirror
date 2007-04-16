From: Christian <crich-ml@beronet.com>
Subject: git push over http is very dangerous
Date: Mon, 16 Apr 2007 17:22:20 +0200
Message-ID: <462394AC.303@beronet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 16 17:50:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdTTA-0000sK-8v
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 17:50:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030775AbXDPPuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030766AbXDPPuP
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 11:50:15 -0400
Received: from beronet.com ([80.244.243.34]:4843 "EHLO mail.beronet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030775AbXDPPuN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 11:50:13 -0400
X-Greylist: delayed 1621 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Apr 2007 11:50:13 EDT
Received: from mail.beronet.com (localhost [127.0.0.1])
	by mail.beronet.com (Postfix) with ESMTP id 19E40510DA2
	for <git@vger.kernel.org>; Mon, 16 Apr 2007 17:31:30 +0200 (CEST)
Received: from [172.20.5.5] (pd956852e.dip0.t-ipconnect.de [217.86.133.46])
	by mail.beronet.com (Postfix) with ESMTP id D7B88510CA0
	for <git@vger.kernel.org>; Mon, 16 Apr 2007 17:31:29 +0200 (CEST)
User-Agent: Icedove 1.5.0.7 (X11/20061013)
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on m24s12.beronet.com
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=5.0 tests=ALL_TRUSTED autolearn=failed 
	version=3.0.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44652>

Hi Git developers,

first of all thanks for the great toolkit :)

We are using git for the mISDN Open Source ISDN Stack (www.misdn.org / 
git.misdn.org).  We are using webdav to push up data from users with 
write access. Readonly access is granted via the git daemon.

We have moved from CVS to git in the beginning of last week, all went 
well until this weekend. This weekend one developer wanted to push some 
of his local modifications, unfortunately during the push his http 
connection seemed to have broken or so. Unfortunately git does not prove 
if the push went well. Therefore our repository was broken this morning.

We found out that it was broken, because we could not do a pull or clone 
from the central repository anymore, but we got an error message.

Then i did a "git log" which worked well. then i wanted to "show" the 
last 2 commits, so i did: "git show":

error: corrupt loose object 'cd1aac1a43cfdac07118240f75c0ba7662eb8140'
<crich1999> error: cd1aac1a43cfdac07118240f75c0ba7662eb8140: object 
corrupt or missing


i found that i could "git show" all commits, but only the last 2 
produced the above error message.

gitster from IRC helped me out and showed me that i could do

git branch -f master master~2 

to remove the 2 commits. i did that and all worked well again!


I wonder if it would be possible to delay a central push until all data 
was uploaded, then after the upload finished a checksum is transmitted, 
if the checksum is correct, the push can be done centrally..


cheers,

christian
