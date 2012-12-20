From: Jeff King <peff@peff.net>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 10:52:30 -0500
Message-ID: <20121220155229.GA6008@sigill.intra.peff.net>
References: <50CF039A.7010800@gmx.de>
 <20121220150408.GD27211@sigill.intra.peff.net>
 <20121220154915.GA5162@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 20 16:52:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TliQU-0006PU-28
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab2LTPwd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2012 10:52:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59750 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751133Ab2LTPwc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:52:32 -0500
Received: (qmail 10375 invoked by uid 107); 20 Dec 2012 15:53:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 10:53:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 10:52:30 -0500
Content-Disposition: inline
In-Reply-To: <20121220154915.GA5162@pug.qqx.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211901>

On Thu, Dec 20, 2012 at 10:49:15AM -0500, Aaron Schrab wrote:

> At 10:04 -0500 20 Dec 2012, Jeff King <peff@peff.net> wrote:
> >The problem seems to be that people are giving bad advice to tell
> >people to post "git config -l" output without looking at. Maybe we
> >could help them with a "git config --share-config" option that
> >dumps all config, but sanitizes the output. It would need to have a
> >list of sensitive keys (which does not exist yet), and would need
> >to not just mark up things like smtppass, but would also need to
> >pull credential information out of remote.*.url strings. And maybe
> >more (I haven't thought too long on it).
> 
> If such an option is added, it is likely to cause more people to
> think that there is no need to examine the output before sharing it.
> But, I don't think that the sanitizing could ever be sufficient to
> guarantee that.
> 
> Tools outside of the core git tree may add support for new config
> keys which are meant to contain sensitive information, and there
> would be no way for `git config` to know about those.

Good point. I was a little on the fence already because any time you
have a "prevent known bad" list in a security setting, it is guaranteed
to go out of date and screw you. But the presence of third-party tools
means it does not even have to get out of date. It will always be
complete.

> I think that attempting to do this would only result in a false sense
> of security.

Yeah. Thanks for a dose of sanity. I was really trying not to say "the
given advice is bad, and we cannot help those people". But I think you
are right; the only sensible path is for the user to inspect the output
before posting it.

-Peff
