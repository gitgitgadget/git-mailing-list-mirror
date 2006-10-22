From: Jeff King <peff@peff.net>
Subject: Re: Commit-ish shortcut for immediate parent range
Date: Sun, 22 Oct 2006 15:53:15 -0400
Message-ID: <20061022195315.GB10977@coredump.intra.peff.net>
References: <200610221548.42048.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 21:53:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbjNq-0002f7-2A
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 21:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWJVTxT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWJVTxT
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 15:53:19 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:64152 "HELO
	peff.net") by vger.kernel.org with SMTP id S1751179AbWJVTxS (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 15:53:18 -0400
Received: (qmail 17470 invoked from network); 22 Oct 2006 15:53:17 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 22 Oct 2006 15:53:17 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 22 Oct 2006 15:53:15 -0400
To: Andy Parkins <andyparkins@gmail.com>
Content-Disposition: inline
In-Reply-To: <200610221548.42048.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29779>

On Sun, Oct 22, 2006 at 03:48:35PM +0100, Andy Parkins wrote:

> Git's commit-ish is very powerful.  I was wondering however, if there was a 
> shortcut for (for example)?
> 
>  git-diff 3435fdb4c^..3435fdb4c
> 
> That is - the short range of a particular commit's parent to that commit; like
> 
>  git-diff 3435fdb4c!
> 
> Or similar.

I think a more general (but possibly harder to implement and use!) form
would be a commit-ish token for "refer to previous commit-ish." This
would not increase expressiveness, but could save a lot of typing. So if
'!' meant "the last sha1/ref parsed", your example range would be:

  3435fdb4c^..!

but you could also do more exotic things like:
  3435fdb4c~25..!~20

Obviously you could think of more interesting ways to refer to previous
THINGS. But I think in most cases in which you have repeated refs, you
really are just repeating one ref twice as a basis for a range.

The '!' character is probably a bad choice, since it's generally an
interactive shell metacharacter. I'm not sure what would be a better
choice; we're running low on punctuation.

At any rate, I'm not convinced this is a worthwhile optimization. It's
annoying to have to re-specify a long sha1, but in 99% of cases, you
really are looking for sha1^..sha1. As others have pointed out, that's
already handled through git-show.

-Peff
