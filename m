From: Jeff King <peff@peff.net>
Subject: Re: [BUG] - git rebase -i performs rebase when it shouldn't?
Date: Sun, 11 Apr 2010 06:15:26 -0400
Message-ID: <20100411101526.GA20484@coredump.intra.peff.net>
References: <z2q76c5b8581004091235ucd9b2a52i223b3191b288c42a@mail.gmail.com>
 <20100410042609.GA24295@coredump.intra.peff.net>
 <7vsk73zzt1.fsf@alter.siamese.dyndns.org>
 <4BC0D87E.70001@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 12:16:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0uD5-0006RQ-2I
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 12:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390Ab0DKKPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 06:15:53 -0400
Received: from peff.net ([208.65.91.99]:56346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770Ab0DKKPw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 06:15:52 -0400
Received: (qmail 1741 invoked by uid 107); 11 Apr 2010 10:15:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 11 Apr 2010 06:15:52 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Apr 2010 06:15:26 -0400
Content-Disposition: inline
In-Reply-To: <4BC0D87E.70001@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144634>

On Sat, Apr 10, 2010 at 09:58:54PM +0200, Johannes Sixt wrote:

> >	git checkout foo&&  git rebase master
> >	git checkout bar&&  git rebase master
> >	git checkout baz&&  git rebase master
> 
> I'm actually very glad that the current interface is the way it is -
> because it can do the rebase *without* the checkout. This way you can
> save a lot of recompilation due to changed timestamps if the topic is
> based on an old version.
> 
> Only that some (all?) variants of rebase still unnecessarily do the
> checkout...

Good point. Originally, we did the rebase directly on the branch, though
I'm not sure if we did "checkout $branch && reset $onto" or "branch -f
$branch $onto && checkout $branch". These days we operate on a detached
HEAD, and we seem to "checkout $onto^0", which should do the
optimization you mention.

-Peff
