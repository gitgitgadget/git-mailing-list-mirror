From: Tim Prouty <tim.prouty@isilon.com>
Subject: git-svn dcommit and setting svn properties
Date: Tue, 8 Jul 2008 10:30:12 -0700
Message-ID: <7C3A0713-1040-43AC-93DF-331F422DF922@isilon.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 08 19:46:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGHGg-0006F2-Ua
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 19:46:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754062AbYGHRpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 13:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752083AbYGHRpZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 13:45:25 -0400
Received: from seaxch05.isilon.com ([74.85.160.21]:35559 "EHLO
	seaxch05.isilon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753989AbYGHRpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 13:45:25 -0400
X-Greylist: delayed 912 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Jul 2008 13:45:25 EDT
Received: from 10-8-5-63.isilon.com ([10.8.5.63]) by seaxch05.isilon.com with Microsoft SMTPSVC(6.0.3790.211);
	 Tue, 8 Jul 2008 10:30:13 -0700
X-Mailer: Apple Mail (2.919.2)
X-OriginalArrivalTime: 08 Jul 2008 17:30:13.0256 (UTC) FILETIME=[475D5080:01C8E120]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87778>

Hi,

My internal subversion repository has a pre-commit script that  
requires the svn:mime-type and svn:eol-style properties to be set on  
any new file before it can be added to the repository.  If these  
properties aren't set, the commit fails.  When using git-svn dcommit  
to commit a patch that adds a new file, the dcommit also fails with  
the error below.  I have added auto-props rules in my ~/.subversion/ 
config file to automatically set these properties based on file  
extension, so an svn commit doesn't require explicitly setting them.   
I tried adding the --config-dir=~/.subversion option to the dcommit  
command, but it didn't seem to make a difference.

Is there any way to set these properties or consult subversion auto- 
props so that git-svn knows how to set them during the dcommit?  Would  
it be difficult to add this capability if it doesn't already exist?


Example command and subsequent error:

# git-svn dcommit --verbose --config-dir=~/.subversion
Committing to https://svn/repo/foo ...
         A       bar.c
A repository hook failed: MERGE request failed on '/repo/foo': 'pre- 
commit' hook failed with error output:
/svnrepo/hooks/check-mime-type.pl:

foo/bar.c : svn:mime-type is not set

     Every added file must have the svn:mime-type property set. In
     addition text files must have the svn:eol-style property set.

     For binary files try running
     svn propset svn:mime-type application/octet-stream path/of/file

     For text files try
     svn propset svn:mime-type text/plain path/of/file
     svn propset svn:eol-style native path/of/file

     You may want to consider uncommenting the auto-props section
     in your ~/.subversion/config file. Read the Subversion book
     (http://svnbook.red-bean.com/), Chapter 7, Properties section,
     Automatic Property Setting subsection for more help.
  at /usr/bin/git-svn line 461


Thanks!

-Tim
