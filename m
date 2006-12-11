X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] CGit v0.1-pre
Date: Mon, 11 Dec 2006 09:33:38 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612110929510.12500@woody.osdl.org>
References: <8c5c35580612101542n72d300c7o106e53e219670510@mail.gmail.com> 
 <Pine.LNX.4.64.0612101653420.12500@woody.osdl.org>
 <8c5c35580612110033y4f6260c9xffeaf4457f4ead21@mail.gmail.com>
 <Pine.LNX.4.64.0612110859200.12500@woody.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Mon, 11 Dec 2006 17:34:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612110859200.12500@woody.osdl.org>
X-MIMEDefang-Filter: osdl$Revision: 1.162 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34020>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gtp2A-0006p4-CR for gcvg-git@gmane.org; Mon, 11 Dec
 2006 18:33:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762990AbWLKRdn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 12:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762992AbWLKRdn
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 12:33:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:47469 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1762990AbWLKRdm
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec 2006 12:33:42 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBBHXeID023348
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Mon, 11
 Dec 2006 09:33:40 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBBHXcJZ000606; Mon, 11 Dec
 2006 09:33:39 -0800
To: Lars Hjemli <hjemli@gmail.com>
Sender: git-owner@vger.kernel.org



On Mon, 11 Dec 2006, Linus Torvalds wrote:
> 
> The point is, if you have races, you will hit them _occasionally_. It may 
> not be a performance problem in real life, BUT:

Side note: another problem with races is that

 - exactly because they are rare, any potential problems they cause are 
   really hard to debug - you may have a hard time reproducing things.

 - some loads may be able to trigger them thanks to very unlucky timing, 
   so even if the problem is "just a theoretical performance issue", 
   sometimes that theoretical performance problem that only happens once 
   in a blue moon ends up happening a _lot_ for a particular user.

I'm probably biased, simply because I've done system programming for so 
long (and race conditions etc are one of the most common source of subtle 
bugs), but I've long since come to the very strong opinion that locking is 
simply too important to not do right.

Even if you can argue that "it doesn't matter" (and you may even be 
right), I personally tend to just consider dodgy locking to be a serious 
bug _whether_ it really matters or not.

Just a hangup of mine.

