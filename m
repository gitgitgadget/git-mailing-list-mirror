From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] builtin/checkout: DWIM with -f -b
Date: Sun, 20 Jun 2010 16:11:38 -0400
Message-ID: <20100620201137.GA8502@coredump.intra.peff.net>
References: <1277051592-4552-1-git-send-email-rctay89@gmail.com>
 <1277051592-4552-2-git-send-email-rctay89@gmail.com>
 <1277051592-4552-3-git-send-email-rctay89@gmail.com>
 <1277051592-4552-4-git-send-email-rctay89@gmail.com>
 <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 20 22:11:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OQQrv-0001cJ-36
	for gcvg-git-2@lo.gmane.org; Sun, 20 Jun 2010 22:11:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029Ab0FTULn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jun 2010 16:11:43 -0400
Received: from peff.net ([208.65.91.99]:46236 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757019Ab0FTULm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jun 2010 16:11:42 -0400
Received: (qmail 8531 invoked by uid 107); 20 Jun 2010 20:12:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 20 Jun 2010 16:12:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Jun 2010 16:11:38 -0400
Content-Disposition: inline
In-Reply-To: <7vvd9dtt54.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149403>

On Sun, Jun 20, 2010 at 12:12:55PM -0700, Junio C Hamano wrote:

> I think this is not "DWIM" but is "-f does not work with -b; fix it".
> 
> Will queue; thanks.

I am not sure it is fixing a bug. There are really two possible things
to be forced during checkout:

  1. throw away local changes

  2. overwrite an existing branch

Right now, "checkout -f" means just (1). This patch makes it _also_ mean
(2). Do we want to conflate those two cases?

In some sense, it is reasonable for "-f" to mean "force anything that
might be questionable". But I wonder if it pays to be a little more
conservative given that this is a safety valve we are talking about. The
user can of course still split their compound action into:

  git branch [-f] new_branch old_branch
  git checkout [-f] new_branch

Less convenient, but there is no ambiguity.

I dunno. I don't have a strong feeling on how it should be, but I think
it is more than a simple bug fix.

-Peff
