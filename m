From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] rebase --merge: fix for rebasing more than 7 commits.
Date: Sat, 24 Jun 2006 00:09:03 -0700
Message-ID: <7vac83114g.fsf@assigned-by-dhcp.cox.net>
References: <7vy7vptw8p.fsf@assigned-by-dhcp.cox.net>
	<7vpsh1tvt1.fsf@assigned-by-dhcp.cox.net>
	<20060622110941.GA32261@hand.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 24 09:09:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fu2GT-00031k-NE
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 09:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932940AbWFXHJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 03:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932947AbWFXHJF
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 03:09:05 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:9212 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932940AbWFXHJE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 03:09:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060624070904.QOSK22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 03:09:04 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060622110941.GA32261@hand.yhbt.net> (Eric Wong's message of
	"Thu, 22 Jun 2006 04:09:41 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22490>

Eric Wong <normalperson@yhbt.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> Junio C Hamano <junkio@cox.net> writes:
>> 
>> >  * I wanted to raise my confidence level in the new rebase --merge
>> >    code, so I did a little exercise which resulted in finding this
>> >    buglet.
>> >...
>> >    So the exercise went like this:
>> >...
>> >   With this fix, the above works beautifully.  I am reasonably
>> >   happy with this shiny new toy.  Good job, Eric! and thanks.
>
> :)  Thanks for the extra QA and fix.

Another thing I noticed is while rebasing onto the mainline that
has accepted a few of the patches from the topic.  The original
rebase with "git am -3" logic notices that the patch has already
been applied and drops that commit, which is rather nice, but
the new "rebase --merge" logic barfs when git-commit notices
there is nothing to commit.  I think you could before calling
git-commit check if the git-merge-$strategy gave you the tree
identical to the HEAD tree, and simply skip it (maybe after
giving the user "patch already applied"message).
