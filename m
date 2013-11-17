From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] commit -v: strip diffs and submodule shortlogs from
 the commit message
Date: Sun, 17 Nov 2013 03:53:57 -0500
Message-ID: <20131117085357.GB17016@sigill.intra.peff.net>
References: <528140F5.6090700@web.de>
 <loom.20131111T214646-550@post.gmane.org>
 <52814C35.6040205@web.de>
 <5281DCC5.2000209@kdbg.org>
 <5282A90A.4030900@web.de>
 <xmqqy54tfeje.fsf@gitster.dls.corp.google.com>
 <5283C701.8090400@web.de>
 <xmqq7gccdq67.fsf@gitster.dls.corp.google.com>
 <5287F735.3030306@web.de>
 <CAPig+cTiwA7wg2eeCcfw8d=-+_QoxGiWVq9sABNdUTCka=5fbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>, Ari Pollak <ari@debian.org>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Nov 17 09:54:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vhy7I-0004fW-Fq
	for gcvg-git-2@plane.gmane.org; Sun, 17 Nov 2013 09:54:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795Ab3KQIyB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 03:54:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:40725 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751794Ab3KQIx7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 03:53:59 -0500
Received: (qmail 12652 invoked by uid 102); 17 Nov 2013 08:53:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Nov 2013 02:53:59 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Nov 2013 03:53:57 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cTiwA7wg2eeCcfw8d=-+_QoxGiWVq9sABNdUTCka=5fbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237953>

On Sat, Nov 16, 2013 at 07:22:29PM -0500, Eric Sunshine wrote:

> >         /* Truncate the message just before the diff, if any. */
> >         if (verbose) {
> > -               p = strstr(sb.buf, "\ndiff --git ");
> > -               if (p != NULL)
> > -                       strbuf_setlen(&sb, p - sb.buf + 1);
> > +               p = strstr(sb.buf, wt_status_diff_divider);
> 
> Would it make sense to use the more flexible is_scissors_line() from
> builtin/mailinfo.c here?

I don't think so. We are not trying to be friendly to a remote source
which has given us an arbitrarily-written scissor line. Rather the
opposite: we are trying to be very strict only to break on the line we
have included ourselves.

-Peff
