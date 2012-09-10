From: Yann Dirson <dirson@bertin.fr>
Subject: Re: [BUG?] git rebase not accepting :/ syntax
Date: Mon, 10 Sep 2012 09:12:24 +0200
Organization: Bertin Technologies
Message-ID: <20120910091224.4eca1b6e@chalon.bertin.fr>
References: <20120907150803.0ae2b186@chalon.bertin.fr>
 <m2ipbqx7iu.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git list <git@vger.kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Mon Sep 10 09:12:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAyAf-00045n-6h
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 09:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752711Ab2IJHM0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 03:12:26 -0400
Received: from cabourg.bertin.fr ([195.68.26.10]:44263 "EHLO cabourg.bertin.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941Ab2IJHMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 03:12:25 -0400
Received: from cabourg.bertin.fr (localhost [127.0.0.1])
	by postfix.imss70 (Postfix) with ESMTP id 85466A104D
	for <git@vger.kernel.org>; Mon, 10 Sep 2012 09:12:23 +0200 (CEST)
Received: from yport1.innovation.bertin.fr (yport1.bertin.fr [192.168.1.13])
	by cabourg.bertin.fr (Postfix) with ESMTP id 50517A104A
	for <git@vger.kernel.org>; Mon, 10 Sep 2012 09:12:23 +0200 (CEST)
Received: from chalon.bertin.fr ([172.16.1.1]) by yport1.innovation.bertin.fr
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 with ESMTPPA id <0MA400E68HCMJA70@yport1.innovation.bertin.fr> for
 git@vger.kernel.org; Mon, 10 Sep 2012 09:12:23 +0200 (CEST)
In-reply-to: <m2ipbqx7iu.fsf@igel.home>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; i486-pc-linux-gnu)
X-TM-AS-Product-Ver: IMSS-7.0.0.8220-6.8.0.1017-19174.005
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205111>

On Fri, 07 Sep 2012 15:54:49 +0200
Andreas Schwab <schwab@linux-m68k.org> wrote:

> Yann Dirson <dirson@bertin.fr> writes:
> 
> > In 1.7.10.3, "git rebase -i :/Merge" will complain with:
> >
> > fatal: Needed a single revision
> > invalid upstream :/Merge
> >
> > ... whereas "git rev-parse :/Merge" has no problem resolving
> > to a single revision.
> 
> git rebase actually calls "git rev-parse :/Merge^0", which due to the
> unlimited nature of :/ doesn't work.

Hm.  But then, git rev-parse $(git rev-parse :/Merge}^0 does work, a trivial
patch would appear to make things better.

BTW, git-rebase.sh seems to be quite inconsistent on the use of $() vs. ``,
not to mention the clear preference stated in CodingGuidelines.

I guess I'll find a moment for a couple of patches...

> > OTOH, "git rebase -i HEAD^{/Merge}" does work, and rev-parse resolves
> > it to the same commit.
> 
> OTOH, "git rev-parse HEAD^{/Merge}^0" works as expected.
> 
> Andreas.
> 


-- 
Yann Dirson - Bertin Technologies
