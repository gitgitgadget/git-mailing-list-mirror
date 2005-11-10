From: Yaacov Akiba Slama <ya@slamail.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 11:54:21 +0200
Message-ID: <437318CD.2050401@slamail.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 10:57:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ea98j-0003wb-G2
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 10:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbVKJJyi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 04:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbVKJJyi
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 04:54:38 -0500
Received: from [195.140.142.33] ([195.140.142.33]:10423 "EHLO
	c1-033.cyaris.net") by vger.kernel.org with ESMTP id S1750738AbVKJJyh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Nov 2005 04:54:37 -0500
Received: from localhost ([127.0.33.1] helo=localhost.localdomain)
	by c1-033.cyaris.net with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50)
	id 1Ea98W-000779-AT; Thu, 10 Nov 2005 10:54:32 +0100
Received: from [127.0.0.1] (helo=[127.0.0.1])
	by localhost.localdomain with esmtp (Exim 4.54)
	id 1Ea98Q-0003w4-7F; Thu, 10 Nov 2005 11:54:22 +0200
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net>
X-Spam-Score: -2.8 (--)
X-Spam-Report: Spam detection software, running on the system "c1-033.cyaris.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Junio C Hamano wrote: >Although I did not hear anybody
	jumping up-and-down to merge >svnimport updates from Yaacov Akiba
	Slama, I did not hear it >broke things either, so it graduated to the
	master branch and >included in this release. It obviously improved
	things for >Yaacov, and I am hoping this would not cause disruptions
	for >people's existing setup. > > Thanks for the merge. IMHO, the
	commit labelled "Bundle file copies from multiple branches into a
	merge" (109fc2b97b73090a4a0a6550cdf9b2446fd12389) needs more
	attention/discussion. [...] 
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11475>

Junio C Hamano wrote:

>Although I did not hear anybody jumping up-and-down to merge
>svnimport updates from Yaacov Akiba Slama, I did not hear it
>broke things either, so it graduated to the master branch and
>included in this release.  It obviously improved things for
>Yaacov, and I am hoping this would not cause disruptions for
>people's existing setup.
>  
>
Thanks for the merge.
IMHO, the commit labelled 
"Bundle file copies from multiple branches into a merge" 
(109fc2b97b73090a4a0a6550cdf9b2446fd12389) needs more attention/discussion.

In svn, there is no concept of branches or tag, but because the copy is 
cheap, directories are used to simulate branches and tags.
The repository will be like :

/trunk/path/to/file
/branches/branch_1/path/to/file
/branches/branch_n/path/to/file
/tags/tag_1/path/to/file
/tags/tag_m/path/to/file

Now, someone can copy directory or files from the trunk or any 
branch/tag into any other directory. For instance one can commit the 
following tree as a new revision :

/trunk/path/to/file
/trunk/new/path/to/file (this is a copy of /branches/branch_1/path/to/file)
/branches/branch_1/path/to/file
/branches/branch_n/path/to/file
/tags/tag_1/path/to/file
/tags/tag_m/path/to/file


Now the commit 109fc2b97b73090a4a0a6550cdf9b2446fd12389 creates a new 
commit with two parents:
1) HEAD
2) the git branch called "branch_1"

 From what I read about the definition of commit in git's documentation, 
that seems to be ok, but can this marking of  "branch_1" as a parent of 
this commit be dangerous for merges done later in pure git ?

--yas
