From: chris <jugg@hotmail.com>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Wed, 11 May 2011 10:10:01 +0000 (UTC)
Message-ID: <loom.20110511T040830-212@post.gmane.org>
References: <loom.20110505T103708-225@post.gmane.org> <20110505093752.GB29595@sigill.intra.peff.net> <loom.20110505T114511-660@post.gmane.org> <20110505105914.GA464@sigill.intra.peff.net> <loom.20110506T034552-210@post.gmane.org> <20110506170204.GA16576@sigill.intra.peff.net> <loom.20110510T153328-584@post.gmane.org> <20110510194738.GB14456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 19:26:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QKDB8-0004NA-1o
	for gcvg-git-2@lo.gmane.org; Wed, 11 May 2011 19:26:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753532Ab1EKR0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2011 13:26:20 -0400
Received: from lo.gmane.org ([80.91.229.12]:33849 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751169Ab1EKR0T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2011 13:26:19 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1QK6Mv-0001nm-Lc
	for git@vger.kernel.org; Wed, 11 May 2011 12:10:13 +0200
Received: from 114-38-77-62.dynamic.hinet.net ([114.38.77.62])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 May 2011 12:10:13 +0200
Received: from jugg by 114-38-77-62.dynamic.hinet.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 May 2011 12:10:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 114.38.77.62 (Mozilla/5.0 (X11; Linux i686) AppleWebKit/534.24 (KHTML, like Gecko) Ubuntu/10.04 Chromium/11.0.696.65 Chrome/11.0.696.65 Safari/534.24)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173416>

Jeff King <peff <at> peff.net> writes:
> 
> On Tue, May 10, 2011 at 03:34:26PM +0000, chris wrote:
> 
> > 
> >   $ git push origin HEAD:newbranch
> > 
> > is valid only if HEAD contains a branch ref pointer.  Otherwise, if the 
> > LHS of the refspec is not a known ref type, the RHS must always be 
> > explicit when pushing a new ref.  If the LHS is a known ref type, then 
> > the same ref type is used for the RHS of the refspec - also the RHS 
> > becomes optional in such a case and the LHS name will be used if the RHS 
> > was omitted.
> 
> I think the RHS is always optional, isn't it? That is, if I say:
> 
>   git push origin foo
> 
> then that is always equivalent to
> 
>   git push origin foo:foo
> 
> which will then push to the matching "foo" on the remote; if it does not
> exist, then it will infer the type of "foo" on the remote from the type
> of "foo" locally. But I could be mis-remembering, as it's been a while
> since I've dug into the refspec code.

Yes, but I was distinguishing when the LHS is not a known ref type

  $ git push origin HEAD^

isn't valid.  So, my meaning was RHS only becomes optional if the LHS resolves 
to a local ref.  Which may be obvious; I was just trying to cover the use cases.

I think the generalization is that git-push tries to build the refspec using 
hints from the local ref part.  If it can not do so, it fails rather than 
defaulting to any particular behavior.

chris
