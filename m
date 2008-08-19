From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add a 'pre-push' hook
Date: Tue, 19 Aug 2008 15:08:32 -0400
Message-ID: <20080819190832.GC17943@coredump.intra.peff.net>
References: <1219170876-46893-1-git-send-email-schacon@gmail.com> <d411cc4a0808191155g188b0f10je5fd79afb92f36ef@mail.gmail.com> <20080819185804.GA17943@coredump.intra.peff.net> <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 21:10:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVWaw-0004el-Vt
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 21:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756626AbYHSTIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 15:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756504AbYHSTIh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 15:08:37 -0400
Received: from peff.net ([208.65.91.99]:1168 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756518AbYHSTIf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 15:08:35 -0400
Received: (qmail 4327 invoked by uid 111); 19 Aug 2008 19:08:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 19 Aug 2008 15:08:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Aug 2008 15:08:32 -0400
Content-Disposition: inline
In-Reply-To: <d411cc4a0808191200o39837fd0ka2530aed870e06b0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92908>

On Tue, Aug 19, 2008 at 12:00:38PM -0700, Scott Chacon wrote:

> If the patch is acceptable, I will update the githooks doc with more
> information, but we would like this so that you could add a hook that
> runs your automated tests before a push would go through.

I think the common wisdom has been that such tests should be done on the
_receiving_ end, since that makes a more trustworthy enforcement point.
E.g., I know that crap can't get into my central repo because a hook
checks everything coming in. But if a developer has turned off his
pre-push hook (or accidentally failed to enable it), he can still send
crap.

One other argument I have seen is that, to prevent the proliferation of
hooks, the rule is not to add a hook that could just as easily be done
as a sequence of commands. IOW, what's wrong with

  run_my_automated_tests && git push

?

Off the top of my head, I guess the response to those two arguments
would be:

 - sometimes the receiving end isn't set up to run tests, which means it
   is more reasonable to do it on the sending side

 - it's more convenient to just type "git push" than to remember "tests
   && git push", so this reduces the chances of contributors
   accidentally pushing crap

-Peff
