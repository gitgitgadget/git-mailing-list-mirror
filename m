From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Add Author and Documentation sections to
 git-for-each-ref.txt
Date: Thu, 17 Mar 2011 02:59:55 -0400
Message-ID: <20110317065955.GE11931@sigill.intra.peff.net>
References: <1299590170-30799-1-git-send-email-alcosholik@gmail.com>
 <1299590170-30799-3-git-send-email-alcosholik@gmail.com>
 <4D773570.4010803@drmicha.warpmail.net>
 <7voc5k9hfy.fsf@alter.siamese.dyndns.org>
 <20110310223732.GE15828@sigill.intra.peff.net>
 <AANLkTinzJ7C_Eym20Y3rP3d7hiviPBiCAfdwXGFa4P54@mail.gmail.com>
 <20110313030214.GB10452@sigill.intra.peff.net>
 <7vsjuril5r.fsf@alter.siamese.dyndns.org>
 <20110313064710.GA13135@sigill.intra.peff.net>
 <7vd3lviie7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexei Sholik <alcosholik@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:00:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q07Bi-0005Nk-Ud
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 08:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846Ab1CQG76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 02:59:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55458
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751689Ab1CQG75 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 02:59:57 -0400
Received: (qmail 20976 invoked by uid 107); 17 Mar 2011 07:00:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 03:00:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 02:59:55 -0400
Content-Disposition: inline
In-Reply-To: <7vd3lviie7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169214>

On Sat, Mar 12, 2011 at 11:33:52PM -0800, Junio C Hamano wrote:

> > Git-cherry sort of does this, but patch-ids miss a lot of cases: patches
> > tweaked in transit, patches applied on a different commit, or even
> > patches taken partially or split up. So I rebase frequently, and as
> > patches get picked up in master, the branches dwindle to empty.
> > Suggestions welcome if anybody else has figured out something clever.
> 
> A solution to string different iterations of the same patch together,
> perhaps using notes as the storage media, that makes it easier to view the
> changes between different iterations?  I think Shawn does something like
> that in Gerrit code review.

I don't necessarily care about different iterations of the patch on my
end. Usually when I discard an old version I don't go back to it, and in
the rare case that I do, it is simple enough to pull it from the reflog
or from the mailing list.

What I mean is lining up what I have locally (and what I send) with what
ends up in your repository. Which can have arbitrary changes from the
original. I don't think there is a general solution. In theory you could
take a single patch of mine, split it into two, then mark up each half.
I know you have the sense not to do this, but there are simpler cases
that still cause problems.

For example, in my recent trace-sifter series, you took some squashes
from other people on the early bits, and those impacted the text of
later bits. So there was no way for patch-id to link up the patches.

Rebasing at least faces me with the conflicts over the rewrite, and I
can manually check each conflict and say "OK, it looks like he took my
patch, but this part had to be rewritten". And then I can either accept
your rewrite (by resolving in favor of you), or I can rework my patch to
do what I think should be done on top of yours, and then submit my new
one on top.

I could also use Jay's suggested "loose patch id", and link things up by
commit author and message. Unless you do something drastic like
splitting a patch in two (or merging two patches into one), then I can
create the correlation. But it makes me a little nervous, because the
content of your version may not be the same as mine. And probably I
should be reviewing it before throwing away my version in favor of
yours.

-Peff
