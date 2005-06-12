From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] apply.c: tolerate diff from a dirty but unchanged path
Date: Sun, 12 Jun 2005 10:05:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506121003450.2286@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
 <7vsm091887.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
 <7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net> <7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
 <7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
 <7vpsusqxsy.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0506120900200.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 19:02:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhVo0-0008Uw-I2
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 18:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262649AbVFLREA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 13:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262650AbVFLREA
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 13:04:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51407 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262649AbVFLRD4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Jun 2005 13:03:56 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5CH3pjA030646
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 12 Jun 2005 10:03:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5CH3oJi006237;
	Sun, 12 Jun 2005 10:03:50 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.58.0506120900200.2286@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 12 Jun 2005, Linus Torvalds wrote:
> 
> I'll fix it up,

One-liner fix checked in: we should ignore all git headers that are just a 
single line. A valid git header is _always_ multiple lines: either you 
have the "---/+++" lines of a diff, or you have the old/new lines of a 
mode or name change.

So the

	if (git_hdr_len < 0)

test of the return value of "parse_git_header()" was changed into

	if (git_hdr_len <= len)

and that cleanly solves the problem.

		Linus
