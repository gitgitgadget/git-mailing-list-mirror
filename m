From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 22:00:46 -0500
Message-ID: <20080209030046.GA10470@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 04:01:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNfy0-0003Qt-4F
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 04:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbYBIDAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 22:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753230AbYBIDAu
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 22:00:50 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3932 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753075AbYBIDAt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 22:00:49 -0500
Received: (qmail 7181 invoked by uid 111); 9 Feb 2008 03:00:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 08 Feb 2008 22:00:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2008 22:00:46 -0500
Content-Disposition: inline
In-Reply-To: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73187>

On Fri, Feb 08, 2008 at 05:44:12PM +1300, Martin Langhoff wrote:

> This means that beyond the branches I actively work on, I also have
> local tracking branches for remote heads that I am not updating. When
> I say git push, these stale local tracking branches are making a lot
> of noise in the output:
> 
> To git+ssh://git.catalyst.net.nz/var/git/moodle-r2.git
>  ! [rejected]        mdl17-ceo -> mdl17-ceo (non-fast forward)
>  ! [rejected]        mdl18-local -> mdl18-local (non-fast forward)
>  ! [rejected]        mdl18-masseyedu-wimbatest ->
> mdl18-masseyedu-wimbatest (non-fast forward)
>  ! [rejected]        mdl18-nmit -> mdl18-nmit (non-fast forward)
>  ! [rejected]        mdl18-proxy -> mdl18-proxy (non-fast forward)
>  ! [rejected]        mdl18-shared -> mdl18-shared (non-fast forward)
>  ! [rejected]        mdl18-sqm -> mdl18-sqm (non-fast forward)
>  ! [rejected]        mdl18-stcuthberts -> mdl18-stcuthberts (non-fast forward)
>  ! [rejected]        mdl18-topnz -> mdl18-topnz (non-fast forward)
>  ! [rejected]        mdl19-dbperf -> mdl19-dbperf (non-fast forward)
>  ! [rejected]        mdl19-ucol -> mdl19-ucol (non-fast forward)
>  ! [rejected]        mdl19-uow -> mdl19-uow (non-fast forward)
> error: failed to push to 'git+ssh://git.catalyst.net.nz/var/git/moodle-r2.git'

Thinking about this more, this situation is more than a minor annoyance:
it is actually somewhat dangerous. If you ever wanted to push _one_
non-ff case (say, for your current branch) and you were to use "git push
-f", you would rewind history for random branches, and sorting the mess
out at the remote could be awful (especially if it is a bare repo
without reflogs).

I really think that Steffen's "default to pushing only the current
branch" approach fits much better with the model described in your
workflow, and is generally a safer default. IIRC, the main objection was
that old-timers like the current push behavior better. Steffen, was
there objection to a "push.onlyHEAD" config option?

-Peff
