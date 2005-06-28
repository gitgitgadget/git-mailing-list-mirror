From: Junio C Hamano <junkio@cox.net>
Subject: Re: CAREFUL! No more delta object support!
Date: Mon, 27 Jun 2005 19:01:03 -0700
Message-ID: <7vwtofi6jk.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 28 03:54:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dn5Iq-0004tR-6i
	for gcvg-git@gmane.org; Tue, 28 Jun 2005 03:54:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbVF1CBN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Jun 2005 22:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbVF1CBN
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jun 2005 22:01:13 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:139 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262373AbVF1CBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2005 22:01:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050628020103.TARP550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Jun 2005 22:01:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506271755140.19755@ppc970.osdl.org> (Linus
 Torvalds's message of "Mon, 27 Jun 2005 18:14:40 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Now, there's still a misfeature there, which is that when you create a new
LT> object, it doesn't check whether that object already exists in the
LT> pack-file, so you'll end up with a few recent objects that you really
LT> don't need (notably tree objects), and we'll fix that eventually.

Patch will be sent separately.

LT> ... Also, please note that the pack-file _only_ packs the commits
LT> and the things reachable from them ...

Shouldn't feeding "git-rev-list --object" output plus
handcrafted list of objects in 2.6.11 tree object to
git-pack-objects just work???

LT> Maybe you might not want to switch over yet, and as mentioned, rsync then
LT> ends up not being a good way to sync (nor git-local-pull), but the
LT> "git-http/ssh-pull" family should hopefully just work.

No.  The pull protocol Dan did expects to throw compressed
representation around on the wire (which is valid if you assume
uncompressed transfer) and does not use read-sha1-file --
write-sha1-file pair, so all three do not work.
