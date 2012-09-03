From: cmn@elego.de (Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto)
Subject: Re: checkout extra files
Date: Mon, 03 Sep 2012 15:55:41 +0200
Message-ID: <87sjazw6qq.fsf@centaur.cmartin.tk>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:55:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8X80-00031l-9m
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 15:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095Ab2ICNzl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 09:55:41 -0400
Received: from hessy.cmartin.tk ([78.47.67.53]:34562 "EHLO hessy.dwim.me"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1756480Ab2ICNzl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 09:55:41 -0400
Received: from cmartin.tk (p4FC5D726.dip.t-dialin.net [79.197.215.38])
	by hessy.dwim.me (Postfix) with ESMTPA id AA35981C5D;
	Mon,  3 Sep 2012 15:55:37 +0200 (CEST)
Received: (nullmailer pid 5029 invoked by uid 1000);
	Mon, 03 Sep 2012 13:55:42 -0000
In-Reply-To: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
	(Angelo Borsotti's message of "Mon, 3 Sep 2012 15:42:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204694>

Angelo Borsotti <angelo.borsotti@gmail.com> writes:

> Hello,
>
> the man page of git checkout states:
>
> git checkout [-p|--patch] [<tree-ish>] [--] <pathspec>...
>
> It updates the named paths in the working tree from the index file or
> from a named <tree-ish> ...
>
> This means that for each file denoted by pathspec, git tries to
> restore it from the tree-ish.
> However, it seems that git does more than this: it restores also files
> that are not denoted
> by pathspec.
> This sequence of commands shows it:
>
> $ mkdir gittest
> $ cd gittest
> $ git init
> Initialized empty Git repository in d:/gittest/.git/
> $ touch f1
> $ git add f1
> $ git commit commit -m "first commit"
> [master (root-commit) 94d882a] first commit
>  0 files changed
>  create mode 100644 f1
> $ rm f1
> $ git checkout 94d8 -- *
> $ ls
> f1
>
> Note that the work directory is empty when the checkout is done, and
> that the checkout restores f1
> in it, a file that is not denoted by the * pathspec.

The '*' pathspec refers to every file. There are no files in the current
directory, so your shell can't expand the glob and passes it to git,
which then looks and sees that the glob expands to f1 in the given
commit which it then checks out.

   cmn
