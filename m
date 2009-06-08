From: Johan Herland <johan@herland.net>
Subject: Re: Merge into locally modified files?
Date: Tue, 09 Jun 2009 00:36:43 +0200
Message-ID: <200906090036.43492.johan@herland.net>
References: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
 <200906082022.09936.johan@herland.net>
 <2729632a0906081214q43e45ce7p812bd02f34934691@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 09 00:37:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDnSb-0004Kj-Aw
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 00:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755732AbZFHWgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 18:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbZFHWgr
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 18:36:47 -0400
Received: from mx.getmail.no ([84.208.15.66]:47527 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755442AbZFHWgr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 18:36:47 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKX00KXVYT9ZM90@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Jun 2009 00:36:45 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KKX006AXYT89NF0@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Jun 2009 00:36:45 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.6.8.222228
User-Agent: KMail/1.11.4 (Linux/2.6.29-ARCH; KDE/4.2.4; x86_64; ; )
In-reply-to: <2729632a0906081214q43e45ce7p812bd02f34934691@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121124>

On Monday 08 June 2009, skillzero@gmail.com wrote:
> On Mon, Jun 8, 2009 at 11:22 AM, Johan Herland <johan@herland.net> wrote:
> > Git, instead encourages you to commit your changes _first_
> > (aka. "commit-before-merge"), so that your changes are not necessarily
> > affected by the updated changes from the server.
>
> The problem I have with this is that it's a lot of extra work to
> commit, pull (which will create a merge commit), then back out the
> merge commit git pull did, back out my local commit, then re-apply my
> local changes.

I never suggested you do something convoluted like that. What I suggested 
was:

1. "git commit" your local changes
2. "git pull --rebase"

After this, your local changes will be on top of the pulled changes. (Then 
you can put them on a separate branch, if you're paranoid about accidentally 
pushing them to the server.)

> I typically always have some modified files in my tree
> for little things I may never want to commit. I'll tweak some build
> Makefile build setting (e.g. enable extra logging, some debug printfs,
> etc.). These changes are very transient. We tend to pull in changes
> several times a day as people change stuff.

Yes, and that's why I suggest you keep your debug stuff on a separate 
branch, so that it's easily separated from the mainline development.

> It looks like I can use git stash to help here. If I do 'git stash &&
> git pull && git stash pop', it seemed to work in a simple example.

Yes, that's another way of doing it; possibly better than my suggestion.

> If I had no changes, I'd need to be careful to not try to do a git stash
> pop since it would haven't stashed anything.

If this is the only thing you use 'git stash' for, you could start off with 
a 'git stash clear'. That way, there would be nothing to 'pop' if there was 
nothing to 'stash'.

> Is this something that would be pretty easy to add to git pull (or I
> guess really to git merge since pull is just fetch+merge)? Maybe
> something like a 'git pull --rebase-local'? If I wanted to add
> something like this, should I just start by looking at git stash and
> see how it does it and try to integrate support for that into git
> merge (and make sure git pull will pass that option through to git
> merge)? Conceptually, it seems easy, but I don't know how hard it
> would be to get it into the code.

Feel free to whip up a patch. I can't say whether it'll be accepted or not.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
