From: Jeff King <peff@peff.net>
Subject: Re: git pull works remotely but not locally
Date: Thu, 27 May 2010 11:38:12 -0400
Message-ID: <20100527153812.GA23484@coredump.intra.peff.net>
References: <4BFE750B.5030007@llaisdy.com>
 <AANLkTikmrBQ1aUQeAZKB8pdgwXjureozZOzEHq8CF4kb@mail.gmail.com>
 <4BFE83A7.4020604@llaisdy.com>
 <AANLkTinn_D2nrZDoczHqvAFKdCxxubK0N0jHr-nE94JP@mail.gmail.com>
 <4BFE8A99.5060906@llaisdy.com>
 <20100527151514.GB18590@coredump.intra.peff.net>
 <4BFE8DF8.8050301@llaisdy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Ivan Uemlianin <ivan@llaisdy.com>
X-From: git-owner@vger.kernel.org Thu May 27 17:38:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHfA4-0002I4-Nm
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 17:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417Ab0E0PiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 11:38:18 -0400
Received: from peff.net ([208.65.91.99]:45669 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932415Ab0E0PiO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 11:38:14 -0400
Received: (qmail 23217 invoked by uid 107); 27 May 2010 15:38:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 May 2010 11:38:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 May 2010 11:38:12 -0400
Content-Disposition: inline
In-Reply-To: <4BFE8DF8.8050301@llaisdy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147881>

On Thu, May 27, 2010 at 04:21:28PM +0100, Ivan Uemlianin wrote:

> Thanks for your comment.
> >What happens if you run "git pull"? If you get an error, can you try to
> >run "GIT_TRACE=1 git pull"? Git should then print out exactly what it is
> >trying to exec that is failing.
> 
> Not very exciting:
> 
> $ GIT_TRACE=1 git pull
> trace: exec: 'git-pull'
> trace: run_command: 'git-pull'
> fatal: cannot exec 'git-pull': Permission denied

Then the next thing to try is probably (assuming you are running Linux):

  strace -f -e execve git pull

Though I suspect we may just see:

  execve("/opt/libexec/git-core/git-core/git-pull", ...) = -1 EACCES (Permission denied)

which doesn't help much. I just want to be sure that is the source of
the problem.

-Peff
