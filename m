From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Mon, 28 Apr 2014 16:03:26 -0400
Message-ID: <20140428200326.GA2961@sigill.intra.peff.net>
References: <20140428161630.GA9435@sigill.intra.peff.net>
 <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com>
 <20140428193502.GD25993@sigill.intra.peff.net>
 <535EB167.4030804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:03:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Werm2-0003eY-NA
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 22:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997AbaD1UDa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2014 16:03:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:40654 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752632AbaD1UD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 16:03:29 -0400
Received: (qmail 15612 invoked by uid 102); 28 Apr 2014 20:03:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 15:03:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 16:03:26 -0400
Content-Disposition: inline
In-Reply-To: <535EB167.4030804@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247433>

On Mon, Apr 28, 2014 at 09:52:07PM +0200, Torsten B=C3=B6gershausen wro=
te:

> To my knowledge repos with decomposed unicode should be rare in
> practice.  I only can speak for european (or latin based) or cyrillic
> languages myself:

I've run across several cases in the past few months, but only just
figured out what was going on. Most were tickets to GitHub support, but
we actually have such a case in our github/github repository. In most
cases, I think they were created on older versions of git on OS X,
either before core.precomposeunicode existed, or before it was turned o=
n
by default. The decomposed form got baked into the tree (whatever the
user originally typed, git probably found out about it via "git add .")=
=2E

I think reports are just coming in now because we didn't start turning
on core.precomposeunicode by default until v1.8.5, shipped in November.
And then, a person working on the repository would not notice anything,
since we only set the flag during clone. So it took time for people to
upgrade _and_ to make fresh clones.

> So for me the test case could sense, even if I think that nobody (TM)
> uses an old Git version under Mac OS X which is not able to handle
> precomposed unicode.

Even when they do not, the decomposed values are baked into history fro=
m
those old versions. So it is a matter of history created with older
versions not interacting well with newer versions.

-Peff
