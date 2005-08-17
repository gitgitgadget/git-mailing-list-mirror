From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC PATCH] Add support for figuring out where in the git archive
 we are
Date: Tue, 16 Aug 2005 17:01:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508161655460.3553@g5.osdl.org>
References: <Pine.LNX.4.58.0508161536390.3553@g5.osdl.org>
 <7vll315u3w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Aug 17 02:01:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5BNA-0003FD-3Q
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 02:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbVHQAB3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 20:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbVHQAB3
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 20:01:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26265 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750754AbVHQAB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 20:01:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7H01OjA011955
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 16 Aug 2005 17:01:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7H01NCi022382;
	Tue, 16 Aug 2005 17:01:23 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vll315u3w.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Junio C Hamano wrote:
> 
> Comments: Wouldn't that mean git-*-scripts would not benefit from this
>           because git-sh-setup would set GIT_DIR for you even if
>           you don't?

As it stands now, yes. But the point being that if people like this, then 
I'll just change the git-sh-setup-script accordingly. For example, once 
git-diff-tree also does the same thing, then "git-diff-script" would have 
no reason left to even call the current git-sh-setup-script at all, since 
the git-diff-* commands would basically do the setup _and_ report the 
errors that git-sh-setup-script does now.

> 	  If you can do "cd drivers && git-diff-files ../net"
> 	  that would be very useful.

I don't do that right now, but it's actually very easy to do in the 
setup_git_directory() function. It falls out very simply there - both the 
"./" and the "../" prefix would make tons of sense to handle there.

Do you want to take the current patch (which buys you very little because 
not a lot of stuff has been set up to deal with it, but is the basis for 
all future work anyway) or do you want me to polish it up a bit and 
re-submit the whole thing?

I'd do at least the "git-diff-tree" part and the "./" and "../" handling,
and convert at least the "git diff" thing to the new world order and away
from git-sh-setup-script?

		Linus
