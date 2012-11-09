From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/5] push: return reject reasons via a mask
Date: Fri, 9 Nov 2012 13:35:35 -0500
Message-ID: <20121109183535.GA22164@sigill.intra.peff.net>
References: <1352084908-32333-1-git-send-email-chris@rorvick.com>
 <1352084908-32333-2-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Johannes Sixt <j6t@kdbg.org>,
	Kacper Kornet <draenog@pld-linux.org>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 19:35:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWtQo-0002Hd-Ib
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 19:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754998Ab2KISfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 13:35:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40275 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753154Ab2KISfk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 13:35:40 -0500
Received: (qmail 9354 invoked by uid 107); 9 Nov 2012 18:36:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Nov 2012 13:36:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Nov 2012 13:35:35 -0500
Content-Disposition: inline
In-Reply-To: <1352084908-32333-2-git-send-email-chris@rorvick.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209234>

On Sun, Nov 04, 2012 at 09:08:24PM -0600, Chris Rorvick wrote:

> Pass all rejection reasons back from transport_push().  The logic is
> simpler and more flexible with regard to providing useful feedback.
> [...]
>  
>  void transport_print_push_status(const char *dest, struct ref *refs,
> -		  int verbose, int porcelain, int *nonfastforward);
> +		  int verbose, int porcelain, unsigned int *reject_mask);

You missed updating one call-site of this function in
builtin/send-pack.c (gcc -Wall will now complain of the signed/unsigned
mismatch in the passed-in pointer).

-Peff
