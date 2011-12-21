From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Tue, 20 Dec 2011 23:38:43 -0500
Message-ID: <20111221043843.GA20714@sigill.intra.peff.net>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Nathan W. Panike" <nathan.panike@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 21 05:38:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdDxA-0003YV-Of
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 05:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607Ab1LUEiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Dec 2011 23:38:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46403
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730Ab1LUEiv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Dec 2011 23:38:51 -0500
Received: (qmail 14105 invoked by uid 107); 21 Dec 2011 04:45:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Dec 2011 23:45:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Dec 2011 23:38:43 -0500
Content-Disposition: inline
In-Reply-To: <20111220220754.GC21353@llunet.cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187548>

On Tue, Dec 20, 2011 at 04:07:54PM -0600, Nathan W. Panike wrote:

> We can specify the precision of a subject string, so that length the subjects
> viewed by the user do not grow beyond a bound set by the user, in a pretty
> formatted string
> 
> This makes it possible to do, e.g., 
> 
> $ git log --pretty='%h %s' d165204 -1
> d165204 git-p4: fix skipSubmitEdit regression
> 
> With this patch, the user can do
> 
> $ git log --pretty='%h %30s' d165204 -1
> d165204 git-p4: fix skipSubmitEdit reg

Hmm. I think the idea of limiting is OK (though personally, I would just
pipe through a filter that truncates long lines). But I'm a bit negative
on adding a tweak like this that only affects the subject. Is there a
reason I couldn't do %30gs, or %30f, or even some other placeholder?

Also, we already have %w to handle wrapping. Could this be handled in a
similar way (perhaps it could even be considered a special form of
wrapping)?

-Peff
