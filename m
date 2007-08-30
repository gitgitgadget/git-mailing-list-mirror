From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: gitweb and remote branches
Date: Thu, 30 Aug 2007 11:09:05 +0200
Message-ID: <cb7bb73a0708300209g564284f8w900db693485acdb7@mail.gmail.com>
References: <favitd$3ff$1@sea.gmane.org> <200708300001.39203.jnareb@gmail.com>
	 <cb7bb73a0708300018u37f5c465u5d87eae0eb23543c@mail.gmail.com>
	 <200708301016.17552.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 11:09:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQg1b-0003mI-OS
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 11:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756376AbXH3JJK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 05:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbXH3JJJ
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 05:09:09 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:54163 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755795AbXH3JJI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 05:09:08 -0400
Received: by py-out-1112.google.com with SMTP id u77so2750070pyb
        for <git@vger.kernel.org>; Thu, 30 Aug 2007 02:09:07 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MmE5cqF0PmPvUBNu4e+wDo7oNsRKPqLWlDkOqF6xtDzBOmOMsO7qwBdbnlu/qNtKXfWuXLSNLNC2cO3nddOjTCwwoYIMKkREcXuNKtTP/69YpdY2EXsSctfZmCm1A+9202Or/hlLg18xri7OVBeM07rN7JOBAP7azsN1w4W2pXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tzTTnZCuJMGG6I3NGR/1U0KZTmvrfSxmGdULrjEXiPzThsMkeidHq89scyWeAVjd085JGg//oUFLYIrA10fqROaoITBgtRja0gu5viXv5qeQDzhT/brfwgAvnNqsZQyXcTV+NfC5QYkZ8AD0rCFFfJNH4GrzjBeBfrpdGE11JNE=
Received: by 10.35.44.16 with SMTP id w16mr406411pyj.1188464945488;
        Thu, 30 Aug 2007 02:09:05 -0700 (PDT)
Received: by 10.35.43.11 with HTTP; Thu, 30 Aug 2007 02:09:05 -0700 (PDT)
In-Reply-To: <200708301016.17552.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57014>

On 8/30/07, Jakub Narebski <jnareb@gmail.com> wrote:
> On Thu, 30 August 2007, Giuseppe Bilotta wrote:
> > What I had in mind was a way to modify 'heads' view with a boolean
> > option that enable/disabled remotes view.
>
> That is a good idea. We can for example use extra_options ('opt')
> parameter to pass 'refs/remotes' etc. to 'heads' view. Or we can
> use some new CGI parameter. Or just make it configurable in gitweb
> configuration, with per repository override, i.e. make it into
> %feature.

For the time being I've made it into a project-overridable %feature.
(It was easier to set up than I though.) I do like the idea of having
it also as an additional CGI parameter.

> > For their visualizations, I
> > had in mind a split 'heads' secion, with the lhs being as it is now,
> > and the rhs having the remotes.
>
> Care to provide some ascii-art mockup?

(monospace view)

[heads]                | [remotes]
date headname links    | date headname links
date headname links    | date headname links

or a variation thereof. However, I have a 1600x1200 screen so not
everybody might be confortable with such a view.

> What I had in mind was for 'summary' view (*bold*, _underline_):
>
>   [heads]
>   27 min ago       _gitweb-allheads_   shortlog | log | tree
>   24 hours ago     master              shortlog | log | tree
>
>   [remotes]
>   *origin*
>     24 hours ago    man        shortlog | log | tree
>     24 hours ago    html       shortlog | log | tree
>     24 hours ago    next       shortlog | log | tree
>     24 hours ago    pu         shortlog | log | tree
>     24 hours ago    _master_   shortlog | log | tree
>     2 weeks ago     maint      shortlog | log | tree
>     2 weeks ago     todo       shortlog | log | tree
>
> and similarly for 'remotes' view (or 'heads').

I think I like yours better. I had just implemented split
remotes/heads list in summary view, so I'll keep working towards your
idea.

> Note that we remove remote name from remote branch name, although
> we can leave it as is (i.e. origin/man vs. man),

Yes, I'll work on this next.

> and that we filter
> out HEAD if it points to existing branch, marking one of the branches
> as current instead.

I don't know if I'll be able to implement this, but I'll try :)

> > However, I wasn't sure if such a view would have been appreciated, so
> > I went for the merged view and used the spans to make the heads appear
> > as they do in the shortlog, as a clear way to mark which ones were
> > local and which ones were remote.
>
> On
>
>   http://oblomov.dnsalias.org/git?p=git.git;a=heads
>
> I don't see any difference between formatting of remote heads and local
> branches.

Indeed, I removed the thing when I started working on the repo.

> > However, it's even harder if you consider
> > that even the latest git-svn plops all the svn-converted refs straight
> > into refs/remotes and not in a subdir such as refs/remotes/svn.
>
> Or refs/svn. I think that dumping remotes directly into refs/remotes
> and not to refs/remotes/<remote> is a bug (also in git-svn).

I think so too. I'll report it as a bug to the git-svn developers.

> > I'll be working on it here
> >
> > http://oblomov.dnsalias.org/git?p=git.git;a=shortlog;h=gitweb-allheads
> >
> > and keep you posted on my progress.
>
> You can also make a git fork at http://repo.or.cz

Oh, interesting. Just clicking on the 'fork' link in
http://repo.or.cz/w/git/gitweb.git and filling up the form?

I'll set that up as a mirror shortly.


-- 
Giuseppe "Oblomov" Bilotta
