From: Pavel Roskin <proski@gnu.org>
Subject: cg-pull to pull branches, not the whole repository
Date: Wed, 14 Sep 2005 17:31:56 -0400
Message-ID: <1126733516.10827.54.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 14 23:34:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFerT-0000AX-Dr
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 23:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbVINVcI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 17:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932747AbVINVcI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 17:32:08 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:42978 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S932561AbVINVcH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 17:32:07 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EFerO-0005Cr-1I
	for git@vger.kernel.org; Wed, 14 Sep 2005 17:32:06 -0400
Received: from proski by dv.roinet.com with local (Exim 4.52)
	id 1EFerE-0003Ft-Tp; Wed, 14 Sep 2005 17:31:56 -0400
To: Petr Baudis <pasky@suse.cz>
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8568>

Hello!

I believe cg-pull should be changed to pull only the objects relevant to
the branch rather than the whole repository.  This could be more
expensive in terms of processor power (since the objects would be
checked for parents), but it would save the bandwidth, especially for
users tracking stable branches with little changes in presence of
heavily changed development branches in the same repository.

To keep things simple, pulling the whole repository should be removed
from cogito.  Users don't need objects that are not reachable from any
branch known to cogito.  If I'm not tracking a branch, I don't want
objects from it.  To compensate for intermittently connected users,
cg-pull could have an option to pull from all branches (or from all
branches marked for automatic pull).

Ideally, cogito should not rely on the server being able to list
directories.  This would allow support more protocols and servers, e.g.
http servers without directory listings.  Unfortunately, listings are
still needed to get refs/tags and refs/heads.  Any fix for that would
involve git core, and I don't see an elegant fix.

For git+ssh protocol, git-fetch-pack already provides a server side
solution.  Client side support would be needed for http and rsync.

I'd like to hear comments before I attempt any hacking in this
direction.

-- 
Regards,
Pavel Roskin
