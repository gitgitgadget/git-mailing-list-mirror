From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: more support for PATH_INFO based URLs
Date: Sun, 17 Sep 2006 16:20:23 +0200
Organization: At home
Message-ID: <eejlht$870$1@sea.gmane.org>
References: <20060916210832.GV17042@admingilde.org> <eejhtr$paa$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sun Sep 17 16:20:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOxVF-00048c-E2
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 16:20:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbWIQOUA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 10:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWIQOUA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 10:20:00 -0400
Received: from main.gmane.org ([80.91.229.2]:394 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932213AbWIQOT7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Sep 2006 10:19:59 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GOxUu-00044c-3n
	for git@vger.kernel.org; Sun, 17 Sep 2006 16:19:52 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 16:19:52 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 17 Sep 2006 16:19:52 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27194>

matled (Matthias Lederhofer) on #git proposed to use ':' as a separator
between branch and filename (as branch doesn't need to be flat, 
e.g. "jc/diff" like branch name), because valid branch name cannot contain
':' (and this limit is only for branch name).

He also said that filename doesn't need to be necessary file (which would be
then present in "blob_plain" view), but it can be also a directory (which
then would be present in "tree" view). We can either check type using
git-cat-file -t via git_get_type subroutine, or assume that if we want for
directory to be shown, it should end with "/".

Let's assume for simplicity that empty branch name equals to HEAD branch,
and empty filename equals to top (root) directory of project.

So we would have the following types of path based URLs:

* project              overview (summary) page of project
* project/branch       shortlog of branch
* project/branch:file  file in branch, blob_plain view
* project/branch:dir/  directory listing of dir in branch, tree view

Possible shortcuts:
* project/branch:      directory listing of branch, main tree view
* project/:file        file in HEAD (raw)
* project/:dir/        directory listing of dir in HEAD
* project/:            directory listing of project's HEAD
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
