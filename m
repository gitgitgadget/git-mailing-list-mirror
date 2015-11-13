From: Jeff King <peff@peff.net>
Subject: Re: Replicating the default "git log" format with a format string.
Date: Fri, 13 Nov 2015 16:52:46 -0500
Message-ID: <20151113215246.GA14318@sigill.intra.peff.net>
References: <loom.20151112T011419-749@post.gmane.org>
 <20151113053800.GE29708@sigill.intra.peff.net>
 <CA+P7+xro=nNfzO6Q6-kGe6C=vJp-z_svd229kRZdf5QjQ+Di8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kannan Goundan <kannan@cakoose.com>, git@vger.kernel.org
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 13 22:53:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZxMH8-0000t6-If
	for gcvg-git-2@plane.gmane.org; Fri, 13 Nov 2015 22:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbbKMVwv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2015 16:52:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:57273 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751106AbbKMVwt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2015 16:52:49 -0500
Received: (qmail 10773 invoked by uid 102); 13 Nov 2015 21:52:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 15:52:49 -0600
Received: (qmail 28849 invoked by uid 107); 13 Nov 2015 21:53:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 Nov 2015 16:53:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Nov 2015 16:52:46 -0500
Content-Disposition: inline
In-Reply-To: <CA+P7+xro=nNfzO6Q6-kGe6C=vJp-z_svd229kRZdf5QjQ+Di8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281265>

On Fri, Nov 13, 2015 at 01:41:23PM -0800, Jacob Keller wrote:

> On Thu, Nov 12, 2015 at 9:38 PM, Jeff King <peff@peff.net> wrote:
> >> Is it possible to exactly replicate the default "git log" format with a
> >> format string?
> >
> > Sadly, no, I don't think it is possible with the current format
> > specifiers. It would be nice if it was, though.
> 
> Isn't this something that might be obtainable using the new ref-filter
> work being done?

It moves in the right direction, but it isn't enough. I don't recall the
specifics, but I think it has conditional placeholders for things like
"if this is non-empty print it". But there are still some problems:

  - the ref-filter formatting isn't unified with the commit
    pretty-printer formatting. So this wouldn't help for a traversal,
    anyway.

  - the decoration thing needs a new placeholder. "%d" means "always
    show the decoration", but the OP really wants "show the decoration
    if the user asked for decorations, and empty otherwise".

-Peff
