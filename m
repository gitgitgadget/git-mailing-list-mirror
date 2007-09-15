From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] git-svn: remove --first-parent, add --upstream
Date: Sat, 15 Sep 2007 16:37:43 +0200
Message-ID: <20070915143743.GB4957@xp.machine.xx>
References: <20070906075104.GA10192@hand.yhbt.net> <1189096669534-git-send-email-hjemli@gmail.com> <20070906210155.GA20938@soma> <20070906213556.GA21234@soma> <8c5c35580709061514n1de6f141v5e596074cfa9fb42@mail.gmail.com> <20070906235516.GC4538@xp.machine.xx> <8c5c35580709061723m7e01c9d4p1b1936dc1d590459@mail.gmail.com> <20070907084352.GD4538@xp.machine.xx> <8c5c35580709070313l4b815ddbg70be8fb0aef4eefd@mail.gmail.com> <8c5c35580709150708k5acdeabdh17fc7ef30ee3eb79@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 16:38:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWYmq-0007fz-Pg
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 16:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbXIOOiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 10:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbXIOOiQ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 10:38:16 -0400
Received: from matlock.hofmann.stw.uni-erlangen.de ([131.188.24.35]:36960 "HELO
	mail.hofmann.stw.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751266AbXIOOiP (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Sep 2007 10:38:15 -0400
Received: (qmail 27971 invoked by uid 0); 15 Sep 2007 14:38:14 -0000
Received: from ho135.hofmann.stw.uni-erlangen.de (HELO localhost) (p.b@hofmann.stw.uni-erlangen.de@172.17.27.135)
  by mail.hofmann.stw.uni-erlangen.de with SMTP; 15 Sep 2007 14:38:14 -0000
Content-Disposition: inline
In-Reply-To: <8c5c35580709150708k5acdeabdh17fc7ef30ee3eb79@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58251>

On Sat, Sep 15, 2007 at 04:08:31PM +0200, Lars Hjemli wrote:
> On 9/7/07, Lars Hjemli <hjemli@gmail.com> wrote:
> > On 9/7/07, Peter Baumann <waste.manager@gmx.de> wrote:
> > >    lets reset 'trunk' to its state before the merge and
> > >    'branch1' to the merge commit, before fixing the bug in 'branch1'.
> > >
> > >        a-b-c-d-e    trunk
> > >           \      \
> > >            \ -x-y m branch1
> >
> > Yeah, this would certainly not be handled correctly by dcommit using
> > --first-parent (but it could be handled by (a correct implementation
> > of) --upstream).
> 
> Actually, I don't think there's any way to handle this correctly. The
> current git-svn will do the right thing except in cases like the one
> you described, and in these cases it can be _forced_ to do the right
> thing by editing the grafts file, so I'll drop the whole --upstream
> idea.
> 

What do you mean by editing the graft file? Remove (the wrong) parent
from the merge commit by a graft? This will help you commit on the right
branch, but 7b02b85a66fee6b357e02f9e70dd0baa0fd24308 removes the
possibility to get the same graph back, because now git-svn really
honors the graft in its rebase phase.

So you would get something like this back:

       a-b - c - d - e    trunk
          \
           \ -x'-y'- m branch1

Notice that you've lost the merge information :-(

-Peter
