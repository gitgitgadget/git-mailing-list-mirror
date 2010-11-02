From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Remove restriction on notes ref base
Date: Tue, 2 Nov 2010 10:29:31 -0400
Message-ID: <20101102142931.GA31394@sigill.intra.peff.net>
References: <1288657003-17802-1-git-send-email-kroot@google.com>
 <20101102065208.GA4280@burratino>
 <201011020948.22677.johan@herland.net>
 <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, Kenny Root <kroot@google.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Nov 02 15:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDHr0-0007vw-Nm
	for gcvg-git-2@lo.gmane.org; Tue, 02 Nov 2010 15:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751525Ab0KBO2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Nov 2010 10:28:46 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55925 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751259Ab0KBO2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Nov 2010 10:28:45 -0400
Received: (qmail 1505 invoked by uid 111); 2 Nov 2010 14:28:43 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 02 Nov 2010 14:28:43 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Nov 2010 10:29:31 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinN1UXSmkxOg59pT_xVd2eWS0Ms2sgAweLv7hbg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160522>

On Tue, Nov 02, 2010 at 07:11:45AM -0700, Shawn O. Pearce wrote:

> I didn't want to use refs/notes/bad-commits because its not really an
> annotation you would be looking at with git log.  But we do want to
> have a log of who banned particular SHA-1s from entering the
> repository, and being able to push that branch from a workstation to
> the server is a convenient way to edit that list of banned SHA-1s.

FWIW, I use refs/notes/cache/textconv/* to store textconv caches, and
there is no problem. Unless somebody specifically configures
GIT_NOTES_REF or notes.displayRef to see them, log should never look at
them.

So I think you are being overly cautious. That being said:

> I think the docs are correct, and the code is buggy.  If the user
> asked us to edit refs/meta/bad-commits, we should.  If the user asked
> us to edit refs/heads/my-branch... well, they asked us to edit it.
> :-)

I agree. This part of git is unlike most other parts, which tend to DWYM
with a partial ref (by prepending refs/heads, refs/tags, etc), but still
accept a full ref if the user really feels like organizing their refs
differently.

> A better safety measure might be to sniff the ref's contents and see
> what it is.  If the top level directory has a number of non-note like
> entries, we should abort editing the branch.  Its not common for users
> to name their directories "02" and "fe".

Agreed.

-Peff
