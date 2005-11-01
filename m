From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: hgmq vs. StGIT
Date: Tue, 1 Nov 2005 17:34:43 +0000
Message-ID: <b0943d9e0511010934m8d32eb2i@mail.gmail.com>
References: <Pine.LNX.4.63.0510311111340.2916@wbgn013.biozentrum.uni-wuerzburg.de>
	 <20051031195010.GM11488@ca-server1.us.oracle.com>
	 <7vr7a1e719.fsf@assigned-by-dhcp.cox.net>
	 <20051031213616.GO11488@ca-server1.us.oracle.com>
	 <7vk6ftcp0d.fsf@assigned-by-dhcp.cox.net>
	 <20051031224246.GP11488@ca-server1.us.oracle.com>
	 <20051101002554.GA7634@thunk.org> <20051101090804.GA11618@pasky.or.cz>
	 <b0943d9e0511010123i1f9eb679w@mail.gmail.com>
	 <20051101101004.GD11618@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Ts'o <tytso@mit.edu>,
	Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <junkio@cox.net>, mason@suse.com,
	git@vger.kernel.org, Chuck Lever <cel@citi.umich.edu>
X-From: git-owner@vger.kernel.org Tue Nov 01 18:35:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EX023-0005J7-1t
	for gcvg-git@gmane.org; Tue, 01 Nov 2005 18:34:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbVKAReo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 Nov 2005 12:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751030AbVKAReo
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Nov 2005 12:34:44 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:17862 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751023AbVKARen convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 1 Nov 2005 12:34:43 -0500
Received: by xproxy.gmail.com with SMTP id i30so1370653wxd
        for <git@vger.kernel.org>; Tue, 01 Nov 2005 09:34:43 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NPmGZ3j9WWQJKtl4YlMcjTlpG9/s1vpvqEEUL/bldzZ/o89cwRLO7cm3XsFfxRRbNAM73tFaV+2261oLrlQsBH8km+ql6Zga3OOoB+eLejWQoyKiknwNCGibMQ7XPVolYGhRx6lQN1WCoXBtorSOqHB/r5i8zHjoRZIViH4xxew=
Received: by 10.70.113.20 with SMTP id l20mr2645152wxc;
        Tue, 01 Nov 2005 09:34:43 -0800 (PST)
Received: by 10.70.31.3 with HTTP; Tue, 1 Nov 2005 09:34:43 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051101101004.GD11618@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10944>

On 01/11/05, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Tue, Nov 01, 2005 at 10:23:55AM CET, I got a letter
> where Catalin Marinas <catalin.marinas@gmail.com> told me that...
> > That's not too far away. Chuck Lever has a patch (and there were some
> > other discussions in the past) for tracking the history of a patch.
> > Basically, there would be another commit object, not reachable from
> > HEAD but only via an StGIT command, which would chain all the versions
> > of a patch. You would be able to view them with gitk for example.
>
> Perhaps you could emulate the topical branches - one patch == one head.
> E.g. for patch foo-bar on branch 'master', you would create head
> master/foo-bar, etc.

The patches need to be chained so a top patch would also refer to the
previously applied patches since they are its base. Anyway, I don't
like adding too many files to the refs/heads directory.

> > My main issue was whether we should store every state resulted from a
> > refresh  or use a separate command (somebody suggested 'freeze') to
> > mark the states that should be preserved in the history. Chuck's patch
> > implements the first. The drawback is that a future 'stg prune'
> > command would not be able to remove the history and some states of the
> > patch might not be useful (there are times when I do a refresh only to
> > pop the patch and modify a different one, without any logical meaning
> > for the state of the patch).
>
> I'd prefer the snapshotting being done in refresh anyway. Perhaps you
> would be asked for log message when you refresh by default, but when you
> refresh -n or something, only a temporary commit would be created and
> next refresh would mutate it instead of creating another commit.

The refresh -n should be the default and maybe just specifying an
option when you want to add a comment to that commit. But, by mutating
the temporary commit, wouldn't this mean that you lose the refresh
history?

> Anyway, "freeze" is confusing. Perhaps "snapshot" if anything...

You are right.

--
Catalin
