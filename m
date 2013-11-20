From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7507-*.sh: Fix test #8 (could not run '"$FAKE_EDITOR"')
Date: Wed, 20 Nov 2013 14:01:29 -0500
Message-ID: <20131120190129.GA7285@sigill.intra.peff.net>
References: <528CE716.8060307@ramsay1.demon.co.uk>
 <xmqqsiur6l9k.fsf@gitster.dls.corp.google.com>
 <20131120174226.GA16453@sigill.intra.peff.net>
 <xmqqhab67wjr.fsf@gitster.dls.corp.google.com>
 <20131120185420.GA11404@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>, Jens.Lehmann@web.de,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 20 20:01:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjD1r-0000Uj-QZ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 20:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754738Ab3KTTBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Nov 2013 14:01:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:42750 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754668Ab3KTTBb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Nov 2013 14:01:31 -0500
Received: (qmail 29856 invoked by uid 102); 20 Nov 2013 19:01:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Nov 2013 13:01:31 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Nov 2013 14:01:29 -0500
Content-Disposition: inline
In-Reply-To: <20131120185420.GA11404@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238092>

On Wed, Nov 20, 2013 at 01:54:20PM -0500, Jeff King wrote:

> I'm not sure why the old $FAKE_EDITOR doesn't work there, though (not
> that it would make the test pass anyway, as it does something different
> than what the test wants, but I would not expect the shell to complain
> of failure).

Oh, I see. The original FAKE_EDITOR is:

  exec grep '^diff --git' "\$1"

But the whole point of the test is that we do not have such a "diff"
header, being only a submodule update, and so grep exits non-zero, and
git thinks the editor has failed.

So mystery solved, and the sole problem is the proper setting of the
variable.

-Peff
