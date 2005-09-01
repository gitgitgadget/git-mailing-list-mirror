From: Junio C Hamano <junkio@cox.net>
Subject: What's in git.git today.
Date: Wed, 31 Aug 2005 18:20:23 -0700
Message-ID: <7vhdd560tk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 01 03:21:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EAdkj-0002YD-2W
	for gcvg-git@gmane.org; Thu, 01 Sep 2005 03:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVIABUZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Aug 2005 21:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVIABUZ
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Aug 2005 21:20:25 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23459 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S965017AbVIABUZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2005 21:20:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050901012025.YBGQ18319.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 31 Aug 2005 21:20:25 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7986>

I've been doing some clean-ups, mostly in the documentation
area.  The tutorial reachable from the main gitweb page should
look a lot nicer and use glossary words more consistently then
before.  I think its 'Packing your repository' section should be
replaced with more general 'Feeding and caring for your
repository' section, that talks not just about packing, but the
general repository organization issues like:

 - Public (naked) repository vs working tree repository.
 - What each hook is for.
 - Why pack?  When to pack?
 - Why prune?  When to prune?
 - Should I use objects/info/alternates?
 - Transport specific hints:
   - For dumb transports, update-server-info is a must.
   - For git: transport, 'git-daemon-export-ok' is needed.
   - Git-native transport is inefficient when bootstrapping.

But other than that I consider the tutorial in a pretty good
shape.

... and that can only mean one thing.  I want to really start
1.0pre, but I'd settle for 0.99.6 for now.

By the way.  A couple of people privately asked me what the
extra "branch" `todo` is doing in the git.git repository.

That "branch" does not share any tree namespace with the real
git source.  Its tree has only one blob, TODO, and keeps my
notes on the current progress.  So you should *not* do this:

    $ git clone kernel.org/pub/scm/git/git.git/
    $ git pull . todo

You would end up merging completely different things together if
you did so.

There is another mystery branch called "dbrt-test"; I'll blow it
away after we are done with the read-tree change Daniel is
working on.  The changed read-tree code looks much cleaner and I
like the general direction it is going, but there are some
debugging ahead of us.  That mystery branch holds standalone
test suite that is supposed to be extracted in a repository
independent from the main git repository, so please do not merge
from it, either.
