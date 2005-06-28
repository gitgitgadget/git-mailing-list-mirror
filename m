From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Tue, 28 Jun 2005 08:49:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506280846100.19755@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506280049090.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 17:41:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DnICh-0006At-JV
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 17:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262156AbVF1Pru (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 28 Jun 2005 11:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVF1Pru
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jun 2005 11:47:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62379 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262156AbVF1Pri (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2005 11:47:38 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5SFlSjA027235
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 28 Jun 2005 08:47:29 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5SFlOVe010062;
	Tue, 28 Jun 2005 08:47:26 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506280049090.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0.667 required=5 tests=MANY_EXCLAMATIONS
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 28 Jun 2005, Daniel Barkalow wrote:
> 
> It shouldn't be hard to add; the main issue is determining when
> transfering a pack file is a good idea, because it probably doesn't make
> sense to transfer a pack file just because the source side has an object
> that the target side wants in that pack.

Oh, you'd never just transfer the whole big pack-file at all: you'd just 
create a new one. And creatign a new one is just a matter of finding the 
common parent, and then doing

	git-rev-list --objects common..HEAD | git-pack-file .git/tmp-pack

and then you send the result to the other side..

		Linus
