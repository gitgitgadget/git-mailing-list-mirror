From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] status: list unmerged files last
Date: Sat, 5 Sep 2009 04:48:09 -0400
Message-ID: <20090905084809.GA13073@coredump.intra.peff.net>
References: <200909012325.45739.j6t@kdbg.org>
 <7vtyzmxkpr.fsf@alter.siamese.dyndns.org>
 <20090902011513.GA3874@coredump.intra.peff.net>
 <7vmy5egefh.fsf@alter.siamese.dyndns.org>
 <20090902051248.GB12046@coredump.intra.peff.net>
 <7vljkxdiil.fsf@alter.siamese.dyndns.org>
 <20090902100730.GA18226@gmail.com>
 <20090902175908.GA5998@coredump.intra.peff.net>
 <20090903011234.GA7415@gmail.com>
 <20090905062846.GD29863@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:48:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjqwx-0001HA-2q
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757227AbZIEIsL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757220AbZIEIsL
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:48:11 -0400
Received: from peff.net ([208.65.91.99]:49294 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757217AbZIEIsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:48:10 -0400
Received: (qmail 25977 invoked by uid 107); 5 Sep 2009 08:48:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 05 Sep 2009 04:48:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2009 04:48:09 -0400
Content-Disposition: inline
In-Reply-To: <20090905062846.GD29863@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127798>

On Sat, Sep 05, 2009 at 02:28:46AM -0400, Jeff King wrote:

> I see. I still think you may want to improve "commit --dry-run" with a
> plumbing format, though, instead of "git status". Then it would
> automagically support "--amend", as well as other dry-run things (e.g.,
> "git commit --dry-run --porcelain --amend foo.c"). And not having looked
> at the code, I would guess it is a one-liner patch to switch the "output
> format" flag that commit passes to the wt-status.c code.

OK, it was a bit more complex than that. But here is a series which does
a few things. It is still missing a few bits, so is RFC.

  These first two are unrelated fixups that I noticed while working.

  [1/6]: status: typo fix in usage
  [2/6]: docs: note that status configuration affects only long format

  These are the --porcelain patches we discussed. The first two are
  obviously cleanup.

  [3/6]: status: refactor short-mode printing to its own function
  [4/6]: status: refactor format option parsing
  [5/6]: status: add --porcelain output format

  This brings the new formats to "commit --dry-run" to handle your case.
  Conceptually, it could come before (or instead) of 4/6 and 5/6, but as
  it adds both --short and --porcelain, there is an obvious dependency.

  [6/6]: commit: support alternate status formats

-Peff
