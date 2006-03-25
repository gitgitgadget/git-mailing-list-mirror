From: Junio C Hamano <junkio@cox.net>
Subject: Re: Effective difference between git-rebase and git-resolve
Date: Fri, 24 Mar 2006 22:08:09 -0800
Message-ID: <7v64m3ys3a.fsf@assigned-by-dhcp.cox.net>
References: <20060325035423.GB31504@buici.com>
	<Pine.LNX.4.64.0603242014160.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Singer <elf@buici.com>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 25 07:08:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FN1wl-00072i-Va
	for gcvg-git@gmane.org; Sat, 25 Mar 2006 07:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbWCYGIN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Mar 2006 01:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbWCYGIN
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Mar 2006 01:08:13 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:14301 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751016AbWCYGIM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Mar 2006 01:08:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060325060811.NASR20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Mar 2006 01:08:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603242014160.15714@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 24 Mar 2006 20:23:04 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17954>

Linus Torvalds <torvalds@osdl.org> writes:

> As to rebase, it often is very nice, but on the other hand, it leaves 
> things in a total mess when it fails, which is a pity. Maybe there's a 
> nice way to just continue, but I end up just doing a
>
> 	git reset --hard ORIG_HEAD
>
> to undo the failed rebase.
>
> Junio, is there some magic to restart a rebase after you've fixed up the 
> conflicts?

The modern rebase is essentially git-format-patch piped to
git-am (with -3 flag to allow falling back to three-way merge),
and all the familiar "the patch did not apply -- what now?"
techniques can be employed.

Since the pre-image blobs recorded in the intermediate
format-patch output by definition exist in your repository, it
always falls back to three-way merge when the patch does not
apply cleanly.  Then you can resolve and say "git am --resolved"
to continue.
