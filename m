From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'read-tree -m head' vs 'read-tree head'
Date: Tue, 03 May 2005 12:13:40 -0700
Message-ID: <7vbr7sw2aj.fsf@assigned-by-dhcp.cox.net>
References: <20050503124935.GT25004@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 21:08:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT2jt-0005uM-RG
	for gcvg-git@gmane.org; Tue, 03 May 2005 21:07:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVECTNp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 15:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVECTNp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 15:13:45 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:54996 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S261616AbVECTNo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2005 15:13:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050503191341.USZV22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 3 May 2005 15:13:41 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050503124935.GT25004@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Tue, 3 May 2005 14:49:35 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The form "git-read-tree <tree>" does not care what the original
cache contained and builds the cache from scratch. On the other
hand, "git-read-tree -m <tree>" uses what the original cache
contained to speed things up in later checkout-cache.  That's
the official version of difference description.

That said, I've been wondering if "git-read-tree -m <tree>"
always does the same thing (but only making the operation
afterwards faster) as "git-read-tree <tree>".  That is, if there
is a valid use case where you would want to use it without "-m"
because "-m" does something wrong.  If there is no such valid
use case probably we should always do "-m" version if we are
reading only one tree, practically deprecating "-m" flag to the
same status as "-r" flag to git-diff-cache.

However, I have not had time to think things through and have
not bugged Linus about it myself.


