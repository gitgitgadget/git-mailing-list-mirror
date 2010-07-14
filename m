From: Boaz Harrosh <bharrosh@panasas.com>
Subject: serving git with both "git:" and "http:" and submodules
Date: Wed, 14 Jul 2010 18:29:51 +0300
Message-ID: <4C3DD7EF.6010805@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 14 17:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ3uO-0005LH-RR
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 17:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757072Ab0GNP34 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 11:29:56 -0400
Received: from daytona.panasas.com ([67.152.220.89]:33370 "EHLO
	daytona.int.panasas.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756811Ab0GNP3y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 11:29:54 -0400
Received: from fs2.bhalevy.com ([172.17.33.181]) by daytona.int.panasas.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jul 2010 11:29:52 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100430 Fedora/3.0.4-2.fc12 Thunderbird/3.0.4
X-OriginalArrivalTime: 14 Jul 2010 15:29:52.0889 (UTC) FILETIME=[67B8BE90:01CB2369]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150996>


I have a public tree that I maintain for users. The tree is consisted
of a main-tree and a submodule tree which is also served from the same
server.

The main tree:
git://my-domain.org/my-tree/.git
The sub-tree:
git://my-domain.org/my-tree/sub/.git

in my .gitmodule I have the usual
[submodule "sub"]
        url = git://my-domain.org/my-tree/sub/.git

So smart people using git will just do:
1. $ git clone git://my-domain.org/my-tree/.git
2. $ git submodule init
3. $ git submodule update

And all is well... But smart ass corporate people would not use "git:"
protocol because of fire-walls and for them I have a dumb "http:" export
as:
1. $ git clone http://my-domain.org/trees/my-tree/.git

With them, step 3 above will not work. My current instructions
for them is that after the step 2 "git submodule init" they should
manually edit my-tree/.git/config and change to:
[submodule "sub"]
-        url = git://my-domain.org/my-tree/sub/.git
+        url = http://my-domain.org/trees/my-tree/sub/.git

And then do step 3 to clone the sub-module.

So my question is: Can I automate this so people with "http:"
clones are not forced to manually edit their config files?
(Some users are just not up to it)

Thanks, (Sorry if that has been raised before. Couldn't find any.)
Boaz
