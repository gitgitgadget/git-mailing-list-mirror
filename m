X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] Allow '-' in config variable names
Date: Mon, 30 Oct 2006 19:02:27 -0800
Message-ID: <7vfyd5rxvg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0610300823250.25218@g5.osdl.org>
	<7vodrtv2wy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 03:02:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vodrtv2wy.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 30 Oct 2006 14:45:17 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30562>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GejtY-0004a4-GR for gcvg-git@gmane.org; Tue, 31 Oct
 2006 04:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965466AbWJaDC3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 22:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbWJaDC2
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 22:02:28 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61857 "EHLO
 fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP id S1752025AbWJaDC2
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 22:02:28 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao10.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031030227.KHAH18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 22:02:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gr271V00R1kojtg0000000 Mon, 30 Oct 2006
 22:02:08 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> I need this in order to allow aliases of the same form as "ls-tree", 
>> "rev-parse" etc, so that I can use
>>
>> 	[alias]
>> 		my-cat=--paginate cat-file -p
>>
>> to add a "git my-cat" command.
>
> I do not have problem with this (and would perhaps also want to
> add '_' to keychar set), but people who envisioned parsing
> config from scripts (i.e. Perly git) might prefer if we stayed
> within alnum, since I'd suspect then they may be able to reuse
> existing .ini parsers.  I do not much care about that myself,
> but I am bringing it up just in case other people might.
>
> Other than that, this sounds nice.

One thing I forgot to add.  Just like we downcase what user has
written in config file, it might make sense to also remove '-'
(and if we add '_' to keychar set, that one as well) to when
canonicalizing the key value.  That way, somewhat awkward long
configuration variables we currently have can be written more
readably, e.g. repack.use-delta-base-offset

Likes, dislikes?  It is not strictly needed, since we can do
CamelCase as well in the configuration file.

> By the way, everybody seems to do "alias.xxx = -p cat-file -p"
> (I have it as "git less").  Maybe we would want to make a
> built-in alias for that?

Seconds?
