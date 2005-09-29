From: Robert Watson <robert.oo.watson@gmail.com>
Subject: Re: [PATCH] Fix git-pull output message
Date: Thu, 29 Sep 2005 09:48:56 +0100
Message-ID: <72499e3b05092901484731450a@mail.gmail.com>
References: <72499e3b05092803027175bab0@mail.gmail.com>
	 <Pine.LNX.4.58.0509280823260.3308@g5.osdl.org>
Reply-To: Robert Watson <robert.oo.watson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Sep 29 10:50:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKu68-0001ni-7V
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 10:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVI2Is5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 04:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbVI2Is5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 04:48:57 -0400
Received: from qproxy.gmail.com ([72.14.204.192]:7961 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751197AbVI2Is5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 04:48:57 -0400
Received: by qproxy.gmail.com with SMTP id c12so474348qbc
        for <git@vger.kernel.org>; Thu, 29 Sep 2005 01:48:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EDJytEbHyv2D6pbYAVnWPWn24ClYEZhOlvUfQm2HUs9vMmp4UJjWXhNLmzkJqxH6catm5c7hw1qgR4vO+3q1hRnciojyPzusO5zgqfunG7rTzy56HvZRlBv+HGywB7vkCs7JSu5ypw/lsQ0yMc+X2hoHcMtcmaTzrXOwJQ/tnT8=
Received: by 10.64.204.1 with SMTP id b1mr222426qbg;
        Thu, 29 Sep 2005 01:48:56 -0700 (PDT)
Received: by 10.64.203.14 with HTTP; Thu, 29 Sep 2005 01:48:56 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509280823260.3308@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9478>

On 9/28/05, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Wed, 28 Sep 2005, Robert Watson wrote:
> >
> > Notice that the git.git directory is truncated.  It seems the
> > intension is to truncate at the .git
> > directory level.  The following patch fixes it.
>
> No, the intention really is to remove the ".git" at the end. At least
> that's how I use it.
>
> I like seeing my merges say
>
>     Merge branch 'for-linus' from master.kernel.org:/pub/scm/linux/kernel/git/roland/infiniband
>
> even though the _real_ directory was ".../infiniband.git/", simply because
> the ".git" doesn't really add any extra information when you're already in
> git.
>
> _outside_ of git, the ".git" tells you something: it tells you that you're
> entering a git archive. But when merging in git, that part is kind of
> taken for granted, isn't it?
>
> This also matches what "git-receive-pack" and "git-upload-pack" does:
>
>         ...
>         /* chdir to the directory. If that fails, try appending ".git" */
>         if (chdir(dir) < 0) {
>                 if (chdir(mkpath("%s.git", dir)) < 0)
>                         die("unable to cd to %s", dir);
>         }
>
>         /* If we have a ".git" directory, chdir to it */
>         chdir(".git");
>         ...
>
> Note how it _both_ will append ".git" to the directory name (if it can't
> find one without ".git" _and_ will try to chdir to a ".git" directory
> _within_ the directory name.
>
> So if you use the native pack ssh interfaces, you really can say
>
>         git pull master.kernel.org:.../infiniband
>
> because the tools (well, the "native pack" ones - not the http/rsync/scp
> ones) will automatically DTRT.
>
>                 Linus
>

Now, I understand it.  Thanks Linus and Junio.

Robertoo
