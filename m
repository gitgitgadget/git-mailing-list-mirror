From: Yakup Akbay <yakbay@ubicom.com>
Subject: Confused about `git gc`
Date: Tue, 09 Jun 2009 11:28:39 +0300
Message-ID: <4A2E1D37.9010909@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 09 12:32:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDycp-000396-A6
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 12:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761651AbZFIK2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 06:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761643AbZFIK2u
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 06:28:50 -0400
Received: from server70b.appriver.com ([74.205.4.150]:3379 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1761662AbZFIK2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 06:28:49 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2009 06:28:49 EDT
Received: by server70.appriver.com (CommuniGate Pro PIPE 5.2.13)
  with PIPE id 95220257; Tue, 09 Jun 2009 04:28:52 -0400
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.13)
  with ESMTP id 95220252 for git@vger.kernel.org; Tue, 09 Jun 2009 04:28:48 -0400
Received: from [172.18.200.101] ([172.18.200.101]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 9 Jun 2009 01:26:56 -0700
User-Agent: Thunderbird 2.0.0.21 (X11/20090409)
X-OriginalArrivalTime: 09 Jun 2009 08:26:57.0265 (UTC) FILETIME=[0D6FCE10:01C9E8DC]
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-18/SG:2 6/9/2009 4:27:49 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.573425 p=-0.800766 Source Normal
X-Signature-Violations: 0-0-0-3228-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 112 113 114 115 119 120 210 
X-Note: Mail Class: VALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121164>

Looks like I didn't quite understand the actual role of `git gc`. I just 
thought that `git gc` would remove all unreferenced objects during the 
unpack-pack process. However, I'm not seeing the result what I was 
expecting from `git gc`.

I'm adding an object into the database, which is ignored by git. Then I 
expect the object to be removed after `git gc`. But, it's still there.

Please follow:

$ echo "/ignored_file" > .gitignore
$ echo "This file is ignored by git. I'm sure that this content has 
never been existed in the repository before." > ignored_file
$ git hash-object -w ignored_file
39cd40a92c0a92bbcbd74ec6879b4936212beebd
$ ls .git/objects/
07  39  9f  b9  d0  fa  info  pack
$ ls .git/objects/39/
cd40a92c0a92bbcbd74ec6879b4936212beebd
$ git gc
Counting objects: 319, done.
Delta compression using up to 2 threads.
Compressing objects: 100% (147/147), done.
Writing objects: 100% (319/319), done.
Total 319 (delta 124), reused 319 (delta 124)
$ ls .git/objects/39/
cd40a92c0a92bbcbd74ec6879b4936212beebd


As you see, 39cd40a92c0a92bbcbd74ec6879b4936212beebd is still there. 
Shouldn't it be removed by `git gc`?

What am I overlooking?


Regards,
Yakup
