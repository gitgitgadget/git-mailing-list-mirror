From: Johan Herland <johan@herland.net>
Subject: Re: post-receive hook
Date: Fri, 30 May 2008 11:06:33 +0200
Message-ID: <200805301106.33992.johan@herland.net>
References: <alpine.DEB.1.10.0805300108140.4014@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri May 30 11:07:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K20aF-00046e-5E
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 11:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752190AbYE3JGn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 05:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbYE3JGm
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 05:06:42 -0400
Received: from smtp.getmail.no ([84.208.20.33]:40699 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985AbYE3JGm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 05:06:42 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0K1O00703BZ4G000@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 30 May 2008 11:06:40 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1O0002QBYYCU20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Fri, 30 May 2008 11:06:34 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0K1O00GJXBYYEPP0@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Fri, 30 May 2008 11:06:34 +0200 (CEST)
In-reply-to: <alpine.DEB.1.10.0805300108140.4014@asgard.lang.hm>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83278>

On Friday 30 May 2008, david@lang.hm wrote:
> I'm trying to setup a post-receive hook to do a checkout -f when I push to 
> a public repo (it's a web based tool and I want the executables to be 
> updated with a push)
> 
> unfortunantly if I just add git checkout -f to the post-receive hooks it 
> checks the files out in the .git directory.
> 
> if I do a cd .. ; git checkout -f I get an error message complaining that 
> it's not in a git repository, but if I manually cd to that directory and 
> do a checkout it works.
> 
> what am I missing here?

I'm guessing that the post-receive hook is invoked with "GIT_DIR=.", which goes bad the moment you chdir anywhere. I have this in my own update hook script:

if [ "$GIT_DIR" = "." ]; then
	GIT_DIR=`pwd`
fi

If you do this before the "cd .. ; git checkout -f", you might have better luck.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
