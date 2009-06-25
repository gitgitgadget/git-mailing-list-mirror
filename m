From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: Could this be done simpler?
Date: Fri, 26 Jun 2009 00:23:02 +0200
Message-ID: <200906260023.03169.chriscool@tuxfamily.org>
References: <alpine.LFD.2.01.0906241426120.3154@localhost.localdomain> <7veit9m8cs.fsf@alter.siamese.dyndns.org> <200906260002.40531.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:22:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJxLO-00049B-Lt
	for gcvg-git-2@gmane.org; Fri, 26 Jun 2009 00:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbZFYWWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 18:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751924AbZFYWWr
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 18:22:47 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:38026 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751897AbZFYWWr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 18:22:47 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1557D8180C5;
	Fri, 26 Jun 2009 00:22:42 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E81178180E2;
	Fri, 26 Jun 2009 00:22:39 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200906260002.40531.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122249>

On Friday 26 June 2009, Christian Couder wrote:
> On Thursday 25 June 2009, Junio C Hamano wrote:
> > Side note.
> >
> > People sometimes say, and I am certain I agreed to them on more than
> > one occasions, that Octopus hurt bisectability and does not have much
> > value in real life.  I've always thought this bisectability issue was a
> > downside of Octopus merges, but now I think about it, perhaps "git
> > bisect" can be taught to dynamically decompose an Octopus merges into a
> > sequence of two-head virtual merges while bisecting.  We strongly
> > discourage and do not allow conflicting Octopus merges, so when you
> > need to bisect a history with an Octopus that looks like this:
> >
> >     ---o---A
> >             \
> >   ---o---B---M---o
> >             /
> >     ---o---C
> >
> > it should be able to mechanically decompose it, without conflicts, into
> >
> >
> >     ---o---A
> >             \
> >   ---o---B---M1--M2--o
> >                 /
> >         ---o---C
> >
> > where the tree of M and the tree of M2 are identical.
>
> If someone creates a "git decompose-octopus <commit>" command then you
> only need to do "git replace M M2" after that and you can bisect as
> usual. (Of course after that you can remove the replacement with "git
> replace -d M".)

(Or if we make the "refs/replace/bisect/" directory special so that it is 
only used when bisecting, and if the replace ref is created in this 
directory, then no need to remove the replacement ref. On the contrary it's 
better to leave it there so that people who fetch it benefit from it too.)

Best regards,
Christian.
