From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 15:29:09 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411181523320.879-100000@iolanthe.rowland.org>
References: <20141118194129.GI6527@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:29:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpOk-0001ml-NS
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbaKRU3L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:29:11 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:36938 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753829AbaKRU3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:29:10 -0500
Received: (qmail 24250 invoked by uid 2102); 18 Nov 2014 15:29:09 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Nov 2014 15:29:09 -0500
X-X-Sender: stern@iolanthe.rowland.org
In-Reply-To: <20141118194129.GI6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Nov 2014, Jonathan Nieder wrote:

> Hi,
> 
> Alan Stern wrote:
> 
> > The "git rev-list A ^B" command lists all the commits that are
> > reachable from A but not from B.  Is there a comparable command for the
> > converse relation, that is, a command to list all the commits that A is
> > reachable from but B isn't?
> >
> > And if there is such a command, can the output be limited to just the
> > latest commits?  That is, list commit X if and only if A is reachable
> > from X, B isn't reachable from X, and B is reachable from each of X's
> > children?
> 
> Someone else can answer your direct question, but you've got my
> curiosity.  What is the application?

Tracking down regressions.  Bisection isn't perfect.  Suppose a
bisection run ends up saying that B is the first bad commit.  It's easy
enough to build B and test it, to verify that it really is bad.

But to be sure that B introduced the fault, it would help to find the
latest commit that doesn't include B's changes -- that is, the latest
commit that B isn't reachable from (or the maximal elements in the set
of all such commits).  This is also important in cases where there are
multiple bugs and you want to investigate only the commits that don't
include one of the bugs.

Alan Stern
