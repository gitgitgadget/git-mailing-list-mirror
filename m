X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cannot install git RPM
Date: Tue, 09 Aug 2005 10:13:32 -0700
Message-ID: <7vr7d3uj7n.fsf@assigned-by-dhcp.cox.net>
References: <20050809104040.B9C61352B36@atlas.denx.de>
	<20050809110705.6B1FF352B36@atlas.denx.de>
	<7v3bpjxoi1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 9 Aug 2005 17:15:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Original-cc: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <7v3bpjxoi1.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 09 Aug 2005 05:51:02 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1E2XfX-0002Ey-Au for gcvg-git@gmane.org; Tue, 09 Aug
 2005 19:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964892AbVHIRNg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 9 Aug 2005
 13:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964889AbVHIRNg
 (ORCPT <rfc822;git-outgoing>); Tue, 9 Aug 2005 13:13:36 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:46753 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S964890AbVHIRNg
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 Aug 2005 13:13:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127]) by
 fed1rmmtao06.cox.net (InterMail vM.6.01.04.00 201-2131-118-20041027) with
 ESMTP id
 <20050809171333.VPUE19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
 Tue, 9 Aug 2005 13:13:33 -0400
To: Wolfgang Denk <wd@denx.de>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

>> But the resulting RPM cannot be installed either,  at  least  not  in
>> standard Fedora Core 2/3/4 installations:
>> ...
>> Is there at least some  documentation  which  external  packages  are
>> needed, and where to find these?

The problematic one is git-send-email-script.  

I have to admit that it was a mistake to take that patch; I was
trying to be _too_ inclusive.  The script does not even read
from nor write into a git repository, and the only relevance to
git is that it is useful for people to patchbomb the list with
git generated patches.  In other words, the program may be
useful, but its usefulness does not have much to do with git, so
it does not belong to git.

My short-term plan is to downgrade it to "contrib" status, and
not touch it from the main Makefile.  It will be in the 0.99.4
sources but will not be installed nor made into binary package.
I hope Ryan does not mind this decision.

After we audit the set of tools we currently ship, along with
some other scripts/programs, either we remove it altogether from
our source tree, or create a contrib/ subdirectory and move it
there.
