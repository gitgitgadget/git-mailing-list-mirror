From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC][PATCH] Allow transfer of any valid sha1
Date: Thu, 25 May 2006 11:28:51 -0700
Message-ID: <7v3beyuffg.fsf@assigned-by-dhcp.cox.net>
References: <m164jvj1x3.fsf@ebiederm.dsl.xmission.com>
	<7vejyjpz9a.fsf@assigned-by-dhcp.cox.net>
	<m13beysnb2.fsf@ebiederm.dsl.xmission.com>
	<7vwtcay5k8.fsf@assigned-by-dhcp.cox.net>
	<m1lksqdook.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605251024320.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 20:29:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FjKZt-0004SA-7V
	for gcvg-git@gmane.org; Thu, 25 May 2006 20:28:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030319AbWEYS2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 14:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWEYS2x
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 14:28:53 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:60890 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030319AbWEYS2w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 14:28:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525182852.KKYI9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 14:28:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605251024320.5623@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 25 May 2006 10:28:47 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20753>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 25 May 2006, Eric W. Biederman wrote:
>> 
>> My basic argument is that starting a pull with a commit that is not a
>> reference is no worse than staring a pull from a broken repository.  The
>> same checks that protects us should work in either case.
>
> I think Junio reacted to the subject line, which was somewhat badly 
> phrased. You're not looking to transfer random objects, you're looking to 
> _start_ a branch at any arbitrary known point.

I realize that now.  From Eric's original message:

  To be accurate of his source Andrew records the sha1 of the commit
  and the git tree he pulled from.  Which looks like:

  GIT b307e8548921c686d2eb948ca418ab2941876daa \
   git+ssh://master.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

  So I figured I would transform the above line into the obvious
  git-pull command:

   git-pull \
    git+ssh://master.kernel.org/pub/scm/.../torvalds/linux-2.6.git \
    b307e8548921c686d2eb948ca418ab2941876daa

With the limitation of the current tool, we could do:

  git-fetch master.kernel.org:/pub/scm/.../torvalds/linux-2.6.git \
	refs/heads/master:refs/remotes/linus/master
  git merge 'whatever merge message' HEAD b307e854

assuming that b307e854 is reachable from your tip.  So it might
be just a matter of giving a convenient shorthand to do the
above two commands, instead of mucking with upload-pack.
