From: Jeff King <peff@peff.net>
Subject: Re: merge --no-commit not able to report stats more verbosely?
Date: Sun, 28 Oct 2012 07:21:50 -0400
Message-ID: <20121028112150.GD11434@sigill.intra.peff.net>
References: <k63iai$kbp$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Scott R. Godin" <scottg.wp-hackers@mhg2.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 12:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSQwP-0006rQ-6c
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 12:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab2J1LVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 07:21:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:41274 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750932Ab2J1LVw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 07:21:52 -0400
Received: (qmail 8003 invoked by uid 107); 28 Oct 2012 11:22:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 28 Oct 2012 07:22:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Oct 2012 07:21:50 -0400
Content-Disposition: inline
In-Reply-To: <k63iai$kbp$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208539>

On Mon, Oct 22, 2012 at 09:39:31AM -0400, Scott R. Godin wrote:

> As you can see from the below, I can't seem to get it to give me more
> verbose results of what's being merged (as in the actual merge below)
> with --stat or -v .. is it supposed to do that?

Yes. The diffstat is shown for the completed merge, but here:

> (develop)>$ git merge --no-commit --stat -v widget_twitter
> Automatic merge went well; stopped before committing as requested

You do not complete the merge.

> (develop|MERGING)>$ git merge --abort
> 
> (develop)>$ git merge widget_twitter
> Merge made by the 'recursive' strategy.
>  .../code/community/Dnd/Magentweet/Model/User.php   |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

Whereas here you do, and you get a diffstat.

When you are in the middle of an uncompleted merge and want to know what
is happening, you should look at the index using "git status" (to get an
overview of what is ready to be committed and what is unmerged), "git
diff --cached" (to see what was automatically merged and is ready for
commit), and "git diff" (to see conflicted entries that still need to be
resolved).

-Peff
