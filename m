From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Thu, 6 Jun 2013 02:37:54 -0400
Message-ID: <20130606063754.GA20050@sigill.intra.peff.net>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org>
 <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net>
 <51B02D81.3000700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 06 08:38:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkTpi-0007Ti-LU
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 08:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754277Ab3FFGh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 02:37:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:57454 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753969Ab3FFGh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 02:37:57 -0400
Received: (qmail 6712 invoked by uid 102); 6 Jun 2013 06:38:44 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Jun 2013 01:38:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Jun 2013 02:37:54 -0400
Content-Disposition: inline
In-Reply-To: <51B02D81.3000700@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226480>

On Thu, Jun 06, 2013 at 08:34:41AM +0200, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> The test case depends on that test-sigchain can commit suicide by a call
> to raise(SIGTERM) in a way that run-command.c::wait_or_whine() can detect
> as death through a signal. There are no POSIX signals on Windows, and a
> sufficiently close emulation is not available in the Microsoft C runtime
> (and probably not even possible).
> 
> The particular deficiency is that when a signal is raise()d whose SIG_DFL
> action will cause process death (SIGTERM in this case), the
> implementation of raise() just calls exit(3).
> 
> We could check for exit code 3 in addition to 143, but that would miss
> the point of the test entirely. Hence, just skip it on Windows.

Thanks. I wasn't quite clear on how the signal handling worked on
Windows, but from your description, I agree there is not any point in
running the test at all.

Acked-by: Jeff King <peff@peff.net>

-Peff
