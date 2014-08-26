From: Jeff King <peff@peff.net>
Subject: Re: Improving the git remote command
Date: Tue, 26 Aug 2014 13:33:12 -0400
Message-ID: <20140826173312.GB16394@peff.net>
References: <53FC537C.4080206@gmail.com>
 <20140826124027.GE29180@peff.net>
 <CAGK7Mr7BPvV6oO_t4x_1m9sDtWBgPWUqDq+3kZx6rVYAhY+wqA@mail.gmail.com>
 <20140826163741.GA14983@peff.net>
 <xmqq7g1vjh9o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?B?UsOpbXk=?= Hubscher <hubscher.remy@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 19:33:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMKcQ-0007ZL-UA
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 19:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbaHZRdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2014 13:33:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:59388 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751618AbaHZRdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2014 13:33:14 -0400
Received: (qmail 2146 invoked by uid 102); 26 Aug 2014 17:33:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 26 Aug 2014 12:33:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2014 13:33:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g1vjh9o.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255925>

On Tue, Aug 26, 2014 at 10:24:35AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... But we are left with three options:
> >
> >   1. Add "git remote list" with verbose output. This is bad because it
> >      differs gratuitously from "git remote".
> >
> >   2. Add "git remote list" with non-verbose output. This is good because
> >      it means "git remote" is just a shortcut for "git remote list",
> >      which is consistent with other parts of git. But it is potentially
> >      bad if "-v" is a better output format.
> >
> >   3. Add "git remote list" with verbose output, and tweak "git remote"
> >      to match. This is bad because it breaks backwards compatibility.
> >
> > The proposal is for (1). I think we agree that (3) is out. The question
> > is whether (1) or (2) is the least bad.
> 
> I would imagine that those who want list of remotes programatically
> would read from "git config" output and it would be with less
> friction to change the output from "git remote", a command that is
> solely to cater to end-user humans, to suit people's needs, so I am
> not sure if (3) is immediately "out".

Yeah, I touched on that earlier. I would personally consider "git
remote" to be a porcelain, and "git config" to be the appropriate
plumbing for accessing those values. However, it's a little tricky to
robustly get the list of remotes with "git config". So I would not be
surprised if scripts have used "git remote" to do the same thing (I know
for a fact that some internal scripts at GitHub did this, though I
recently cleaned them up so I do not have a vested interest either way
at this point).

That does not mean those scripts are right and we cannot change things,
but it may be a matter of practicality.

> Having said that, my preference is 
> 
>     0. Do nothing, but document the "default to listing" better if
>        needed.
> 
> and then 2. above, and then 1.

Yeah, I'd agree with that.

-Peff
