From: Jeff King <peff@peff.net>
Subject: Re: Auto detaching head options (update) (Re: Working copy
	revision and push pain)
Date: Sun, 30 Mar 2008 21:59:37 -0400
Message-ID: <20080331015937.GA32645@coredump.intra.peff.net>
References: <47E66DAA.4080807@jwatt.org> <alpine.LSU.1.00.0803231555380.4353@racer.site> <47E6765D.2020103@jwatt.org> <alpine.LSU.1.00.0803231658460.4353@racer.site> <20080325192552.GC4857@efreet.light.src> <20080325232424.GB5273@coredump.intra.peff.net> <7v3aqde2wn.fsf@gitster.siamese.dyndns.org> <20080329082757.GA4920@efreet.light.src> <20080329084743.GA19200@coredump.intra.peff.net> <7vy77zslor.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Watt <jwatt@jwatt.org>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 04:00:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jg9Jz-0007Wy-52
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 04:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbYCaB7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Mar 2008 21:59:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753056AbYCaB7k
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Mar 2008 21:59:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2627 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbYCaB7j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Mar 2008 21:59:39 -0400
Received: (qmail 10159 invoked by uid 111); 31 Mar 2008 01:59:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 30 Mar 2008 21:59:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Mar 2008 21:59:37 -0400
Content-Disposition: inline
In-Reply-To: <7vy77zslor.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78542>

On Sun, Mar 30, 2008 at 06:53:56PM -0700, Junio C Hamano wrote:

> While I too find the proposal attractive as a concept, I am sorry to say
> that it would not work even with the current set of Porcelain (fwiw, when
> the index-base extension was done, the approach based on HEAD reflog would
> not have worked either).  This is because 605fac8 (update HEAD reflog when
> branch pointed to by HEAD is directly modified, 2007-03-21) made gremlin
> updates to the current branch tip to also update the reflog of HEAD.
> 
> If we revert that commit, we may be able to.

Eww. I didn't know we were doing that. In fact, that was one of the
cases I mentioned as "this would cause the reflog to get out of sync,
but that is a good thing because it would trigger your safety valve."
But obviously I was wrong about how we behave now.

Why is 605fac8 beneficial? What common workflow is updating the HEAD
branch through its actual name? If it is manipulating the index and
worktree at the same time, then it should be using the name HEAD. If it
isn't, then shouldn't the HEAD and index get out of sync (exactly the
thing Jan's proposal is meant to protect against)?

-Peff
