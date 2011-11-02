From: Jeff King <peff@peff.net>
Subject: Re: Fork freedesktop project to bitbucket, make changes, generate
 patch back to freedesktop?
Date: Wed, 2 Nov 2011 19:37:14 -0400
Message-ID: <20111102233714.GB17466@sigill.intra.peff.net>
References: <CAO+9iGeHSsJz+7=N0BzmGGbkGN1P=CyNvxJWO_1nCNjiZZzetA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alec Taylor <alec.taylor6@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 03 00:37:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLkN1-00012T-Ik
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 00:37:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912Ab1KBXhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Nov 2011 19:37:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60508
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753215Ab1KBXhS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Nov 2011 19:37:18 -0400
Received: (qmail 17580 invoked by uid 107); 2 Nov 2011 23:43:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 02 Nov 2011 19:43:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 02 Nov 2011 19:37:14 -0400
Content-Disposition: inline
In-Reply-To: <CAO+9iGeHSsJz+7=N0BzmGGbkGN1P=CyNvxJWO_1nCNjiZZzetA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184684>

On Sat, Oct 29, 2011 at 02:35:42PM +1100, Alec Taylor wrote:

> I am working with a team extending the functionality of this project.
> 
> After many MANY adds, commits and pushes back and forth on the
> bitbucket project, we then want to send this freedesktop project a
> PATCH with the changes we've made.
> 
> Can you tell me the command I need to do this?

Do you want to send them one patch, or a series of patches?

If one, then you probably want to diff off of some known point (either
their current branch tip, or maybe some recently released version). And
then send them the resulting diff in an email. You can just use "git
diff" for this if you want, and include it in an email, or you can
actually create a new "squashed" commit in git, like this:

  git checkout v1.0 ;# or wherever you think they would want to apply
  git merge --squash your-branch
  git commit

and then use "git format-patch" to create a patch (and optionally
git-send-email to send it).

If you want to share the whole series, you can use format-patch to
create the series, but note that a patch series can only represent a
linear history. If you have a lot of merges from pushing back and forth,
you may want to linearize it first using "git rebase -i".

That's just a high level overview of what you'll need. You can try
reading up on those commands to get a better sense of exactly how you
want to proceed, or if you have more specific questions, ask.

-Peff
