X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] revision: introduce ref@{N..M} syntax.
Date: Sun, 17 Dec 2006 10:14:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612171009550.3479@woody.osdl.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net>
 <3C540990-B78E-405B-ACFF-F558DB776C85@silverinsanity.com>
 <7vbqm36mv6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 17 Dec 2006 18:14:29 +0000 (UTC)
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vbqm36mv6.fsf_-_@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34696>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gw0Wk-0001jd-Uq for gcvg-git@gmane.org; Sun, 17 Dec
 2006 19:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932282AbWLQSOU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 13:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWLQSOU
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 13:14:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48669 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932282AbWLQSOT
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec 2006 13:14:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBHIEDID032085
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Sun, 17
 Dec 2006 10:14:14 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBHIECni015848; Sun, 17 Dec
 2006 10:14:13 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Sat, 16 Dec 2006, Junio C Hamano wrote:
>
> This allows you to add between Nth and Mth (inclusive) reflog entries.
> "git show master@{1} master@{2} master@{3}" is equivalent to
> "git show master@{1..3}".

Well, logically, if you do that, then you should also allow

	git log master@{one.week.ago..yesterday}

as a reflog expression.

"Because It Only Makes Sense(tm)".

		Linus

PS. Yeah, I'm only half serious. I like our revision parsing, and the 
above _would_ actually be consistent with the "master@{1..3}" kind of 
specification, but at the same time, it's also obviously more complex, and 
maybe it's not THAT usable.

But I think the "master@{date..date}" syntax would actually fall out 
automatically if you did the {x..y} parsing at a higher level and didn't 
