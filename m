X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] index-pack usage of mmap() is unacceptably slower on
 many OSes other than Linux
Date: Tue, 19 Dec 2006 16:40:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0612191640010.6766@woody.osdl.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org>
 <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home>
 <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org>
 <8664c896xv.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181511260.3479@woody.osdl.org>
 <Pine.LNX.4.64.0612181906450.18171@xanadu.home> <20061219051108.GA29405@thunk.org>
 <Pine.LNX.4.64.0612182234260.3479@woody.osdl.org>
 <Pine.LNX.4.63.0612190930460.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v1wmwtfmk.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191027270.18171@xanadu.home>
 <7vk60npv7x.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612191409500.18171@xanadu.home>
 <Pine.LNX.4.64.0612191148270.3483@woody.osdl.org> <4588453A.3060904@garzik.org>
 <7vzm9jo1df.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 00:41:24 +0000 (UTC)
Cc: Jeff Garzik <jeff@garzik.org>, Nicolas Pitre <nico@cam.org>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <7vzm9jo1df.fsf@assigned-by-dhcp.cox.net>
X-MIMEDefang-Filter: osdl$Revision: 1.163 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34874>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwpWM-0003uB-U3 for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932735AbWLTAlU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 19:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWLTAlU
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 19:41:20 -0500
Received: from smtp.osdl.org ([65.172.181.25]:49582 "EHLO smtp.osdl.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932669AbWLTAlT
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 19:41:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kBK0ex2J011313
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 19
 Dec 2006 16:40:59 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kBK0ewB5015294; Tue, 19 Dec
 2006 16:40:58 -0800
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org



On Tue, 19 Dec 2006, Junio C Hamano wrote:

> Jeff Garzik <jeff@garzik.org> writes:
> 
> > If you are going to do this, you have to audit -every- file, to make
> > sure git-compat-util.h is -always- the first header.
> 
> Will do.

Well, since any cases where it isn't (and where we'd care) will  show up 
as just a compiler warning, I doubt we really even need to. We can fix 
things up as they get reported too..

