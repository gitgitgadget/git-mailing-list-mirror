X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Fri, 03 Nov 2006 16:02:43 -0800
Message-ID: <7vr6wk3wpo.fsf@assigned-by-dhcp.cox.net>
References: <200610301953.01875.jnareb@gmail.com>
	<200611031719.13073.jnareb@gmail.com>
	<7virhw5hoi.fsf@assigned-by-dhcp.cox.net>
	<200611032333.49794.jnareb@gmail.com>
	<7vwt6c40bj.fsf@assigned-by-dhcp.cox.net>
	<20061103225041.GQ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 00:03:02 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061103225041.GQ20017@pasky.or.cz> (Petr Baudis's message of
	"Fri, 3 Nov 2006 23:50:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30900>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gg8zv-0000zV-3N for gcvg-git@gmane.org; Sat, 04 Nov
 2006 01:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932506AbWKDACp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 3 Nov 2006
 19:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932507AbWKDACp
 (ORCPT <rfc822;git-outgoing>); Fri, 3 Nov 2006 19:02:45 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31194 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S932506AbWKDACp
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 3 Nov 2006 19:02:45 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061104000244.LCZW2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Fri, 3
 Nov 2006 19:02:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id iQ2N1V00b1kojtg0000000 Fri, 03 Nov 2006
 19:02:23 -0500
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Dear diary, on Fri, Nov 03, 2006 at 11:44:48PM CET, I got a letter
> where Junio C Hamano <junkio@cox.net> said that...
>> Jakub Narebski <jnareb@gmail.com> writes:
>> > Which solution do you think it's best?
>> 
>> Sorry, if it was not clear in my message, I wanted to say that I
>> kinda liked those "control pictures" in U+2400 range.
>
> In principle, right now it should be pretty easy for a project that for
> some reason does not use UTF-8 in commits etc. to adjust gitweb to work
> properly, right? Just change the encoding in HTTP headers and you're
> done, I think.
>
> Is it worth trying to preserve that flexibility?

Absolutely, and I got your point.  Maybe <blink>\011</blink>
would be more portable and appropriate.

Also munging [:cntrl:] would break iso-2022 encoding if it
munges ESC, but the function under discussion was only for paths
and I think no sane platform would use iso-2022 for filenames.

Each repository has commit charset/encoding configuration item
if I am not mistaken, so it is probably a sane thing to do to
convert commit messages from that uniformly to utf-8, I think.

