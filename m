From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/4] Refactor patch-id filtering out of git-cherry and
 git-format-patch.
Date: Sat, 14 Apr 2007 10:57:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704141028220.18846@racer.site>
References: <1175686583.19898.68.camel@okra.transitives.com>
 <Pine.LNX.4.64.0704040744160.6730@woody.linux-foundation.org>
 <7vircbwfym.fsf@assigned-by-dhcp.cox.net> <7virc524cd.fsf_-_@assigned-by-dhcp.cox.net>
 <7vmz1fua4r.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 14 10:58:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hce5p-0003rf-QY
	for gcvg-git@gmane.org; Sat, 14 Apr 2007 10:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825AbXDNI6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 04:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753812AbXDNI6q
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 04:58:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:49702 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753825AbXDNI6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 04:58:46 -0400
Received: (qmail invoked by alias); 14 Apr 2007 08:58:42 -0000
Received: from mail.superfast.com (EHLO [10.0.0.38]) [194.30.223.1]
  by mail.gmx.net (mp041) with SMTP; 14 Apr 2007 10:58:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187JZ1CCew7RRbE9AYkwi4NSs0hH02mEiFuWN+TEj
	MgJqCG6L/eShFr
X-X-Sender: gene099@racer.site
In-Reply-To: <7vmz1fua4r.fsf_-_@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44452>

Hi,

On Tue, 10 Apr 2007, Junio C Hamano wrote:

> This implements the patch-id computation and recording library,
> patch-ids.c, and rewrites the get_patch_ids() function used in
> cherry and format-patch to use it, so that they do not pollute
> the object namespace.  Earlier code threw non-objects into the
> in-core object database, and hoped for not getting bitten by
> SHA-1 collisions.  While it may be practically Ok, it still was
> an ugly hack.

No, it was not an ugly hack. Instead, it served as a reminder that we 
_rely_ on different content having different SHA-1 ids.

Having said that, I do not particularly mind patch-ids being stored 
elsewhere, if only as a clean up. However, I would have liked your patch 
so much more if you had done the only sane thing: resurrect object-hash.c.

Now, we have yet another data structure which is unnecessarily bound to a 
certain use, and the next person wanting a new hashmap needs to add _yet_ 
another data structure.

Ciao,
Dscho
