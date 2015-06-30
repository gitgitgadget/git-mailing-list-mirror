From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] introduce "format" date-mode
Date: Tue, 30 Jun 2015 13:50:11 -0400
Message-ID: <20150630175011.GA5349@peff.net>
References: <20150625165341.GA21949@peff.net>
 <20150625165545.GC23503@peff.net>
 <20150629222247.GA31607@flurp.local>
 <20150630102055.GA11928@peff.net>
 <xmqq381988ud.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	"H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 19:50:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9zfo-0004q1-TH
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 19:50:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbbF3RuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 13:50:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:53863 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751591AbbF3RuP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 13:50:15 -0400
Received: (qmail 4220 invoked by uid 102); 30 Jun 2015 17:50:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 12:50:14 -0500
Received: (qmail 17166 invoked by uid 107); 30 Jun 2015 17:50:18 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Jun 2015 13:50:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jun 2015 13:50:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqq381988ud.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273090>

On Tue, Jun 30, 2015 at 09:22:18AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> 	strbuf_addf(&f, "%s ", fmt);
> >
> > Basically I was trying to avoid making any assumptions about exactly how
> > strftime works. But presumably "stick a space in the format" is a
> > universally reasonable thing to do. It's a hack, but it's contained to
> > the function.
> 
> Why can't I shake this feeling that (" %s", fmt), i.e. prepend not
> append, is the safer thing to do than to append?

Because then removing the extra space involves `memmove` of the buffer,
rather than just shortening the length by one.

-Peff
