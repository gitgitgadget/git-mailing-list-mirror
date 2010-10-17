From: Jeff King <peff@peff.net>
Subject: Re: Efficiently detecting paths that differ from each other only
 in case
Date: Sun, 17 Oct 2010 00:25:25 -0400
Message-ID: <20101017042525.GA15595@sigill.intra.peff.net>
References: <AANLkTimGAbosbD0pprROu_g-UW38faotYA2dTxj9scsP@mail.gmail.com>
 <20101008135034.GC5163@sigill.intra.peff.net>
 <AANLkTik6pSJFUkY9sooSH7iANaKLhxdN+ouKRXJn1B9G@mail.gmail.com>
 <20101008195120.GA10810@sigill.intra.peff.net>
 <AANLkTimAhjHm5Z4ekTOBaxwzyw2YD6MrRnB1O8E6nAtw@mail.gmail.com>
 <20101008200657.GA10954@sigill.intra.peff.net>
 <AANLkTi=YQOVYsK6Brq5pMiAdrH3Un7RgrWvYf_pymT=d@mail.gmail.com>
 <20101011030755.GB6523@sigill.intra.peff.net>
 <AANLkTimSNTKFYnYgpha4MpyiC5CdZU5ay1B-848JQrzJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dun Peal <dunpealer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 17 06:25:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7Knz-0006C3-KQ
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 06:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab0JQEY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 00:24:59 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:39327 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab0JQEY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 00:24:58 -0400
Received: (qmail 27484 invoked by uid 111); 17 Oct 2010 04:24:57 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 17 Oct 2010 04:24:57 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Oct 2010 00:25:25 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimSNTKFYnYgpha4MpyiC5CdZU5ay1B-848JQrzJ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159191>

On Sat, Oct 16, 2010 at 05:37:53PM -0500, Dun Peal wrote:

> Running:
> 
>     git ls-tree -r HEAD
> 
> produces almost 100k lines of output, representing 100k total file +
> directory count, which is a pretty big tree. I hope and expect to be
> able to split out some branches in the future, but even with
> everything included, the operation still only takes ~0.5s real (user +
> sys).

Out of curiosity, is your bare repo fully packed? My linux-2.6 repo is
only ~35000 entries, but it can ls-tree -r with a warm cache in about
.09s. If it scaled linearly with the number of files, that would be
almost twice as fast as yours.

The distribution of files within your directories can impact exactly how
many trees you have, and thus the lookup performance. Or maybe your
machine is simply a little bit slower. But since you seem
performance-conscious, it might be worth double-checking.

-Peff
