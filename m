From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: About detached heads
Date: Fri, 14 Mar 2008 03:52:14 -0700 (PDT)
Message-ID: <m3lk4ly3vy.fsf@localhost.localdomain>
References: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Fri Mar 14 11:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ja7Wz-0003M0-9m
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 11:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752485AbYCNKwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 06:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752227AbYCNKwS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 06:52:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:41694 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbYCNKwR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 06:52:17 -0400
Received: by ug-out-1314.google.com with SMTP id z38so44575ugc.16
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 03:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=rytSErszmAax0L28xZiKDq35H9wEni+RBvnA/AUrmKY=;
        b=eqK3u/9kxSdzFMueaBJRIHYnmsqvZL2O1jAo8MvLrM3dQsRaqAcYhQcHcx9F/vwR+/U1bifKF+Ac7BNj4nBHcWrd5rOz5EsmNNRfRl1o70ZiKTZdnO24FrP3ZUo7EXomQt7TLmTc2ubAhOjKWRa9QvDKbDno4+qQzs74BOHIzsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=TFa+0CGTcWJeXt9WI1B/UqkW2r9y29Xb2BUCJg6Vteu5X2ilvOl5EUBimQlp3oaRp+jIXp97l0T7SIbLYrAPdz9D6a85dOM9ggKaGwv9Wq2vCUpjV3HLnSQw+X0crh+zYEZLZw/gooxd56DgvmcaB08FHydcobDQikk4UDoUKTg=
Received: by 10.67.115.10 with SMTP id s10mr253881ugm.89.1205491935831;
        Fri, 14 Mar 2008 03:52:15 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.191.199])
        by mx.google.com with ESMTPS id l20sm331717uga.62.2008.03.14.03.52.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Mar 2008 03:52:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m2EAq3bf025074;
	Fri, 14 Mar 2008 11:52:04 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m2EAq1ob025070;
	Fri, 14 Mar 2008 11:52:01 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <93c3eada0803140246k53408c74m21f9dc277857202d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77205>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> This should be simple! I have a series of commits:
> 
>            1---2---3---4---5
> 
> I want to go back to 3 but not branch, so I want
> 
>            1---2---3---4---5---3
> 
> ?
> 
>          git checkout 3...
> 
> gets me the commit on a detached head, but I don't know how to put this back
> as the HEAD.

Lets check what git does in each of scenarios. Let's assume that
current branch is named 'master'.

At beginning we have:

   1---2---3---4---5    <--- master <--- HEAD

HEAD contents is "ref: refs/heads/master"

1. Now, "git checkout 3...", which is equivalent to "git checkout 3",
detaches HEAD because commit '3' is not a head (is not a branch), so
we have:

   1---2---3---4---5    <--- master
           ^
            \ 
             \-------------- HEAD

HEAD contents is "<sha1 of 3>"


2. If we did "git reset --hard 3" we would rewind the history,
resulting in the following situation:

   1---2---3           <--- master <--- HEAD
            \           
             \-4---5   <... master@{1}, ORIG_HEAD, HEAD@{1}
              
and now commits 4 and 5 are referenced only by reflogs, and by the
(temporary) "last position of HEAD" reference named ORIG_HEAD.


3. Now, if you have published 1..5 history you would not want
(usually) to rewind published branch. If you do the following:

  $ git revert --no-commit 5
  $ git revert 4

you would get the following:

   1---2---3---4---5---(5^-1 4^-1 => 3)  <--- master <--- HEAD

git-revert applies reversal of changes in given commit, in the 
"patch -R" ("patch --reverse") sense. Using '--no-commit' option
allows to squash reverting two commits into one commit. The ordering
of reverting ensures that there are no merge conflicts.


4. Or you can just put the _contents_ of revision 3 into your working
tree, either using plumbing command git-read-tree, or by checking out
or resetting to top tree: "git checkout 3^{tree}", or 
"git checkout 3 -- .", or equivalent git-reset invocation.

This way you would get exactly

   1---2---3---4---5---3   <--- master <--- HEAD

but the relation of 5---3 parentage is unclear: you would have to
explain it in the commit mesage.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
