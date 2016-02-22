From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Correct conditions to free textconv result data
Date: Mon, 22 Feb 2016 18:25:44 -0500
Message-ID: <20160222232544.GA10362@sigill.intra.peff.net>
References: <1456145545-5374-1-git-send-email-pclouds@gmail.com>
 <1456145545-5374-3-git-send-email-pclouds@gmail.com>
 <20160222180645.GB4587@sigill.intra.peff.net>
 <20160222181224.GA4917@sigill.intra.peff.net>
 <CACsJy8BWgDFq_Dv=omkpDBa_pUF7zKr9cFftNL-KxtMcTkc5-w@mail.gmail.com>
 <xmqqfuwk4a3y.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 00:25:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXzrS-0003u8-Rt
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 00:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbcBVXZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 18:25:47 -0500
Received: from cloud.peff.net ([50.56.180.127]:47194 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756093AbcBVXZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 18:25:47 -0500
Received: (qmail 23656 invoked by uid 102); 22 Feb 2016 23:25:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 18:25:46 -0500
Received: (qmail 23902 invoked by uid 107); 22 Feb 2016 23:25:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 18:25:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 18:25:44 -0500
Content-Disposition: inline
In-Reply-To: <xmqqfuwk4a3y.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287001>

On Mon, Feb 22, 2016 at 03:08:01PM -0800, Junio C Hamano wrote:

> > The only thing common in this series is it's the result of
> > -Wwrite-strings. 1/3 changes some "char *" to "const char *", you
> > don't miss anything.
> 
> While reading Peff's clarification patch, I did find the assignment
> of "" to the *out pointer disturbing.  That part of your patch (I
> presume that is what you mean by the above) may want to be revived.

That part was inherited from diff_populate_filespec, though it casts
explicitly to "char *" since d2543b8 (Clean up diff.c, 2006-06-24).
I guess we could do the same here (not that it makes things any safer,
but at least tells everyone "yes, I _know_ this is weird".

-Peff
