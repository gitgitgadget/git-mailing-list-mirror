X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Convenient support of remote branches in git-checkout
Date: Mon, 06 Nov 2006 18:27:27 -0800
Message-ID: <7vvels6lf4.fsf@assigned-by-dhcp.cox.net>
References: <200611070026.16425.Josef.Weidendorfer@gmx.de>
	<7vd580azbb.fsf@assigned-by-dhcp.cox.net>
	<200611070225.24956.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 02:27:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611070225.24956.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Tue, 7 Nov 2006 02:25:24 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31041>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhGgW-0003uq-JH for gcvg-git@gmane.org; Tue, 07 Nov
 2006 03:27:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753954AbWKGC13 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 21:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753955AbWKGC13
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 21:27:29 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:25830 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1753954AbWKGC12
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 21:27:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061107022727.JFMB18985.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>; Mon, 6
 Nov 2006 21:27:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id jeTY1V00w1kojtg0000000; Mon, 06 Nov 2006
 21:27:33 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

>> Then "git checkout origin/next" would always mean "I want to
>> switch to the branch I use to hack on the branch 'next' Junio
>> has".  Do it once and you will get exactly my tip, hack on it,
>> switch out of it and then do it again and you won't lose your
>> previous work but just switch to that branch.
>
> Ah, now I understand your thinking.
> I admit it has a compelling elegance.
>
> However.
> Would it not be confusing for newbies (and not only for them) to
> first reference the remote branch with "origin/next", and afterwards, you
> get your own development branch by using the exactly same name?

When we get these per-branch attributes used widely enough, we
might add new vocabulary to our extended sha1 expressions that
denotes "the branch I forked this branch off of".

If refs/heads/next is created from refs/remotes/origin/next,
perhaps with an updated git-branch command that knows how to
help set things up, we might want to be able to refer to
remotes/origin/next as "next's upstream".  While we are on
'next' branch, we might want to refer to "HEAD's upstream".

I am not sure what the syntax for that should be, though.
Perhaps "HEAD@upstream"?

Unlike the regular extended sha1 expression modifiers such as
name~n, name^n, and name^{type}, it does not work with arbitrary
object name; it can only work with a refname.  Which is similar
to the '@{time}' notation we added when we started using
ref-log.  Strictly speaking these should not belong to the sha1
naming layer, but we can have them anyway for the user's
convenience.
