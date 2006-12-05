X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: using xdl_merge(), was Re: Resolving conflicts
Date: Tue, 05 Dec 2006 10:43:38 -0800
Message-ID: <7vwt56gp45.fsf@assigned-by-dhcp.cox.net>
References: <456FD461.4080002@saville.com>
	<Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
	<456FDF24.1070001@saville.com>
	<Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
	<7vejri20mf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
	<4575B32F.5060108@ramsay1.demon.co.uk>
	<Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 5 Dec 2006 18:43:46 +0000 (UTC)
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org> (Linus
	Torvalds's message of "Tue, 5 Dec 2006 10:28:53 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33363>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrfGZ-0006Fz-Ef for gcvg-git@gmane.org; Tue, 05 Dec
 2006 19:43:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S968615AbWLESnk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 13:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968616AbWLESnk
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 13:43:40 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:63846 "EHLO
 fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S968615AbWLESnj (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006
 13:43:39 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao08.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061205184338.QDDK18207.fed1rmmtao08.cox.net@fed1rmimpo02.cox.net>; Tue, 5
 Dec 2006 13:43:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id v6jo1V00P1kojtg0000000; Tue, 05 Dec 2006
 13:43:49 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Tue, 5 Dec 2006, Ramsay Jones wrote:
>>
>> Have you had time to look at my test cases?
>> As I said, I found them very useful when debugging
>> my git-diff3 code, and (hopefully) you will find them
>> to be equally useful.
>
> It might be interesting to also do a simple test:
>
>  - take every single merge in git (or the kernel, if you want even more)
>
>  - ignore all the trivial ones that didn't have any file-level merging at 
>    all (ie done entirely in the index)
>
>  - for all the rest, just compare what the end result is when re-doing the 
>    merge with "xdl_merge" vs "external 3-way merge".
>
> [ Side note: DO NOT COMPARE AGAINST THE ACTUAL RESULT IN GIT OR IN THE 
>   KERNEL ARCHIVE! Those will obviously have been fixed up by humans in the 
>   event of a data conflict, and sometimes even in the _absense_ of a data 
>   conflict (ie "git commit --amend" to fix up something that got mismerged 
>   perfectly automatically or whatever).
>
>   So a script should literally re-do the merge two ways, and compare the 
>   end result ]
>
> Is that any "proof"? Of course not. And it will probably show differences 
> due to any conflict handling, but a lot of the time you'd expect to get 
> exactly the same end result, so the occasional differences are going to be 
> just all the more interesting ("it resolved differently, but it was 
> an equally good resolve" is interesting data on its own).
>
> Anybody want to write a small script to do this?
>
> 		Linus

I was planning to do this today anyway.  Thanks for the
reminder.
