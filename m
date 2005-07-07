From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 07 Jul 2005 15:29:31 -0600
Message-ID: <m1vf3muwxw.fsf@ebiederm.dsl.xmission.com>
References: <20050703234629.GF13848@pasky.ji.cz>
	<42CBC822.30701@didntduck.org> <20050707144501.GG19781@pasky.ji.cz>
	<7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 00:24:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqem7-0006Al-5n
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 00:23:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVGGVdN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 17:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVGGVau
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 17:30:50 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6049 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262124AbVGGVaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2005 17:30:22 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id j67LTdkA010726;
	Thu, 7 Jul 2005 15:29:39 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id j67LTVD7010722;
	Thu, 7 Jul 2005 15:29:31 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org> (Linus
 Torvalds's message of "Thu, 7 Jul 2005 12:04:58 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> That said, I really think the dumb protocols are useless anyway. No other 
> system supports pure static object pulling anyway, and as far as I'm 
> concerned, I want "rsync" to kind of work (but it won't be optimal, since 
> re-packing will delete all the old objects and replace it with the new 
> pack that is downloaded anew). But plain http? I'm not convinced.

Have you not looked at tla/arch? tla does supports dumb servers.
It's job is a little easier as it has one file per atomic commit
I suspect once packs start working well that should not be an
issue for git either.

For small projects this is a major benefit, as they can just push
their files to a convenient http or ftp server.

> I'd much rather have a "stupid server" that just listens to a port, and
> basically forks off and executes "git-upload-pack" when it's connected to
> (perhaps reading the directory name first).  Nothing else. Then we can do 
> a security analysis of upload-pack, which should be fairly easy since it's 
> not actually ever _writing_ anything.
>
> At that point, you can do
>
> 	git pull git://www.kernel.org/pub/scm/git/..
>
> and it would just connect to some default "git port", pass off the 
> directory name, and be done with it - exact same discovery protocol that 
> now use for ssh. And "git clone" would also automatically work.

For optimizing network bandwidth that sounds like the way to go.  For
adhoc development I don't know.  For a central sever you still need
an authenticated way to push content, which makes it another dimension
of the problem.  So it is mostly a question of what is the sanest way
to mirror/publish data.  http is used a lot for publishing data and
practically everyone has access to a http server that can host
content, so I think supporting http makes git a lot more accessible
to people.  The only thing more accessible seems to be email, and
email is terrible for publish small projects.

Eric
