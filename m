From: Jeff King <peff@peff.net>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Wed, 27 Jul 2011 02:10:34 -0600
Message-ID: <20110727081034.GB8105@sigill.intra.peff.net>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net>
 <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net>
 <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
 <20110726060903.GA29486@sigill.intra.peff.net>
 <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
 <CACsJy8C822Fvwav4Wpw4e-12ZY20XM1s2v4KymZkaDYLxkMHvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 10:10:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlzCV-0006o8-Qj
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 10:10:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627Ab1G0IKi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 04:10:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34616
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752159Ab1G0IKh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 04:10:37 -0400
Received: (qmail 28570 invoked by uid 107); 27 Jul 2011 08:11:07 -0000
Received: from S010690840de80b38.ss.shawcable.net (HELO sigill.intra.peff.net) (70.64.172.81)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Jul 2011 04:11:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Jul 2011 02:10:34 -0600
Content-Disposition: inline
In-Reply-To: <CACsJy8C822Fvwav4Wpw4e-12ZY20XM1s2v4KymZkaDYLxkMHvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177944>

On Tue, Jul 26, 2011 at 08:03:01PM +0700, Nguyen Thai Ngoc Duy wrote:

> It would be even more cool if --hunks (or whatever the name will be)
> could work without -p. I mean, if "git diff" supports it, then I can
> fine tune my regex to meet a selection of hunks I want, and verify it
> really is what I want. Then "git add --hunks=magic" and voila! (The
> "git add --hunks" without -p surely can be workaround by adding "-p",
> then accept all hunks).

Yeah, doing "yes | git add -p --hunks=foo" would probably do what you
want. But you don't really have a good way of verifying what it will add
(you could check after the fact what's left in "git diff", or what's now
in "git diff --cached", of course).

> And if diff machinery learns this, we would have "git log --hunks" too.
> 
> OK I'm asking too much..

Probably. :)

I'm not sure how useful "log --hunks" would be. The changes you commit
don't tend to be that big (well, not if you're doing it right). It seems
much more likely to have the case you brought up, which is that some
file has a bunch of boring boilerplate that doesn't need to be
changed, and you need to pick out the interesting changes from the
boilerplate changes.

I suppose if somebody committed all of the boilerplate changes (like .po
comment changes), then you would want to be able to pick them apart. But
that just seems like the wrong thing (i.e., if those comments really are
uninteresting, they should not be committed). But I don't work with .po
files at all, so maybe there is a good reason to commit them.

-Peff
