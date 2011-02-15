From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/7] commit,status: describe -u likewise
Date: Tue, 15 Feb 2011 02:21:48 -0500
Message-ID: <20110215072148.GC28634@sigill.intra.peff.net>
References: <cover.1297695910.git.git@drmicha.warpmail.net>
 <959cfaee441413401ddb7ad7fd29f4a98f668bec.1297695910.git.git@drmicha.warpmail.net>
 <7vei7as82n.fsf@alter.siamese.dyndns.org>
 <4D5A22D3.2080605@warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <drmicha@warpmail.net>
X-From: git-owner@vger.kernel.org Tue Feb 15 08:21:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpFES-00057u-CJ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Feb 2011 08:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754166Ab1BOHVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 02:21:51 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49404 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751912Ab1BOHVu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 02:21:50 -0500
Received: (qmail 29008 invoked by uid 111); 15 Feb 2011 07:21:49 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 15 Feb 2011 07:21:49 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 02:21:48 -0500
Content-Disposition: inline
In-Reply-To: <4D5A22D3.2080605@warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166821>

On Tue, Feb 15, 2011 at 07:53:07AM +0100, Michael J Gruber wrote:

> > I however wonder if we have an opportunity for even more unifying
> > these two arrays, typing the same thing only once.
> 
> I was surprised we have two arrays at all, "status" being "commit
> --dry-run". I'll check whether we can remove redundancy without too
> much effort.

Hmm, not according to 9e4b7ab (git status: not "commit --dry-run"
anymore, 2009-08-15).

"Commit --dry-run" more-or-less runs status on the index that would be
committed. But it obviously takes a lot of options that status does not,
and in theory status could take options that "commit --dry-run" does
not (certainly its non-option arguments are different these days, but
parse_options doesn't care about that).

I said "in theory" because I have no idea if such options exist yet or
not. But probably any refactoring should pull out the common options
into a shared list, and not simply make commit a superset of the status
options.

-Peff
