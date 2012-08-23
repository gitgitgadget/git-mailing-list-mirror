From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 05/17] Do not check the same match_pos twice
Date: Thu, 23 Aug 2012 04:42:15 -0400
Message-ID: <20120823084213.GC6963@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
 <1345709442-16046-6-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Aug 23 10:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Szv-0007tH-Jt
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752846Ab2HWImd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:42:33 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45961 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678Ab2HWIma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 04:42:30 -0400
Received: (qmail 19290 invoked by uid 107); 23 Aug 2012 08:42:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 04:42:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 04:42:15 -0400
Content-Disposition: inline
In-Reply-To: <1345709442-16046-6-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204137>

On Thu, Aug 23, 2012 at 10:10:30AM +0200, mhagger@alum.mit.edu wrote:

> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> Once a match has been found at match_pos, the entry is zeroed and no
> future attempts will match that entry.  So increment match_pos to
> avoid checking against the zeroed-out entry during the next iteration.

Good catch.

A subtle side effect of this zero-ing (not introduced by your patch, but
something I noticed while re-reading the code) is that we implicitly
eliminate duplicate entries from the list of remote refs. There
shouldn't generally be any duplicates, of course, but I think skipping
them is probably sane.

-Peff
