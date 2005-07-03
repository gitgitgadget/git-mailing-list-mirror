From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: Stacked GIT 0.3 (now more Quilt-like)
Date: Sun, 03 Jul 2005 22:14:29 +0100
Message-ID: <1120425269.6845.28.camel@localhost.localdomain>
References: <1119994003.9631.6.camel@localhost.localdomain>
	 <m3ekagp9mk.fsf@telia.com> <1120385280.6845.12.camel@localhost.localdomain>
	 <m3oe9k6p40.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 03 23:15:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpBnT-00053X-7Z
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 23:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261536AbVGCVOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 17:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261538AbVGCVOe
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 17:14:34 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:51833 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S261536AbVGCVOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jul 2005 17:14:31 -0400
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050703211430.XTYK11649.mta09-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>;
          Sun, 3 Jul 2005 22:14:30 +0100
Received: from cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com ([81.104.193.212])
          by aamta10-winn.ispmail.ntl.com with ESMTP
          id <20050703211430.WPFB23101.aamta10-winn.ispmail.ntl.com@cpc2-cmbg5-3-0-cust212.cmbg.cable.ntl.com>;
          Sun, 3 Jul 2005 22:14:30 +0100
To: Peter Osterlund <petero2@telia.com>
In-Reply-To: <m3oe9k6p40.fsf@telia.com>
X-Mailer: Evolution 2.2.1.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 2005-07-03 at 14:38 +0200, Peter Osterlund wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
> > I know that using -A gives a more detailed output in case of a conflict.
> > The problem is that you will get a conflict even if the changes are
> > identical, making it impossible to detect when a patch was merged
> > upstream.
> 
> OK, I see. How about using wiggle instead?
> 
>         http://cgi.cse.unsw.edu.au/~neilb/source/wiggle/
> 
> That's what patch-utils uses if you run "pushpatch -m". wiggle is also
> a lot smarter than diff3, so there will be fewer cases that result in
> a conflict. Maybe a parameter to "stg push" could enable wiggle mode.

I haven't used wiggle before but I will give it a try (though I prefer
such a tool not to be too smart since it might make mistakes). Anyway, I
will make this configurable, i.e. you could put something like below in
the .stgitrc file:

merger = 'diff3 -m -E %(branch1)s %(ancestor)s %(branch2)s'

or

merger = 'wiggle -m %(branch1)s %(ancestor)s %(branch2)s'

> Is there a way in StGIT to undo a push that results in a large mess of
> conflicts?

Good point. No, there isn't yet. I will think about an undo command. At
the moment, the old top and bottom ids of a patch are saved so that the
patch before the merge can be retrieved but there isn't any command to
make use of them.

--
Catalin
