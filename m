From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] Invalidate cache-tree entries for touched paths in git-apply.
Date: Sun, 23 Apr 2006 19:47:21 -0700
Message-ID: <7vk69fd70m.fsf@assigned-by-dhcp.cox.net>
References: <7v3bg3etnv.fsf@assigned-by-dhcp.cox.net>
	<7vodyrdas9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 24 04:47:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXr6l-0001Zi-Bb
	for gcvg-git@gmane.org; Mon, 24 Apr 2006 04:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWDXCrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 23 Apr 2006 22:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWDXCrY
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Apr 2006 22:47:24 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:49832 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751493AbWDXCrY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Apr 2006 22:47:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060424024723.FKA16517.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 23 Apr 2006 22:47:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vodyrdas9.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 23 Apr 2006 18:25:58 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19082>

Junio C Hamano <junkio@cox.net> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>>  * ... then the big rock falls.  With this, I tried to apply and
>>    then write-tree "diff-tree -p $commit^1 $commit" on top of
>>    "$commit^1" for the last 20 or so commits in the kernel tree.
>>    The "master" version takes 0.15 second per patch on my Duron
>>    750 with 700MB, while this one does that in 0.06 second.
>>    This also helps the memory pressure because we do not have to
>>    regenerate unchanged trees.  810 minor faults with the patch
>>    vs 2150 minor faults without.
>
> Sorry, but not really.  The patch is wrong and the measurement
> was flawed.

Again, sorry, but there are some more bugs in the cache-tree
code that I need to fix and re-measure.

In the meantime, please do not use it on your production
repositories.  It does not seem to produce corrupt trees, but it
creates broken index.aux for no good reason.
