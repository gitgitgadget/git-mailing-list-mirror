From: Junio C Hamano <junkio@cox.net>
Subject: Re: killing a branch
Date: Tue, 10 Jan 2006 02:52:41 -0800
Message-ID: <7vy81o73t2.fsf@assigned-by-dhcp.cox.net>
References: <20060110102207.GP3389@suse.de>
	<7vr77g8jm4.fsf@assigned-by-dhcp.cox.net>
	<20060110103533.GT3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 11:52:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EwH7Q-0001ix-3R
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 11:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWAJKwo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jan 2006 05:52:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWAJKwo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jan 2006 05:52:44 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:11199 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932165AbWAJKwn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2006 05:52:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110105135.TPXW6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 10 Jan 2006 05:51:35 -0500
To: Jens Axboe <axboe@suse.de>
In-Reply-To: <20060110103533.GT3389@suse.de> (Jens Axboe's message of "Tue, 10
	Jan 2006 11:35:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14417>

Jens Axboe <axboe@suse.de> writes:

>> that having dangling objects in your repository is not a crime,
>> and you do not have to religiously do "git prune" every time.
>
> I know, it just doesn't feel nice!

Sorry, but I can think of only three reasons (and a half) why
somebody cannot live with "one git prune at the end of the day
before leaving" (or "week" for that matter) workflow:

 * the filesystem quota is too tight and you cannot afford to
   leave unused loose objects around.  May still be true on
   student accounts, perhaps, but I doubt this is much of an
   issue in the modern world anymore.

 * rsync is used to sync from a repository that dropped a branch
   just now, and you do not want to push the garbage out.  Well,
   if you are still using rsync, I'll tell about it to Linus ;-)
   Pushing via git native protocol over ssh would not send
   unreferenced objects out and will not contaminate the other
   end with the garbage.

 * you do not want to leave after starting prune before it
   finishes.  If it is your hobby to watch the paint dry, I
   cannot help you, but you could run prune under nohup (or
   always work inside "screen", which is what I do).

 + having unused things on the disk just does not _feel_ right.
   Well, maybe.  I can argue with a reason but not with a
   feeling.  On a bright side, leaving recently abandoned
   objects around for a while lets you run git-lost-found to
   recover if you accidentally deleted a still-useful branch.
