X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: [BUG] daemon.c blows up on OSX
Date: 20 Dec 2006 15:17:10 -0800
Message-ID: <86wt4mximh.fsf@blue.stonehenge.com>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 20 Dec 2006 23:17:26 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
In-Reply-To: <Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
Original-Lines: 40
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34982>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GxAgW-0005CX-3D for gcvg-git@gmane.org; Thu, 21 Dec
 2006 00:17:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030398AbWLTXRN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 20 Dec 2006
 18:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWLTXRM
 (ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 18:17:12 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:32517 "EHLO
 blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1030398AbWLTXRL (ORCPT <rfc822;git@vger.kernel.org>); Wed, 20 Dec 2006
 18:17:11 -0500
Received: from localhost (localhost [127.0.0.1]) by blue.stonehenge.com
 (Postfix) with ESMTP id B5ABF8FA88; Wed, 20 Dec 2006 15:17:10 -0800 (PST)
Received: from blue.stonehenge.com ([127.0.0.1]) by localhost
 (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP id
 17212-01-59; Wed, 20 Dec 2006 15:17:10 -0800 (PST)
Received: by blue.stonehenge.com (Postfix, from userid 1001) id 326B28FA8A;
 Wed, 20 Dec 2006 15:17:10 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

Linus> 	#define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
Linus> 	#define _GNU_SOURCE
Linus> 	#define _BSD_SOURCE

Well, _GNU_SOURCE and _BSD_SOURCE only get defined, and only by some
oddballs that aren't relevant here.

Linus> sequence actually _disables_ those things.

Linus> Some googling finds a python source diff:

Linus> 	   # On Mac OS X 10.4, defining _POSIX_C_SOURCE or _XOPEN_SOURCE
Linus> 	   # disables platform specific features beyond repair.
Linus> 	-  Darwin/8.*)
Linus> 	+  Darwin/8.*|Darwin/7.*)
Linus> 	     define_xopen_source=no
Linus> 	     ;;

Linus> (and Ruby shows up as well in the google)

Linus> Can you try to grovel around in the OS X headers, and see what the magic 
Linus> is to enable all the compatibility crud on OS X?


But yes, _XOPEN_SOURCE_EXTENDED definitely does some damage to
curses.h.  However, I don't see how that's relevant to strings.h
or the others I need.  There's no "config" for "compatibility".
Welcome to Linux vs Unix. :)

What I do know is (a) it worked before the header changes and (b)
the patch I just gave you works.  If the patch doesn't break others,
can we just leave it in?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
