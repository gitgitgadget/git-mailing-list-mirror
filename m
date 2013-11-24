From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Git issues with submodules
Date: Sun, 24 Nov 2013 02:06:42 +0100
Message-ID: <20131124010642.GB3500@sandbox-ub>
References: <CALkWK0nDME-z7G4kcag=ad3qH5FL9FawrYFyVLQB6Z_g+TV+vQ@mail.gmail.com>
 <20131122151120.GA32361@sigill.intra.peff.net>
 <CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
 <CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
 <CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
 <CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
 <CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
 <528FC638.5060403@web.de>
 <20131122215454.GA4952@sandbox-ub>
 <529110ED.8000501@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 24 02:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkOA2-0005FN-Tm
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 02:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756394Ab3KXBGv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Nov 2013 20:06:51 -0500
Received: from smtprelay01.ispgateway.de ([80.67.29.23]:38866 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756176Ab3KXBGu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Nov 2013 20:06:50 -0500
X-Greylist: delayed 97906 seconds by postgrey-1.27 at vger.kernel.org; Sat, 23 Nov 2013 20:06:50 EST
Received: from [77.20.34.36] (helo=sandbox-ub)
	by smtprelay01.ispgateway.de with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1VkO9r-0007rQ-Ud; Sun, 24 Nov 2013 02:06:44 +0100
Content-Disposition: inline
In-Reply-To: <529110ED.8000501@web.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238247>

On Sat, Nov 23, 2013 at 09:32:45PM +0100, Jens Lehmann wrote:
> Am 22.11.2013 22:54, schrieb Heiko Voigt:
> > What I think needs fixing here first is that the ignore setting should not
> > apply to any diffs between HEAD and index. IMO, it should only apply
> > to the diff between worktree and index.
> 
> Not only that. It should also apply to diffs between commits/trees
> and work tree but not between commits/trees. The reason the ignore
> setting was added three years ago was to avoid expensive work tree
> operations when it was clear that either the information wasn't
> wanted or it took too much time to determine that. And I doubt you
> want to see modifications to submodules in your work tree when
> diffing against HEAD but not when diffing against the index.
> 
> And this behavior happens to be just what the floating branch model
> needs too. I'm not sure there isn't a use case out there that also
> needs to silence diff & friends regarding submodule changes between
> commits/trees and/or index too (even though I cannot come up with
> one at the moment). So I propose to add "worktree" as another value
> for the ignore option - which ignores submodule modifications in
> the work tree - and leave "all" as it is.

I am not so sure about that. Only finding out what has changed (commit
wise) in a submodule is expensive. Just finding out whether a submodule
sha1 has changed is not expensive. Maybe we should completely stop
respecting the ignore=all setting for history and diff between index and
HEAD. AFAIK, we do not have any other setting that instruct git to
ignore specific parts of the history unless explicitly asked for by
specifying a pathspec.

And I think a user should never miss by accident that something has
changed in the repository.

Cheers Heiko
