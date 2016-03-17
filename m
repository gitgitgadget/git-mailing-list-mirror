From: Jeff King <peff@peff.net>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Thu, 17 Mar 2016 01:40:47 -0400
Message-ID: <20160317054047.GA3457@sigill.intra.peff.net>
References: <20160316204912.GA1890@sigill.intra.peff.net>
 <CAFZEwPMa3GZS6pvFwr8PLVDqKm5xmMd307nbjhpZSC_ndpw8vw@mail.gmail.com>
 <20160316212308.GA4538@sigill.intra.peff.net>
 <CAPig+cRKyaUefz0qj6unkaiPg25=Xi2WorQE4Fm46CCf00UbHQ@mail.gmail.com>
 <20160316214442.GC4441@sigill.intra.peff.net>
 <CAGZ79kbbAv=PukD+sftmoO8u3GX=S1YCYGV8zcNMxrZ+E41-UA@mail.gmail.com>
 <20160316231626.GA11808@sigill.intra.peff.net>
 <CAGZ79kYVT0cq8XgruZ+i_gGuSDySE+s3POU95PXyra9DwVGLkQ@mail.gmail.com>
 <20160317014310.GA12830@sigill.intra.peff.net>
 <CAPig+cSmQpt3u+1PPFD6CP9TF58R6NR=KCgC1dik9U=deaeCkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 06:40:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agQg4-00008R-47
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 06:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbcCQFkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 01:40:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:33105 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751564AbcCQFkv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 01:40:51 -0400
Received: (qmail 16070 invoked by uid 102); 17 Mar 2016 05:40:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 01:40:51 -0400
Received: (qmail 24979 invoked by uid 107); 17 Mar 2016 05:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Mar 2016 01:41:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2016 01:40:47 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cSmQpt3u+1PPFD6CP9TF58R6NR=KCgC1dik9U=deaeCkA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289076>

On Thu, Mar 17, 2016 at 01:32:41AM -0400, Eric Sunshine wrote:

> On Wed, Mar 16, 2016 at 9:43 PM, Jeff King <peff@peff.net> wrote:
> > Arguably cmd_commit() should be using OPT_BOOL instead of OPT__VERBOSE,
> > as there is no such thing as "verbose > 1" here. But I don't think there
> > is any real user-facing consequence of that (however, given Eric's
> > suggestion, I suspect it would make Pranit's problem just go away, as it
> > assigns rather than increments; IOW, it does the thing Eric was
> > suggestion OPT__VERBOSE to do).
> 
> Actually, Pranit's previous version of the patch did treat verbosity
> as a boolean, but then SZEDER pointed out this bit from
> git-commit.txt:
> 
>     --verbose::
>         ...
>         If specified twice, show in addition the unified diff between
>         what would be committed and the worktree files, i.e. the unstaged
>         changes to tracked files.
> 
> which is what led us to the current discussion about wanting an
> "unspecified" value for OPT__VERBOSE.

Ah, thanks. I looked for something like that in builtin/commit.c and
didn't see us using verbose as anything but a boolean. But we pass it
into wt_status, which does look at "s->verbose > 1".

Sorry for the noise (and probably I should stop participating in this
discussion without having read all of the backstory!).

-Peff
