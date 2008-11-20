From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 5/9] update-index: add --checkout/--no-checkout to
	update CE_NO_CHECKOUT bit
Date: Thu, 20 Nov 2008 10:32:52 -0500
Message-ID: <20081120153252.GA7374@coredump.intra.peff.net>
References: <1222833849-22129-2-git-send-email-pclouds@gmail.com> <1222833849-22129-3-git-send-email-pclouds@gmail.com> <1222833849-22129-4-git-send-email-pclouds@gmail.com> <1222833849-22129-5-git-send-email-pclouds@gmail.com> <1222833849-22129-6-git-send-email-pclouds@gmail.com> <20081118113316.GA18610@segfault.peff.net> <7vk5b0vp19.fsf@gitster.siamese.dyndns.org> <7v4p24tq59.fsf@gitster.siamese.dyndns.org> <20081119130223.GA27893@segfault.peff.net> <fcaeb9bf0811200726x1f2956c6k6f2ca16543a0fbc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 16:34:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3BXn-00037c-Aj
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 16:34:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754958AbYKTPc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 10:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755084AbYKTPc4
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 10:32:56 -0500
Received: from peff.net ([208.65.91.99]:3598 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754930AbYKTPc4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 10:32:56 -0500
Received: (qmail 18436 invoked by uid 111); 20 Nov 2008 15:32:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 20 Nov 2008 10:32:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Nov 2008 10:32:52 -0500
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0811200726x1f2956c6k6f2ca16543a0fbc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101453>

On Thu, Nov 20, 2008 at 10:26:48PM +0700, Nguyen Thai Ngoc Duy wrote:

> Thanks for catching. The last half also has the same problem. Another

I'm not sure what you mean by "the last half also has the same problem";
with the patch I posted (or Junio's patch) the test works fine for me.

> way is maybe just stay away for those numbers, naming the files by
> alphabet. Just wonder if we could have some ways to automatically
> catch this kind of bug in the future.

Dscho suggested something similar. I would be happy if somebody wrote a
portability lint that found problems in shell constructs and calling
conventions of tools. In practice, though, I think it ends up being
quite hard to catalog all of the quirks of every platform (and
certainly, I would never have thought that this would break -- as it
was, after it _did_ break I had to sit scratching my head wondering how
that piece of code could be wrong).

So I think a simpler approach makes sense: write tests that make sure
the system is doing what you want, and then run those tests periodically
in the environments that you care about checking. When it breaks, you
know there is a problem. :) And that is exactly how this bug was caught.

-Peff
