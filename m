From: Jean-Luc Herren <jlh@gmx.ch>
Subject: Re: [PATCH] Invoke "gc --auto" from git commit
Date: Wed, 26 Nov 2008 02:00:31 +0100
Message-ID: <492C9FAF.4090407@gmx.ch>
References: <492C24B9.6090200@gmx.ch> <alpine.DEB.1.00.0811260056480.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L596a-0004pb-6Y
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 02:22:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753083AbYKZBUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2008 20:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752932AbYKZBUz
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Nov 2008 20:20:55 -0500
Received: from mail.gmx.net ([213.165.64.20]:40616 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752715AbYKZBUy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2008 20:20:54 -0500
Received: (qmail invoked by alias); 26 Nov 2008 01:00:32 -0000
Received: from 70-46.78-83.cust.bluewin.ch (EHLO [192.168.123.204]) [83.78.46.70]
  by mail.gmx.net (mp061) with SMTP; 26 Nov 2008 02:00:32 +0100
X-Authenticated: #14737133
X-Provags-ID: V01U2FsdGVkX1/GZXIsT0/GIdiIbIThr0mYuLJSxiYeutohkkiazz
	zwDkwb4xLEXUHg
User-Agent: Thunderbird 2.0.0.18 (X11/20081123)
In-Reply-To: <alpine.DEB.1.00.0811260056480.30769@pacific.mpi-cbg.de>
X-Enigmail-Version: 0.95.7
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101699>

Johannes Schindelin wrote:
> On Tue, 25 Nov 2008, Jean-Luc Herren wrote:
>> This feature was lost during the port of git commit to C.
> 
> See http://article.gmane.org/gmane.comp.version-control.git/82125

Oh, I missed that.  But then the only commands ever invoking git
gc --auto would be git rebase -i, git merge, git svn and git am.
I don't know if some people have repositories where they never use
any of those, but I certainly have repositories where I only ever
use git rebase -i and never any of the other.  'git commit' is
something everyone is bound to use and thus it would be the best
place for running 'git gc --auto'.

As for the performance impact, on my machine 'git gc --auto' runs
500 times per second in a loop on the git repository (it won't
call the hook unless repacking is necessary).  I suppose any
script calling git commit in a loop would do substantially more
work than git gc --auto itself.  And if that bit of performance
really matters, it could be invoked by git commit only if (rand()
% 20 == 0).

My two cents anyway.

jlh
