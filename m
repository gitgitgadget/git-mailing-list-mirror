From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] remote.c: Fix overtight refspec validation
Date: Sat, 22 Mar 2008 16:45:20 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0803221559220.19665@iabervon.org>
References: <alpine.LNX.1.00.0803202049090.19665@iabervon.org> <7v4pb0vhrg.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210014100.19665@iabervon.org> <7vmyosskyu.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803210134070.19665@iabervon.org>
 <7v3aqksic6.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803211148120.19665@iabervon.org> <7vlk4boh6v.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0803211840480.19665@iabervon.org> <7vy78bmxx1.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803212021190.19665@iabervon.org> <7viqzeilp0.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Samuel Tardieu <sam@rfc1149.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 21:46:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdAbb-0004Cz-OK
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 21:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbYCVUp2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 16:45:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752563AbYCVUp2
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 16:45:28 -0400
Received: from iabervon.org ([66.92.72.58]:34778 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752497AbYCVUp1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 16:45:27 -0400
Received: (qmail 20850 invoked by uid 1000); 22 Mar 2008 20:45:20 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Mar 2008 20:45:20 -0000
In-Reply-To: <7viqzeilp0.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77850>

On Sat, 22 Mar 2008, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Fri, 21 Mar 2008, Junio C Hamano wrote:
> > ...
> >> Do you mean you want the callers of this internal implementation to also
> >> loop over the input set of refs?  I think that would be more complex code
> >> but I do not see much gain by doing so.
> >
> > I think it's more breadth but less depth. It would make the internal 
> > implementation not depend on fetch, and put the checks that only apply to 
> > fetch out of the push code path and vice versa.
> >
> > Or just have a section
> >
> > 	if (fetch) {
> > 		// checks for fetch LHS
> > 		// checks for fetch RHS
> > 	} else {
> > 		// checks for push LHS
> > 		// checks for push RHS
> > 	}
> >
> > The body of the condition is only four lines, after all.
> 
> There are two commits on jc/refspec-fix branch merged to 'pu'.  The
> earlier one is my version, and the one on top is based on the above
> suggestion.  I do not know which one is clearer, more readable and
> maintainable.

I like the second one quite a bit. If nothing else, it's got, as the
comments, the best documentation of refspecs I've seen, and then it's got 
code which clearly implements those rules. I think the explicitness is 
worth the extra lines.

Thanks for taking care of this; as a result of starting a new job, I 
haven't had much in the way of coding attention for other stuff the past 
couple of weeks.

	-Daniel
*This .sig left intentionally blank*
