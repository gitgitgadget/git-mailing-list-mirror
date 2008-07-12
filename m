From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: git-rebase eats empty commits
Date: Sun, 13 Jul 2008 00:12:07 +0200
Message-ID: <20080712221207.GB22323@leksak.fem-net>
References: <g4vrrm$g35$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
X-From: git-owner@vger.kernel.org Sun Jul 13 00:13:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHnL5-0005Yo-O5
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 00:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYGLWMN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jul 2008 18:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753227AbYGLWMN
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jul 2008 18:12:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:43824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752482AbYGLWMM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jul 2008 18:12:12 -0400
Received: (qmail invoked by alias); 12 Jul 2008 22:12:10 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp042) with SMTP; 13 Jul 2008 00:12:10 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX199edte4QR9eRN25jrhktJefzRINONCI2rbzNStZu
	Fv3besS8GFZBBI
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KHnK3-0006NP-Ox; Sun, 13 Jul 2008 00:12:07 +0200
Content-Disposition: inline
In-Reply-To: <g4vrrm$g35$1@ger.gmane.org>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88269>

Hi,

Michael J Gruber wrote:
> "git commit" allows empty commits with the "--allow-empty" option, i.e.  
> commits which introduce no change at all. This is sometimes useful for  
> keeping a log of untracked work related to tracked content.
>
> "git rebase" removes empty commits, for the good reason that rebasing  
> may make certain commits obsolete; but I don't want that in the case  
> mentioned above. Is there any way to specify "--preserve-empty" or 
> similar?

First I can speak for git-sequencer: there is no such thing as a
"preserve empty" option, but currently, when you are picking a commit
that has already been applied so that no changes occur, it will pause.
(It will not pause if it is a fast-forward.)
Yet, I was unsure if this is a "correct" behavior, but it seemed to be
useful, because you can inspect the situation.

In my mind, the same should happen with an empty commit, so I tested it:
 1. It pauses.
 2. In that pause I only need to run "git commit --allow-empty" and I have
    the picked empty patch with that commit message.

So if this behavior is kept, there is no such need for such an option.

Now I'm checking it with the old rebase-i (I'm always referring to
git-rebase--interactive as rebase-i) and exactly the same behavior
occurs.

But rebase is not rebase-i.
So I've also checked both, pure rebase and rebase-m: then the empty commit
is lost.

To sum up, use rebase -i and when it's pausing, do "git commit --allow-empty"
and then "git rebase --continue" and you have what you want.

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
