From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] use gcrypt instead of libssl for hash
Date: Sun, 17 Apr 2005 10:52:07 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171039460.7211@ppc970.osdl.org>
References: <87hdi5oet6.dancerj@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 19:46:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNDr0-0000ci-67
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 19:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVDQRu1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 13:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261381AbVDQRu1
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 13:50:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:36826 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261380AbVDQRuN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 13:50:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HHoAs4006411
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 10:50:10 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HHo8wd028056;
	Sun, 17 Apr 2005 10:50:09 -0700
To: Junichi Uekawa <dancer@netfort.gr.jp>
In-Reply-To: <87hdi5oet6.dancerj@netfort.gr.jp>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Junichi Uekawa wrote:
> 
> This is the first  time for me to send you a patch; be gentle.
> the following patch allows for use of gcrypt.

Well, libgcrypt seems to be pretty rare out there - I certainly don't have 
it installed on my machine.

> libssl seems to have a restrictive licensing wrt GPL applications.

It does? I really don't read it that way. 

The openssl license is BSD+mention, but it only kicks in if you 
_redistribute_ it (and you're not allowed to market things as being 
openssl based without giving them credit, but that's another thing).

So yes, the openssl license is incompatible with the GPL in the sense that 
you cannot actually _mix_ the openssl source-code with the GPL 
source-code. But that's true of a lot of libraries, the normal system C 
library being just one common example.

The GPL makes explicit mention of the system libraries (which openssl
definitely is by now), so it's ok by the GPL . And I don't see how you'd
claim that the openssl license doesn't allow it. So it all looks ok by me.

That said, if somebody wants to abstract this out, and have a simple "sign 
with sha1" interface that can be used with both openssl and libgcrypt (or 
any other crypt license), then hey, go wild. Or merge the SHA1 code from 
the kernel, even, and make the project entirely self-sufficient.

But requiring libgcrypt seems silly. Especially as the libgcrypt 
interfaces are horribly ugly, much more so than the openssl ones - so even 
if you use libgcrypt, you don't actually want to use it directly, you want 
to have much nicer wrappers around it.

		Linus
