X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Sat, 18 Nov 2006 10:35:47 -0800
Message-ID: <7vr6w0eh6k.fsf@assigned-by-dhcp.cox.net>
References: <20061118041137.6064.75827.stgit@machine.or.cz>
	<Pine.LNX.4.64.0611180933360.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 18:36:00 +0000 (UTC)
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611180933360.3692@woody.osdl.org> (Linus
	Torvalds's message of "Sat, 18 Nov 2006 09:35:18 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31785>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlV2h-0005ln-J2 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 19:35:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755309AbWKRSfu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 13:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755310AbWKRSfu
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 13:35:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:17574 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1755309AbWKRSft
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 13:35:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118183548.RJDN7494.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 13:35:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oJbL1V00D1kojtg0000000; Sat, 18 Nov 2006
 13:35:20 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 18 Nov 2006, Petr Baudis wrote:
>>
>> Some of the ref manipulation tools (git-for-each-ref and git-show-ref in
>> particular) would not handle hidden (~ /^\./) refs. This may be an
>> acceptable or possibly even desirable behaviour for the ref walkers and
>> repackers, but git-show-ref hiddenrefname must work.
>
> No.
>
> Refnames MUST NOT start with a ".". 
>
> It's not even about the traditional unix "hidden file" thing. It's simply 
> a syntactic issue. A ref cannot start with a ".", because we use things 
> like ".." and "..." to separate them.

We do not forbid a refname that ends with a ".", but I think it
was a mistake.  We _can_ disambiguate the ones that begin with a
"." by saying "whatever..heads/.I-begin-with-dot", but not the
ones that end with "heads/I-end-with-dot...end-of-range".
