From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: git rebase: yet another newbie quest.
Date: Mon, 8 Sep 2014 10:07:58 -0400
Message-ID: <20140908140758.GI1066@thunk.org>
References: <87a96ecqe9.fsf@osv.gnss.ru>
 <20140905154159.GB1510@thunk.org>
 <87sik28bir.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 16:08:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQzc1-0005Bp-2T
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 16:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753848AbaIHOIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 10:08:04 -0400
Received: from imap.thunk.org ([74.207.234.97]:43681 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754032AbaIHOID (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 10:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=E22mXEuieoiVm7IAwiKXYcl3+N5xYLPLeDi8b/plVcs=;
	b=DeMzh0DVrM2fxwF97PF/ZiF+ppErR7qnoWMjIQHM5jwSupu8dUv8Gu7YqrD2V3HvA3KT5d6bWzYK8HJb3pPDYanXZ6fSJ0pSJGbEUPhBfDAO6xumIBUk0qPxiw/+Q8yx7Oe4Gj+x+Kl8M9qNvqHG3wjf4FyPBpbZMTQYDelumks=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1XQzbs-0004Bg-Kl; Mon, 08 Sep 2014 14:08:00 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 2BE1A580506; Mon,  8 Sep 2014 10:07:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87sik28bir.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256649>

On Mon, Sep 08, 2014 at 05:52:44PM +0400, Sergey Organov wrote:
> 
> I didn't intend to make topic branch from the very beginning, and
> already made a commit or two on the remote tracking branch bofore I
> realized I'd better use topic branch. It'd create no problem as far as I
> can see, provided vanilla "git rebase" has "sane" defaults. That said,
> I've already been once pointed to by Junio that my definition of "sane"
> doesn't take into account workflows of others, so now I try to be
> carefull calling vanilla "git rebase" names.

Right, so what I typically in that situation is the following:

<on the master branch>
<hack hack hack>
git commit
<hack hack hack>
git commit
<oops, I should have created a topic branch>
git checkout -b topic-branch
git branch -f master origin/msater

This resets the master branch to only have what is in the upstream
commit.

> Please also notice that I didn't pull immediately after I've re-arranged
> my branches, and this fact only made it more difficult to find and
> isolate the problem.

It's also the case that I rarely will do a "git rebase" without taking
a look at the branches to make sure it will do what I expect.  I'll do
that using either "gitk" or "git lgt", where git lgt is defined in my
.gitconfig as:

[alias]
	lgt = log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit

And typically what I will do is something like this:

gitk -20 master origin/master topic

-or-

git lgt -20 master origin/master topic

The "git lgt" command is very handy when I want to see how the
branches are arranged, and I'm logged remotely over ssh/tmux or some
such, so gitk isn't really available to me.

Cheers,

						- Ted
