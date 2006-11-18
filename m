X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not ignore hidden refs
Date: Fri, 17 Nov 2006 23:27:09 -0800
Message-ID: <7vzmapdxki.fsf@assigned-by-dhcp.cox.net>
References: <20061118041137.6064.75827.stgit@machine.or.cz>
	<7v8xi9fjw9.fsf@assigned-by-dhcp.cox.net>
	<20061118045323.GK7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 07:27:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061118045323.GK7201@pasky.or.cz> (Petr Baudis's message of
	"Sat, 18 Nov 2006 05:53:23 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31761>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlKbc-0001mZ-9E for gcvg-git@gmane.org; Sat, 18 Nov
 2006 08:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756231AbWKRH1L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 02:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756233AbWKRH1L
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 02:27:11 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:16521 "EHLO
 fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP id S1756231AbWKRH1K
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 02:27:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao02.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061118072709.FILU97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>; Sat, 18
 Nov 2006 02:27:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id o7TG1V00M1kojtg0000000; Sat, 18 Nov 2006
 02:27:16 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> I don't *need* but it might be nice to have also private heads, for
> possible setups when you declare heads namespace of two repositories
> matching 1:1 but would like to temporarily make a short-lived head in
> one of them or so.

I agree that different classes of heads and tags (not just
"public" vs "private") may come in handy in different workflows.

I think, however, if we (collectively as all the Porcelain
writers although I am not really one of them) are to support it,
they should not make distinction to the core, and it should be
handled with the agreed-upon convention.  In other words, if
".bar" were a valid refname to the core then I would agree that
not packing them had definitely been a bug.

And we already have one such convention of using refs/remotes
for tracking branches, which is promoted to become the default
(thus an official BCP).

Personally I established a convention to treat heads/??/* as
"private namespace" while using heads/* as public refs for my
own work (I do that for git.git as people know, and I do that
for my day job project as well).  I do not think it is a great
enough convention to be promoted as the official BCP, but it has
been good enough for me, especially commands like "show-branch"
and "tag -l" understands the shell-style filegrobs (e.g
"show-branch master heads/??/*" would show what's yet to be
polished and merged).


