From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [RFC/PATCH] merge: loosen overcautious "working file will be lost" check.
Date: Mon, 9 Oct 2006 17:01:27 -0700 (PDT)
Message-ID: <20061010000127.76332.qmail@web31801.mail.mud.yahoo.com>
References: <7vy7rp9kdz.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 02:01:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX541-0004LS-Kf
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 02:01:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWJJAB2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 20:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964868AbWJJAB2
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 20:01:28 -0400
Received: from web31801.mail.mud.yahoo.com ([68.142.207.64]:29034 "HELO
	web31801.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964827AbWJJAB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 20:01:27 -0400
Received: (qmail 76337 invoked by uid 60001); 10 Oct 2006 00:01:27 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pPqeYourgP97gJO0DuHiLAAUflAsKO+Gds14BxHnrzcp/7M0fpu0OrkdIiUqWyk7X8cE3NqS4JWoDFizuW4/vTRMBjwJaDLMXGCmG6BvLGj68clp5p2KiBvs2xwK78dD6tRff++fCvG3utYzl92M0Z9vf5Codej0/D5Xh/o9Af4=  ;
Received: from [64.215.88.90] by web31801.mail.mud.yahoo.com via HTTP; Mon, 09 Oct 2006 17:01:27 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vy7rp9kdz.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28586>

--- Junio C Hamano <junkio@cox.net> wrote:
> Luben Tuikov <ltuikov@yahoo.com> writes:
> 
> > I think this is a good thing.
> >
> > How about this case I've noticed in my trees:
> >
> > After branching out, a file is deleted, only to add
> > a different file with the same file name.
> >
> > Then any time I pull in from the trunk to merge,
> > merge fails with git-diff-files showing all 0's and the
> > file name in question.  Picture:
> >
> >   Branch B       +-----------------M1---->
> >                 /                 /
> >                C2 <-- git-add A  /
> >               /                 /
> >              C1 <-- git-rm A   /
> >             /                 /
> > Trunk -----+-----------------+---->
> 
> Sorry I do not understand the picture; where is the common
> ancestor?  If it is the left plus sign on the Trunk line, and

Yes, the left plus sign is the common ancestor.

> you are talking about what happens when making the merge M1,
> then before C1 A did not exist (so Trunk tip which is the right

File A exists before C1, it does not exist after C1.  C1 removes
it.

> plus sign on the Trunk line would not either), and the other
> head (tip of branch B you are pulling the trunk into) would have
> one already (from C2), so I would imagine it would be "one side
> adds while the other did not touch" (net effect since branch B

The trunk is free to change/update file A.  In fact this is what
most likely happens.

> forked from trunk is an addition of A, while Trunk did not do
> anything with respect to path A), so I do not see where any
> conflict can come from.  Puzzled.

>From branch B's point of view, we are not interested in
any updates/changes/etc of file A coming from the trunk.
Since we've deleted that file and added our own, albeit
with the same name.

   Luben
P.S. I'm not sure if this is tenable, since it is hard
for GIT to know... or is it?
