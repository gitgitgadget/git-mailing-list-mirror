From: Jeff King <peff@peff.net>
Subject: Re: Fwd: git status options feature suggestion
Date: Sun, 12 Oct 2008 21:04:15 -0400
Message-ID: <20081013010415.GB3768@coredump.intra.peff.net>
References: <81bfc67a0810082234p55e2fb9jb2a10f837eea7de0@mail.gmail.com> <20081009061136.GA24288@coredump.intra.peff.net> <81bfc67a0810082327p421ca4e9v84f4b33023bc6fe6@mail.gmail.com> <81bfc67a0810082327q71b9d6apf2787eb8519031bb@mail.gmail.com> <alpine.DEB.1.00.0810091101230.22125@pacific.mpi-cbg.de.mpi-cbg.de> <48EE1F58.2060707@drmicha.warpmail.net> <20081012044900.GA27845@coredump.intra.peff.net> <7vwsgegvsh.fsf@gitster.siamese.dyndns.org> <20081012064512.GA32597@coredump.intra.peff.net> <7v1vymgrom.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 03:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpBsI-0001xQ-GN
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 03:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753861AbYJMBES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 21:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbYJMBES
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 21:04:18 -0400
Received: from peff.net ([208.65.91.99]:1338 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbYJMBER (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 21:04:17 -0400
Received: (qmail 4466 invoked by uid 111); 13 Oct 2008 01:04:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 12 Oct 2008 21:04:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Oct 2008 21:04:15 -0400
Content-Disposition: inline
In-Reply-To: <7v1vymgrom.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 12, 2008 at 01:10:01AM -0700, Junio C Hamano wrote:

> One thing to keep in mind is what to do when you would want to detect
> renames.  The parallel walk would be Ok but between HEAD and index there
> could be renames involved, and at that point it would get quite tricky.
> Once the index is in-core, I think it hurts us much to walk HEAD vs index
> and index vs working tree in separate passes.

Assuming you meant "I _don't_ think it hurts us much" then OK, that
makes sense. I was just thinking it would be more elegant than holding
each list in memory and comparing, but really that is not all that
different than what diffcore does with the output queue.

> I think it is perfectly fine to run the diff-index first, and keep the
> result from it in a string_list, and then run "diff-files" and annotate
> the string_list with the output from it.

Thanks, I think that is a sane direction to go in. And I agree that any
solution should be totally split from the actual output format, so we
can reuse it in "git status" if desired.

However, now that Shawn has revealed the existence of his super-secret
status replacement, I am going to wait to see that before moving any
further. :)

-Peff
