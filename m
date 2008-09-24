From: Jeff King <peff@peff.net>
Subject: Re: Applying changes across divergent branches
Date: Wed, 24 Sep 2008 13:09:56 -0400
Message-ID: <20080924170956.GA9265@coredump.intra.peff.net>
References: <48DA514E.6060904@siscog.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tom Schutzer-Weissmann <tom.weissmann@siscog.pt>
X-From: git-owner@vger.kernel.org Wed Sep 24 19:11:23 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiXtQ-00033e-Aa
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 19:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbYIXRKA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 13:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbYIXRKA
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 13:10:00 -0400
Received: from peff.net ([208.65.91.99]:1413 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662AbYIXRKA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 13:10:00 -0400
Received: (qmail 22649 invoked by uid 111); 24 Sep 2008 17:09:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 24 Sep 2008 13:09:57 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Sep 2008 13:09:56 -0400
Content-Disposition: inline
In-Reply-To: <48DA514E.6060904@siscog.pt>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96666>

On Wed, Sep 24, 2008 at 03:40:14PM +0100, Tom Schutzer-Weissmann wrote:

> Could we use git, or a tool based on git, to change on the development  
> branch and selectively apply changes to the other branches - is it as  
> simple as using git cherry-pick?

If I am understanding your description of the problem correctly, then
yes, it is as simple as cherry-picking.

If your branches have a strict hierarchy, you can also use a "merge up"
workflow where some branches always contain all of other branches. For
example, in git has a "maint" branch for stable bugfixes and a "master"
branch for general development. The rule is that one must always merge
"up", meaning that master can merge from maint, but maint can never
merge from master. Stable bugfixes go on maint, and then get to master
by merging.

Depending on the details of your branches, something like that may work
for you. You can have a "base" branch that all product branches merge
from, and only changes which should affect all products go on that
branch (or on topic branches that are based on the "base" branch).

-Peff
