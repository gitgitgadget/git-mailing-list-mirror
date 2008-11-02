From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] git send-email: avoid leaking directory file
	descriptors.
Date: Sun, 2 Nov 2008 00:31:20 -0400
Message-ID: <20081102043120.GD5261@coredump.intra.peff.net>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225450632-7230-2-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sun Nov 02 05:32:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwUdg-0000FZ-Ih
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 05:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYKBEbX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 00:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbYKBEbX
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 00:31:23 -0400
Received: from peff.net ([208.65.91.99]:1188 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750890AbYKBEbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 00:31:22 -0400
Received: (qmail 22502 invoked by uid 111); 2 Nov 2008 04:31:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Nov 2008 00:31:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Nov 2008 00:31:20 -0400
Content-Disposition: inline
In-Reply-To: <1225450632-7230-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99809>

On Fri, Oct 31, 2008 at 11:57:10AM +0100, Pierre Habouzit wrote:

> +		closedir(DH);

Ugh. This is a great reason to use a scoped variable (like "my $dh),
which will close automatically. Once upon a time I think you _had_ to
use globs for this, but I think it has not been the case for some time
(and I think we only support back to perl 5.6 these days). Can any perl
gurus comment?

-Peff
