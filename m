From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] HOME must be set before calling git-init when creating
 test repositories
Date: Sat, 26 Mar 2011 14:31:02 -0400
Message-ID: <20110326183102.GA3796@sigill.intra.peff.net>
References: <20110325200528.GA7302@blimp.localdomain>
 <7vsjub53j2.fsf@alter.siamese.dyndns.org>
 <AANLkTimQzPVOWCUx1hr+DEmRfdFB8=UeY_xCaxzVSwFy@mail.gmail.com>
 <7voc4y6g6v.fsf@alter.siamese.dyndns.org>
 <AANLkTikO4=TtFtpsQ_JtmGKqQ1NzgTuo7e8cdaQca+T7@mail.gmail.com>
 <7vvcz64ygm.fsf@alter.siamese.dyndns.org>
 <AANLkTi=+SZGxLyP8vFPpmK8DZvke6-Tu-crwq5+89qWx@mail.gmail.com>
 <20110326141118.GA3475@sigill.intra.peff.net>
 <20110326182126.GA13496@blimp.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 19:31:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3YGW-0000HP-0l
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 19:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab1CZSbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Mar 2011 14:31:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33659
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481Ab1CZSbF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Mar 2011 14:31:05 -0400
Received: (qmail 25735 invoked by uid 107); 26 Mar 2011 18:31:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Mar 2011 14:31:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Mar 2011 14:31:02 -0400
Content-Disposition: inline
In-Reply-To: <20110326182126.GA13496@blimp.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170064>

On Sat, Mar 26, 2011 at 07:21:26PM +0100, Alex Riesen wrote:

> > No, it's totally broken. $(pwd)/$test is nonsensical. The code right
> > above your change guarantees that $test is an absolute path, either
> > because the user gave us an absolute $root or because it has been
> > prepended with $TEST_DIRECTORY (which itself comes from $(pwd)).
> 
> I see. I mistook "$root" for the root of a filesystem, not the variable in
> test-lib.sh. How about this, than?

Oops, when I said "$test" I meant to say $TRASH_DIRECTORY. That is,
$TRASH_DIRECTORY is always the absolute path to the trash.

> +HOME="$(pwd)/$test"
> +test -n "$root" && HOME="$test"
> +export HOME

So you can simplify this to just:

HOME=$TRASH_DIRECTORY

and not have to worry about checking $root at all.

Sorry for the confusion.

-Peff
