From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Mon, 26 Sep 2005 15:37:48 -0700
Message-ID: <7v3bnra20z.fsf@assigned-by-dhcp.cox.net>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz>
	<20050926212536.GF26340@pasky.or.cz>
	<7virwna2oi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:38:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1bf-0003Fi-76
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:37:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVIZWhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbVIZWhw
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:37:52 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:49332 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932340AbVIZWhw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 18:37:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926223748.PQAY4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 18:37:48 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7virwna2oi.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 26 Sep 2005 15:23:41 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9351>

Junio C Hamano <junkio@cox.net> writes:

> Petr Baudis <pasky@suse.cz> writes:
>
>> Opinions?
>
> I do not understand this part of your logic:
>
>> .... But fetching the tags will cause all the commits
>> connected to the tags getting slurped too, and we didn't want that.
>
> What is the objective here?  If you fetch a tag without the
> object being tagged (or commit without its tree), you will end
> up with smaller object database but you would get yelled at by
> git-fsck-objects.

Having said that, I am sympathetic to what you are trying to do
here; if what I understand what you are trying to do matches
what you are actually trying to do, that is.

I think there should be a way to say "I do not care if this
repository does not have all the history back to root -- as long
as I can operate on reasonably recent commits, do not complain
about missing objects" to fsck-objects and various fetch
engines.  We can cauterize commit history chain using the grafts
file so that 'git log', 'git whatchanged', and 'gitk' would stop
somewhere.  Commit walkers can help you, albeit somewhat
differently, if you do not give -a flag to them.
