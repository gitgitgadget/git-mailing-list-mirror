From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: tree sorting..
Date: Fri, 16 Mar 2007 16:35:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703161632270.3910@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703160941290.3816@woody.linux-foundation.org>
 <20070316231329.GA4508@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 00:35:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSLxk-0005g3-Rx
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 00:35:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbXCPXfy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Mar 2007 19:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbXCPXfy
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Mar 2007 19:35:54 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42428 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030202AbXCPXfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2007 19:35:53 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2GNZocD010780
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 16 Mar 2007 16:35:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2GNZniM024479;
	Fri, 16 Mar 2007 15:35:50 -0800
In-Reply-To: <20070316231329.GA4508@spearce.org>
X-Spam-Status: No, hits=-0.48 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42410>



On Fri, 16 Mar 2007, Shawn O. Pearce wrote:
> 
> The entire reason this happened is hysterical raisins.  Your first
> draft of Git had trees as one flat structure, sorting complete
> paths by their memcmp result.  Which is dead simple and worked.

No. 

It's *not* historical reasons. That's what I tried to explain.

It's absolutely *required*. Not because of the old flat layout, but 
because we want read-tree to translate 1:1 into the index.

And the index is a flat file. And it *needs* to be a flat file, because we 
need to open it and read it efficiently. If it wasn't a flat file, we'd 
have all the index operations taking as long as the tree operations take.

> Now we are stuck with it.

No. How you need to accept it. It's that easy. It's not "stuck". It's 
"correct".

That's why I reacted to your irc thing. You seemed to think (and still 
apparently do) that the sorting is some messy mistake. It's anything but.

So yes, "foo" is *different* from "foo/". You just need to realize that 
they are two totally different entries. They have absolutely no 
relationship what-so-ever with each other, except that you obviously must 
not add one when the other exists.

		Linus
