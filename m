From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 24 Nov 2007 11:09:59 -0800
Message-ID: <7vtznbqx2w.fsf@gitster.siamese.dyndns.org>
References: <7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<7vr6j6ve90.fsf@gitster.siamese.dyndns.org>
	<7vir4d40sw.fsf@gitster.siamese.dyndns.org>
	<7vwsso3poo.fsf@gitster.siamese.dyndns.org>
	<7vfxz89x9q.fsf@gitster.siamese.dyndns.org>
	<7vabpctx3b.fsf@gitster.siamese.dyndns.org>
	<7vsl30eyuk.fsf@gitster.siamese.dyndns.org>
	<7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<20071123103003.GB6754@sigill.intra.peff.net>
	<Pine.LNX.4.64.0711231319220.27959@racer.site>
	<20071124113814.GA17861@sigill.intra.peff.net>
	<alpine.LFD.0.99999.0711241042011.9605@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Nov 24 20:10:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iw0Ob-0000Ik-Ds
	for gcvg-git-2@gmane.org; Sat, 24 Nov 2007 20:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753036AbXKXTKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Nov 2007 14:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbXKXTKL
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Nov 2007 14:10:11 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:47241 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035AbXKXTKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Nov 2007 14:10:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 9C5992F0;
	Sat, 24 Nov 2007 14:10:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id F2A7198648;
	Sat, 24 Nov 2007 14:10:22 -0500 (EST)
In-Reply-To: <alpine.LFD.0.99999.0711241042011.9605@xanadu.home> (Nicolas
	Pitre's message of "Sat, 24 Nov 2007 10:47:56 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65957>

Nicolas Pitre <nico@cam.org> writes:

> Yet the message itself is not totally accurate either, since "need to 
> pull" might have to be "need to force" in some cases.

We used to say only "this is not a fast-forward", and did not
mention "what next".  Later we added "maybe you want to pull
first?" without making it clear enough that the reason why the
suggestion may or may not apply to the user is because it
depended largely on the user's workflow.  It probably was a
mistake and not mentioning "what next" at all might have been
less confusion-prone.  I dunno.

> I think that would be better to append a single line at the end of the 
> display with a clue about what "non fast forward" means.

I'd agree, but having said all the above, I am not entirely
happy not mentioning "what next" at all.

There are two equally valid "what next" after your push is
rejected due to non-fast-forwardness.

 (1) You know what you are doing.

   - You are pushing into a "back-up" repository, not for a
     public consumption.

   - You are pushing a branch that are advertised to rebase and
     rewind into your own publishing repository, and other
     people interacting with the branch know about this.

   - You pushed a wrong head there very recently and are fairly
     confident that nobody has seen that mistake, and pushing
     the correct one to fix the mistake.

     In these cases, forcing the push is the right solution
     (except that the third one is dubious, because it depends
     heavily on the "fairly confident" part).

 (2) You were building on a stale head, and were indeed about to
     lose others' changes with a non-fast-forward push.

     The right solution is to rebuild what you push so that you
     will not lose others' changes.  Rebuilding can take two
     different forms:

   - You may want to git-fetch and rebase your work on top of
     others'.

   - You may want to git-pull, which will merge your work with
     what others did.

But of couse the above is way too long as the help text.

Does the user-manual talk about this?  It has a really good
description of how to notice when a merge is not resolved
automatically and what to do next ("Resolving a merge" section).
Perhaps we can enhance "Pushing changes to a public repository"
section to include "what if the push is refused" information.
