From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/4] Recovery after interrupted HTTP(s) fetch
Date: Wed, 14 Sep 2005 13:48:01 -0700
Message-ID: <7vacifgyv2.fsf@assigned-by-dhcp.cox.net>
References: <20050914124206.GC24405@master.mivlgu.local>
	<7vpsrbjz0t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509141325310.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 22:48:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFeAt-00052l-KE
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 22:48:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVINUsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 16:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbVINUsF
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 16:48:05 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:4583 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932495AbVINUsE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 16:48:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914204802.EEWR8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 16:48:02 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509141325310.26803@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 14 Sep 2005 13:27:12 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8563>

Linus Torvalds <torvalds@osdl.org> writes:

> Any "fetch" logic that writes the refs before all the objects are gathered 
> is _buggy_. It's not about "recovery", it should never do that in the 
> first place.

I agree about refs, but in this case what is stored, and is used
as a signal not to refetch to the next run, is the commit
object.  Ideally we should defer creating trees until we store
all blobs and subtrees, and commits until we do its tree, but
the fetch.c (formerly called pull.c) is not written that way
from day one.

> Is it just the http one that is this broken?

I belive all of the commit walkers share this property.
