From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Tue, 24 Jun 2008 13:34:28 -0400
Message-ID: <20080624173428.GA9500@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org> <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org> <20080623195314.GA29569@sigill.intra.peff.net> <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org> <20080624053504.GB19224@sigill.intra.peff.net> <alpine.LFD.1.10.0806240954150.2926@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 24 19:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBCQU-0002vS-42
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 19:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753077AbYFXRed (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 13:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbYFXRed
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 13:34:33 -0400
Received: from peff.net ([208.65.91.99]:4180 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753074AbYFXRec (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 13:34:32 -0400
Received: (qmail 5170 invoked by uid 111); 24 Jun 2008 17:34:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 13:34:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 13:34:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806240954150.2926@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86095>

On Tue, Jun 24, 2008 at 09:59:47AM -0700, Linus Torvalds wrote:

> I have a _single_ problem I have with parse_options(), namely that it was 
> painful to convert in pieces. It may well be that builtin-blame.c was one 
> of the more painful cases, but it really was a _single_ issue.
> 
> I also had a _single_ fix for it.
> 
> I never had "other" problems.
>
> What happened was that you and Dscho and others then tried to pick that 
> _single_ issue apart, because the solutions _you_ wanted (tying all the 

Perhaps I was confused about the definition of "single", because
throughout this thread you seem to be making multiple complaints about
parse_options, including its lack of a "stop on unknown" flag, a
"continue on unknown flag", and the movement of arguments within the
argv array.

But whether you want to call that a "single" problem or not, my point
was that I am not talking about most of those things.

So I will say one last time, as clearly as I possibly can, what I was
trying to bring to the discussion:

  - You proposed a CONTINUE_ON_UNKNOWN type of flag.

  - It is impossible for that mechanism to be correct in all cases, due
    to the syntactic rules for command lines. IOW, you cannot parse an
    element until you know the function of the element to the left.

  - I wanted to mention it specifically, because that exact mechanism
    had already been proposed in a patch last week, and Junio said "this
    conceptually is broken".

  - There has been discussion underway about what is the best mechanism
    to solve the same situation.

That is the entirety of my point. I am glad you are trying to increase
parse_options uptake. There is obviously a problem with multi-stage
parsers. I talked about one way for them to be handled. I think there
are multiple ways of going about it. It looks like STOP_ON_UNKNOWN
is the way that Pierre is pursuing. I think this is good, because it
doesn't suffer from the corner cases that CONTINUE_ON_UNKNOWN does.

And now I will stop making these points, because I don't think I am
capable of saying them any more clearly than I already have, and because
Pierre seems to be moving in a sane direction.

> And then you talk about how things "ought to be" in your world, to make 
> your solution relevant at all.
> 
> And I'm trying to tell you that "ought to be" has no relevance, because 
> you're not even looking at the problem!

Again, did you even read the mail you are responding to? The phrase
"ought to be" was totally incidental to the point I was making. I could
just as easily have said "and this is the method that I think will be
acceptable for dealing with this problem." But for some reason you
insist on harping on the phrase as if I have proposed magical fairies
should come work on the code, and totally ignoring the actual points
that were made.

-Peff
