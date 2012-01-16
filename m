From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test_interactive: interactive debugging in test scripts
Date: Mon, 16 Jan 2012 15:11:23 -0500
Message-ID: <20120116201123.GA18699@sigill.intra.peff.net>
References: <4F133069.10308@web.de>
 <20120115232413.GA14724@sigill.intra.peff.net>
 <20120116154953.GA21238@padd.com>
 <4F148211.70106@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Wyckoff <pw@padd.com>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 21:11:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmstv-0002nc-F5
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 21:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754670Ab2APUL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 15:11:27 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39434
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754199Ab2APUL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 15:11:26 -0500
Received: (qmail 17717 invoked by uid 107); 16 Jan 2012 20:18:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Jan 2012 15:18:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jan 2012 15:11:23 -0500
Content-Disposition: inline
In-Reply-To: <4F148211.70106@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188649>

On Mon, Jan 16, 2012 at 09:01:21PM +0100, Jens Lehmann wrote:

> So I vote for your patch as it takes my initial idea even further. I
> really like that HOME, TERM and SHELL are honored in your version
> leaving the user with a fully functional shell of his choice.

I'm actually mildly negative on this feature, as it interferes with the
tests themselves. Probably TERM and SHELL don't matter. But $HOME means
git will read your personal .gitconfig, not any config (or lack thereof)
in the trash directory.

I've personally been left head-scratching in the past by:

  $ ./tXXXX-foo -v -i
  ...
  expecting success: git foo
  not ok - 1 git foo

  $ cd trash\ directory.tXXXX-foo
  $ git foo ;# and it works!

where the culprit was a non-clean environment caused by my personal git
config (or very occasionally, something else in $HOME).

-Peff
