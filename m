X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use memmove instead of memcpy for overlapping areas
Date: Mon, 30 Oct 2006 17:37:22 -0800
Message-ID: <7vpsc9s1t9.fsf@assigned-by-dhcp.cox.net>
References: <20061030222615.1e38908b.froese@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 01:38:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061030222615.1e38908b.froese@gmx.de> (Edgar Toernig's message
	of "Mon, 30 Oct 2006 22:26:15 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30559>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeiZE-0001yG-Ac for gcvg-git@gmane.org; Tue, 31 Oct
 2006 02:37:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161568AbWJaBhY (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 20:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161569AbWJaBhX
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 20:37:23 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52432 "EHLO
 fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP id S1161568AbWJaBhX
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 20:37:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao05.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061031013722.NTGN12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>; Mon, 30
 Oct 2006 20:37:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id gpd31V0091kojtg0000000 Mon, 30 Oct 2006
 20:37:03 -0500
To: Edgar Toernig <froese@gmx.de>
Sender: git-owner@vger.kernel.org

Edgar Toernig <froese@gmx.de> writes:

> There may be more - this is just the result of a quick eye-grep
> for memcpy(x, x+i).

Thanks.  Sign-off?

Among many false hit, 

$ git grep 'memcpy.*( *\(.*\),.*\1.*+'

gives this one:

builtin-unpack-objects.c:               memcpy(buffer, buffer + offset, len);
