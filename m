From: Eric Wong <normalperson@yhbt.net>
Subject: Re: troubles in supersede old development history (git-svn)
Date: Sun, 7 Jan 2007 18:44:28 -0800
Message-ID: <20070108024428.GD10933@localdomain>
References: <7d73e7d80701070129r48dfa3bcq46112dea56962b3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 08 03:44:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3kUz-0002Vj-GI
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 03:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbXAHCoa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 21:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbXAHCoa
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 21:44:30 -0500
Received: from hand.yhbt.net ([66.150.188.102]:34250 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030459AbXAHCoa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 21:44:30 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id A9CDC7DC094;
	Sun,  7 Jan 2007 18:44:28 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 07 Jan 2007 18:44:28 -0800
To: Songmao Tian <kingkongmao@gmail.com>
Content-Disposition: inline
In-Reply-To: <7d73e7d80701070129r48dfa3bcq46112dea56962b3e@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36228>

Songmao Tian <kingkongmao@gmail.com> wrote:
> our trunk's maintainer is lazy in merging branches, I'd like to merge
> the branch kkmao, and now there are so many the conflicts. I want to
> just use my version and overcome all the conflicts.
> 
> i try in this way:
> 
> git-checkout -b trunk remotes/trunk
> git-rebase --merge -s ours remotes/kkmao
> git-svn dcommit -i trunk
> diff-tree 9b75e30191838431810aec4eda98482a8d6935ed~1
> 9b75e30191838431810aec4eda98482a8d6935ed
> Transaction is out of date: Out of date:
> 'trunk/Targets/Bonito/conf/Bonito.lmbox' in transaction '74-3' at
> /home/kkmao/bin/git-svn line 1577
> 
> so what's the solution?

Probably obvious, but is remotes/trunk up-to-date with git-svn fetch?

Next, can you ensure that the tree referenced by
9b75e30191838431810aec4eda98482a8d6935ed~1 (note the ~1) is the same
as remotes/trunk?
(git diff 9b75e30191838431810aec4eda98482a8d6935ed~1 remotes/trunk)

Unfortunately, I'm not familiar with how the 'ours' strategy works with
rebase --merge.  I generally use the default recursive.  Can you look
at the history in gitk to see if the history from refs/remotes/trunk
to refs/heads/trunk is linear?

> and another question. I use normal merge strategy
> git-svn remotes/kkmao
> got some conflicts..
> 
> and one file is missing, i have to git-ls-files -u to see what's beneath.
> git-ls-files -u
> 100644 f7a66ae00d4034ab580e4ee71b0eaccc3a3e44e7 1
> Targets/Bonito/conf/Bonito
> 100644 e6f5d90b30c3ee694acd2199a03e8f34ef1412ac 3
> Targets/Bonito/conf/Bonito
> 
> I have read some doc, but I think I am still not good at resolve conflict:)

Just look at the file in question; edit it and resolve
the conflicts in it and then git commit <conflicted files>

-- 
Eric Wong
