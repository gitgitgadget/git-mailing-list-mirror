From: Jeff King <peff@peff.net>
Subject: Re: 'git status -z' missing separators on OSX
Date: Wed, 17 Jun 2015 15:17:04 -0400
Message-ID: <20150617191703.GC25304@peff.net>
References: <20150617140738.UMQU25489.txasav-vm07.suddenlink.net@[10.1.40.186]>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Tad Hardesty <tad@platymuus.com>
To: Tad Hardesty <tad.hardesty@suddenlink.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 21:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Ipp-0005M5-6V
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 21:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757097AbbFQTRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2015 15:17:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:47590 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751605AbbFQTRG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 15:17:06 -0400
Received: (qmail 30438 invoked by uid 102); 17 Jun 2015 19:17:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 14:17:06 -0500
Received: (qmail 28337 invoked by uid 107); 17 Jun 2015 19:17:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 Jun 2015 15:17:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 Jun 2015 15:17:04 -0400
Content-Disposition: inline
In-Reply-To: <20150617140738.UMQU25489.txasav-vm07.suddenlink.net@[10.1.40.186]>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271885>

On Wed, Jun 17, 2015 at 09:07:36AM -0500, Tad Hardesty wrote:

> Everything looks normal using the commands you described, and it does=
 appear to only affect status:
>=20
> ~/test (master)$ type git
> git is hashed (/usr/local/bin/git)
> ~/test (master)$ git config --list
> core.repositoryformatversion=3D0
> core.filemode=3Dtrue
> core.bare=3Dfalse
> core.logallrefupdates=3Dtrue
> core.ignorecase=3Dtrue
> core.precomposeunicode=3Dtrue
> ~/test (master)$ GIT_TRACE=3D1 git status -z
> 08:59:11.806197 git.c:348=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace: built-in: git 'status' '=
-z'
> ~/test (master)$ git log --oneline -1 -z | hexdump -C
> 00000000=C2=A0 35 31 35 39 30 65 30 20=C2=A0 49 6e 69 74 69 61 6c 20=C2=
=A0 |51590e0 Initial |
> 00000010=C2=A0 63 6f 6d 6d 69 74 2e 00=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |commit..|
> 00000018
> ~/test (master)$ touch c d
> ~/test (master)$ git status -z | hexdump -C
> 00000000=C2=A0 3f 3f 20 63 3f 3f 20 64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |?? c?? d|
> 00000008
>=20
> This is again with 2.4.3 from git-scm.com.

Hmph. I don't really have any more ideas, then. I think my next step
would be to walk it through a debugger (the interesting function is
wt_shortstatus_status, or wt_shortstatus_other).

-Peff
