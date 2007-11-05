From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in
 git, help users out.
Date: Mon, 5 Nov 2007 23:40:46 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711052325090.4362@racer.site>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
 <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com>
 <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Grimm <koreth@midwinter.com>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 00:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBZp-00021i-JY
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 00:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754453AbXKEXlk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 18:41:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754476AbXKEXlk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 18:41:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:47718 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754355AbXKEXlj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 18:41:39 -0500
Received: (qmail invoked by alias); 05 Nov 2007 23:41:37 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp002) with SMTP; 06 Nov 2007 00:41:37 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+gMs8AhHiglgnCiROI5K8MJCfU2dcH/HwSPJtjMQ
	9/2/44xj2VltUO
X-X-Sender: gene099@racer.site
In-Reply-To: <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63588>

Hi,

On Mon, 5 Nov 2007, Junio C Hamano wrote:

> Steven Grimm <koreth@midwinter.com> writes:
> 
> > But that suggested command is not going to convince anyone they were
> > wrong about git being hard to learn. I wonder if instead of saying, "I
> > know what you meant, but I'm going to make you type a different
> > command," we should make git revert just do what the user meant.
> >
> > There is already precedent for that kind of mixed-mode UI:
> >
> > git checkout my-branch
> > vs.
> > git checkout my/source/file.c
> 
> That's an example of mixed-mode UI, but what you are suggesting is quite 
> different, isn't it?
> 
> There is no other officially supported single-command-way to
> checkout paths out of the index.

Okay, let's step back a bit.

We taught "git show" to show other objects than commits, by doing the 
obvious things.  So there _is_ a precendent to changing a commands 
behaviour to accept more than just commits.  And there was already another 
command for the same purpose, cat-file, which was never meant as 
porcelain however.

Now, what does "revert" _mean_?  At the moment, it wants a commit, and 
will undo the changes that commit introduced, _and commits it_ (asking 
for a message).

What would I expect "git revert -- file" to do?  It would undo the changes 
to that file -- and since no commit was specified, I would expect it to 
look at the changes against the index.  (IOW exactly what Steven 
proposed.)

To continue the analogy, it would have to commit the undoing of the 
change.  But since that change never was committed, I think it is more 
natural to _not_ commit it.

In the same way, I would expect "git revert <commit> -- file" to undo the 
changes in that commit to _that_ file (something like "git merge-file 
file <commit>:file <commit>^:file"), but this time commit it, since it 
was committed at one stage.

IMHO this would be a consistent behaviour _and_ help new git users.

After all, we are not Python, supposedly narrowing users down to 
one-way-to-do-things only.

Ciao,
Dscho
