From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] MSVC: fix t0040-parse-options crash
Date: Mon, 31 Mar 2014 17:09:56 -0400
Message-ID: <20140331210956.GB6422@sigill.intra.peff.net>
References: <1396008298-1434-1-git-send-email-marat@slonopotamus.org>
 <1396123762-28673-1-git-send-email-marat@slonopotamus.org>
 <7vtxago359.fsf@alter.siamese.dyndns.org>
 <m2wqfcm6nj.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Mar 31 23:11:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUjTC-0005Mj-RK
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 23:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbaCaVKC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 17:10:02 -0400
Received: from cloud.peff.net ([50.56.180.127]:51249 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750996AbaCaVJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 17:09:58 -0400
Received: (qmail 11420 invoked by uid 102); 31 Mar 2014 21:09:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 31 Mar 2014 16:09:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Mar 2014 17:09:56 -0400
Content-Disposition: inline
In-Reply-To: <m2wqfcm6nj.fsf@linux-m68k.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245532>

On Sun, Mar 30, 2014 at 10:29:04AM +0200, Andreas Schwab wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > As OPT_SET_PTR() is about setting the pointer value to intptr_t defval,
> > a follow-up patch on top of this fix (see attached) may not be a bad
> > thing to have, but that patch alone will not fix this issue without
> > dropping the unneeded and unwanted cast to unsigned long.
> 
> Wouldn't it make sense to change defval into a union to avoid the cast?
> (The intptr_t type may be too narrow for other values to be put there.)

The primary function of these structs is to capture the information
found in brace initializers.  Is it possible in C89 to initialize the
second member of a union (I think in C99, you can use named
initializers).

-Peff
