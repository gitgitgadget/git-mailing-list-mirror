From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 15:46:18 -0400
Message-ID: <20080624194617.GA11862@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <20080623195314.GA29569@sigill.intra.peff.net> <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org> <20080624053504.GB19224@sigill.intra.peff.net> <alpine.LFD.1.10.0806240954150.2926@woody.linux-foundation.org> <20080624173428.GA9500@sigill.intra.peff.net> <alpine.LFD.1.10.0806241036560.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 21:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBEU2-0007rx-Fa
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 21:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753153AbYFXTqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 15:46:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbYFXTqW
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 15:46:22 -0400
Received: from peff.net ([208.65.91.99]:1118 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752704AbYFXTqU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 15:46:20 -0400
Received: (qmail 6585 invoked by uid 111); 24 Jun 2008 19:46:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 15:46:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 15:46:18 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806241036560.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86128>

On Tue, Jun 24, 2008 at 10:44:24AM -0700, Linus Torvalds wrote:

> And to solve that _single_ problem, I wanted parse_options() to be able 
> to:
> 
>  - stop at unknown options (so that I could hand-parse them)
> 
>  - ignore unknown options (so that I could parse all the ones I knew 
>    about, and then either hand-parse the rest, or just pass them on to 
>    _another_ function that used some arbitrary model to parse the parts it 
>    knew about)
> 
> See? Single issue.

OK, fair enough. You are working towards a single goal. But I think
there is a flaw with that one sub-part of your goal (specifically your
second bullet point). I don't care about the other parts, and in fact I
even said "this is a fine way of doing that".

> And I even sent out a single patch for it. That single patch, btw, was 
> even rather small. 
> 
> Did you ever look at that patch? Did you ever look at the code I was 
> trying to have use parse_options()? No.

How can you even say something so ridiculous? Were you sitting at my
computer all day yesterday, making sure I didn't read your patch? No?
Funnily enough, I was there. And guess what I saw? Yes, it was me
READING YOUR PATCH (in a mirror, of course).

But I don't expect you to have a camera installed over my shoulder. So I
guess you would have had to just content yourself with THE EMAILS WHERE I
MENTION YOUR PATCH AND ITS EFFECTS.

> You constantly try to change the discussion to be about SOMETHIGN ELSE.
> 
> For example, you keep on bringing up this TOTAL RED HERRING:
> 
> >   - It is impossible for that mechanism to be correct in all cases, due
> >     to the syntactic rules for command lines. IOW, you cannot parse an
> >     element until you know the function of the element to the left.
> 
> NOBODY F*CKIGN CARES!

I care. Apparently Junio cared in the thread that I pointed out earlier.
Other commands that parse the options will care, if we are to ever port
them to parse_options. I understand that you don't care about those
things, and you only want git-blame to work.  I am merely trying to help
amortize work that goes into fixing git-blame into helping to fix other
commands. To do that, I pointed out a flaw that might prevent the same
solution being used again.

I understand that you are interested in incremental change, and that
doing something now in git-blame is better than doing nothing while we
wait for a longer, more complete solution to arrive. But did I say "No,
we shouldn't apply this patch from Linus because it's not the optimal
solution?" No. Instead, I said "In the meantime, your patch does not
make this particular problem any worse."

> Because what builtin-blame.c *already* does is exactly that.

I KNOW AND I EVEN SAID THAT. But here it is in case you are hard of
hearing:

  From 20080623195314.GA29569@sigill.intra.peff.net:

    "In the meantime, I don't think your patch makes anything _worse_,
    since we already have these sorts of bugs in the current parsing
    code."

  From 20080623183358.GA28941@sigill.intra.peff.net:

    "It's worse than that...Try (with current git-blame...

     $ git blame -n 1 git.gc
     fatal: bad revision '1'

> This is what I'm complaining about with your totally IDIOTIC mails. You're 
> ignoring reality, and talking about how things "ought to work", and never 
> ever apparently looked at how things *do* work.

Again, how in the world can you say that I didn't look at how things do
work WHEN I CUT AND PASTED A SAMPLE TRANSCRIPT SHOWING HOW THEY DO WORK?

BTW, this is the third time you have mentioned the phrase "ought to
work" in a way that is totally disingenuous about what I actually said.
I can understand that perhaps I was not clear in the initial statement.
But I would have thought the other two times I explained it further
would have made it clear. So did you truly not understand my point, or
are you just being intentionally rude?

> The fact is, the one program I wanted to convert already does exactly what 
> you claim is "impossible to be correct in all cases".

And it's not correct as it is now. And we have lived with it. Which is
why I didn't say "your proposal makes things worse." In fact, I said the
opposite.

> So either shut up, or send a patch to fix what you consider a bug. I'm 
> waiting.

I already volunteered to work on it. I'm sorry that the patch didn't
materialize immediately, but I was working on other parts of git, just
as I mentioned when I said I would work on it.

In the meantime, I think Pierre has proposed an alternate approach that
also has promise, so I think it makes sense to see how he progresses
with that rather than potentially duplicate work.

And I will shut up now, because this is obviously getting nowhere. I
just find your responses so rude and misinformed not about technical
matters, but about my statements and my intent that I feel the need to
publicly defend myself.

-Peff
