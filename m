X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sat, 18 Nov 2006 17:45:08 -0800
Message-ID: <7vac2o9pln.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	<7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	<20061118184345.GO7201@pasky.or.cz>
	<e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	<7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	<Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
	<7vfycg9pu5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 01:45:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vfycg9pu5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 18 Nov 2006 17:40:02 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31821>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlbkE-0000o0-Px for gcvg-git@gmane.org; Sun, 19 Nov
 2006 02:45:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755485AbWKSBpL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 20:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755486AbWKSBpL
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 20:45:11 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:59544 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1755485AbWKSBpK
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 20:45:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061119014509.LCAY5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sat, 18
 Nov 2006 20:45:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id oRkh1V0071kojtg0000000; Sat, 18 Nov 2006
 20:44:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> On Sun, 19 Nov 2006, Marco Costalba wrote:
>>> 
>>> Tested also with show-ref only, not useful to me, but just as a comparison.
>>> 
>>> - git tree 1420ms
>>> - linux tree 1021ms
>>> 
>>> Better, but still slower then what I would expected.
>>
>> MUCH slower than expected.

There is something seriously wrong about Marco's number with or
without my patch.  I am getting something like this from
linux-2.6 with fully packed and pruned refs;

$ /usr/bin/time git-show-ref -d >/dev/null
0.08user 0.00system 0:00.08elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+3314minor)pagefaults 0swaps

$ /usr/bin/time ../git.junio/git-show-ref -d >/dev/null
0.05user 0.01system 0:00.06elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+2724minor)pagefaults 0swaps

The second one is with the patch, the first one is from
yesterday's master.
