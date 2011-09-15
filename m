From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] credential-osxkeychain: load Security framework
 dynamically
Date: Wed, 14 Sep 2011 20:16:05 -0400
Message-ID: <20110915001605.GB6238@sigill.intra.peff.net>
References: <1316023117-84755-1-git-send-email-jaysoffian@gmail.com>
 <1316040926-89429-1-git-send-email-jaysoffian@gmail.com>
 <20110914230816.GA5754@sigill.intra.peff.net>
 <CAG+J_Dxenu7GDsTzUCCQiYg38Vto8CtD8ODX1J9mA8o1n2_YJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 15 02:16:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3zcq-0006hI-TE
	for gcvg-git-2@lo.gmane.org; Thu, 15 Sep 2011 02:16:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751521Ab1IOAQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 20:16:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:50362
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751095Ab1IOAQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 20:16:07 -0400
Received: (qmail 16020 invoked by uid 107); 15 Sep 2011 00:17:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Sep 2011 20:17:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Sep 2011 20:16:05 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_Dxenu7GDsTzUCCQiYg38Vto8CtD8ODX1J9mA8o1n2_YJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181417>

On Wed, Sep 14, 2011 at 07:56:42PM -0400, Jay Soffian wrote:

> Okay, I think I was led astray by the fact that
> credential-{cache,store}.c (at least the latter of which is meant as
> nothing more than an example helper right?) links with git.

No, credential-store is meant to be used. It's just that it has a
security tradeoff that makes it the wrong choice for most cases. So it's
meant to be used sparingly. :)

As for those helpers being linked against git, I guess it doesn't make
them the best example code. But I wanted them to be always available as
a lowest common denominator (because even if you have a fancy local
keychain, it is likely that you'll end up at some point using git across
an ssh connection, and I wanted to provide _something_ there).

Not having any external dependencies, those helpers don't pollute our
code base too much. Building and testing them with the rest of git keeps
the code fresh and unbroken. Maybe it would be better if they provided a
clearer separation as an example. I'm open to that if people think it's
worth splitting them out. I suspect I could write credential-store as
something like 10 lines of perl.

-Peff
