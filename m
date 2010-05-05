From: Jeff King <peff@peff.net>
Subject: Re: [RFD PATCH] revlist/rev-parse: Introduce --heads and --locals
 revision specifiers
Date: Tue, 4 May 2010 23:35:36 -0400
Message-ID: <20100505033536.GB8779@coredump.intra.peff.net>
References: <83fc6259c434cc63f8e64ddf9ac8f90bae0ab2eb.1272557175.git.git@drmicha.warpmail.net>
 <20100502050054.GE14776@coredump.intra.peff.net>
 <4BDD8169.9050301@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed May 05 05:37:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9VQl-0006km-NR
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 05:37:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933635Ab0EEDfk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 23:35:40 -0400
Received: from peff.net ([208.65.91.99]:56174 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933437Ab0EEDfk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 23:35:40 -0400
Received: (qmail 18330 invoked by uid 107); 5 May 2010 03:35:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 04 May 2010 23:35:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 04 May 2010 23:35:36 -0400
Content-Disposition: inline
In-Reply-To: <4BDD8169.9050301@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146369>

On Sun, May 02, 2010 at 03:43:05PM +0200, Michael J Gruber wrote:

> > I don't have anything against the concept, but "--heads" is a horrible
> > name, as it implies refs/heads (which is of course what --branches does.
> > Yikes!). I know why you picked it, and once you think about it, yes, it
> [...]
> > does make some sense (it is all the local and remote heads), but I am
> > worried that it will cause confusion.
> 
> So, your alternative suggestion is...? ;)

I have to criticize _and_ suggest? Sheesh.

> How about --tips? But I don't like that.

I don't like it either. Really, "--branches" is a reasonable
description of what you are providing, but that is already taken. :)

I can't think of another place in git where we collectively refer to
local and remote branch heads by a single term. The closest is
git-branch's "-a". You could do "--all-branches", but this was meant to
save some typing, so it probably fails on that count.

The problem with things like --tips, --heads, or --branches, is that
there is nothing to say "I mean _both_ local and remote" as opposed to
just local. And I'm not sure there is a way to say that without getting
long. I guess "--all-heads" is shorter, but still ugly.

> We really use head as the term for the tip (ordered end-vertex) of a
> branch, be it local or remote.

Yeah. Originally both of those things were in refs/heads/, but the
"separate remote" layout has been standard for some time. Even Junio may
have switched by now. :)

> I would hope that ordinary users do not have to deal with the layout under
> refs, and thus won't be confused. But people peel and poke everywhere
> where there not supposed to :)

I think refs/heads is something many git users know about. Git was
designed from the start to have a simple data model, and that model
(including things like ref naming) was always exposed to the user.
That's what makes it so flexible, and of course is what makes many
people complain.

These days that data model is a little more hidden, but I think you do
still see the refs hierarchy. Certainly users see "remotes/" (e.g., in
"git branch -a"), though perhaps they don't necessarily realize how it
relates to refs/ and refs/heads/. Full ref names are also used for
disambiguation, though I suppose most people never need to deal with
that. But the first time one runs "git for-each-ref" (I know, I manage
to work it into every conversation, right?) you get full exposure.

-Peff
