X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] A unique way to express "all" (vs "add vs "update") ?
Date: Fri, 15 Dec 2006 13:55:13 -0800
Message-ID: <7vzm9on7su.fsf@assigned-by-dhcp.cox.net>
References: <elu1cn$k3$1@sea.gmane.org> <4582906A.7020204@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 21:56:23 +0000 (UTC)
Cc: git@vger.kernel.org, t2a2e9z8ncbs9qg@brefemail.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34565>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvL2Q-0006er-H8 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 22:56:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965213AbWLOVze (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 16:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965203AbWLOVze
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 16:55:34 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:48992 "EHLO
 fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S965205AbWLOVzQ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 16:55:16 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao01.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061215215514.CKSK9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>; Fri, 15
 Dec 2006 16:55:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id z9vR1V00C1kojtg0000000; Fri, 15 Dec 2006
 16:55:25 -0500
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> writes:

> Jerome Lovy wrote:
> ...
> But this isn't "commit" at all. It's "git add".
>
>>     (This would allow the typical usage "git commit -u ." which is
>>     barely longer than the current "git commit -a")
>>
>> For interface completeness, "git commit -u|--update <files>" could also
>> exist but would probably be of no use.
>>
>> To sum up, "all" would be consistently expressed with the <dir> syntax.
>> "git commit -a" would not mean "--all" anymore. Lastly, a distinction
>> would be made between "--add" and "--update":
>> - "git commit -add" would have the same semantics as "git add"
>
> This is bollocks. git commit should commit things. We'll be in some
> serious trouble if "git commit -a" stops working the way it has and
> starts just adding things to index.

I agree everything you said in your response to Jerome, except
for one thing.

We might want to allow:

	$ git commit untracked.c tracked.c

to internally 'git add' untracked files while making the commit.

Currently you would get:

	$ git commit untracked.c tracked.c
        error: pathspec 'untracked.c' did not match any file(s) known to git.
        Did you forget to 'git add'?

which is usable, safe, and helpful, so changing it to
automatically including it would not help the end user that
much and one could argue that it removes the safety which is a
bad idea.

So, let's not do this; sorry for the noise.


