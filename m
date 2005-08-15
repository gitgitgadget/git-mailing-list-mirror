From: Carl Baldwin <cnb@fc.hp.com>
Subject: Making note, in the repository, of push/pull relationships
Date: Mon, 15 Aug 2005 10:25:19 -0600
Organization: Hewlett Packard
Message-ID: <20050815162519.GB9719@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Mon Aug 15 18:28:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4hn0-00072j-Ud
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 18:26:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVHOQZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 12:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964824AbVHOQZf
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 12:25:35 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:48844 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S964821AbVHOQZU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 12:25:20 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel8.hp.com (Postfix) with ESMTP id 705621A8E
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 12:25:19 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP id 2477B41F5C6
	for <git@vger.kernel.org>; Mon, 15 Aug 2005 16:25:19 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 18EE72AF18; Mon, 15 Aug 2005 10:25:19 -0600 (MDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

(Sorry for the repost.  The other one was an accident.)

Over the week-end, I was thinking about the thread "Re: How is working
on arbitrary remote heads supposed to work in Cogito".  I wanted to
weigh in an opinion that I've developed on it but thought it deserved a
new thread.

Somewhere in the thread something was mentioned about maintaining
<local branch>:<remote branch> pairs in the git repository when pushes
and pulls are performed.  I think the argument was actually against
keeping this information and ultimately against allowing pushes to a
branch of a different name.

I wanted to weigh in with why it would be a good idea to make note of
this information.  The only thing that would be required of the plumbing
is to specify how this information is kept and if a push or pull is
performed directly with git then make note of the push/pull
relationship.  Everything else would be up to the porcelains.

So, I envision a simple directed graph where nodes represent the
branches (wether local or remote) and the edges represent push or pull
relationships between branches.

Git already stores the nodes.

The edges, in theory, would spring into existence when a push or pull is
performed between two branches for the first time.

This graph will be extremely useful for manageing flow in a project.  It
could enable something as simple as a script that would walk the edges
and tell which ones have fallen behind.  It would also be possible to
easily pull up a visual representation of the graph (with graphviz,
maybe).  This sort of thing might prove to be a valuable orientation
tool for the developer or project manager.

It could also enable some very powerful project flow management --- in a
porcelain of course --- that would manage flow from an engineer's own
sand-box through software engineering 'gates' such as integration,
quality assurance, product maintenance and the documentation and
sign-offs required to pass through each of these gates.

It could also be used to aid in documenting and managing the, already
existent, linux tree development flow in whatever way suits.

This is a big return on investment.  Little would be required of the
plumbing to maintain these 'edges', just add to them when it performs a
push/pull on an edge that hasn't already been recorded.  Any changes or
deletions could be handled by the user or by some porcelain.

I think it is important, though, to specify how this information should
be stored to maintain compatibility between porcelains while (hopefully)
allowing for some degree of flexibility.  I don't yet know where this
line should be drawn.

Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
