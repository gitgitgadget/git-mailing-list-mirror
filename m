From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT PATCH] Fixed trivial warnings. Mainly parametrized raw
	types,   added serialVersionUID, removed unnecessery throws.
Date: Sun, 4 Jan 2009 18:19:59 -0800
Message-ID: <20090105021959.GB20973@spearce.org>
References: <gjrcni$9q$1@ger.gmane.org> <gjrgip$al9$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 03:21:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJf5n-0007AG-Ep
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 03:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbZAECUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Jan 2009 21:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbZAECUD
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 21:20:03 -0500
Received: from george.spearce.org ([209.20.77.23]:41287 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbZAECUB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 21:20:01 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 07DEE38210; Mon,  5 Jan 2009 02:20:00 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <gjrgip$al9$1@ger.gmane.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104557>

Vasyl' Vavrychuk <vvavrychuk@gmail.com> wrote:
> Not sure what is right:
> public abstract class AnyObjectId implements Comparable<ObjectId> {
> or
> public abstract class AnyObjectId implements Comparable<AnyObjectId> {
> 
> IMHO second, but class AnyObjectId contains some compareTo(ObjectId).
 
Hmmph.  That probably can be AnyObjectId.  At one point we only had
ObjectId, then AnyObjectId was introduced as a base so we can have
the immutable AnyObjectId and the mutable MutableObjectId subclasses.

compareTo doesn't care about the mutable state of its argument, this
is probably left-over code that didn't get converted when we added
the AnyObjectId base class.

So it should be the second, and the compareTo method should be made
to match that.

-- 
Shawn.
