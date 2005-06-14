From: Junio C Hamano <junkio@cox.net>
Subject: Re: Semantics for one step undo/redo
Date: Tue, 14 Jun 2005 08:01:16 -0700
Message-ID: <7voea93rur.fsf@assigned-by-dhcp.cox.net>
References: <2cfc403205061406507af5a66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 14 16:58:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DiCqF-0006dg-Ec
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 16:56:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbVFNPB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Jun 2005 11:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVFNPB0
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jun 2005 11:01:26 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49572 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261166AbVFNPBS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2005 11:01:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050614150117.QPLG19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Jun 2005 11:01:17 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc403205061406507af5a66@mail.gmail.com> (Jon Seymour's
 message of "Tue, 14 Jun 2005 23:50:02 +1000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "JS" == Jon Seymour <jon.seymour@gmail.com> writes:

JS> I think my approach differs a little from Junio's (but I haven't
JS> analysed his deeply) in that the redolog is actually just the slightly
JS> edited output of git-rev-list --merge-order --parents head base [ the
JS> edits removes from the list the parallel branches that aren't actually
JS> involved in the undo ]

JS> Comments?

I've only took a brief glance at your description and found it
quite sensible.  I did not find anything majorly wrong.

If you are talking about jit-rewind (I think the message I told
you about it was not sent to the list, so the list audience may
not know about it, by the way), there is not much to analyze.

It populates the snapshot pool with the commits in the specified
commit chain, and after that it is totally up to the user what
to do with them, hence there is no redo semantics attached to
it.  JIT way of doing things is generally more dangerous in that
it gives you so much more flexibility that it lets you freely
shoot yourself in the foot ;-).  When the core Plumbing side
stabilizes I may revisit updating JIT to make certain parts of
it not so sharp-edged, but I have been busy futzing with the
Plumbing side lately, and having found not much need to change
JIT, haven't done much about updating my own Porcelain.

