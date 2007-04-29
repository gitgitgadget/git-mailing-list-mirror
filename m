From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 29 Apr 2007 11:45:49 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704291142510.9964@woody.linux-foundation.org>
References: <11776622643106-git-send-email-junkio@cox.net>
 <11776622643639-git-send-email-junkio@cox.net>
 <7v3b2jdo9h.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 29 20:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HiEPx-0007H2-4J
	for gcvg-git@gmane.org; Sun, 29 Apr 2007 20:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754356AbXD2Sq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Apr 2007 14:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbXD2Sq1
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Apr 2007 14:46:27 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:43584 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754180AbXD2Sq0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Apr 2007 14:46:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3TIjq18032007
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 29 Apr 2007 11:45:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3TIjn6J021313;
	Sun, 29 Apr 2007 11:45:51 -0700
In-Reply-To: <7v3b2jdo9h.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.991 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45832>



On Sun, 29 Apr 2007, Junio C Hamano wrote:
>
> * lt/objalloc (Mon Apr 16 22:13:09 2007 -0700) 1 commit
>  - Make the object lookup hash use a "object index" instead of a
>    pointer

I think you should just drop this. 

You merged the two patches that made this possible, and the third in the 
series isn't really worth it. I can re-create it at will (maybe better) 
now that the core object allocations are all cleaned up, and that patch 
simply didn't give enough of an advantage to be worth it.

Maybe inlining the object index -> ptr conversion would have solved the 
performance regression, but it migth also be something more fundamental, 
like the potential extra cache miss in the converstion part (when looking 
up the allocation block).

So it was interesting to try, but I don't think it's worth carrying around 
considering the results.

		Linus
