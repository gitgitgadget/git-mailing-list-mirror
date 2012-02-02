From: Mark Jason Dominus <mjd@plover.com>
Subject: BUG 1.7.9: git-update-ref strange behavior with ref with trailing
 newline
Date: Thu, 02 Feb 2012 17:09:28 -0500
Organization: P.D.Q. Bernoulli Institute of Lower Mathematics
Message-ID: <15093.1328220568@plover.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 23:10:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rt4qv-0003f9-7Y
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 23:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757362Ab2BBWJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 17:09:53 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:63037 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab2BBWJv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 17:09:51 -0500
Received: from plover.com ([unknown] [72.92.111.222])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LYS00AJVDJTHMY3@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Thu, 02 Feb 2012 16:09:30 -0600 (CST)
Received: (qmail 15095 invoked by uid 1000); Thu, 02 Feb 2012 22:09:28 +0000
Received: from localhost (HELO plover.com) (sendmail-bs@127.0.0.1)
 by localhost with SMTP; Thu, 02 Feb 2012 22:09:28 +0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189715>


Here I use git symbolic-ref to update HEAD with a ref whose name
contains trailing newlines:

        $ git symbolic-ref -m "this message does not appear" HEAD 'refs/heads/master
        >
        >
        > '

The newlines are inserted into .git/HEAD, but are innocuous, because
other git commands ignore them.  The bug is that the -m option is
completely ignored:

        $ git reflog HEAD | grep 'message does not appear'
        $

If trailing newlines are considered acceptable, the -m option should
be honored.  If not, an error message should be printed and thecommand
should exit with a nonzero exit status.

I will prepare a patch if you will say which behavior would be
preferable.

Mark Jason Dominus 	  			                 mjd@plover.com
