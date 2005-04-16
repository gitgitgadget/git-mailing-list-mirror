From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] write_sha1_buffer
Date: Fri, 15 Apr 2005 19:59:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151958000.7211@ppc970.osdl.org>
References: <118833cc05041517502fa52a89@mail.gmail.com>
 <Pine.LNX.4.58.0504151942130.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 04:54:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMdS6-0006OM-Nu
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 04:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVDPC6I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 22:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVDPC6H
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 22:58:07 -0400
Received: from fire.osdl.org ([65.172.181.4]:49580 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262590AbVDPC6F (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 22:58:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3G2w1s4032042
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 19:58:02 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3G2w0WY030587;
	Fri, 15 Apr 2005 19:58:01 -0700
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <Pine.LNX.4.58.0504151942130.7211@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Linus Torvalds wrote:
> 
> (This is also why we should write to a temp-file and then do an atomic
> "rename()").

Btw, before anybody asks: I do _not_ think that we should do fsync() etc. 
We don't actually destroy any old state when we write a new object, so 
even if the machine does go down, we really should just do an fsck and 
then re-try the operation. 

Anal people (or people with machines that crash) can add it later if they 
really want.

		Linus
