From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] strbuf: migrate api-strbuf.txt documentation to
 strbuf.h
Date: Fri, 12 Dec 2014 16:40:10 -0500
Message-ID: <20141212214010.GA27530@peff.net>
References: <20141212212726.GA26284@peff.net>
 <20141212212800.GA27451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 12 22:40:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzXwh-0007SP-SR
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 22:40:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbaLLVkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 16:40:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:52338 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaLLVkM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 16:40:12 -0500
Received: (qmail 20465 invoked by uid 102); 12 Dec 2014 21:40:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 15:40:12 -0600
Received: (qmail 14378 invoked by uid 107); 12 Dec 2014 21:40:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Dec 2014 16:40:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Dec 2014 16:40:10 -0500
Content-Disposition: inline
In-Reply-To: <20141212212800.GA27451@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261379>

On Fri, Dec 12, 2014 at 04:28:00PM -0500, Jeff King wrote:

>  1. All comments created in this way are started with "/**"
>     to indicate they are part of the API documentation. This
>     may help later with extracting the text to pretty-print
>     it.

By the way, two thoughts I had while working on this.

One, I wonder if it would look nicer to drop the leading " * " from our
comments, especially for long, free-form text blocks. Like:

/**

Data Structures
---------------

This is actual asciidoc that can be rendered. It's not _nearly_ as
ugly to leave the asciidoc intact if you avoid the leading asterisks.

*/

I also wondered if you could spell it as:

#ifdef API_DOCUMENTATION
... some asciidoc goes here...
#endif

but the preprocessor does still look at the contents. I didn't check the
standard, but I suspect an implementation doesn't _have_ to, but gcc
will warn about things like unmatched single-quotes in the content.

And two, the editor support for writing comments like this is not as
good. For instance, vim's "reformat paragraph" command considers the
whole comment to be the paragraph. If you're writing asciidoc inside
the comment field, this quickly becomes annoying. This is a minor issue
that can be fixed (I am sure there is probably a vim package to do it
better already, and that emacs people will tsk tsk and explain why their
editor is better), but I thought I would note it as a potential "con" of
this approach.

-Peff
