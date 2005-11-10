From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] GIT 0.99.9g
Date: Thu, 10 Nov 2005 11:32:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511101128510.4627@g5.osdl.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
 <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 10 20:35:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIAf-0007BE-Gf
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbVKJTdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:33:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbVKJTdN
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:33:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:24534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932167AbVKJTdM (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:33:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAAJX6nO024626
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 10 Nov 2005 11:33:07 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAAJWwqJ001713;
	Thu, 10 Nov 2005 11:33:02 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11510>



On Thu, 10 Nov 2005, Junio C Hamano wrote:
> 
> Yeah, the original proposal (in TODO list) explicitly stated why
> I chose lost-found instead of lost+found back then, and somebody
> on the list (could have been Pasky but I may be mistaken) said
> not to worry.  In any case, if we go the route Daniel suggests,
> we would not be storing anything on the filesystem ourselves so
> this would be a non-issue.

I don't know how many people do this, but with the current kernel sources, 
"git-fsck-cache --full" takes about a minute on a reasonable fast machine 
with everything in cache (ie no real disk activity to speak of)

I personally think that's fine, since I repack my trees every once in a 
while, and almost never run a "--full" check, I only do incrementals 
(which are basically free). And I suspect that I run fsck a lot more than 
anybody else does.

But the point is, that if you actually run fsck every time you want to 
visualize your pending commits, you're going to feel the pain. 

I think having some kind of lost+found so that you don't have to re-run 
fsck just because you decided to look at them some other way (use "git 
log" instead of "gitk" or whatever) makes a lot of sense. But yes, it 
shouldn't really be called "lost+found" due to some rather serious 
confusion that can cause.

		Linus
