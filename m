From: Jeff King <peff@peff.net>
Subject: pack count on repo.or.cz [was "Medium term dreams"]
Date: Mon, 1 Sep 2008 20:00:37 -0400
Message-ID: <20080902000037.GA11869@coredump.intra.peff.net>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 02 02:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaJPu-0004YT-Bk
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 02:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbYIBAAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 20:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751383AbYIBAAl
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 20:00:41 -0400
Received: from peff.net ([208.65.91.99]:1990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbYIBAAl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 20:00:41 -0400
Received: (qmail 9324 invoked by uid 111); 2 Sep 2008 00:00:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Sep 2008 20:00:38 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Sep 2008 20:00:37 -0400
Content-Disposition: inline
In-Reply-To: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94631>

On Mon, Sep 01, 2008 at 04:19:47PM -0700, Junio C Hamano wrote:

> I've pushed a sample repository that future git.git might look like to:
> 
>     http://repo.or.cz/w/git/split-submodule.git/

Holy pack count, Batman! On a whim, I cloned this via http (by switching
/w/ to /r/). It took 7m13s. Cloning by git://, for comparison, took
1m31s. I pulled down 82 separate packs (and curiously, 277 separate .idx
files).

I know it is nice to keep the packs somewhat split for dumb transport
users (since they otherwise have to pull down the whole thing), but I
think it is coming here at the cost of first-time cloners (and yes,
obviously I should have used --reference to an existing git clone; but
for many that will not be an option).

It looks like the gc.autopacklimit defaults to 50, which would have
helped this. Pasky, is repo.or.cz not gc-ing? Or gc-ing with different
parameters? Or is this an artifact of the forking infrastructure (i.e.,
these packs are actually split across multiple modules)?

-Peff
