From: Tommy Thorn <tt1729@yahoo.com>
Subject: git-p4 runs out of memory
Date: Thu, 31 Jan 2008 17:18:53 -0800 (PST)
Message-ID: <565265.29093.qm@web39507.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 01 02:26:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKkfU-0000ML-LI
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 02:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbYBABZg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 20:25:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751575AbYBABZf
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 20:25:35 -0500
Received: from web39507.mail.mud.yahoo.com ([209.191.106.91]:44872 "HELO
	web39507.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753713AbYBABZe (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Jan 2008 20:25:34 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Thu, 31 Jan 2008 20:25:34 EST
Received: (qmail 30040 invoked by uid 60001); 1 Feb 2008 01:18:53 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=Vaf0R9ybr3gkHJCC17ru9NVX6dluJSuDGNd07ud2G14Bn4Oj5U3kavvqOj8r2M8+fsWcEvknDEGY2+YgCfMth/UqrayJ425E/BKBbFysPNNBBYW2ZPDw4NUIminYa5151kmKqmAgfahFiH7V/O1B+G7bfUPf7V080IQB73R1K38=;
X-YMail-OSG: aPWP2cUVM1lGIeYEcX96BZL5QrKX4fRJlVUeylH0e1I6DYMjmYfpjo5skn3Gapfo.dl7G3.e_oIN6pZ86cLaytt.NdDR.GcCkQd4h0TkmzKShj9xrC1ox7DQipxMyg--
Received: from [216.228.112.21] by web39507.mail.mud.yahoo.com via HTTP; Thu, 31 Jan 2008 17:18:53 PST
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72144>

Trying to survive in a heavily Perforce dominated 
world, git-p4 looked like the perfect antidote. 
Unfortunately I have a few problems:

0. git-p4 swells until it runs out of virtual space!
It
   appears that the scripts tries to read everything 
   into memory:

 filedata = p4CmdList('-x - print',
                      stdin='\n'.join(['%s#%s' %
(f['path'], f['rev'])
                                       for f in
files]),
                      stdin_mode='w+')

  Short of rewriting git-p4, is it possible to clone
in
  multiple steps?

1. Short of full Perforce client support, support of 
   exclusion would have helped. Dmitry Kakurin
provided
   a good start. I'll try to generalize it such that
   multiple exclusion can be specified as 

     -//branch/file/blah

2. Having "git p4 commit" be an alias of 
   "git p4 submit" seems a mistake - this is not a 
   commit like a git commit, but more like a git push.

Thanks
Tommy



      ____________________________________________________________________________________
Be a better friend, newshound, and 
know-it-all with Yahoo! Mobile.  Try it now.  http://mobile.yahoo.com/;_ylt=Ahu06i62sR8HDtDypao8Wcj9tAcJ 
