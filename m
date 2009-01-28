From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 0/3] fix "Funny: git -p submodule summary"
Date: Wed, 28 Jan 2009 02:17:22 -0500
Message-ID: <20090128071721.GC19165@coredump.intra.peff.net>
References: <alpine.DEB.1.00.0901081601240.30769@pacific.mpi-cbg.de> <20090127062512.GA10487@coredump.intra.peff.net> <497EDCB0.8080806@kdbg.org> <20090127122315.GA22628@sigill.intra.peff.net> <497F021B.2050306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 28 08:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4hF-0003lw-9f
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:18:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbZA1HRZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbZA1HRY
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:17:24 -0500
Received: from peff.net ([208.65.91.99]:38966 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751292AbZA1HRY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:17:24 -0500
Received: (qmail 19396 invoked by uid 107); 28 Jan 2009 07:17:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 02:17:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 02:17:22 -0500
Content-Disposition: inline
In-Reply-To: <497F021B.2050306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107487>

On Tue, Jan 27, 2009 at 01:46:19PM +0100, Johannes Sixt wrote:

> Exit code and start_command/finish_command's return code handling is a
> complete mess IMHO and deserves a clean-up series of its own. If the few

Yes, the negation is a bit confusing, just for being allowed to say

  if (run_command(foo) < 0)

since you end up having to store and re-negate anyway to get the actual
code. Plus the value of errno is untrustworthy, since we may have been
doing cleanup calls.

> codes at 10000 and above are truncated to 8 bits, then we get exit codes
> 16 and higher; I think that's good enough for this series.

I think it is nice to differentiate between an exit code from the
sub-program and our own error, though. See my updated series for what I
think is a reasonable one-liner fix.

-Peff
