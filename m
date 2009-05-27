From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: RFE: "git bisect reverse"
Date: Wed, 27 May 2009 23:18:36 +0200
Message-ID: <20090527211836.GA14841@localhost>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net> <4A1CBF7A.3090708@zytor.com> <200905270726.59883.chriscool@tuxfamily.org> <efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"H. Peter Anvin" <hpa@zytor.com>, Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>
To: Ealdwulf Wuffinga <ealdwulf@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 27 23:18:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9QWR-0002Dp-Tz
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 23:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbZE0VSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 17:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbZE0VSn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 17:18:43 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:6761 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928AbZE0VSm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 17:18:42 -0400
Received: from darc.dnsalias.org ([84.154.120.211]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 27 May 2009 23:18:37 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1M9QWC-00044C-QD; Wed, 27 May 2009 23:18:36 +0200
Content-Disposition: inline
In-Reply-To: <efe2b6d70905271411g4e1616b5w548141ee9fab2c14@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 27 May 2009 21:18:37.0834 (UTC) FILETIME=[B35B36A0:01C9DF10]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120108>

On Wed, May 27, 2009 at 10:11:35PM +0100, Ealdwulf Wuffinga wrote:
> >> Sam Vilain wrote:
> >> > Oh, yes.  And another thing: 'git bisect run' / 'git bisect skip'
> >> > doesn't do a very good job of skipping around broken commits (ie when
> >> > the script returns 126).  It just seems to move to the next one; it
> >> > would be much better IMHO to first try the commit 1/3rd of the way into
> >> > the range, then if that fails, the commit 2/3rd of the way through it,
> >> > etc.
> 
> As I understand it, the idea is that the probability that a commit is
> broken is greater if it is close in the DAG to a known-broken commit.
> I wonder if this can be made more concrete? Can we derive a formula
> for, or collect empriical data on, these probabilities?

No. The idea is that we want to reduce to bisect as close to the middle as
possible so we only have to do log2(n) tests. But if a commit is skipped,
that means we cannot decide whether the test passes or fails for this
commit. But if we choose a commit close to the skipped one, we will likely
have to skip the that one for the same reason.
