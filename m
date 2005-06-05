From: "Tommy M. McGuire" <mcguire@crsr.net>
Subject: Re: cg-init bug -- identified
Date: Sun, 5 Jun 2005 13:43:41 -0500
Message-ID: <20050605184341.GA21345@immutable.crsr.net>
References: <20050605153053.GA6890@tumblerings.org> <20050605172854.GF17462@pasky.ji.cz> <20050605175634.GB6890@tumblerings.org> <20050605181042.GH17462@pasky.ji.cz> <20050605182912.GC6890@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 20:40:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Df03E-0002Gv-5m
	for gcvg-git@gmane.org; Sun, 05 Jun 2005 20:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbVFESoR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Jun 2005 14:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261604AbVFESoR
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Jun 2005 14:44:17 -0400
Received: from [65.98.21.155] ([65.98.21.155]:49674 "EHLO immutable.crsr.net")
	by vger.kernel.org with ESMTP id S261603AbVFESoN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2005 14:44:13 -0400
Received: from mcguire by immutable.crsr.net with local (Exim 3.35 #1 (Debian))
	id 1Df062-0005aT-00; Sun, 05 Jun 2005 13:43:42 -0500
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050605182912.GC6890@tumblerings.org>
User-Agent: Mutt/1.3.28i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 05, 2005 at 11:29:12AM -0700, Zack Brown wrote:
> It turned out one of my files had a "'" in the name, i.e.:

Now this is a neat one.

[mcguire@immobile cgtest]$ sh -x cg-init
[... Normal behavior ...]
+ touch .git/refs/heads/master
+ '[' '' ']'
+ git-read-tree
+ find bar baz foo 'foo'\''prime' '(' -type f -o -type l ')' -print0
+ xargs -0r cg-add
Adding file bar
Adding file baz/1
Adding file baz/0
Adding file foo
Adding file foo'prime
xargs: unmatched single quote
+ cg-commit -C '-mInitial commit' -E

The error is the second-to-last line.  It partially succeeded originally
because xargs broke off and handled parts of the input before reaching 
the single quote.

[By the way, hello!  I've just recently started climbing the git
learning curve, and it's nice to see something I recognize. :-)]

-- 
Tommy McGuire
