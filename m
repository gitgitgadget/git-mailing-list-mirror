From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: daemon.c broken on OpenBSD
Date: Mon, 24 Oct 2005 09:43:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510240936450.10477@g5.osdl.org>
References: <867jc336f4.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0510240901020.10477@g5.osdl.org>
 <86irvmzyq9.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 18:47:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EU5QT-0004Xw-RZ
	for gcvg-git@gmane.org; Mon, 24 Oct 2005 18:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbVJXQnz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 24 Oct 2005 12:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVJXQnz
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Oct 2005 12:43:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751148AbVJXQny (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Oct 2005 12:43:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9OGhqFC000726
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 24 Oct 2005 09:43:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9OGhpEX030781;
	Mon, 24 Oct 2005 09:43:52 -0700
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
In-Reply-To: <86irvmzyq9.fsf@blue.stonehenge.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10547>



On Mon, 24 Oct 2005, Randal L. Schwartz wrote:
> 
> That probably won't work, because on OpenBSD, it's not a #define, but
> rather a real function call.  You can't just #undef that (unless my C
> is even more rusty).

Sure you can. 

The #undef won't necessarily _do_ anything, but it protects against 
systems where it is a #define. Then, the #define makes sure that if it's 
anything else, the #define will take precedence.

So yes, it's ugly, but it definitely is safe in practice, as long as the 
local headers are included before the system ones.

I think Junio's patch (that renames things) is possibly the "cleaner" 
alternative, but on the other hand there's a lot of advantages to just 
using the standard names. No chance of somebody using the wrong version by 
mistake.

			Linus
