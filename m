From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Isn't "dangling" a misnomer?
Date: Mon, 26 Feb 2007 12:19:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702261216380.12485@woody.linux-foundation.org>
References: <3c6c07c20702260835v4865ace1u18a20f6b1d0030b5@mail.gmail.com>
 <7virdolm8u.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Coleman <tutufan@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 26 21:19:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLmJg-00058O-8u
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 21:19:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161005AbXBZUTU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 15:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbXBZUTU
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 15:19:20 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60414 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161005AbXBZUTT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 15:19:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1QKJFhB005339
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 26 Feb 2007 12:19:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1QKJEJS030161;
	Mon, 26 Feb 2007 12:19:15 -0800
In-Reply-To: <7virdolm8u.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.447 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40662>



On Mon, 26 Feb 2007, Junio C Hamano wrote:
> 
> We seem to use the word "unreachable" to refer to them.
> E.g. fsck and prune do "reachability analysis".

Well, everything that cannot be reached is "unreachable", but not 
everything is "dangling".

Being "dangling" is a very special case of unreachability: it's not 
reachable from _anything_ - including other unreachable objects.

So

	git fsck

will report about dangling objects, but

	git fsck --unreachable

will report about unreachable objects, and the result is *not* the same 
(dangling objects will usually be a very small subset of the unreachable 
ones, since in many cases *most* unreachable objects end up being pointed 
to by other unreachable objects, and are thus not the dangling part).

Maybe we could call the dangling objects "unreachable tips" or something. 
Because dangling => unreachable, but unreachable !=> dangling.

		Linus
