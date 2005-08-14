From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Rewriting revs in place in push target repository
Date: Sat, 13 Aug 2005 17:55:16 -0700
Message-ID: <7vwtmpjq17.fsf@assigned-by-dhcp.cox.net>
References: <20050813214725.GM5608@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 14 02:55:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E46mX-0005eX-HR
	for gcvg-git@gmane.org; Sun, 14 Aug 2005 02:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932290AbVHNAzS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 20:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVHNAzS
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 20:55:18 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:31136 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751366AbVHNAzR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2005 20:55:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050814005515.TMEF1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 13 Aug 2005 20:55:15 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813214725.GM5608@pasky.ji.cz> (Petr Baudis's message of
	"Sat, 13 Aug 2005 23:47:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Petr Baudis <pasky@suse.cz> writes:

> Rewrite refs in place in receive-pack & friends
>
> When updating a ref, it would write a new file with the new ref and
> then rename it, overwriting the original file. The problem is that
> this destroys permissions and ownership of the original file, which is
> troublesome especially in multiuser environment, like the one I live in.

Hmph.  If a repo is _really_ used multiuser then you should not
have to care about ownership.  If you can write into a
repository for a project (implying that you are a member of that
project group), and if your umask is set up correctly (meaning
it is 002 or looser), and with g+s bit on the directory at the
repository root level when it was created, shouldn't your newly
created ref file be also writable by others in that project?
