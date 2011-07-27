From: Jeff King <peff@peff.net>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Wed, 27 Jul 2011 11:24:09 -0600
Message-ID: <20110727172408.GB16031@sigill.intra.peff.net>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
 <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net>
 <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
 <20110726060903.GA29486@sigill.intra.peff.net>
 <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
 <CACsJy8C822Fvwav4Wpw4e-12ZY20XM1s2v4KymZkaDYLxkMHvw@mail.gmail.com>
 <20110727081034.GB8105@sigill.intra.peff.net>
 <CACsJy8ByDUByZiX43_+4_49uB+h0AMCk9J+35kZJSKgBn2KZbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 19:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm7qP-0005Fp-3V
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 19:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754449Ab1G0RYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 13:24:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55606
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572Ab1G0RYM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 13:24:12 -0400
Received: (qmail 342 invoked by uid 107); 27 Jul 2011 17:24:42 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 13:24:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 11:24:09 -0600
Content-Disposition: inline
In-Reply-To: <CACsJy8ByDUByZiX43_+4_49uB+h0AMCk9J+35kZJSKgBn2KZbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177983>

On Wed, Jul 27, 2011 at 04:02:48PM +0700, Nguyen Thai Ngoc Duy wrote:

> I was thinking of it as an extension of "git log -Sregex", where as -S
> shows full diff of matched files, the new option only shows hunks that
> actually match. Not sure if that is really useful though. On the other
> hand, "git diff --hunk" is useful for me, I'll see if I can add that
> option.

I think it is more like "log -Gregex", which actually greps within the
diff. It would not be too hard to adapt the "-G" code to return the set
of hunks, rather than a simple "yes we have it". If you did that, it
would make the perl bits way simpler: they would simply call "diff
-Gregex" when creating the patch.

I don't think "git diff --hunk" would be that hard, either. The
trickiest part is that the diff code tries to output lines as soon as we
get them. You'd have to buffer whole chunks.

-Peff
