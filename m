From: Stepan Kasal <kasal@ucw.cz>
Subject: Re: A failing attempt to use Git in a centralized environment
Date: Wed, 30 Apr 2014 18:12:15 +0200
Organization: <)><
Message-ID: <20140430161215.GA24017@camelia.ucw.cz>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Wed Apr 30 18:12:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfX7U-0003DI-67
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 18:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422732AbaD3QMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 12:12:20 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:43160 "EHLO
	jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422657AbaD3QMQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 12:12:16 -0400
Received: from 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (84.64.broadband3.iol.cz [85.70.64.84])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	(Authenticated sender: kasal)
	by jabberwock.ucw.cz (Postfix) with ESMTPSA id ACA761C00C6;
	Wed, 30 Apr 2014 18:12:15 +0200 (CEST)
Received: from camelia.ucw.cz (camelia.ucw.cz [127.0.0.1])
	by 49-117-207-85.strcechy.adsl-llu.static.bluetone.cz (8.14.3/8.14.3) with ESMTP id s3UGCFuk024115;
	Wed, 30 Apr 2014 18:12:15 +0200
Received: (from kasal@localhost)
	by camelia.ucw.cz (8.14.3/8.14.3/Submit) id s3UGCFZV024114;
	Wed, 30 Apr 2014 18:12:15 +0200
Content-Disposition: inline
In-Reply-To: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247726>

Hello Marat,

On Mon, Apr 28, 2014 at 10:29:07AM +0400, Marat Radchenko wrote:
> Setup:
> 20 people (programmers, artists, designers) with prior SVN

I was in a similar situation: 10 people, mostly mathematicians,
previous experience with Tortoise SVN.

I wanted to move to Git with centralized model.  I call it a success:
people can do basic changes on master and also can work with
branches, if they don't want to break master.  (Much better than
keeping uncommitted changes at a svn checkout.)

I avoided TortoiseGit because I thought it would make the switch more
complicated: Git does differ from SVN, and it cannot be hidden.

We use Git Extensions (Windows only frontend).
I like it, as it is very close to command-line, so it is easy for me
to provide support.  It also improves the dialogs by hiding all the
advanced options; you have to click on "advanced" to get the full
list.

When working on master, pull --rebase is a necessity:
The install procedure does set config
  branch.autosetuprebase = always
(Must be done before any clone, so that all branches created after
that are set up to rebase, rtfm...)

I also told people to check "Rebase" in the pull dialog (it is
persistent then).

And I provided snapshots, so they immediatly call for help if they
see non-linear history.

> Problem #4: when conflict happens during rebase, mergetool shows
> user own changes as "theirs" and remote changes as "mine". And
> believe me, explaining this to users doesn't increase their
> willingness to adopt Git.

Our mergetool is Kdiff3.  (Git Extensions are willing to install it;
we did that separately to get a newer 64bit version.)
Kdiff3 shows three columns; their names (BASE, LOCAL, etc.) are
confusiong, but in our case it was easy to ignore them; we had no
previous experience with merge conflicts resolving.

> Problem #6: push - reject - pull - push sequence sometimes
> transforms into a loop with several iterations and doesn't add
> happiness.

I told people to do "pull-push" always when they want to push.
If the pull has conflicts, then they naturally do "pull-push" again
after the conflicts are resolved.

Git Extensions has its problems, you may look at the issue tracker;
I created several reports when exploring it (login kasal).

I would mention:
https://github.com/gitextensions/gitextensions/issues/2241

If you pull on a non-tracking branch, it creates a false
origin/branchname from origin/HEAD.  The bug was fixed, but there was
no release since then: so you have to live with it or you have to
build Git Extensions yourself in Visual Studio.

I had to write this in haste; hope this helps you anyway.

Stepan
