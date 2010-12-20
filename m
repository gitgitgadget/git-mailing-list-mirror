From: Guy Rouillier <guyr@burntmail.com>
Subject: cvsimport still not working with cvsnt
Date: Sun, 19 Dec 2010 23:05:00 -0500
Message-ID: <4D0ED5EC.9020402@burntmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 20 05:27:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUXLY-0001ZU-6d
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 05:27:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752386Ab0LTE1f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Dec 2010 23:27:35 -0500
Received: from mx02.burntmail.com ([70.87.63.122]:48023 "EHLO
	mx02.burntmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155Ab0LTE1e (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 23:27:34 -0500
X-Greylist: delayed 1352 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Dec 2010 23:27:34 EST
Received: from [173.79.59.45] (helo=[192.168.1.60])
	by mx02.burntmail.com with esmtpa (Exim 4.63)
	(envelope-from <guyr@burntmail.com>)
	id 1PUWze-00018m-O5
	for git@vger.kernel.org; Sun, 19 Dec 2010 22:05:02 -0600
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Lightning/1.0b2 Thunderbird/3.1.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163979>

I'm going to try sending this blind, as the mailing list has sent me the 
promised authorization key after 24 hrs.

I'm brand new to git.  We'll be moving over from CVS, so I imported a 
small part of our CVS repository to start learning git.  We use the 
CVSNT server, and git-cvsimport was failing with "I HATE YOU".  I 
finally found the problems, both of which were reported in 2008 here:

http://kerneltrap.org/mailarchive/git/2008/3/13/1157364

However, these changes do not appear in the version 1.7.2.2 that Gentoo 
supplies.  I checked the 1.7.3-rc2 source and the changes are not in 
there either.

I do see one possible issue with the supplied modifications.  At work, 
we upgraded from CVS to CVSNT.  So, my home directory has both .cvspass 
(from the original CVS) and .cvs/cvspass (after the conversion to 
CVSNT.)  Sloppy housekeeping on my part, I admit, but probably not 
uncommon.  The supplied patch would pick up the original CVS file and 
would fail.  (BTW, this is true only of the git-cvsimport.perl script 
itself; cvsps must shell out to the installed CVS client (in my case, 
cvsnt), because when I invoked that manually, it worked.)

So, I would advise checking to see if both files exist, and if so exit 
with an error.  Unless cvsimport wants to get real fancy and shell out 
to the installed cvs client to try to figure out what is installed, 
there is no way to tell which cvspass file is actively being used.  I 
don't recommend trying to figure this out, as the user's intent is unclear.

-- 
Guy Rouillier
