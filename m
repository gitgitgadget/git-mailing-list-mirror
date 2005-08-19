From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Spell __attribute__ correctly in cache.h.
Date: Fri, 19 Aug 2005 02:04:54 -0700
Message-ID: <7vk6ii1emh.fsf@assigned-by-dhcp.cox.net>
References: <812.1124424608@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 11:06:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E62o7-0007b3-9b
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 11:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932552AbVHSJE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Aug 2005 05:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVHSJE4
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Aug 2005 05:04:56 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:39318 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932552AbVHSJE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2005 05:04:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819090455.ROR17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 19 Aug 2005 05:04:55 -0400
To: Jason Riedy <ejr@cs.berkeley.edu>
In-Reply-To: <812.1124424608@lotus.CS.Berkeley.EDU> (Jason Riedy's message of
	"Thu, 18 Aug 2005 21:10:08 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Jason Riedy <ejr@cs.berkeley.edu> writes:

> Sun's cc doesn't know __attribute__.

It turns out that your patch breaks GCC build (#ifndef
__attribute__ is true there, and it should be---what it does
cannot be done in preprocessor alone).  I am going to work it
around like this.  Could you try it with Sun cc please?

---
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -38,11 +38,10 @@
 #define NORETURN __attribute__((__noreturn__))
 #else
 #define NORETURN
-#endif
-
 #ifndef __attribute__
 #define __attribute__(x)
 #endif
+#endif
 
 /*
  * Intensive research over the course of many years has shown that
