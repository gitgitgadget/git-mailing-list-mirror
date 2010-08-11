From: Jeff King <peff@peff.net>
Subject: Re: Git thinks a failing command doesn't exist
Date: Wed, 11 Aug 2010 15:25:55 -0400
Message-ID: <20100811192554.GA8106@coredump.intra.peff.net>
References: <AANLkTin7E-v9TYd1KoD73knnSwSMy-V-pvS0TmpQd72M@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 21:26:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGwA-0001RB-Df
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756217Ab0HKT0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:26:00 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:37703 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756187Ab0HKT0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:26:00 -0400
Received: (qmail 6490 invoked by uid 111); 11 Aug 2010 19:25:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Wed, 11 Aug 2010 19:25:58 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Aug 2010 15:25:55 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin7E-v9TYd1KoD73knnSwSMy-V-pvS0TmpQd72M@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153290>

On Wed, Aug 11, 2010 at 07:12:38PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> Has this been noted before:
>=20
>     $ git rebase --continue
>     .: 986: Can't open /home/avar/g/git/.git/rebase-merge/author-scri=
pt
>     git: 'rebase' is not a git command. See 'git --help'.
>     Did you mean this?
>             rebase
>=20
> Rebase failed, but the help mechanism seems to just test the exit
> code, or something similar.

Which git version and which platform? There is code in run-command to
check for an exit code of 127 (which is what posix shells should produc=
e
for a missing command), and to set ENOENT in that case, which is what
execv_dashed_external notices for a missing command.

So either your shell is producing that exit code for a different case,
or git is broken.

-Peff
