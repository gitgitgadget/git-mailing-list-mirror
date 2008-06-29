From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb/gitk: empty merge diffs
Date: Sun, 29 Jun 2008 10:21:37 -0700 (PDT)
Message-ID: <m34p7ci2ch.fsf@localhost.localdomain>
References: <4867B105.7070208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 19:22:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD0bv-0002SZ-MD
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 19:22:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941AbYF2RVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 13:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753926AbYF2RVl
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 13:21:41 -0400
Received: from qb-out-0506.google.com ([72.14.204.235]:63347 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753904AbYF2RVk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 13:21:40 -0400
Received: by qb-out-0506.google.com with SMTP id d8so2968233qbc.37
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=PoStj6oY26Dgl8U+ZOYN1ndXOAOKkzx5bs8LD7cu4UY=;
        b=mikID3d+/PSHv+U5lNGIKtLFhxrTCaTkhiVVFijCADfF84WdYImUhUHnY64prF7BhG
         JspmZJRk0yF1Nx5H4h5wnLlHYWxoq49nYIdXnHBgp/kUpAgHYVFYVr4O2w+jpb5tsZ2/
         BC4WBWAU2iIlchBw+OlhBa4ltuNFAtfpkdUFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Bhnp1lpt4RWpHqL3xE+umqpUIc+TimSAMtGYRyXehH8ddVuzODtX7NDw3mQQqXIHMp
         fXFop2U7Ie4i5FBwjtLbNgesLb9NMnsZBpDegX1L9PJfJs+9o1XhMBd8BxzP8Up1cRwl
         VNp/EWdHQOf5SgiFte8PjyFxBFGCo8Y/KCAkY=
Received: by 10.67.102.6 with SMTP id e6mr3276899ugm.82.1214760098897;
        Sun, 29 Jun 2008 10:21:38 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.210])
        by mx.google.com with ESMTPS id y1sm938477uge.10.2008.06.29.10.21.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 10:21:37 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5THLaKQ012656;
	Sun, 29 Jun 2008 19:21:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5THLYwA012652;
	Sun, 29 Jun 2008 19:21:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4867B105.7070208@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86813>

Lea Wiemann <lewiemann@gmail.com> writes:

> I'm trying to get the diff of a merge ("git diff master^1 master")
> with gitk and gitweb, but both of them only show empty diffs (you can
> try yourself using the test script below).

Note that if you are handcrafting gitweb URL, gitweb does not allow
"master^1" as value of 'hp' ($hash_parent) parameter due to overly
strict validation (checking) of this parameter: only values suitable
as refnames, or (shortened) SHA-1 identifiers are accepted.

> Gitk doesn't seem to allow me to view the merge diff at all.
> 
> Gitweb only shows "Trivial merge" in the commitdiff view.  

Because it _is_ trivial (tree level) merge, see documentation of diff
format for merges in git-diff(1) or Documentation/diff-format.txt:

  Note that 'combined diff' lists only files which were modified from
  all parents.

If combined diff raw (difftree) format lists nothing, gitweb denotes
this as "Trivial merge".

> In the commit view, I can get the merge diff I want by clicking the
> "diff" link behind the first parent.

You can also click on the "commitdiff" link in the navbar (at top of
the page), or you can click on commit title to switch between 'commit'
and 'commitdiff' views.
 
> Why is this a "trivial merge", and what's the reason for gitweb not
> displaying the diff to the first parent in the commitdiff view?  I'm
> kinda confused here.

Lets take git.git repository as an example.  Gitweb can display both
combined diff output for merge commit, and compact combined (--cc)
output (default); if you however provide both parents it would always
display ordinary diff.  The "diff" links in the 'commit' view you have
mentioned, and "1"/"2"/... links in treediff part of combined merge
output in 'commitdiff' view, always display ordinary diff.

Default compact combined diff of a merge commit (c.f. "git show pu")
  http://repo.or.cz/w/git.git?a=commitdiff;h=58829d79 ('pu' branch)

Diff to first parent (c.f. "git diff pu^1 pu")
  http://repo.or.cz/w/git.git?a=commitdiff;h=58829d79;hp=c944eebd

Diff to second parent (c.f. "git diff pu^2 pu")
Warning: large diff, and it takes some time to be displayed!
  http://repo.or.cz/w/git.git?a=commitdiff;h=58829d79;hp=f1646543

> ===== Graph: =====
> 
> *   master      merge mybranch into master
> |\
> | * mybranch    change file2 on mybranch
> | * mybranch~1  change file2 on mybranch
> * | master~1    change file1 on master
> * | master~2    change file1 on master
> |/
> * mybranch~2    initial commit
> 
> 
> ===== Script to set up the repository: =====

Well, you can display diff to first parent in gitweb, see

  http://localhost/gitweb.cgi/test-repo.git?a=commitdiff;h=36c2b5d0;hp=62868699

-- 
Jakub Narebski
Poland
ShadeHawk on #git
