X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFD] making separate-remote layout easier to use
Date: Sat, 25 Nov 2006 19:37:05 -0800
Message-ID: <7virh2zxni.fsf@assigned-by-dhcp.cox.net>
References: <7v1wnr19do.fsf@assigned-by-dhcp.cox.net>
	<ekafpm$fs7$1@sea.gmane.org> <7vvel3yuzz.fsf@assigned-by-dhcp.cox.net>
	<200611260034.23974.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 03:37:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <200611260034.23974.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 26 Nov 2006 00:34:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32320>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoApM-0000iP-5u for gcvg-git@gmane.org; Sun, 26 Nov
 2006 04:37:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967255AbWKZDhI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 22:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967262AbWKZDhI
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 22:37:08 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:10957 "EHLO
 fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP id S967255AbWKZDhG
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 22:37:06 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061126033706.IBMR9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 22:37:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id rFca1V00X1kojtg0000000; Sat, 25 Nov 2006
 22:36:35 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> Well, the question is if git-clone would generate appropriate config 
> entries in addition to or instead of $GIT_DIR/remotes/origin file...

What I meant by "irrelevant" is that it is purely syntax.  I
would rather nail down the desired semantics first, and then
worry about the syntax.  We have done remotes/origin file by
default and allowed the same thing specified in configuration
file for people who prefer configuration file, and I do not see
an immediate need to change that.

Only if/when the desired semantics turns out to be too complex
to be expressed in the remotes/ file scheme and at the same time
if configuration file is easier to express the same information,
we should start talking about favoring configuration file over
remotes/ file, and perhaps generating the config entries by
default without generating remotes/.

In either case, I do not think generating _both_ by default is a
bad idea.  They will become out of sync and the user either need
to delete one or the other to avoid confusion.

> By the way, what do you think about extended refspec syntax, namely
> in addition to <remote name>:<local name> it would allow to say
> <remote name>:<local name>:<local branch to merge into>?

I do not think it is reasonable to assume that one remote branch
is to be always merged into one fixed local branch, so that is
too limiting as an extension.  In the configuration file, I
think we already allow the default remote to be fetched from and
remote branches to be merged per branch statically.  A
reasonable thing to do is to see how satisfied users are with
that facility, what they find missing there. Worrying about the
syntax should wait until we know what kind of things need to be
expressed; that can be done both by extending the existing
configuration and/or introducing a new entries in remotes/
files but the point is that is mere implementation detail.


