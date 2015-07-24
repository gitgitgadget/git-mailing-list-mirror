From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 00:34:16 -0700
Message-ID: <20150724073415.GD2111@peff.net>
References: <20150723012343.GA21000@peff.net>
 <xmqqpp3io5km.fsf@gitster.dls.corp.google.com>
 <CA+P7+xoOkTfair3M7HH_TPs9qxBAUR5GodHGDuw8Ux_HaUvvyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:34:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIXUu-0004Q0-SF
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 09:34:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752847AbbGXHeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 03:34:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:34406 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751417AbbGXHeU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 03:34:20 -0400
Received: (qmail 9577 invoked by uid 102); 24 Jul 2015 07:34:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 02:34:20 -0500
Received: (qmail 17896 invoked by uid 107); 24 Jul 2015 07:34:24 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 03:34:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 00:34:16 -0700
Content-Disposition: inline
In-Reply-To: <CA+P7+xoOkTfair3M7HH_TPs9qxBAUR5GodHGDuw8Ux_HaUvvyQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274558>

On Thu, Jul 23, 2015 at 11:07:58PM -0700, Jacob Keller wrote:

> I think some projects definitely benefit from the first-parent setup,
> and it could be valuable, but I do tend to agree with Junio here that
> the mess is always helpful. If may be helpful if people's commit
> messages on that mess are good, but generally those that don't take
> the time to rebase local work and re-express the commit messages are
> not going to leave insightful messages the first time. However, have
> the ability to view history this way is still possibly valuable.

I think a really simple example is something like:

  1. somebody implements as feature. It needs to handle cases a, b, and
     c, but it only handles case a. Therefore it is buggy.

  2. During review, somebody notices case b, and a new commit is made to
     fix it. Nobody notices case c.

  3. The topic is merged.

  4. Much later, somebody notices the system is buggy and hunts in the
     history.

In a "clean" history, the patches from steps 1 and 2 are squashed. While
reading the history, you see only "implement feature X", and no mention
of the bug and its fix. But even if the person writes a terrible commit
message for step (2), even seeing it pulled out into its own diff shows
the exact nature of the already-seen bug, and may make it more obvious
to realize that case (c) is a problem.

I realize that's kind of vague. Another way to think about it is: in a
squashing workflow like git.git, any time you have to turn to the
mailing list to read the original sequence of re-rolls, you would have
been better off if that information were in git. That's a minority case,
but I certainly have turned to it (in some cases, the "fix" from our
step 2 above actually introduces the new bug, and it's nice to see the
reasoning that went into it :) ).

Not that I am advocating for git.git to move to such a workflow. I think
on balance the "clean" history is nicer to work with. I am only arguing
that keeping the messy history is not without value; there are some
cases where it is nice to have (and we keep it in the list archive,
which is a minor pain to access compared to git).

-Peff
