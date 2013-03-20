From: Jeff King <peff@peff.net>
Subject: Re: [PATCH jk/pkt-line-cleanup] t5700-clone-reference: send trace to
 fd 2, not 3, to please Windows git
Date: Wed, 20 Mar 2013 05:33:13 -0400
Message-ID: <20130320093313.GA9482@sigill.intra.peff.net>
References: <5149724C.3060105@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Mar 20 10:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIFP6-0000YJ-B8
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 10:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757957Ab3CTJdY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 05:33:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59873 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752312Ab3CTJdX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 05:33:23 -0400
Received: (qmail 6434 invoked by uid 107); 20 Mar 2013 09:35:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 05:35:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 05:33:13 -0400
Content-Disposition: inline
In-Reply-To: <5149724C.3060105@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218580>

On Wed, Mar 20, 2013 at 09:24:44AM +0100, Johannes Sixt wrote:

> From: Johannes Sixt <j6t@kdbg.org>
> 
> Two tests use GIT_TRACE=3 to dump debugging information of git. On
> Windows, however, bash is unable to set up file descriptor 3 correctly
> for its child process, so that git reports "Bad file descriptor" on
> every trace attempt. The 'git clone' test succeeds nevertheless because
> an empty trace file remains, and there is only a check for the
> absence of a particular line. But the 'git fetch' process ultimately
> hangs (the dynamics that lead to this surprising result have not been
> investigated).
> 
> Since we do not otherwise use stderr in the test cases, divert the
> trace dump to stderr.

I think that is OK, but I'm curious why this is a problem _now_, and not
with the code prior to 97a83fa8. The old GIT_DEBUG_SEND_PACK was also
just calling write() to descriptor 3.

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  This fixes a regression introduced in 

...in 97a83fa8, I assume.

-Peff
