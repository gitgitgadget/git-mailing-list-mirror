From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pull from one branch to another?
Date: Wed, 28 Sep 2005 23:35:33 -0700
Message-ID: <7vbr2cmle2.fsf@assigned-by-dhcp.cox.net>
References: <433B84BD.8030003@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 08:36:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKs15-00086L-DU
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 08:35:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091AbVI2Gfg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 02:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbVI2Gfg
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 02:35:36 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:25476 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932091AbVI2Gfg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 02:35:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929063534.VGXO9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 02:35:34 -0400
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <433B84BD.8030003@pobox.com> (Jeff Garzik's message of "Thu, 29
	Sep 2005 02:07:57 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9469>

Jeff Garzik <jgarzik@pobox.com> writes:

> My question:  is this the best/right way to pull one branch into 
> another?  It's been working for me, for months, but...

Yes, that is how 'resolve' is designed to work.

You could instead use standard 'git pull' from the local
repository.  Here is what I usually do in git.git repository:

    $ git checkout foo
    $ ... work in foo "topic" branch
    $ git checkout bar
    $ ... work in bar "topic" branch
    $ git checkout pu
    $ git pull . foo bar

End result: foo and bar branches are pulled from the local
repository and merged into pu branch, as an Octopus.

Of course, I could instead:

    $ git checkout pu
    $ git pull . foo
    $ git pull . bar

to pull 'foo' and then 'bar' in sequence, which is easier if
these topic branches touch overlapping area, because Octopus
does not allow manual resolving.  On the other hand if I know
foo and bar are independent work, there is no point recording
the order of merges (merging foo first and then bar does not
have any significance) and I tend to let Octopus to happen.
