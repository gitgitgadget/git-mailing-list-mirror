From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] fast-export: Omit tags that tag trees
Date: Sat, 20 Jun 2009 13:31:28 -0400
Message-ID: <20090620173128.GE31022@coredump.intra.peff.net>
References: <1245472623-28103-1-git-send-email-newren@gmail.com>
 <1245472623-28103-2-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	kusambite@gmail.com
To: newren@gmail.com
X-From: git-owner@vger.kernel.org Sat Jun 20 19:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI4Pt-0005zi-9c
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 19:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755314AbZFTRbb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 13:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754926AbZFTRbb
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 13:31:31 -0400
Received: from peff.net ([208.65.91.99]:58427 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754883AbZFTRbb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 13:31:31 -0400
Received: (qmail 27568 invoked by uid 107); 20 Jun 2009 17:33:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 20 Jun 2009 13:33:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 20 Jun 2009 13:31:28 -0400
Content-Disposition: inline
In-Reply-To: <1245472623-28103-2-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121947>

On Fri, Jun 19, 2009 at 10:36:57PM -0600, newren@gmail.com wrote:

> From: Elijah Newren <newren@gmail.com>
> 
> Commit c0582c53bcf4e83bba70e1ad23abbad31f96ebc8 introduced logic to just
> omit tags that point to tree objects.  However, a case was missed
> resulting in a tag being output which pointed at "mark :0", which would
> cause fast-import to crash.

Do we really want to disallow tags pointing to trees? There is at least
one well-known case in use (kernel v2.6.11).

Also, (and I haven't investigated at all), this sounds like the same
issue we have with tags pointing to tags. IOW, everything referenceable
should be given a mark, but it is not currently. I posted a "how about
this" patch for the tag case here:

  http://article.gmane.org/gmane.comp.version-control.git/119245

but I never got around to following it up with tests. Could you do
something similar for the tree case?

-Peff
