From: Jeff King <peff@peff.net>
Subject: Re: Trouble with cat-file on tags
Date: Fri, 1 Apr 2016 08:26:31 -0400
Message-ID: <20160401122631.GA12019@sigill.intra.peff.net>
References: <ndlesh$dj1$1@ger.gmane.org>
 <ndlf7q$ghe$1@ger.gmane.org>
 <ndlgsc$ed7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 14:26:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alyA5-0006HH-He
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 14:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274AbcDAM0f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 08:26:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:42299 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752410AbcDAM0f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 08:26:35 -0400
Received: (qmail 24071 invoked by uid 102); 1 Apr 2016 12:26:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 08:26:34 -0400
Received: (qmail 23853 invoked by uid 107); 1 Apr 2016 12:26:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 Apr 2016 08:26:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2016 08:26:31 -0400
Content-Disposition: inline
In-Reply-To: <ndlgsc$ed7$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290531>

On Fri, Apr 01, 2016 at 12:00:44PM +0200, Sebastian Schuberth wrote:

> This means
> 
> $ git cat-file tag refs/tags/v0.1.2
> 
> displays the *contents* of the tag, not the tag itself.

Right. `cat-file` is about looking at object content.

> Which leads me to
> the next question: For a given name of an annotated tag, how to get the hash
> of the tag object? The solution I found for now:
> 
> $ git show-ref --tags -- v0.1.2
> 92b67e2b0626519ef8cd4e9cacb2bdafba6d53f0 refs/tags/v0.1.2

Here you just want to resolve the ref, without looking at the object.
The canonical way is:

  git rev-parse --verify v0.1.2

You can also use that to peel the tag to a commit, or a commit to a tree
(e.g., with "v0.1.2^{commit}").

-Peff
