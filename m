From: Johan Herland <johan@herland.net>
Subject: Re: way to automatically add untracked files?
Date: Mon, 06 Aug 2007 09:30:13 +0200
Message-ID: <200708060930.13967.johan@herland.net>
References: <873ayymzc1.fsf@catnip.gol.com>
 <200708051411.25238.johan@herland.net> <f95q7l$8lv$2@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 06 09:30:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHx2w-0005p3-Vi
	for gcvg-git@gmane.org; Mon, 06 Aug 2007 09:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754178AbXHFHaX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Aug 2007 03:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbXHFHaX
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 03:30:23 -0400
Received: from smtp.getmail.no ([84.208.20.33]:48202 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753668AbXHFHaW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 03:30:22 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JMC00C01CULMQ00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 06 Aug 2007 09:30:21 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMC004WSCUJR570@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 06 Aug 2007 09:30:19 +0200 (CEST)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-009-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JMC00FY3CUH6430@no-osl-m323-srv-009-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 06 Aug 2007 09:30:19 +0200 (CEST)
In-reply-to: <f95q7l$8lv$2@sea.gmane.org>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55119>

On Monday 06 August 2007, Jakub Narebski wrote:
> Johan Herland wrote:
> 
> > So different users seem to have two different (almost incompatible) 
> > expectations to git-add:
> > 
> > 1. git-add adds new files into the index. git-add has _no_ business removing 
> > deleted files from the index.
> > 
> > 2. git-add updates the index according to the state of the working tree. 
> > This includes adding new files and removing deleted files.
> > 
> > 
> > Both interpretations are useful and worth supporting, but git-add currently 
> > seems focused on #1 (and rightly so, IMHO).
> > 
> > Even though #2 can be achieved by using a couple of git-add commmands (or a 
> > longer series of more obscure plumbing-level commands), it might be worth 
> > considering the more user-friendly alternative of adding a dedicated 
> > command for supporting #2. Such a command already exists in a similar RCS:
> > 
> > ---
> > $ hg addremove --help
> > hg addremove [OPTION]... [FILE]...
> > 
> > add all new files, delete all missing files
> 
> git update-index --add --remove?

This is actually the nicest looking command I've seen so far in this thread.
It's reasonably simple to deduce what it does, or rather, should do...

Of course it has some shortcomings:

- It only works on individual files. Supplying a directory (subdir or '.')
  is not supported.

- It _seems_ to not support .gitignore, i.e. new files that are already in
  .gitignore give the same feedback (add 'foo') as new files that are not
  ignored. But when you commit, the ignored files will in fact _not_ be
  committed (which is correct, AFAICS). It would be nice if git-update-index
  told me that up front.

Of course, It may be that git-update-index is too low-level (i.e. plumbing)
to support the above use case in a user-friendly fashion. In that case, feel
free to ignore the above issues.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
