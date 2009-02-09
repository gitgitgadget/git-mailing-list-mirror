From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] receive-pack: receive.denyDeleteCurrent
Date: Mon, 9 Feb 2009 14:22:10 -0500
Message-ID: <20090209192210.GD27037@coredump.intra.peff.net>
References: <1234170565-6740-1-git-send-email-gitster@pobox.com> <1234170565-6740-2-git-send-email-gitster@pobox.com> <1234170565-6740-3-git-send-email-gitster@pobox.com> <1234170565-6740-4-git-send-email-gitster@pobox.com> <20090209185310.GB27037@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 09 20:24:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWbjh-00023q-JK
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 20:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754300AbZBITWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 14:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753928AbZBITWN
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 14:22:13 -0500
Received: from peff.net ([208.65.91.99]:45162 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575AbZBITWM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 14:22:12 -0500
Received: (qmail 4571 invoked by uid 107); 9 Feb 2009 19:22:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 09 Feb 2009 14:22:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Feb 2009 14:22:10 -0500
Content-Disposition: inline
In-Reply-To: <20090209185310.GB27037@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109110>

On Mon, Feb 09, 2009 at 01:53:10PM -0500, Jeff King wrote:

> On Mon, Feb 09, 2009 at 01:09:22AM -0800, Junio C Hamano wrote:
> 
> > This is a companion patch to the recent 3d95d92 (receive-pack: explain
> > what to do when push updates the current branch, 2009-01-31).
> > 
> > Deleting the current branch from a remote will result in the next clone
> > from it not check out anything, among other things.  It also is one of the
> > cause that makes remotes/origin/HEAD a dangling symbolic ref.  This patch
> > still allows the traditional behaviour but with a big warning, and promises
> > that the default will change to 'refuse' in a future release.
> 
> This patch looks good to me. One comment:

Actually, one more comment on this one. If a user tries to delete the
current branch in a non-bare repository, they actually get _both_
gigantic warning messages (one for denyCurrentBranch and one for
denyDeleteCurrent).

Should the denyCurrentBranch code be triggering at all on a deletion?
That is, if I have:

  [receive]
    denyCurrentBranch = refuse
    denyDeleteCurrent = ignore

should such a deletion be refused or allowed?

-Peff
