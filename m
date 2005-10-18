From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] git-daemon extra paranoia
Date: Tue, 18 Oct 2005 16:21:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181616500.3369@g5.osdl.org>
References: <435560F7.4080006@zytor.com> <Pine.LNX.4.64.0510181517280.3369@g5.osdl.org>
 <7v64ruo31i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 01:23:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES0mO-0004nz-RC
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 01:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751472AbVJRXVu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 19:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751477AbVJRXVu
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 19:21:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58861 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751472AbVJRXVt (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 19:21:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9INLjFC016434
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 16:21:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9INLfVK004975;
	Tue, 18 Oct 2005 16:21:44 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ruo31i.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10240>



On Tue, 18 Oct 2005, Junio C Hamano wrote:
> 
> Wouldn't having /home/linux-2.6/.git/ repository with
> /home/linux-2.6/ working tree be good enough for that?  Instead
> of doing "find / -type d -name '*.git'" you could do "find /
> -type d -name .git" for automated tasks.

In this case, yes.

But In a mixed environment where you might have "bare" repositories, you 
want to have "reponame.git" as the repository name.

So with the rule that (a) try to first append ".git" and (b) then, after a 
successful chdir, try to go in one more level, you can handle both types, 
without ever having to care whether it's checked-out or not.

And for secondary projects (where git isn't necessarily the primary source 
control method), I actually use the "project.git" naming just to make it 
obvious that this is the "gitified" version of the project.

For example, I keep both my private uemacs and pine source trees as git 
repositories these days, and I have them under "~/src/uemacs.git/" and 
"~/src/pine.git/" even though they are checked out and thus actually have 
another ".git" inside of them.

		Linus
