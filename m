From: Junio C Hamano <junkio@cox.net>
Subject: Re: Add "git grep" helper
Date: Mon, 12 Sep 2005 15:31:58 -0700
Message-ID: <7virx57w9t.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0509121203210.4098@g5.osdl.org>
	<7vbr2y7yfd.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509121500400.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 13 00:33:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEwqK-0008Ea-Lz
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 00:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVILWcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 18:32:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbVILWcB
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 18:32:01 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:36318 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932317AbVILWcA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 18:32:00 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912223200.VVTB24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 18:32:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509121500400.3266@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 12 Sep 2005 15:12:32 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8444>

Linus Torvalds <torvalds@osdl.org> writes:

> Actually, the more I think about it, the more I think Morten was right, 
> and the git-grep case statement should just put all flags in "$flags", and 
> any git-ls-files flags can be handled specially before.
>
> We also need special casing for grep flags that take an argument.  So the
> end result might be something like the following..

Arrrrrrrrrrrrrrrrrrrgh.

Now, whose grep are we going to support?  Should we teach every
flag GNU grep supports that can take a parameter to the script?

Can we cheat and do something like this instead?

    git grep -B 6 -A 2 frotz -- arch/i386
    git grep -B 6 -A 2 frotz --others arch/i386

That is, things up to a known git-ls-files flag  or -- are
passed to grep and the rest is given to git-ls-files.
