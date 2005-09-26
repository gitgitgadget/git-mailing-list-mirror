From: Junio C Hamano <junkio@cox.net>
Subject: Re: rsync deprecated but promoted?
Date: Mon, 26 Sep 2005 13:19:00 -0700
Message-ID: <7v7jd3inuz.fsf@assigned-by-dhcp.cox.net>
References: <20050925163201.GA29198@tumblerings.org>
	<4d4586301dca616f42880612fae01492@cream.org>
	<20050926133204.GB21019@pasky.or.cz>
	<Pine.LNX.4.58.0509260801430.3308@g5.osdl.org>
	<dh98gk$6rp$1@sea.gmane.org>
	<Pine.LNX.4.58.0509261038460.3308@g5.osdl.org>
	<dh9hqs$6nl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 22:20:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzRm-00078B-8a
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932507AbVIZUTK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:19:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVIZUTJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:19:09 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:9715 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932507AbVIZUTI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 16:19:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926201901.HZLY16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 16:19:01 -0400
To: walt <wa1ter@myrealbox.com>
In-Reply-To: <dh9hqs$6nl$1@sea.gmane.org> (wa1ter@myrealbox.com's message of
	"Mon, 26 Sep 2005 12:23:07 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9327>

walt <wa1ter@myrealbox.com> writes:

>>>  From git I got this:
>>> $git-fsck-objects
>>> missing commit 00d8bbd3c4bba72a6dfd48c2c0c9cbaa000f13c2
>>> broken link from     tag 02b2acff8bafb6d73c6513469cdda0c6c18c4138
>>>                to  commit d5bc7eecbbb0b9f6122708bf5cd62f78ebdaafd8
>>> <similar lines snipped>

>> Your git tree is quote possibly corrupted.
>
> I recloned from http://kernel.org and I still get exactly the same fsck
> errors for git, with or without the --full flag.

That 00d8bbd3c4bba72a6dfd48c2c0c9cbaa000f13c2 is v0.99.7c commit.

While I do not doubt your git repository is missing that object,
it probably is a buggy clone method.  Let me see if I can
reproduce.

    $ git clone http://kernel.org/pub/scm/git/git.git/ git-clone
    (says a lot of "got" and "walk" here)
    $ cd git-clone
    $ git-cat-file -t 00d8bbd3c4bba72a6dfd48c2c0c9cbaa000f13c2
    commit
    $ git-fsck-objects
    $ git-fsck-objects --full
    $ exit

Nope.  Things look OK from here.
