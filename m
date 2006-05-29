From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 6/10] fsck-objects: avoid unnecessary tree_entry_list
 usage
Date: Mon, 29 May 2006 12:29:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605291226250.5623@g5.osdl.org>
References: <Pine.LNX.4.64.0605291145360.5623@g5.osdl.org>
 <Pine.LNX.4.64.0605291218390.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon May 29 21:30:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FknRI-0002Ya-Pl
	for gcvg-git@gmane.org; Mon, 29 May 2006 21:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbWE2T3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 15:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWE2T3w
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 15:29:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751246AbWE2T3w (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 15:29:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4TJTl2g015581
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 May 2006 12:29:48 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4TJTjAo015840;
	Mon, 29 May 2006 12:29:46 -0700
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0605291218390.5623@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20966>



On Mon, 29 May 2006, Linus Torvalds wrote:
> -		has_zero_pad |= entry->zeropad;
> +		has_zero_pad |= *(char *)desc.buf = '0';

Aieee.

I fixed that once in my tree already, and then broke it again when 
re-doing the series with cherry-picking but didn't notice, because the 
tests don't pick up the totally bogus warnings that it causes.

That "= '0'" should obviously be "== '0'"

		Linus
