From: Jeff King <peff@peff.net>
Subject: Re: Groups of commits
Date: Tue, 27 Apr 2010 22:14:31 -0400
Message-ID: <20100428021431.GD16107@coredump.intra.peff.net>
References: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: John Tapsell <johnflux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 04:14:43 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6wnR-00005e-0B
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 04:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab0D1COf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 22:14:35 -0400
Received: from peff.net ([208.65.91.99]:37205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751007Ab0D1COe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 22:14:34 -0400
Received: (qmail 5949 invoked by uid 107); 28 Apr 2010 02:14:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 27 Apr 2010 22:14:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Apr 2010 22:14:31 -0400
Content-Disposition: inline
In-Reply-To: <j2u43d8ce651004271859t8f306261n330004142a42b6df@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145966>

On Wed, Apr 28, 2010 at 10:59:44AM +0900, John Tapsell wrote:

>   In my work place, we have a lot of strict rules to get something
> committed.  The code has to pass against a large test suite, it has to
> be tested on different hardware, and so on.
> 
>   The problem is that it forces everyone to have one single large
> commit for a week's work.  All the intermediate stages get squashed
> and that history forever lost.

Redefine "committed" to be "merged to the mainline branch" (or
"committed to the mainline branch" if you need to keep the nomenclature
to please pointy-haired people). Have everybody work on their own branch
each week (or better yet, a branch per topic).

When they would make their single big commit, instead "git merge
--no-ff" from the topic branch into mainline. Do your tests on the
result. If it fails, kick back an error (or whatever you do now). If it
works, then add that merge commit to mainline.

If you want to see the "big commits", follow "log --first-parent" of the
mainline branch. These commits will all pass the test suite. If you want
to see the whole history, then use regular history browsing. Commits on
side-branches do not necessarily pass the test suite.

>   It would be nice to have a commit in the repository, treated as a
> single commit for all purposes, but then be able to split it into
> multiple commits if necessary.

My suggestion above is not exactly what you asked for. It treats the
history as multiple commits most of the time, but using --first-parent
you can ask for just the big commits.

-Peff
