From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] spawn pager via run_command interface
Date: Tue, 22 Jul 2008 03:16:30 -0400
Message-ID: <20080722071630.GA3669@sigill.intra.peff.net>
References: <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net> <20080722061807.GA6714@glandium.org> <20080722064603.GA25221@sigill.intra.peff.net> <20080722071009.GA3610@sigill.intra.peff.net> <20080722071246.GA3584@sigill.intra.peff.net> <20080722071411.GB3584@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:17:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLC7m-0004oU-Gw
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751438AbYGVHQc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751277AbYGVHQb
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:16:31 -0400
Received: from peff.net ([208.65.91.99]:2245 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbYGVHQb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:16:31 -0400
Received: (qmail 3280 invoked by uid 111); 22 Jul 2008 07:16:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 03:16:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 03:16:30 -0400
Content-Disposition: inline
In-Reply-To: <20080722071411.GB3584@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89453>

On Tue, Jul 22, 2008 at 03:14:12AM -0400, Jeff King wrote:

>  static struct child_process pager_process = {
>  	.argv = pager_argv,
> -	.in = -1
> +	.in = -1,
> +#ifndef __MINGW32__
> +	.preexec_cb = pager_preexec,
> +#endif

I couldn't recall if this initializer style is portable enough for us.
It was already there wrapped in ifdefs, but perhaps it was only ok
because the mingw version always uses the same compiler?

-Peff
