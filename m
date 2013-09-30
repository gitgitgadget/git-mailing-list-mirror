From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty
 format string.
Date: Mon, 30 Sep 2013 17:34:32 -0400
Message-ID: <20130930213432.GA19498@sigill.intra.peff.net>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org>
 <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com>
 <20130929190017.GA2482@elie.Belkin>
 <20130930201429.GA14433@sigill.intra.peff.net>
 <20130930212636.GY9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 23:34:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQl79-0005Ii-OL
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 23:34:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab3I3Vef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 17:34:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:58728 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754855Ab3I3Vee (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 17:34:34 -0400
Received: (qmail 755 invoked by uid 102); 30 Sep 2013 21:34:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 Sep 2013 16:34:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 Sep 2013 17:34:32 -0400
Content-Disposition: inline
In-Reply-To: <20130930212636.GY9464@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235629>

On Mon, Sep 30, 2013 at 02:26:36PM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> >                                            I think we'd be better off to
> > simply mark up the few callsites. Workarounds are here:
> >
> >   http://article.gmane.org/gmane.comp.version-control.git/230026
> 
> Yeah, that looks okay (ugly but tolerable).  It's tempting to do
> something like
> 
> 	-	status_printf_ln(s, GIT_COLOR_NORMAL, "");
> 	+	status_nl(s, GIT_COLOR_NORMAL);
> 
> and
> 
> 	-	status_printf(s, color(WT_STATUS_HEADER, s), "");
> 	+	status_start_line(s, color(WT_STATUS_HEADER, s));
> 
> to make the intent clearer.  Sane?

Yeah, I hinted at adding wrappers like this in the earlier thread but
didn't actually try it.  I think the approach is reasonable, as I doubt
the wrappers should require too much refactoring.

-Peff
