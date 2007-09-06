From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Significant performance waste in git-svn and friends
Date: Wed, 5 Sep 2007 22:16:59 -0400
Message-ID: <20070906021659.GE18160@spearce.org>
References: <20070905184710.GA3632@glandium.org> <7vd4wwj16d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:17:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT6vj-0006zQ-QB
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbXIFCRL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:17:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757367AbXIFCRK
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:17:10 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35510 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757352AbXIFCRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:17:09 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT6vJ-0005Z1-Jz; Wed, 05 Sep 2007 22:16:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AEA7B20FBAE; Wed,  5 Sep 2007 22:16:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd4wwj16d.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57799>

Junio C Hamano <gitster@pobox.com> wrote:
> Mike Hommey <mh@glandium.org> writes:
> 
> > The same things obviously apply to git-cvsimport and other scripts
> > calling git-hash-object a lot.
> 
> I *obviously* hate this patch, as it makes this Porcelain
> command to be aware of the internal representation too much.

Me too.  I think its bad enough that fast-import knows the
internal representation of a packfile.  And its plumbing!
 
> I wonder if letting fast-import handle the object creation is an
> option, though.

I agree.  This is *exactly* what fast-import was built for.  It
really would be the better tool to use here.  Much better than
reinventing the wheel.  Its already been invented twice for you
in Git (normal object creation path and fast-import path).  No
need to do it a third time.

-- 
Shawn.
