From: Jeff King <peff@peff.net>
Subject: Re: git push
Date: Wed, 25 Feb 2009 04:51:30 -0500
Message-ID: <20090225095129.GA16357@coredump.intra.peff.net>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com> <7vskm3c84t.fsf@gitster.siamese.dyndns.org> <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com> <7v4oyjc64z.fsf@gitster.siamese.dyndns.org> <20090225090230.GA15919@coredump.intra.peff.net> <7viqmy7tqk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGRx-0001Ro-1r
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbZBYJvf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755961AbZBYJvf
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:51:35 -0500
Received: from peff.net ([208.65.91.99]:55718 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753174AbZBYJve (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:51:34 -0500
Received: (qmail 25172 invoked by uid 107); 25 Feb 2009 09:51:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 25 Feb 2009 04:51:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Feb 2009 04:51:30 -0500
Content-Disposition: inline
In-Reply-To: <7viqmy7tqk.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111425>

On Wed, Feb 25, 2009 at 01:26:11AM -0800, Junio C Hamano wrote:

> Of course. "Encouraging a behaviour" means just that.  A better workflow
> and a better use of branches.

I don't agree that it is necessarily a better workflow.

> > When you think about "is my current branch ready to push?" there is no
> > reason for you to think of that other long-running branch that you
> > haven't seen for days.
> 
> Sorry, I have to disagree with that.
> 
> We are talking about people to whom the "push matching refs" is a problem,
> and that means they are using a branch with the same name with other
> people (either from a shared central repository or his own publishing
> branch) to house long-running, intermediate, uncooked state.

I do this all the time by making "wip" commits on top of my topic
branches. I push the topic branches to a networked repo so they are
accessible and backed up. Then when I work, I do something like:

  (1) git checkout jk/existing-topic
  (2) hack hack hack
  (3) # oops, must sleep on this topic
  (4) git commit -a -m wip
  (5) sleep sleep sleep
  (6) # oops, I need to work on something else this morning
  (6) git checkout -b jk/new-topic master
  (7) # ok, master is ready
  (8) git push origin HEAD

I don't want my WIP commit pushed; it is a purely local and temporary
placeholder.

It seems that you are suggesting that I should never put such uncooked
state onto a branch that has already been pushed. Which means I should
replace (4) with "git checkout -b jk/topic-subtopic". This is a pain.
When I come back to the topic, I want to:

  git checkout jk/existing-topic
  gitk origin.. ;# where was I? Oh right, a WIP.

I think where I am leaving your mental model is that my published
branches are not necessarily "long running" in the same way that you
think. I publish them so I can pick them up elsewhere, and maybe even so
other people can see what I'm working on. But they really are topic
branches.

-Peff
