From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git svn with non-standard svn layout
Date: Sun, 11 Oct 2009 00:09:37 -0700
Message-ID: <20091011070937.GC16264@dcvr.yhbt.net>
References: <loom.20091010T001433-536@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Fabian Molder <fm122@arcor.de>
X-From: git-owner@vger.kernel.org Sun Oct 11 09:11:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwsaZ-0003Ct-DP
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 09:11:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbZJKHKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 03:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbZJKHKQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 03:10:16 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:46636 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751277AbZJKHKP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 03:10:15 -0400
Received: from localhost (user-118bg0q.cable.mindspring.com [66.133.192.26])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 75E9B1F78E;
	Sun, 11 Oct 2009 07:09:38 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20091010T001433-536@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129905>

Fabian Molder <fm122@arcor.de> wrote:
> Hello,
> 
> - want to use git inside an huge SVN project
>  --> so git-svn could do the job ..
> 
> 
> - I struggle with two things:
>    A) - the SVN project has an non-standard layout
>    B) - want to have (several) git's for just the (few) peaces I work on
> 
> for A)
> ======
> - svn layout looks like this (simplified):
>   - trunk  (not really used, all interesting work in branches)
>   - branches
>     - r1.2
>      - development
>      - integration
>     - r1.3
>      - development
>      - integration
>     ...
> 
> - inside development and integration is:
>        - xapplication1
>        - xapplication2
>        - xapplication3
>        ...
>        - aa
>         -bb
>          -cc
>           - zapplication1
>           - zapplication2
>           - zapplication3
>           ...
> 
> - I created an simplified svn test (from scratch; import/repo/workdir) 
>   via this bash-script:   http://pastebin.ca/1608231
> 
> for B)
> ======
> - the svn repo is very huge, but I'm only interested in these dirs:
>          xapplication2/
>          aa/bb/cc/zapplication1
> - my objectives: 
>    - have several local git's, just the ones I need:
>      --> xapplication2/.git
>      --> aa/bb/cc/zapplication1/.git

Hi Fabian,

Since you don't want to track the entire repo and these seem like
unrelated (history-wise) trees, you probably want the simplest cases:

  git svn clone svn://example.com/path/to/xapplication2
  git svn clone svn://example.com/path/to/aa/bb/cc/xapplication1

These commands are like doing the following with plain old svn:

  svn co svn://example.com/path/to/xapplication2
  svn co svn://example.com/path/to/aa/bb/cc/xapplication1

> I tried to use "git config svn-remote.svn.branches" to do this,
>  please see in function "do_git_svn" in bash-script - but no success

svn-remote.svn.branches and tags are really only for repos with
standard layouts.

-- 
Eric Wong
