From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: zlib experts, please..
Date: Tue, 5 Jul 2005 17:04:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507051701101.3570@g5.osdl.org>
References: <Pine.LNX.4.58.0507051644100.3570@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Wed Jul 06 02:05:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpxPJ-0002e3-Sg
	for gcvg-git@gmane.org; Wed, 06 Jul 2005 02:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVGFAEn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 20:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVGFAEn
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 20:04:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34773 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261983AbVGFAEg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jul 2005 20:04:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6604WjA005359
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Tue, 5 Jul 2005 17:04:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6604TOM000678
	for <git@vger.kernel.org>; Tue, 5 Jul 2005 17:04:31 -0700
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0507051644100.3570@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 5 Jul 2005, Linus Torvalds wrote:
> 
> But what I care about is that when git-unpack-objects sees that it wants a 
> zero-byte object, and asks zlib to unpack it, zlib will not actually use 
> the bytes it wrote - it will just say "oh, you wanted zero bytes, here's 
> zero bytes". Which means that the stream handling gets upset.

Actually, never mind. zlib does exactly the right thing, and eats the 8 
bytes of header that it wrote for "empty". The real culprit was that 
git-unpack-objects incorrectly made that zero a special case on reading, 
but not writing.

So just ignore me. zlib actually does what I expected it to do, even for 
the zero case.

		Linus
