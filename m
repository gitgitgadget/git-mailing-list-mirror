From: Jeff King <peff@peff.net>
Subject: Re: RFC: "git config -l" should not expose sensitive information
Date: Thu, 20 Dec 2012 10:04:08 -0500
Message-ID: <20121220150408.GD27211@sigill.intra.peff.net>
References: <50CF039A.7010800@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 20 16:04:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tlhfg-0006Jk-QB
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 16:04:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119Ab2LTPEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Dec 2012 10:04:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:59695 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750908Ab2LTPEK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2012 10:04:10 -0500
Received: (qmail 9662 invoked by uid 107); 20 Dec 2012 15:05:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Dec 2012 10:05:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Dec 2012 10:04:08 -0500
Content-Disposition: inline
In-Reply-To: <50CF039A.7010800@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211895>

On Mon, Dec 17, 2012 at 12:35:54PM +0100, Toralf F=C3=B6rster wrote:

> often the output is requested in help forums - and a
> "git config -l | wgetpaste" exposes parameters like sendmail.smtppass=
 -
> so hide those variables in the output (if not explicitly wanted) woul=
d
> makes sense, or ?

But if we change "git config -l", won't that break all of the
non-exposing uses that rely on seeing all of the variables (e.g., it is
perfectly fine for a porcelain to parse "git config -l" rather than
making several calls to "git config"; IIRC, git-cola does this).

The problem seems to be that people are giving bad advice to tell peopl=
e
to post "git config -l" output without looking at. Maybe we could help
them with a "git config --share-config" option that dumps all config,
but sanitizes the output. It would need to have a list of sensitive key=
s
(which does not exist yet), and would need to not just mark up things
like smtppass, but would also need to pull credential information out o=
f
remote.*.url strings. And maybe more (I haven't thought too long on it)=
=2E

-Peff
