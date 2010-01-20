From: Johan Herland <johan@herland.net>
Subject: Re: git notes: notes
Date: Wed, 20 Jan 2010 11:48:11 +0100
Message-ID: <201001201148.11701.johan@herland.net>
References: <20100120050343.GA12860@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Wed Jan 20 11:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXY6l-0005oe-Qt
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 11:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753122Ab0ATKsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 05:48:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752904Ab0ATKsP
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 05:48:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:57817 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752503Ab0ATKsP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Jan 2010 05:48:15 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWJ00AQPKOC94B0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 20 Jan 2010 11:48:13 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KWJ00MK3KOBJ830@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 20 Jan 2010 11:48:12 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.1.20.103618
User-Agent: KMail/1.12.4 (Linux/2.6.32-ARCH; KDE/4.3.4; x86_64; ; )
In-reply-to: <20100120050343.GA12860@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137541>

On Wednesday 20 January 2010, Joey Hess wrote:
> Just a quick note that the new notes feature can break things that parse
> git log. For example a parser that assumes it can split the log on blank
> lines to separate the header and commit message, can easily become
> confused by the new blank line before "Notes:".

As Thomas already stated, git log is porcelain, and its output format is not 
set in stone. If you need a stable, script-friendly format, you should 
probably use the --format option, or use plumbing instead (such as e.g. git 
rev-list, which also has a --format option).

> Might be worth documenting in release notes, maybe too late now though.
> But really, it's all good, notes are a great feature.
> 
> PS, Has anyone thought about using notes to warn bisect away from
> commits that are known to be unbuildable or otherwise cause bisection
> trouble?

No, I haven't thought of that specific use case. Great idea! :)

BTW, since I started talking about git notes, people on this list have found 
more and more interesting use cases for them:

- Free-form text extension to the commit message

- Help in bug tracking with header-like lines such as:
    - Causes-Bug: #12345
    - Fixes-Bug: #54321

- Store after-the-fact "Acked-By", "Reviewed-By", etc. annotations

- In a repo converted from a merge-unfriendly VCS (such as CVS), use notes
  to identify merges without having to rewrite Git history (note that you
  can also use grafts, or "git replace" to accomplish this).

- Refer to related commits elsewhere in the repo (i.e. relationships that
  are not already apparent from the commit graph)

- When cherry-picking, add a reverse link from the source commit to the
  cherry-picked commit (since it may be of interest to people reviewing the
  source commit

- Rebasing public branches is forbidden, but if you wanted to change that,
  you could potentially help solve it by using notes to add reverse links
  from source commits to rebased commits, so that downstream people could
  more easily traverse your history when rebasing/merging their own
  branches.

- Initially, there were some discussion whether it could also be used to
  guide git blame to make better decisions, although I don't currently see
  how that would be done in practice.

In any case, it seems the notes idea may have the potential to become one of 
the more useful features in Git.


Have fun! :)

...Johan


[1]: ...almost 3 years ago (wow, time flies...):
     http://article.gmane.org/gmane.comp.version-control.git/46883

-- 
Johan Herland, <johan@herland.net>
www.herland.net
