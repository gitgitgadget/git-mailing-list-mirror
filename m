From: Jeff King <peff@peff.net>
Subject: Re: bringing changes from one repo to other
Date: Thu, 30 Jun 2011 16:19:49 -0400
Message-ID: <20110630201949.GA25850@sigill.intra.peff.net>
References: <F750768F-DC8E-435E-813A-C89AE9B9D89A@uab.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Shantanu Pavgi <pavgi@uab.edu>
X-From: git-owner@vger.kernel.org Thu Jun 30 22:19:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcNiO-0003TO-9w
	for gcvg-git-2@lo.gmane.org; Thu, 30 Jun 2011 22:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407Ab1F3UTw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 16:19:52 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55381
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab1F3UTv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 16:19:51 -0400
Received: (qmail 29139 invoked by uid 107); 30 Jun 2011 20:20:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Jun 2011 16:20:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Jun 2011 16:19:49 -0400
Content-Disposition: inline
In-Reply-To: <F750768F-DC8E-435E-813A-C89AE9B9D89A@uab.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176507>

On Thu, Jun 30, 2011 at 12:36:10PM -0500, Shantanu Pavgi wrote:

> I need to bring in changes from one git repository (say repo-A) to
> other(say repo-B) preferably preserving the commit history. The repo-A
> contains few initial bad-commit points - includes files that should
> have been ignored (e.g temporary files generated at runtime) and large
> number of files got committed in one go. Also, the repo-A and repo-B
> don't have any common commit point with common set of files. Is there
> any way to get commits from repo-A to repo-B? I tried git cherry-pick,
> but I am not able to preserve history after resolving conflicts.  Any
> comments or suggestions will be really helpful.

It sounds like you should use "git filter-branch" to edit the history in
repo-A into the shape you want (or even "git rebase -p -i" if the
history is simple and small), and then merge it into repo-B.

Note that this would mean throwing away the old repo-A history (which it
sounds like you want). If you want to include the full history, warts
and all, then simply merge repo-A into repo-B. Git doesn't have a
problem with merging histories with no common commits (though of course
you may get more conflicts, since there is no useful ancestor for a
3-way merge).

-Peff
