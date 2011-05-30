From: Jeff King <peff@peff.net>
Subject: Re: Git global usage and tests
Date: Mon, 30 May 2011 11:36:20 -0400
Message-ID: <20110530153620.GA24431@sigill.intra.peff.net>
References: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Romain Geissler <romain.geissler@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 30 17:36:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QR4W4-0003oo-VU
	for gcvg-git-2@lo.gmane.org; Mon, 30 May 2011 17:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757223Ab1E3PgX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 May 2011 11:36:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35873
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359Ab1E3PgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2011 11:36:23 -0400
Received: (qmail 16669 invoked by uid 107); 30 May 2011 15:36:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 30 May 2011 11:36:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 30 May 2011 11:36:20 -0400
Content-Disposition: inline
In-Reply-To: <754E784F-51C6-4B8D-B15D-3FF8B7AF1321@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174755>

On Mon, May 30, 2011 at 04:58:14PM +0200, Romain Geissler wrote:

> Indeed the test t2050-git-dir-relative.sh run :
> 
> echo changed >top &&
> git --git-dir subdir/.git add top &&
> git --git-dir subdir/.git commit -m topcommit &&
> test -r "${COMMIT_FILE}"
> 
> But according to the git help, it should have specified a git-dir with --git-dir=value ie
> git --git-dir=subdir/.git add top

The test is OK. Long options that have a required argument can be
expressed as either:

  --long-option=value

or

  --long-option value

Long options with an optional argument must use the first form, as the
second one is ambiguous (is "value" the value, or the next option?).

Your option parser needs to follow these rules to be compatible with
git. Have you considered pulling the parse-options parser from git into
libgit2? It's one of the more modularized and lib-ified bits of code in
git already.

-Peff
