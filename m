From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rerere should not repeat the earlier hunks in later ones
Date: Thu, 5 Apr 2007 00:00:40 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0704042359470.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v1wj1ujf5.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0704041746580.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xd83sfn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 00:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZDXT-0005cR-Rx
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 00:01:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbXDDWAo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 18:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbXDDWAo
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 18:00:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:49519 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752259AbXDDWAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 18:00:42 -0400
Received: (qmail invoked by alias); 04 Apr 2007 22:00:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 05 Apr 2007 00:00:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+sykloh62snptEdI/Rt8mfW4nzK5/BjP0LFvxlvA
	EinIlvrQuoLyEt
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v8xd83sfn.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43780>

Hi,

On Wed, 4 Apr 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > I wonder if we should also do
> >
> > diff --git a/builtin-rerere.c b/builtin-rerere.c
> > index b8867ab..4eae27b 100644
> > --- a/builtin-rerere.c
> > +++ b/builtin-rerere.c
> > @@ -112,7 +112,8 @@ static int handle_file(const char *path,
> >  		else if (!prefixcmp(buf, ">>>>>>> ")) {
> >  			hunk_no++;
> >  			hunk = 0;
> > -			if (memcmp(one->ptr, two->ptr, one->nr < two->nr ?
> > +			if (one->nr > two->nr || memcmp(one->ptr, two->ptr,
> > +						one->nr < two->nr ?
> >  						one->nr : two->nr) > 0) {
> >  				struct buffer *swap = one;
> >  				one = two;
> >
> > in case that one conflicting region is prefix of the other one.
> 
> If one is not a prefix of two but simply longer what does that
> code do?

You're right. With the eager merging algorithm, it is no longer possible 
that one side is a strict prefix of the other.

So please forget about my comment.

Ciao,
Dscho
