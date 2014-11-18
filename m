From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 16:37:47 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1411181634080.2918-100000@iolanthe.rowland.org>
References: <xmqq1tp0uru5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 22:38:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqqTo-00052G-I0
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 22:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbaKRVhu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 16:37:50 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:38233 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754843AbaKRVhs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 16:37:48 -0500
Received: (qmail 18993 invoked by uid 2102); 18 Nov 2014 16:37:47 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Nov 2014 16:37:47 -0500
X-X-Sender: stern@iolanthe.rowland.org
In-Reply-To: <xmqq1tp0uru5.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 18 Nov 2014, Junio C Hamano wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> >> > No.  Here's a simple example:
> >> >
> >> >             Y
> >> >            /
> >> >           /
> >> >          X--B
> >> >
> >> > In this diagram, X = B^.  But B isn't reachable from either X or Y, 
> >> > whereas it is reachable from one of X's children (namely Y).
> > ...
> > Thus, if B introduced a bug, that bug would not be present in Y.  But Y 
> > might be better for testing than X, because Y might fix some other 
> > problems that are present in X.
> 
> The problem with that line of reasoning is that in real life there
> will be unbound number of Y's that forked from a point before
> somebody wrote B.  Which one among these Y's would you pick and why?

I don't know.  But I would like to see what is available.  I might even 
merge all those commits and test that (if there aren't any bad 
conflicts).

> If Y has fixed another problem that is present in X and make it
> easier to test, Z, a direct descendant of Y (i.e. Z^1 = Y), may have
> fixed yet another problem that is unrelated to the problem B
> introduced and it may make the result even easier to test.  Where do
> you stop?

If Y is maximal among the comments that B isn't reachable from and Z^ = 
Y then, by definition, B _is_ reachable from Z.  Therefore the bug 
introduced in B will be present in Z, unless it got fixed somewhere in 
between.  Either way, Z is not a good candidate for testing whereas Y 
is.

Alan Stern
