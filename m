From: Kalle Olavi Niemitalo <kon@iki.fi>
Subject: [DOC BUG] branch.autosetupmerge defaults to true, not false
Date: Mon, 11 Feb 2008 10:46:58 +0200
Message-ID: <87bq6nc22l.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 11 09:46:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOUJV-0004s1-G5
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 09:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752185AbYBKIqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 03:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752149AbYBKIqV
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 03:46:21 -0500
Received: from 82-128-242-48-Rajakyla-TR1.suomi.net ([82.128.242.48]:37233
	"EHLO Astalo.kon.iki.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751802AbYBKIqU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 03:46:20 -0500
Received: from Kalle by Astalo.kon.iki.fi with local (Exim 4.52)
	id 1JOUJW-00018D-DP
	for git@vger.kernel.org; Mon, 11 Feb 2008 10:46:58 +0200
User-Agent: Gnus/5.110007 (No Gnus v0.7) Emacs/22.0.51 (gnu/linux)
X-Accept-Language: fi;q=1.0, en;q=0.9, sv;q=0.5, de;q=0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73484>

In Git v1.5.4.1, Documentation/config.txt describes:

> branch.autosetupmerge::
>         Tells `git-branch` and `git-checkout` to setup new branches
>         so that linkgit:git-pull[1] will appropriately merge from that
>         remote branch.  Note that even if this option is not set,
>         this behavior can be chosen per-branch using the `--track`
>         and `--no-track` options.  This option defaults to false.

However, in builtin-branch.c:

> static int branch_track = 1;
...
>         if (!strcmp(var, "branch.autosetupmerge"))
>                         branch_track = git_config_bool(var, value);

So if the option is not listed in .git/config, then it actually
defaults to true.  A demonstration with a bit older version:

$ git --version
git version 1.5.4.rc3
$ git config --unset branch.autosetupmerge
$ git branch demo elinks.cz/master
Branch demo set up to track remote branch refs/remotes/elinks.cz/master.
$ 
