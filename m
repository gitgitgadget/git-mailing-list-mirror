From: Pavel Roskin <proski@gnu.org>
Subject: "stg reset --status" doesn't just reset status
Date: Tue, 01 Apr 2008 22:21:24 -0400
Message-ID: <20080401222124.1b4niqtm0ogw40sk@webmail.spamcop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 02 04:22:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jgsc6-0005CN-2k
	for gcvg-git-2@gmane.org; Wed, 02 Apr 2008 04:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752693AbYDBCV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2008 22:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754947AbYDBCV0
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Apr 2008 22:21:26 -0400
Received: from c60.cesmail.net ([216.154.195.49]:10361 "EHLO c60.cesmail.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbYDBCVZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Apr 2008 22:21:25 -0400
Received: from unknown (HELO delta2) ([192.168.1.50])
  by c60.cesmail.net with ESMTP; 01 Apr 2008 22:21:24 -0400
Received: from pool-96-227-100-231.phlapa.east.verizon.net
	(pool-96-227-100-231.phlapa.east.verizon.net [96.227.100.231]) by
	webmail.spamcop.net (Horde MIME library) with HTTP; Tue, 01 Apr 2008
	22:21:24 -0400
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) H3 (4.1.4)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78676>

Hello!

I used to see messages like this:

$ stg pull
Checking for changes in the working directory ... done
stg pull: local changes in the tree. Use "refresh" or "status --reset"

This time I decided to see what "stg reset --status" actually does,  
and I was unpleasantly surprised that it would do much more that its  
name implies.

It doesn't just reset the status (no idea what it would be, but it  
doesn't sound scary).  It removes all local changes.  It's essentially  
"git reset --hard".  I can easily imagine that some beginner would  
lose valuable changes by following that advice while trying to update  
from the upstream repository.

I would hate to suggest another stg command, as there are too many of  
them already.  On the other hand, if "applied" and "unapplied" are  
downgraded to switches for "stg series", we probably could justify  
adding one more command, "stg reset".  By the way, the default could  
be to save the changes to a hidden "stash" patch, and the "--hard"  
switch would do a real reset.

Another (not alternative) approach would be to have an option to "stg  
pull" to save the changes as a temporary patch that would be applied  
and deleted if it applied cleanly.  That shouldn't be a default for  
"stg pull", as it's likely that the user just forgot "stg refresh".

-- 
Regards,
Pavel Roskin
