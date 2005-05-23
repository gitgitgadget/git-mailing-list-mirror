From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] The diff-raw format updates.
Date: Sun, 22 May 2005 18:07:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505221751070.2307@ppc970.osdl.org>
References: <7vwtpsdvgm.fsf@assigned-by-dhcp.cox.net> <7v1x80dluj.fsf@assigned-by-dhcp.cox.net>
 <7vvf5cc779.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221108000.2307@ppc970.osdl.org>
 <20050522184237.GG18500@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0505221203410.2307@ppc970.osdl.org> <7v64xbdq4y.fsf@assigned-by-dhcp.cox.net>
 <7vy8a7cavf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221259110.2307@ppc970.osdl.org>
 <7vis1adfvq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505221611020.2307@ppc970.osdl.org>
 <7vu0kubwyg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 23 03:05:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Da1NH-0004YO-3y
	for gcvg-git@gmane.org; Mon, 23 May 2005 03:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVEWBF5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 21:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVEWBF5
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 21:05:57 -0400
Received: from fire.osdl.org ([65.172.181.4]:64228 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261739AbVEWBFv (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2005 21:05:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4N15ijA003324
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 22 May 2005 18:05:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4N15hMh004097;
	Sun, 22 May 2005 18:05:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vu0kubwyg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 22 May 2005, Junio C Hamano wrote:
> 
>  (2) diff_flush() currently prunes _all_ the unmodified entries
>      just before output happens.  This is a _bug_ as you said.
>      To fix this, first, separate that pruning part


I don't understand why this is so hard.

The built-in diff knows to do the right thing. That means that the 
information is there, in xfrm_msg. 

Instead of making a big deal out of this, why not admit that "xfrm_msg" 
was a mistake, and it should be replaced with just a flag about what that 
thing is. Make the flag be "diff", "copy" or "rename". Add another field 
to say how good a match it was, and then let the people who now use 
xfrm_msg generate the string instead. 

The fact is, we alreadt _have_ the information, but it's been corrupted
into a string too early, making it hard to get at. No?

		Linus
