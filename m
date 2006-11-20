X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [WISH] Store also tag dereferences in packed-refs
Date: Sun, 19 Nov 2006 18:35:01 -0800
Message-ID: <7vr6vy7smi.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550611180115j135746a1h916e8ae029d1374d@mail.gmail.com>
	<7vmz6oeh2k.fsf@assigned-by-dhcp.cox.net>
	<20061118184345.GO7201@pasky.or.cz>
	<e5bfff550611181047w6712774fkccc697d312b87c7e@mail.gmail.com>
	<7vac2oefuz.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550611181628o41e11652ycd17ddad5dd21225@mail.gmail.com>
	<Pine.LNX.4.64.0611181706250.3692@woody.osdl.org>
	<e5bfff550611190140n3277ee26v95feba26dd3348fa@mail.gmail.com>
	<Pine.LNX.4.64.0611190945500.3692@woody.osdl.org>
	<e5bfff550611191107o63d89d8bp5ff4080803a0d784@mail.gmail.com>
	<e5bfff550611191209s63982818vd3999b543e68e8df@mail.gmail.com>
	<Pine.LNX.4.64.0611191219350.3692@woody.osdl.org>
	<7vbqn38831.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0611191310430.3692@woody.osdl.org>
	<ejqhvi$9kc$1@sea.gmane.org>
	<Pine.LNX.4.64.0611191527270.3692@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 20 Nov 2006 02:35:39 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31878>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glz0Q-00022B-SW for gcvg-git@gmane.org; Mon, 20 Nov
 2006 03:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933880AbWKTCfI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 21:35:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933894AbWKTCfI
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 21:35:08 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28059 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S933880AbWKTCfC
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 21:35:02 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061120023502.DFI4817.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>; Sun, 19
 Nov 2006 21:35:02 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id oqb91V00C1kojtg0000000; Sun, 19 Nov 2006
 21:35:09 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So I'd suggest adding - at the very top of the ref-pack file - a line line
>
> 	# Ref-pack version 2
>
> which will be ignored by the current ref-pack reader (again, because it's 
> not a valid ref line), but we can use it in the future to specify further 
> extensions if we want to.
>
> Now somebody would just need to implement that ;)

For this particular one, there is no need for version 2.

My current wip does:

	SHA-1 SP name LF
	SHA-1 SP SP name^{} LF

the latter of which is ignored by code in the wild and the new
code can take advantage of (and fall back the usual deref_tag
when it is not available).

I need to rebase it on top of a minor update to refs.c before
pushing it out.
