From: Nathan Panike <nwp@cs.wisc.edu>
Subject: Re: [PATCH] Specify a precision for the length of a subject string
Date: Wed, 21 Dec 2011 08:51:13 -0600
Message-ID: <20111221145112.GA13097@llunet.cs.wisc.edu>
References: <20111220220754.GC21353@llunet.cs.wisc.edu>
 <20111221043843.GA20714@sigill.intra.peff.net>
Reply-To: nathan.panike@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nathan W. Panike" <nathan.panike@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 21 15:51:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdNW3-0004jm-Et
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 15:51:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911Ab1LUOvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Dec 2011 09:51:18 -0500
Received: from llunet.cs.wisc.edu ([128.105.175.76]:46471 "EHLO
	llunet.cs.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1LUOvR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 09:51:17 -0500
Received: from llunet.cs.wisc.edu (localhost [127.0.0.1])
	by llunet.cs.wisc.edu (8.14.1/8.14.1) with ESMTP id pBLEpDHF013340;
	Wed, 21 Dec 2011 08:51:13 -0600
Received: (from nwp@localhost)
	by llunet.cs.wisc.edu (8.14.1/8.14.1/Submit) id pBLEpDdS013339;
	Wed, 21 Dec 2011 08:51:13 -0600
Content-Disposition: inline
In-Reply-To: <20111221043843.GA20714@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187564>

On Tue, Dec 20, 2011 at 11:38:43PM -0500, Jeff King wrote:
> On Tue, Dec 20, 2011 at 04:07:54PM -0600, Nathan W. Panike wrote:
> 
> > We can specify the precision of a subject string, so that length the subjects
> > viewed by the user do not grow beyond a bound set by the user, in a pretty
> > formatted string
> > 
> > This makes it possible to do, e.g., 
> > 
> > $ git log --pretty='%h %s' d165204 -1
> > d165204 git-p4: fix skipSubmitEdit regression
> > 
> > With this patch, the user can do
> > 
> > $ git log --pretty='%h %30s' d165204 -1
> > d165204 git-p4: fix skipSubmitEdit reg
> 
> Hmm. I think the idea of limiting is OK (though personally, I would just
> pipe through a filter that truncates long lines). But I'm a bit negative
> on adding a tweak like this that only affects the subject. Is there a
> reason I couldn't do %30gs, or %30f, or even some other placeholder?

The ones that make sense to limit are all those that depend on the subject, as the
above; it does not make sense to limit other fields that don't depend on the
subject, as they are fixed width, or have small variance. And it does not make
sense to me to limit the length of the body.

> 
> Also, we already have %w to handle wrapping. Could this be handled in a
> similar way (perhaps it could even be considered a special form of
> wrapping)?

I'll look at the wrapping code and see. Thanks for the idea.
> 
> -Peff
