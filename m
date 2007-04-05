From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere should not repeat the earlier hunks in later ones
Date: Thu, 5 Apr 2007 15:03:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704051502540.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wj1ujf5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0704041746580.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xd83sfn.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0704042359470.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vmz1nycjp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 15:03:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZRd5-0005S4-Vm
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 15:03:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766976AbXDENDw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 09:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766975AbXDENDw
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 09:03:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:45821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1766976AbXDENDv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 09:03:51 -0400
Received: (qmail invoked by alias); 05 Apr 2007 13:03:49 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp056) with SMTP; 05 Apr 2007 15:03:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18uYr5C2GIuFhQrMRZvI6nIlxwnHnD8G35NJNkJo5
	xO6UYXxEJF4xdt
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vmz1nycjp.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43823>

Hi,

On Wed, 4 Apr 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > @@ -112,7 +112,8 @@ static int handle_file(const char *path,
> >> >  		else if (!prefixcmp(buf, ">>>>>>> ")) {
> >> >  			hunk_no++;
> >> >  			hunk = 0;
> >> > -			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
> >> > +			if (one->nr > two->nr || memcmp(one->ptr, two->ptr,
> >> > +						one->nr < two->nr ?
> >> >  						one->nr : two->nr) > 0) {
> >> >  				struct buffer *swap = one;
> >> >  				one = two;
> >> >
> >> > in case that one conflicting region is prefix of the other one.
> >> 
> >> If one is not a prefix of two but simply longer what does that
> >> code do?
> >
> > You're right. With the eager merging algorithm, it is no longer possible 
> > that one side is a strict prefix of the other.
> >
> > So please forget about my comment.
> 
> Now you confused me even more...
> 
> Isn't there a case where one is full of text and two is empty?

If one is empty, yes, there can be a conflict. I only did not think of the 
empty string as a prefix to everything, but you are right.

Ciao,
Dscho
