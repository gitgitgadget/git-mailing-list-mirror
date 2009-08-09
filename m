From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] merge: indicate remote tracking branches in merge
 message
Date: Sun, 9 Aug 2009 03:40:35 -0400
Message-ID: <20090809074035.GA4778@coredump.intra.peff.net>
References: <20090809065936.GA24112@coredump.intra.peff.net>
 <7vab29a1fr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 09 09:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ma31J-0000DT-DD
	for gcvg-git-2@gmane.org; Sun, 09 Aug 2009 09:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbZHIHkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2009 03:40:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbZHIHkh
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Aug 2009 03:40:37 -0400
Received: from peff.net ([208.65.91.99]:41655 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751177AbZHIHkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2009 03:40:37 -0400
Received: (qmail 2471 invoked by uid 107); 9 Aug 2009 07:42:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 09 Aug 2009 03:42:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Aug 2009 03:40:35 -0400
Content-Disposition: inline
In-Reply-To: <7vab29a1fr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125327>

On Sun, Aug 09, 2009 at 12:31:04AM -0700, Junio C Hamano wrote:

> I somewhat suspect that the patch was not applied because it also lacked
> necessary adjustments to tests.  With this patch, I think the tests would
> fail.

Yeah, see my follow-up patch.

> Nevertheless, I think it is a good thing to do.  But I am unsure about the
> implementation.
> 
> Shouldn't it instead feed what it got from the end user to the dwim
> machinery, and make sure it dwims into refs/remotes/ hierarchy?

I'm not sure that is all that different in practice than what is
happening now. Mainly I did it the way I did so that I didn't touch the
code path for detecting local branches.

But assuming they are functionally identical, I think your patch is much
more readable.

> In other words, like this.  Note that it would be much clearer to see
> what's needed, if you want to extend it to refs/tags hierarchy ;-)

I'm not sure adding "tag foo" will actually work, as it still has to
make it through the bit where we parse FETCH_HEAD. I'm not sure if it
would get mutilated to "commit foo" by that code or not.

-Peff
