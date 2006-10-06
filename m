From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Do not print "log" and "shortlog" redundantly in commit view
Date: Fri, 06 Oct 2006 09:44:29 +0200
Organization: At home
Message-ID: <eg51fi$7rs$2@sea.gmane.org>
References: <20061005192257.50209.qmail@web31809.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Oct 06 09:45:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVkO7-0006el-R5
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 09:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWJFHov (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 03:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWJFHov
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 03:44:51 -0400
Received: from main.gmane.org ([80.91.229.2]:22434 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750722AbWJFHou (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 03:44:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GVkNb-0006TY-LN
	for git@vger.kernel.org; Fri, 06 Oct 2006 09:44:23 +0200
Received: from host-81-190-18-48.torun.mm.pl ([81.190.18.48])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 09:44:23 +0200
Received: from jnareb by host-81-190-18-48.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 06 Oct 2006 09:44:23 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-18-48.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28390>

Luben Tuikov wrote:

> Do not print "log" and "shortlog" redundantly in commit
> view.  This is passed into the $extra argument of
> git_print_page_nav from git_commit, but git_print_page_nav
> prints "log" and "shortlog" already with the same head.
> 
> Noticed by Junio.
> 
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>

Gaah, the whole cae1862a3b55b487731e9857f2213ac59d5646d commit
"gitweb: More per-view navigation bar links" is somewhat broken.
Up to this point we used top navigation bar for commit (hash base)
or whole project related links, while bottom part of navigation
bar for "formats" i.e. links related to current view (passing hash)
or for pagination.

So while "snapshot" link has it's place in top navigation bar
(but by modyfying git_print_page_nav subroutine, not by adding it
by hand), "history" for example IMHO doesn't; history link should be
present in the bottom part of navigation bar. Perhaps we could
reuse git_print_page_nav for formats, for example blob wiew would have
        blob | _blame_ | _history_ | _raw_ | _HEAD_
while tree view would have
        tree | _snapshot_ | _history_ | _HEAD_
(where _text_ indices link).  Perhaps _snapshot_ in tree view
shouldn't be repeated, although top one might mean snapshot of commitish,
bottom one snapshot of tree.
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
