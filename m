From: Jon Loeliger <jdl@jdl.com>
Subject: git push refspec URL weirdness
Date: Fri, 24 Mar 2006 21:42:47 -0600
Message-ID: <E1FMzfr-0006xT-Uq@jdl.com>
X-From: git-owner@vger.kernel.org Sat Mar 25 04:43:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMzgI-0008Ol-GR
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 04:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750743AbWCYDnJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 22:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWCYDnI
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 22:43:08 -0500
Received: from colo.jdl.com ([66.118.10.122]:65456 "EHLO jdl.com")
	by vger.kernel.org with ESMTP id S1750743AbWCYDnH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Mar 2006 22:43:07 -0500
Received: from jdl (helo=jdl.com)
	by jdl.com with local-esmtp (Exim 4.44)
	id 1FMzfr-0006xT-Uq
	for git@vger.kernel.org; Fri, 24 Mar 2006 21:42:48 -0600
To: git@vger.kernel.org
X-Spam-Score: -5.9 (-----)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17950>


I wanted to git push some bits to a remote repo
and set up this .git/refs/remotes/publish file:

    URL: git+ssh://www.example.com/some/path/repo.git
    Push: my-branch:public-branch

So that I could "git push publish".

The ssh on the far side is listening on port 1234
and not the default 22.  So I slapped this into my
~/.ssh/config file on the local machine:

    Host www.example.com
    Port 1234

This worked great for a straight "ssh www.example.com"
connection.  However, git still complained that port 22
was refusing connections.  It was.  Git shouldn't have
been trying to use it.

So Junio suggested taking advantage of the fact that the
default refspec uses git+ssh and use this instead:

    URL: www.example.com:/pub/software/linux-2.6-86xx.git
    Push: my-branch:public-branch

Which just worked.

So this is either a bug report or google food. :-)

jdl
