X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Increase length of function name buffer
Date: Thu, 23 Nov 2006 12:53:43 -0800
Message-ID: <7vbqmxkhpk.fsf@assigned-by-dhcp.cox.net>
References: <200611231005.17859.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 23 Nov 2006 20:54:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32159>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnLZu-0002z7-GA for gcvg-git@gmane.org; Thu, 23 Nov
 2006 21:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933938AbWKWUxr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 15:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757463AbWKWUxr
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 15:53:47 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:54686 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1755256AbWKWUxr
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 15:53:47 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061123205344.UCXT20330.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>; Thu, 23
 Nov 2006 15:53:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qLts1V00J1kojtg0000000; Thu, 23 Nov 2006
 15:53:52 -0500
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> writes:

> In xemit.c:xdl_emit_diff() a buffer for showing the function name as
> commentary is allocated; this buffer was 40 characters.  This is a bit
> small; particularly for C++ function names where there is often an
> identical prefix (like void LongNamespace::LongClassName) on multiple
> functions, which makes the context the same everywhere.  In other words
> the context is useless.  This patch increases that buffer to 80
> characters - which may still not be enough, but is better.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>

I agree this is a good problem to address.

I wonder however which is easier to read, a loooong heading line
as you do in this patch, or "...TailOfVeryLongClassName::method"
that still fits on a single line without terminal line-wrapping.
Especially with our default settings that runs "less" with -S to
truncate the right hand side of a long line, truncating at the
top (instead of at the tail as we currently do) might be easier
to read.

Not rejecting your implementation and asking to change the
patch; asking for opinions from the list.
