From: David Kastrup <dak@gnu.org>
Subject: Re: empty directories
Date: Thu, 23 Aug 2007 01:55:29 +0200
Message-ID: <85sl6bjf9q.fsf@lola.goethe.zz>
References: <1187716461.5986.71.camel@beauty>
	<20070821134030.b763e9d3.seanlkml@sympatico.ca>
	<1187817948.5986.159.camel@beauty>
	<alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh England <jjengla@sandia.gov>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 01:55:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO02y-0000PM-U9
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 01:55:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbXHVXzc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 19:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbXHVXzc
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 19:55:32 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:51573 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932398AbXHVXzb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 19:55:31 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id EEDE032E8B0;
	Thu, 23 Aug 2007 01:55:29 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id E1C1F114373;
	Thu, 23 Aug 2007 01:55:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-060-116.pools.arcor-ip.net [84.61.60.116])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id BDB9F3425E5;
	Thu, 23 Aug 2007 01:55:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 666CF1C36605; Thu, 23 Aug 2007 01:55:29 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 22 Aug 2007 16\:25\:21 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/4032/Wed Aug 22 22:15:27 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56438>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Full permissions might be easy enough to resurrect, but since it's
> still pointless without ownership, that really isn't even relevant.

I'd not call it entirely pointless without ownership: under most
systems, only root can do chown, so for example a private backup of a
home directory usually has unique ownership (and nothing but the
normal ownership could be restored by a user, anyway).

However, once the user is member of more than a single group and
actually makes _use_ of that, we are getting on thin ice.  But at
least different group ownership is usually much better contained (and
thus reconstructible manually in the case of an emergency) as the
permissions are.

Since tracking permissions would be a per-project decision (nothing
else makes any sense), it should be workable to amend the tree records
themselves by adding ownership and ACL and whatever else optionally
right there in-place if one figures out a good syntax for it.

One still needs to come up with a good and flexible way to implement
policies: what kind of permissions/ownership data will be let into the
repository from workdir/pushing, and what won't?

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
