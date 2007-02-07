From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git log filtering
Date: Wed, 7 Feb 2007 10:16:15 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Don Zickus <dzickus@gmail.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Feb 07 19:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HErLF-0000qM-Q9
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 19:16:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965701AbXBGSQW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Feb 2007 13:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965541AbXBGSQW
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Feb 2007 13:16:22 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58252 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965701AbXBGSQU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Feb 2007 13:16:20 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l17IGGmA012361
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 7 Feb 2007 10:16:16 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l17IGFmS022095;
	Wed, 7 Feb 2007 10:16:16 -0800
In-Reply-To: <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.455 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.112__
X-MIMEDefang-Filter: osdl$Revision: 1.174 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38951>



On Wed, 7 Feb 2007, Linus Torvalds wrote:
> 
> 	git log --pretty -z |

Gaah. If all you want is normal logs, you don't need the "--pretty", 
of course, since that's the default. Just "git log -z" will give you 
zero-terminated logs. 

But if you want to grep on committer, you'd need to use "--pretty=full" or 
something, of course, so the "--pretty=xyz" thing is indeed often 
applicable for things like this.

Also, I just checked, and we have a bug. Merges do not have the ending 
zero in "git log -z" output. It seems to be connected to the fact that we 
handle the "always_show_header" commits differently (the ones that we 
wouldn't normally show because they have no diffs associated with them).

The obvious fix for that failed. I'll look at it some more.

		Linus
