From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: removing content from git history
Date: Wed, 21 Feb 2007 10:24:12 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702211016340.4043@woody.linux-foundation.org>
References: <20070221164527.GA8513@ginosko.local> <20070221165636.GH25559@spearce.org>
 <20070221171738.GA9112@fieldses.org> <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Michael Hendricks <michael@ndrix.org>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 19:24:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJw8d-0004uf-99
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 19:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422765AbXBUSYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 13:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbXBUSYU
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 13:24:20 -0500
Received: from smtp.osdl.org ([65.172.181.24]:36435 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422765AbXBUSYT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 13:24:19 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1LIOBhB030535
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Feb 2007 10:24:11 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1LIOAGW021880;
	Wed, 21 Feb 2007 10:24:11 -0800
In-Reply-To: <Pine.LNX.4.64.0702210934470.4043@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.463 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40313>



On Wed, 21 Feb 2007, Linus Torvalds wrote:
> 
>    For the kernel, it took 2 minutes, but again, it was exactly the same 
>    thing: just a few old tree objects that it rewrote, and as a result, 
>    every single commit SHA1 changed. Still, it was almost _only_ commits 
>    (it generated 49521 new objects, 49332 of which was the new commit 
>    history)

Side note: I wasn't entirelyaccurate. The kernel had trees with file mode 
0644 for all the early commits, because my umask is 0022. So everything up 
to commit 4bfa437cf1 is shared after the conversion.

But the next one (commit 5dfa9c1b4f) introduced the file 
include/asm-mips/vr41xx/pci.h with file mode 0664, and I'm not 100% sure 
why that one happened with that file mode, but as a result, every single 
commit ever after will have a different SHA1, because the tree got 
rewritten (and subsequent commits - even if their trees did *not* get 
rewritten - will obviously have different parent SHA1's).

So 56 commits are shared, and "only" 49276 commits were rewritten (and 
apparently 245 trees).

			Linus
