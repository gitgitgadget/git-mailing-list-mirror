From: Luc Bourhis <luc_j_bourhis@mac.com>
Subject: Trouble with case insensitive filesystem
Date: Wed, 15 May 2013 10:40:48 +0200
Message-ID: <F0A0C92F-6D85-463E-9CB5-B9060BDA196B@mac.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Luc Bourhis <luc_j_bourhis@mac.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 15 11:41:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcYDD-0007zL-PW
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 11:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758762Ab3EOJlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 May 2013 05:41:24 -0400
Received: from nk11p04mm-asmtp001.mac.com ([17.158.236.236]:58288 "EHLO
	nk11p04mm-asmtp001.mac.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758481Ab3EOJlW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 May 2013 05:41:22 -0400
X-Greylist: delayed 3610 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2013 05:41:22 EDT
Received: from [192.168.1.200] ([80.11.252.214]) by nk11p04mm-asmtp001.mac.com
 (Oracle Communications Messaging Server 7u4-26.01(7.0.4.26.0) 64bit (built Jul
 13 2012)) with ESMTPSA id <0MMU0058F042ZY70@nk11p04mm-asmtp001.mac.com> for
 git@vger.kernel.org; Wed, 15 May 2013 08:40:53 +0000 (GMT)
X-Proofpoint-Virus-Version: vendor=fsecure
 engine=2.50.10432:5.10.8626,1.0.431,0.0.0000
 definitions=2013-05-15_01:2013-05-14,2013-05-15,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 suspectscore=1 phishscore=0 bulkscore=0 adultscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=6.0.2-1305010000
 definitions=main-1305150024
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224392>

Hi,

I work on a case insensitive filesystem and I have core.ignorecase set to true. 
I have a series of troublesome commits and here is what git cat-file -p shows me:

...
100644 blob 99...	fourCircles.py
100644 blob 97...	fourcircles.py
...

The content of those slightly differ:

--- a/99...
+++ b/97...
-__version__='$Header: .../fourCircles.py, ...$'
+__version__='$Header: .../fourcircle.py, ...$'
 
As you can guess this git repo started its life with CVS (it was converted with git cvsimport). 
So I thought it was a job for git filter-branch, specifically I propose to do:
git filter-branch --index-filter 'git rm --cached --ignore-unmatch .../fourCircles.py' <commit>

However because of those two blobs, I have:

~> git status
#	modified:   .../fourCircles.py

and git filter-branch therefore refuses to run. I tried to use checkout, reset, 
even to commit that fluke of a change but whatever I do, that file is still marked 
as modified. 

I am sure I am missing a tiny detail that would get me
out of those dire straights but it has eluded me so far.

I run git 1.8.2.2 on MacOS 10.7.5 (installed with MacPorts if that matters).

Best wishes,

Luc J. Bourhis
