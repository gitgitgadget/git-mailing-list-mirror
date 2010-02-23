From: Jeff King <peff@peff.net>
Subject: Re: Bugs with detection of renames that are also overwrites
Date: Tue, 23 Feb 2010 07:59:52 -0500
Message-ID: <20100223125952.GA7638@coredump.intra.peff.net>
References: <alpine.DEB.2.00.1002131820150.14055@dr-wily.mit.edu>
 <20100223122257.GA1735@coredump.intra.peff.net>
 <2cfc40321002230453q3a593fa6l43850207ebddfc99@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Anders Kaseorg <andersk@mit.edu>, git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 13:59:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjuMo-0007Oz-IU
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 13:59:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181Ab0BWM7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2010 07:59:54 -0500
Received: from peff.net ([208.65.91.99]:37175 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab0BWM7x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2010 07:59:53 -0500
Received: (qmail 18039 invoked by uid 107); 23 Feb 2010 13:00:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 23 Feb 2010 08:00:08 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2010 07:59:52 -0500
Content-Disposition: inline
In-Reply-To: <2cfc40321002230453q3a593fa6l43850207ebddfc99@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140795>

On Tue, Feb 23, 2010 at 11:53:13PM +1100, Jon Seymour wrote:

> I came across a similar case recently while testing my rebasing ideas
> which lead me to wonder - is there a way to suppress the rename and
> overwrite detection? For my purposes, I don't care if the diff is
> bulky, I just want it to apply reliably.

For diff generation, it should be off by default (but you may have
configured diff.renames, in which case you can pass --no-renames to
suppress it).

For the merge-recursive driver, it is on by default. You can hack it off
by setting merge.renamelimit to something small like '1' (but don't use
'0', which means "no limit").  Rebase uses "git am -3" internally, which
in turn invokes merge-recursive.

-Peff
