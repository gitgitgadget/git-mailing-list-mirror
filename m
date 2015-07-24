From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] log: add log.firstparent option
Date: Fri, 24 Jul 2015 00:40:28 -0700
Message-ID: <20150724074028.GE2111@peff.net>
References: <20150723012343.GA21000@peff.net>
 <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Josh Bleecher Snyder <josharian@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Jul 24 09:40:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIXav-0000Ev-6G
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 09:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753333AbbGXHke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 03:40:34 -0400
Received: from cloud.peff.net ([50.56.180.127]:34411 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751974AbbGXHkc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 03:40:32 -0400
Received: (qmail 10741 invoked by uid 102); 24 Jul 2015 07:40:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 02:40:32 -0500
Received: (qmail 17942 invoked by uid 107); 24 Jul 2015 07:40:36 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Jul 2015 03:40:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Jul 2015 00:40:28 -0700
Content-Disposition: inline
In-Reply-To: <CAGZ79kbY8hAom+voAOourkDy34nwaACQEM-n=f25Qbg0+ha_8g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274560>

On Thu, Jul 23, 2015 at 03:14:50PM -0700, Stefan Beller wrote:

> Github pull request messages
> are similar to cover letters, so you could send a series with a
> good cover letter, but crappy unfinished patches inside the series.
> After applying all patches it could be all nice, i.e. compiles, tests, adds the
> new functionality. It might be just a commit in between which may not even
> compile. That's my understanding of the messy-workflow.

Yeah, that's certainly one messy workflow. There are many levels of
messy. But I think fundamentally it comes down to: do you show the steps
that went into the result, or do you squash them out into a clean
history?

> Gerrit cannot provide such a workflow easily as it's rather commit
> centric and not branch centered. So you need to approve each
> commit on its own and until 2 weeks ago you even needed to submit
> each commit. (By now Gerrit has learned to submit a full branch, that
> is you submit a commit and all its ancestors will integrate as well if they
> were approved.)
> Previously when the ancestors were not approved the commit would be
> "submitted, merge pending", so it would wait for each commit to be approved
> and submitted.
> And because of this commit-centric workflow, the crappy commit in the series
> is put into spot light.

Yeah, I agree that does not sound quite the same as the GitHub flow.

> >     So I think this could easily be improved by GitHub (we
> >     have the PR subject and body, after all). It's harder
> >     for a mailing list project like git.git, because Git
> >     never actually sees the subject line. I think it would
> >     require teaching git-am the concept of a patch series.
> 
> This would be cool I would imagine.

I talked with some GitHub folks about this. One of the challenges is
that the PR body is in Markdown, but we'd probably want "real" text in
the merge commit. One option would be to simply convert
Markdown->HTML->Text, which should provide a fairly clean version. It
will take some playing with, but I'm going to see what I can do.

> >     I don't know offhand what Gerrit merges look like.
> 
> Let's say it's complicated. Depending on configuration a few things
> may happen. There are different integration strategies
> * merge always
> * merge if necessary (fastforward else)
> * fastforward only
> * rebase if necessary (to make it a linear history)
> * cherrypick (which may add footers like Reviewed-by: to have that
> information in the git history)
> 
> I think the "merge always" strategy would comfort from this patch.

Yeah, I think for anything else it's not a good idea (especially if you
fast-forward onto master).

> >   - we already have merge.ff to default to making extra
> >     merge commits. And if you use GitHub's UI to do the
> >     merge, it uses --no-ff. I don't think we would want
> >     these to become the default, so there's probably nothing
> >     else to be done there.
> >
> > Signed-off-by: Jeff King <peff@peff.net>
> 
> The signoff is better placed above :)

Whoops. Usually I "format-patch -s" and then add any notes while
sending. But the wifi at OSCON was so abysmal that instead I wrote the
notes directly into the commit message to send the whole thing later.
And of course format-patch is not smart enough to know that I meant
everything after the "---" as notes. :)

-Peff
