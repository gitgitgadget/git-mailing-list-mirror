X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH (take 3)] gitweb: Use git-show-ref instead of git-peek-remote
Date: Sat, 25 Nov 2006 02:42:27 -0800
Message-ID: <7v7ixj3izw.fsf@assigned-by-dhcp.cox.net>
References: <7vhcwoa3mx.fsf@assigned-by-dhcp.cox.net>
	<11644507284105-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 10:42:38 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <11644507284105-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Sat, 25 Nov 2006 11:32:08 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32280>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnuzQ-0007rg-4m for gcvg-git@gmane.org; Sat, 25 Nov
 2006 11:42:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757508AbWKYKm3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 05:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757328AbWKYKm3
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 05:42:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:52477 "EHLO
 fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP id S1757508AbWKYKm2
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 05:42:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao11.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125104228.FNSA296.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>; Sat, 25
 Nov 2006 05:42:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id qyib1V01z1kojtg0000000; Sat, 25 Nov 2006
 05:42:36 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> writes:

> While at it make git_get_references return hash in list context,
> and reference to hash (as it used to do) in scalar and void contexts.

Why did you have to add this?  Generally, context sensitive
returns make the program much harder to maintain, because it
forces the call sites to be extremely careful to choose between
"my ($foo) = func()" vs "my $foo = func()", and people who later
call the function inevitably make mistakes.

So unless there is a compelling reason, I'd rather not see more
"wantarray" in the program.
