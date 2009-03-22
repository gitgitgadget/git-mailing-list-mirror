From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFD] builtin-revert.c: release index lock when
	cherry-picking an empty commit
Date: Sun, 22 Mar 2009 05:41:39 -0400
Message-ID: <20090322094139.GA10599@coredump.intra.peff.net>
References: <1236418251-16947-1-git-send-email-chris_johnsen@pobox.com> <20090308144240.GA30794@coredump.intra.peff.net> <7v8wnflrws.fsf@gitster.siamese.dyndns.org> <20090310181730.GD26351@sigill.intra.peff.net> <AA6A171F-70CE-4CB3-9AE1-27CD69C3202C@pobox.com> <20090311003022.GA22273@coredump.intra.peff.net> <e2b179460903110408i4ab3c9cg3c863b89a2f57cba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 10:43:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlKD5-0005xq-Lg
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 10:43:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbZCVJlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 05:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZCVJlp
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 05:41:45 -0400
Received: from peff.net ([208.65.91.99]:41190 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751540AbZCVJlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 05:41:45 -0400
Received: (qmail 10559 invoked by uid 107); 22 Mar 2009 09:41:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 22 Mar 2009 05:41:54 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Mar 2009 05:41:39 -0400
Content-Disposition: inline
In-Reply-To: <e2b179460903110408i4ab3c9cg3c863b89a2f57cba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114133>

[this is a follow-up on the "eval 'false\n\n'" returns 0 issue on
FreeBSD]

On Wed, Mar 11, 2009 at 11:08:06AM +0000, Mike Ralphson wrote:

> 2009/3/11 Jeff King <peff@peff.net>:
> > OK, then nothing to worry about there. I have no idea which shell
> > OpenBSD and NetBSD use these days, and I don't have access to a box.
> > Anybody?
> 
> OpenBSD uses pdksh in Bourne shell mode for non-root shells (ksh mode
> for root) [1].
> 
> NetBSD >=4 uses a Bourne shell but I don't know the exact provenance.
> [2] "A sh command appeared in Version 1 AT&T UNIX.  It was, however,
> unmaintainable so we wrote this one."
> 
> [1] http://www.openbsd.org/faq/faq10.html#ksh
> [2] http://www.netbsd.org/docs/misc/index.html#shells

Thanks for looking this up, Mike. It sounds like FreeBSD is probably the
only problematic one. I confirmed that the problem still exists in
FreeBSD 7.1, and I've mailed the git ports maintainer off-list to
make him aware of the issue. So we'll see what happens.

Junio, do you want to put anything in the release notes warning people
who build from source that this is a potential issue? Do you want
something in the Makefile detecting that the shell is broken?

-Peff
