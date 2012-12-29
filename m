From: Jeff King <peff@peff.net>
Subject: Re: Lockless Refs?
Date: Sat, 29 Dec 2012 03:16:57 -0500
Message-ID: <20121229081657.GE15408@sigill.intra.peff.net>
References: <20121221080449.GA21741@sigill.intra.peff.net>
 <50DAB447.8000101@alum.mit.edu>
 <201212271611.52203.mfick@codeaurora.org>
 <201212280750.14695.mfick@codeaurora.org>
 <7vhan6jdx3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Shawn Pearce <sop@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 09:17:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Torbc-00055o-Qv
	for gcvg-git-2@plane.gmane.org; Sat, 29 Dec 2012 09:17:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274Ab2L2IRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 03:17:02 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38641 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752160Ab2L2IRB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 03:17:01 -0500
Received: (qmail 27769 invoked by uid 107); 29 Dec 2012 08:18:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 29 Dec 2012 03:18:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 29 Dec 2012 03:16:57 -0500
Content-Disposition: inline
In-Reply-To: <7vhan6jdx3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212299>

On Fri, Dec 28, 2012 at 09:15:52AM -0800, Junio C Hamano wrote:

> Martin Fick <mfick@codeaurora.org> writes:
> 
> > Hmm, actually I believe that with a small modification to the 
> > semantics described here it would be possible to make multi 
> > repo/branch commits work....
> >
> > Shawn talked about adding multi repo/branch transaction 
> > semantics to jgit, this might be something that git wants to 
> > support also at some point?
> 
> Shawn may have talked about it and you may have listened to it, but
> others wouldn't have any idea what kind of "multi repo/branch
> transaction" you are talking about.  Is it about "I want to push
> this ref to that repo and push this other ref to that other repo",
> in what situation will it be used/useful, what are the failure
> modes, what are failure tolerances by the expected use cases, ...?
> 
> Care to explain?

I cannot speak for Martin, but I am assuming the point is to atomically
update 2 (or more) refs on the same repo. That is, if I have a branch
"refs/heads/foo" and a ref pointing to meta-information (say, notes
about commits in foo, in "refs/notes/meta/foo"), I would want to "git
push" them, and only update them if _both_ will succeed, and otherwise
fail and update nothing.

I think Shawn mentioned this at the last GitTogether as a stumbling
block for pushing more of Gerrit's meta-information as refs over the git
protocol. But I might be mis-remembering.

-Peff
