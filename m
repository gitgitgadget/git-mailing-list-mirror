From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-checkout-index, flag ordering and --prefix kludgy handling
Date: Mon, 17 Oct 2005 15:58:27 -0700
Message-ID: <7voe5nycmk.fsf@assigned-by-dhcp.cox.net>
References: <200510162114.27429.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 18 00:59:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERdwM-0007YR-CP
	for gcvg-git@gmane.org; Tue, 18 Oct 2005 00:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVJQW6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 18:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbVJQW6a
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 18:58:30 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:15499 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932362AbVJQW63 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 18:58:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051017225814.MQN4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Oct 2005 18:58:14 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
In-Reply-To: <200510162114.27429.blaisorblade@yahoo.it>
	(blaisorblade@yahoo.it's message of "Sun, 16 Oct 2005 21:14:26 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10197>

Blaisorblade <blaisorblade@yahoo.it> writes:

> I already knew that git-checkout-cache -a -f is wrong. But I
> didn't know that
>
> git-checkout-index -a --prefix=/home/paolo/Uml/space.mnt/paolo/Linux-2.6.git/
>
> is.

> At least, this should be documented in the man page;...


How about a bit further clarification on top of what is there,
like this?

 ------------
[PATCH] clarify that '-a' is really special in checkout-index.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index 1ba6fb2..838059f 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -44,13 +44,15 @@ OPTIONS
 --::
 	Do not interpret any more arguments as options.
 
-Note that the order of the flags matters:
+Note that the order of the flags matters for `-a` flag:
 
      git-checkout-index -a -f file.c
 
 will first check out all files listed in the cache (but not overwrite
 any old ones), and then force-checkout `file.c` a second time (ie that
 one *will* overwrite any old contents with the same filename).
+In other words, `-a` means "operate as if names of all files were
+given here, with the flags given up to this point."
 
 Also, just doing "git-checkout-index" does nothing. You probably meant
 "git-checkout-index -a". And if you want to force it, you want
