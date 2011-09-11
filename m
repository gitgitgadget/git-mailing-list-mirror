From: Jeff King <peff@peff.net>
Subject: Re: "git archive" seems to be broken wrt zip files
Date: Sun, 11 Sep 2011 02:22:06 -0400
Message-ID: <20110911062206.GA29620@sigill.intra.peff.net>
References: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 11 08:22:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2dQm-0002GU-R1
	for gcvg-git-2@lo.gmane.org; Sun, 11 Sep 2011 08:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896Ab1IKGWK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Sep 2011 02:22:10 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58206
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751553Ab1IKGWJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Sep 2011 02:22:09 -0400
Received: (qmail 20055 invoked by uid 107); 11 Sep 2011 06:23:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 11 Sep 2011 02:22:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 11 Sep 2011 02:22:06 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFx43OxExGNrJs+AyKNtdr+KCZZoE=iaQTz8uHoUSrQv0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181166>

On Sat, Sep 10, 2011 at 09:58:08PM -0700, Linus Torvalds wrote:

> So I wouldn't ever have noticed on my own, but now that I've tried
> github for the kernel, somebody else reported that the downloaded zip
> file (seriously? the kernel as a zip file?) is corrupt.
>=20
> And it doesn't really seem to be a github issue. I can re-create it
> with a simple
>=20
>    git archive --format=3Dzip HEAD -o ../kernel.zip
>=20
> on my kernel repository: the end result does not unzip correctly:

Hmm. I can easily replicate the problem here, but interestingly it does
not happen with sub-trees like:

  git archive --format=3Dzip HEAD:drivers -o ../kernel.zip

Going back in history, I can replicate it with Ren=C3=A9's 62cdce1
(git-archive --format=3Dzip: add symlink support, 2006-10-07). So there=
's
nothing to bisect.

Cc'ing Ren=C3=A9.

-Peff
