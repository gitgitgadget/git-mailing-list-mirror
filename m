From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: Re* [RFC] submodule+shallow clone feature request
Date: Thu, 11 Feb 2010 16:51:01 +1000
Message-ID: <20100211065101.GA12261@barra.bne.redhat.com>
References: <4B73277C.9010801@columbia.edu>
 <7vsk983fi4.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002102354010.20986@pacific.mpi-cbg.de>
 <7v1vgszo16.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1002110057180.20986@pacific.mpi-cbg.de>
 <7v8wb0l2f5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Schuyler Duveen <sky@columbia.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 07:54:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfSwO-0008Et-B2
	for gcvg-git-2@lo.gmane.org; Thu, 11 Feb 2010 07:54:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909Ab0BKGyN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 01:54:13 -0500
Received: from leo.clearchain.com ([199.73.29.74]:63240 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751716Ab0BKGyM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 01:54:12 -0500
Received: from leo.clearchain.com (localhost [127.0.0.1])
	by mail.clearchain.com (8.14.3/8.14.3) with ESMTP id o1B6rWCM078958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 11 Feb 2010 17:23:32 +1030 (CST)
	(envelope-from peter.hutterer@who-t.net)
Received: (from whot@localhost)
	by leo.clearchain.com (8.14.3/8.14.3/Submit) id o1B6rViH078957;
	Thu, 11 Feb 2010 17:23:31 +1030 (CST)
	(envelope-from peter.hutterer@who-t.net)
X-Authentication-Warning: leo.clearchain.com: whot set sender to peter.hutterer@who-t.net using -f
Content-Disposition: inline
In-Reply-To: <7v8wb0l2f5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-4.0.1 (mail.clearchain.com [127.0.0.1]); Thu, 11 Feb 2010 17:23:32 +1030 (CST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139575>

On Wed, Feb 10, 2010 at 10:19:42PM -0800, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Wed, 10 Feb 2010, Junio C Hamano wrote:
> >
> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >> 
> >> > Yes. Note, though, that the problems of enhancing git-submodule are 
> >> > not technical, as we can learn from the recent history, including the 
> >> > lack of support for rebasing submodules (there _were_ patches!).
> >> 
> >> Sorry I don't recall.  Were they of 'next' quality?  How well were they 
> >> reviewed?
> >
> > Obviously not, otherwise you would have applied them, no?
> >
> > OTOH I found the technical details rather trivial, so maybe they were 
> > 'next' quality, but there was another reason you did not apply them.
> 
> Well, I spent some time digging the mail archive myself.  I think you were
> talking about this thread:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/116918
> 
> If this is not the thread you were talking about, please discard/disregard
> the remainder of this message, and give me a better pointer instead.
> 
> The thread ends with you asking me:
> 
>     Junio, how about it? post 1.6.3 or not?  It is a well contained change, 
>     with little chance of breaking something, but offers a more sensible 
>     workflow here.
> 
> and I said:
> 
>     I am afraid it is a bit too late for "improvements" after -rc1.
>     People survived without the new feature until now, and they can wait a
>     bit longer for the next one....
> 
> Obviously, after that nothing happened.  We have some people who send
> reminders for good topics after the original thread died without producing
> a visible result.  I'd ask you to do the same (when you can---as everybody
> else, you don't work full time on git; neither do I).

[...]

> To restart the discussion so that we can have it (if it is a good change)
> after 1.7.0 ships, here is a pointer to the last revision of the patch.
> 
>     http://article.gmane.org/gmane.comp.version-control.git/117394/raw

Thanks for CCing me, I'm not on the list at the moment.
FWIW, Johannes pinged me about this patch a few weeks after that, but after
revisiting it a few times I found some issues with it. Here's the email I
sent to Johannes on April 24, my apologies that this was a private email
only and did not reach the list.

"Sorry about the delay again, I've been a bit busy lately.
I've thought about it a bit more and tbh. I don't think this patch - even if
rebased - should be merged.

The original idea was that a module can be marked for auto-rebasing in
.gitmodules. The issue with that is that AFAIK git submodule does not store
branch info. So such auto-rebasing would only work provided it would be on
the master branch. Anything else would require a fancier script than my
patch including specifying which branch should be checked out in the
original clone.

Right now, I don't have the time to design such a patch and I'm not even
sure how much it is needed.
With git submodule foreach it's relatively simple to just do the auto-rebase
setting for all modules and I would not be surprised if the majority of
use-cases require auto-rebasing on all modules anyway.

Does that make sense?
"

So in this particular case the patchset was withdrawn by me for technical
reasons (and the lack of time to sort out the details). It should have
communicated better - again, my apologies for that.

Cheers,
  Peter
