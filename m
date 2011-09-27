From: Jeff King <peff@peff.net>
Subject: Re: Do we have a convenient way to refer to a specific commit in an
 already filtered rev-list?
Date: Tue, 27 Sep 2011 17:35:17 -0400
Message-ID: <20110927213517.GB5176@sigill.intra.peff.net>
References: <CAEvN+1jPD53-e8a31g+iz6vMB0-e2LECjouBELkBOXBV5=oGBg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tzu-Jung Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 23:35:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8fJE-00016s-Ky
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 23:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753577Ab1I0VfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 17:35:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45502
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752858Ab1I0VfT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 17:35:19 -0400
Received: (qmail 28649 invoked by uid 107); 27 Sep 2011 21:40:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 27 Sep 2011 17:40:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Sep 2011 17:35:17 -0400
Content-Disposition: inline
In-Reply-To: <CAEvN+1jPD53-e8a31g+iz6vMB0-e2LECjouBELkBOXBV5=oGBg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182266>

On Sun, Sep 25, 2011 at 12:46:20AM +0800, Tzu-Jung Lee wrote:

> Do we have a convenient/symbolic way to refer  to a specific commit of
> an already filtered rev-list? For example, I'm interested in the
> commits with some constraints:
> 
>     git log somepath --author=someone
> 
> Without gui/tui tools, I have to frequently CUT & PASTE the commit-ID
> for further manipulation (show, cherry-pick, ...), and possibly repeat
> the parsing couple of times if I didn't save the output. I wonder if
> we have a convenient way to refer to the discrete commits? like
> HEAD~4, HEAD@{3} or something magic.

Use the shell:

  git rev-list --author=someone HEAD >saved-query
  git log --no-walk --stdin <saved-query
  git cherry-pick `cat saved-query`

or even:

  q=`git rev-list --author=someone HEAD`
  git log --no-walk $q
  git cherry-pick $q

-Peff
