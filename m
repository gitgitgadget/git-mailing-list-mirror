From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Mon, 31 Aug 2015 15:05:26 -0400
Message-ID: <20150831190526.GD20555@sigill.intra.peff.net>
References: <1440724495-708-1-git-send-email-sbeller@google.com>
 <1440724495-708-8-git-send-email-sbeller@google.com>
 <xmqqtwrfuw1n.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 21:05:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWUOc-0007FF-N5
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 21:05:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753830AbbHaTFa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 15:05:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:52532 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752327AbbHaTF3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 15:05:29 -0400
Received: (qmail 16035 invoked by uid 102); 31 Aug 2015 19:05:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 14:05:29 -0500
Received: (qmail 25386 invoked by uid 107); 31 Aug 2015 19:05:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 31 Aug 2015 15:05:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2015 15:05:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwrfuw1n.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276916>

On Mon, Aug 31, 2015 at 11:56:04AM -0700, Junio C Hamano wrote:

> Stefan Beller <sbeller@google.com> writes:
> 
> > +static void destroy_output_mutex()
> 
> static void destroy_output_mutex(void)

Yep. Stefan, you may want to beef up the warning flags in your
config.mak. For reference, I use:

  CFLAGS += -Wall -Werror
  CFLAGS += -Wdeclaration-after-statement
  CFLAGS += -Wpointer-arith
  CFLAGS += -Wstrict-prototypes
  CFLAGS += -Wvla
  CFLAGS += -Wold-style-declaration
  CFLAGS += -Wold-style-definition

though note that you will need to relax some of those if compiling older
versions of git. My complete config.mak is at:

  https://github.com/peff/git/blob/meta/config/config.mak

which handles this semi-automatically (it's wildly undocumented, but I'd
be happy to explain any of it if anybody is interested).

-Peff
