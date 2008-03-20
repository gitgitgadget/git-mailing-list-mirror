From: James Utter <james.utter@gmail.com>
Subject: strange git delays
Date: Fri, 21 Mar 2008 00:32:48 +1100
Message-ID: <1206019968.27619.26.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 20 14:34:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcKtp-0006sW-QB
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 14:33:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468AbYCTNc6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 09:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbYCTNc6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 09:32:58 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:29014 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754430AbYCTNc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 09:32:57 -0400
Received: by wf-out-1314.google.com with SMTP id 28so971726wff.4
        for <git@vger.kernel.org>; Thu, 20 Mar 2008 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=bYIdOS0yY9dlFpKyMFyMTYv22llyjC++x3MA2qzpgLE=;
        b=D1B6/hBlEYs4cezk5qEYQCNfEvc0AfafZHXk+6OK+ORZJd8AycATZ37X6XrdW6Nm5W5nY8mKrZCrpejtvGDW/u2ZZGL7olKOZ1Hv/WE2vJtWzhPd2d6QzVJPMMbcX05BS0tJSk0UVuwNLdj+eOCuyMC/T63LpSgS/YAW+AdO7RM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Te2KRij0hcoY5T/MB5xTveGNUJKbUHDvtSVV8fHVoGY236nSyIIGiva1ivTHs2jDJakQHRxbHs9hORsUBp/Vzq8aUKaiHDfBAPdbzp/X7R/w/UfpqXcTRlB6g77qVp6NrcP9VurZX9szG+Zh/pejVyuEW4Hhb9srnJHVpnEGVsI=
Received: by 10.143.187.2 with SMTP id o2mr1153150wfp.239.1206019975434;
        Thu, 20 Mar 2008 06:32:55 -0700 (PDT)
Received: from ?10.5.5.2? ( [121.44.240.112])
        by mx.google.com with ESMTPS id h34sm417575wxd.10.2008.03.20.06.32.50
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 20 Mar 2008 06:32:53 -0700 (PDT)
X-Mailer: Evolution 2.12.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77657>

Hi,

Many git operations are running really slowly for me.
For example 'git commit' and 'git branch' are taking 10 seconds to
complete, even on an almost empty repository, and no longer on a 60MB
repository with plenty of history.

There does not appear to be any CPU or disk activity caused by git.

I would appreciate your help in resolving this problem.

Regards,

James Utter


Details of my environment:
-------------------------------
Linux 2.6.24-1-amd64 #1 SMP x86_64 (from debian testing) [1]
git-core 1:1.5.4.3-1 (from debian testing) [2]
Core 2 duo, 2Ghz

[1] I have been experiencing this problem across several kernels
[2] possibly over several git versions too (not sure)

Here is a test run on my computer
---------------------------------
james@timesink:~$ mkdir testgit
james@timesink:~$ cd testgit/
james@timesink:~/testgit$ time git init-db
Initialized empty Git repository in .git/

real	0m0.013s
user	0m0.000s
sys	0m0.008s
james@timesink:~/testgit$ echo "hai there" > hello
james@timesink:~/testgit$ time git add .

real	0m0.103s
user	0m0.000s
sys	0m0.004s
james@timesink:~/testgit$ time git commit --message "initial commit"
Created initial commit 4f4b3a3: initial commit
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 hello

real	0m10.008s
user	0m0.000s
sys	0m0.008s
james@timesink:~/testgit$ time git branch new

real	0m10.006s
user	0m0.000s
sys	0m0.004s
james@timesink:~/testgit$ time git branch -d new
Deleted branch new.

real	0m0.005s
user	0m0.000s
sys	0m0.004s
james@timesink:~/testgit$ echo "im in ur git\n slowin ur workflo" >>
hello
james@timesink:~/testgit$ time git commit -a --message "how long"
Created commit 2392de6: how long
 1 files changed, 1 insertions(+), 0 deletions(-)

real	0m10.059s
user	0m0.000s
sys	0m0.008s
