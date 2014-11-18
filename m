From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 15:45:43 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411181541590.2918-100000@iolanthe.rowland.org>
References: <20141118203204.GM6527@google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:45:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xqpem-00009k-W6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbaKRUpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:45:45 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38121 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754558AbaKRUpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:45:44 -0500
Received: (qmail 6333 invoked by uid 2102); 18 Nov 2014 15:45:43 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Nov 2014 15:45:43 -0500
X-X-Sender: stern@iolanthe.rowland.org
In-Reply-To: <20141118203204.GM6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Nov 2014, Jonathan Nieder wrote:

> Alan Stern wrote:
> 
> > Tracking down regressions.  Bisection isn't perfect.  Suppose a
> > bisection run ends up saying that B is the first bad commit.  It's easy
> > enough to build B and test it, to verify that it really is bad.
> >
> > But to be sure that B introduced the fault, it would help to find the
> > latest commit that doesn't include B's changes -- that is, the latest
> > commit that B isn't reachable from (or the maximal elements in the set
> > of all such commits).
> 
> Isn't that B^ (or B^ and B^2, if B is a merge)?

No.  Here's a simple example:

            Y
           /
          /
         X--B

In this diagram, X = B^.  But B isn't reachable from either X or Y, 
whereas it is reachable from one of X's children (namely Y).  Therefore 
Y is the unique maximal commit which B is not reachable from.

Alan Stern
