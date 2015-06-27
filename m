From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision.c: Remove unneeded check for NULL
Date: Sat, 27 Jun 2015 02:07:10 -0400
Message-ID: <20150627060710.GA9353@peff.net>
References: <1435347619-29410-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gitster@pobox.com, git@vger.kernel.org, jrnieder@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 08:07:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8jGu-00015X-MX
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jun 2015 08:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753565AbbF0GHT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Jun 2015 02:07:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:52603 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753295AbbF0GHO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jun 2015 02:07:14 -0400
Received: (qmail 16790 invoked by uid 102); 27 Jun 2015 06:07:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Jun 2015 01:07:13 -0500
Received: (qmail 22847 invoked by uid 107); 27 Jun 2015 06:07:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 27 Jun 2015 02:07:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 27 Jun 2015 02:07:10 -0400
Content-Disposition: inline
In-Reply-To: <1435347619-29410-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272852>

On Fri, Jun 26, 2015 at 12:40:19PM -0700, Stefan Beller wrote:

> The function is called only from one place, which makes sure
> to have `interesting_cache` not NULL. Additionally it is a
> dereferenced a few lines before unconditionally, which would
> result in a segmentation fault.

Yeah, I think this is the right thing to do.

Acked-by: Jeff King <peff@peff.net>

>     > Should there be
>     >
>     >        if (!interesting_cache)
>     >                die("BUG: &interesting_cache == NULL");
>     >
>     > checks at the top of still_interesting and everybody_uninteresting to
>     > futureproof this?
>     
>     I don't think this is necessary as these functions are local functions
>     so when somebody wants to use them they will be aware of the limitations.

Agreed. We do not assert non-NULL for every parameter in our functions,
and I do not think this is any more special than the others.

>     > This code seems to be underdocumented.
>     
>     I am not a expert in this area of the code, so I hoped Peff
>     would document it if he feels like so.

I kind of thought that the explanation in b6e8a3b covered this code.
Does it not, or did people not read it?

The whole of revision.c is not well documented by comments, but I don't
think that is a new thing.

-Peff
