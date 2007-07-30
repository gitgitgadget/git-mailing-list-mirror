From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: [GUILT PATCH 0/4] Add guards to guilt
Date: Mon, 30 Jul 2007 15:20:27 -0400
Message-ID: <20070730192027.GB17253@filer.fsl.cs.sunysb.edu>
References: <118569541814-git-send-email-eclesh@ucla.edu> <20070730035443.GC22017@filer.fsl.cs.sunysb.edu> <873az6cmve.fsf@hubert.paunchy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Eric Lesh <eclesh@ucla.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 21:20:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFanL-0007HW-7b
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 21:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968042AbXG3TUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 15:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967472AbXG3TUl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 15:20:41 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:53695 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968298AbXG3TUk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 15:20:40 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l6UJKRqV018449;
	Mon, 30 Jul 2007 15:20:27 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l6UJKRSO018447;
	Mon, 30 Jul 2007 15:20:27 -0400
X-Authentication-Warning: filer.fsl.cs.sunysb.edu: jsipek set sender to jsipek@fsl.cs.sunysb.edu using -f
Content-Disposition: inline
In-Reply-To: <873az6cmve.fsf@hubert.paunchy.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54251>

On Mon, Jul 30, 2007 at 01:32:53AM -0700, Eric Lesh wrote:
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:
> 
> >
> > I know I've been bad about forcing even myself to write new regression
> > tests. Your patches modify things significantly enough, that I'd like to see
> > some regression tests cases to make sure that user's data is not eaten
> > (e.g., a bug in the guard setting code could blow away the series file =>
> > very bad).
> >
> 
> Yeah, I'll try and make one.  070-guards.sh to test guilt-guard and
> guilt-select plus pushing and popping?

Sounds good.

> There's also sed -i in a few places. For integrity purposes, are a cp
> and sed better?

I like the fact that sed -i makes the code cleaner, BUT I don't want the
users to come after me if they patches disappear. Perhaps having a wrapper
(a function) for sed that's nicely paranoid and handles errors as well as
possible would be in order:

safe_sed [<sed options...>]

> > Is this a problem with other projects' implementations of guards as well?
> > Perhaps printing a warning if a new guard is set when there are applied
> > patches would be in order?
> >
> 
> Yeah, they have this problem too,

Good :)

> but tell you so when you select, so guilt should too.

Agreed.

> Mercurial also has two options which do the popping and reapplying for
> you, which I'll try and implement also.

As in:

t=`guilt-top`
guilt-pop -a
guilt-push "$t"

? Beware that "$t" might not be in the new guarded series.

> Thanks a lot for the review.  Things were pretty ugly, but with your
> help it should look much better.

Nah...just a few nit-picks, that's all :)

Josef 'Jeff' Sipek.

-- 
I think there is a world market for maybe five computers.
		- Thomas Watson, chairman of IBM, 1943.
