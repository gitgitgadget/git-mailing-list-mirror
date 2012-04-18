From: Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH v5 2/4] git-cherry-pick: Add keep-redundant-commits option
Date: Wed, 18 Apr 2012 06:41:50 -0400
Message-ID: <20120418104150.GA22172@hmsreliant.think-freely.org>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-1-git-send-email-nhorman@tuxdriver.com>
 <1334342707-3326-3-git-send-email-nhorman@tuxdriver.com>
 <20120415104212.GC6263@ecki>
 <20120416153827.GC13366@hmsreliant.think-freely.org>
 <20120416221018.GB5606@ecki>
 <7v3982pdoj.fsf@alter.siamese.dyndns.org>
 <20120417213723.GA19908@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Phil Hord <phil.hord@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Apr 18 12:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKSL0-0004v5-K6
	for gcvg-git-2@plane.gmane.org; Wed, 18 Apr 2012 12:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199Ab2DRKmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Apr 2012 06:42:09 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:34897 "EHLO
	smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406Ab2DRKmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2012 06:42:07 -0400
Received: from hmsreliant.think-freely.org ([2001:470:8:a08:7aac:c0ff:fec2:933b] helo=localhost)
	by smtp.tuxdriver.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.63)
	(envelope-from <nhorman@tuxdriver.com>)
	id 1SKSKd-0004Sa-7R; Wed, 18 Apr 2012 06:41:57 -0400
Content-Disposition: inline
In-Reply-To: <20120417213723.GA19908@ecki>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195851>

On Tue, Apr 17, 2012 at 11:37:23PM +0200, Clemens Buchacher wrote:
> On Tue, Apr 17, 2012 at 08:42:52AM -0700, Junio C Hamano wrote:
> > Clemens Buchacher <drizzd@aon.at> writes:
> > 
> > > On Mon, Apr 16, 2012 at 11:38:27AM -0400, Neil Horman wrote:
> > > ...
> > > Except that the outcome is not the same. With and without your changes,
> > > git cherry-pick <empty-commit> fails. But with your changes, git
> > > cherry-pick <commit-will-become-empty> will succeed and do nothing,
> > > while before it would have failed exactly like git cherry-pick
> > > <empty-commit>.
> > >
> > > So I am not arguing whether failing or skipping is the better default
> > > behavior. But the legacy behavior is consistent between the empty-commit
> > > and commit-will-become-empty cases.
> > 
> > Is that particular "consistency" a good one, though?  If you had an empty
> > commit in the original range, it is a lot more likely that it was an error
> > that you would want to know about.  You may be the kind of person who
> > value an empty commit in your history, using it as some kind of a mark in
> > the history, and in that case you would want to know that it is being
> > discarded.  On the other hand, if a commit that did something in the
> > original context turns out to be unnecessary in the replayed context, that
> > is not something you would ever want to keep in the replayed context, and
> > erroring out and forcing you to say "yeah, I admit I do not want it" would
> > just be annoying.
> 
> Yeah, that makes sense.
> 
> > So "consistency" between the two would actually be a mistake that we may
> > want to "break", I would think.
> 
> Agreed. But we should document the change in the commit message and
> maybe add a comment, because it is really strange to read
> 
>  if (!empty && index_empty)
>  	return "it's all good"
> 
>  if (empty)
>  	return "oh noes!"
> 
> without an explanation as to why empty and index_empty are so different.
> Neil, what do you think?
> 
Well, I've got the comment in the code indicating what were doing, but sure,
I can be more vebose in the commit message about whats going on.  I can probably
rename the empty variable to indicate its meaning a bit more clearly and make
that code more readable.
Neil
