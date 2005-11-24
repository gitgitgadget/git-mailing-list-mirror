From: Nick Hengeveld <nickh@reactrix.com>
Subject: Re: Linux 2.6.15-rc2
Date: Thu, 24 Nov 2005 11:52:56 -0800
Message-ID: <20051124195256.GR3968@reactrix.com>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org> <200511240737.59153.tomlins@cam.org> <Pine.LNX.4.64.0511241020050.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ed Tomlinson <tomlins@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 24 20:54:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EfN9g-0004Is-L7
	for gcvg-git@gmane.org; Thu, 24 Nov 2005 20:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbVKXTxM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Nov 2005 14:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbVKXTxL
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Nov 2005 14:53:11 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:44275 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1750745AbVKXTxJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Nov 2005 14:53:09 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id jAOJquLL030169;
	Thu, 24 Nov 2005 11:52:56 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id jAOJquiW030167;
	Thu, 24 Nov 2005 11:52:56 -0800
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511241020050.13959@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12713>

On Thu, Nov 24, 2005 at 10:37:15AM -0800, Linus Torvalds wrote:

> I just repacked and updated it now, so how http should work too, although 
> inefficiently (because it will get a whole new pack - just one of the 
> disadvantages of the non-native protocols).

There's room to improve on that particular inefficiency.  The http
commit walker could use Range: headers to fetch loose objects directly
from inside a pack if it didn't make sense to fetch the entire pack.
For this to work, pack fetches would need to be deferred until the
entire tree had been walked, and the commit walker could decide whether
to fetch the pack or loose objects based on the percentage of packed
objects it needed to fetch.  It would also need to fetch all
tag/commit/tree objects using ranges to be able to fully walk the tree.

-- 
For a successful technology, reality must take precedence over public
relations, for nature cannot be fooled.
