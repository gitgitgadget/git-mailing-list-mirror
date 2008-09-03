From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Detached-HEAD reminder on commit?
Date: Wed, 3 Sep 2008 11:47:15 +0200
Message-ID: <200809031147.15612.johan@herland.net>
References: <1220383905-48316-1-git-send-email-pdebie@ai.rug.nl> <200809030945.08619.johan@herland.net> <7vljy9d540.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Stephan Beyer <s-beyer@gmx.net>,
	Pieter de Bie <pdebie@ai.rug.nl>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 03 11:49:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaozG-0006Hf-7T
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 11:49:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbYICJsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 05:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751825AbYICJsK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 05:48:10 -0400
Received: from sam.opera.com ([213.236.208.81]:48448 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771AbYICJsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 05:48:09 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m839lFl4025407
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 3 Sep 2008 09:47:21 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <7vljy9d540.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94774>

On Wednesday 03 September 2008, Junio C Hamano wrote:
> Johan Herland <johan@herland.net> writes:
> > It seems to have been suggested (in various forms) by several
> > people and generally well-received in the original thread, but
> > nothing seems to have come of it (at least nothing that has
> > survived till today).
>
> You are masochistic enough to have noticed that people were talking
> about the safety in the context of "HEAD lacks its own reflog"?  Yes,
> we had reflogs on each refs/*, but HEAD itself did not have one.

Yes, I noticed that...

> The situation has changed --- HEAD has its own reflog these days,
> which not only helps this particular issue but is useful in contexts
> that never involves a detached HEAD.

...and that is certainly good, but I wonder if the people we want to 
protect from losing detached commits might not be aware of the 
existence and usage of reflogs (since we already assume they might not 
yet have fully grasped the branch concept). Even so, this would provide 
a golden opportunity to teach them about it. So, what about this: 

When switching away from a detached HEAD that will cause it to become 
unreachable, we should warn the user of what is happening, and how to 
recover from this situation. I.e. something like:

  The commit you switched away from is not reachable from an existing
  ref, and will be deleted when its reflog entry expires (in $X days).
  See "git help reflog" for more information.
  If you want to keep this commit, you must bind it to a ref, for
  example by doing
    git branch <new-branch-name> $SHA1_SUM_HERE


Of course, this warning can be hidden by giving -q to git checkout.

Hmm?


Hopefully no longer masochistic,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
