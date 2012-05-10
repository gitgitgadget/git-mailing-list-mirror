From: Jeff King <peff@peff.net>
Subject: Re: how to clone/checkout branch/tag vesion from GIT repository
Date: Thu, 10 May 2012 10:39:11 -0400
Message-ID: <20120510143911.GB14711@sigill.intra.peff.net>
References: <1336657187852-7546744.post@n2.nabble.com>
 <20120510135605.GA1495@sigill.intra.peff.net>
 <49A2AA38871E7B41841AA7D659D626A62E2098A2@njexch01.imany.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Suchi Upadhyay <supadhyay@revitasinc.com>
X-From: git-owner@vger.kernel.org Thu May 10 16:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSUWW-0000ft-TS
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 16:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754468Ab2EJOjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 10:39:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38803
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612Ab2EJOjO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 10:39:14 -0400
Received: (qmail 28979 invoked by uid 107); 10 May 2012 14:39:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 May 2012 10:39:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 May 2012 10:39:11 -0400
Content-Disposition: inline
In-Reply-To: <49A2AA38871E7B41841AA7D659D626A62E2098A2@njexch01.imany.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197573>

On Thu, May 10, 2012 at 10:19:12AM -0400, Suchi Upadhyay wrote:

> 2- for branch:
> $ git checkout br6-1-0
> 
> Suchi - As per my understanding with GIT this command will create a
> new branch in my repository..for ex. If I run "git checkout suchi"
> then it will create suchi as a new branch.

Not exactly. It will do one of:

  1. If a local branch named br6-1-0 exists, it will be checked out.

  2. If a tag named br6-1-0 exists, then you will be put in a "detached
     HEAD" state, starting at the tag. See the "detached HEAD" section
     of "git help checkout" for details.

  3. If a remote branch named br6-1-0 exists, a local branch of the same
     name will be created, starting at the same spot.

  4. Otherwise, it is an error.

> Please note that  - branch br6-1-0 created in CVS and then our source
> code migrated to Git. But in migration output I can see the br6-1-0
> picked up for copying ...
> [...]
> Suchi - I want a branch list from remote. I have run your suggested
> command  but it shows only tag list and no branch.

>From the message you are seeing from "git clone -b", and from the output
of "ls-remote", it sounds like br6-1-0 really is a tag in git, not a
branch. Since you have said it is coming from CVS, I suspect this is an
artifact of the CVS->git conversion. And if that is not the desired
outcome, you should look into your conversion process (there are several
tools available; if you used git-cvsimport, it is generally considered
to to be the least accurate, and you might try cvs2git).

-Peff
