From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Best way to apply textconv to a working tree file
Date: Tue, 01 Jun 2010 19:30:36 +0200
Message-ID: <vpqtypmaceb.fsf@bauges.imag.fr>
References: <a1ace6b77167a2ad4b4995e8c4d09761@ensimag.fr>
	<vpqd3walot1.fsf@bauges.imag.fr>
	<20100601171359.GD9702@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: clement.poulain@ensimag.imag.fr, git@vger.kernel.org,
	diane.gasselin@ensimag.imag.fr, axel.bonnet@ensimag.imag.fr
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 01 19:30:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJVIh-0001IC-Id
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 19:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755580Ab0FARar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 13:30:47 -0400
Received: from mx1.imag.fr ([129.88.30.5]:46718 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695Ab0FARaq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 13:30:46 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id o51HNHvo006849
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 1 Jun 2010 19:23:17 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1OJVIS-0008GQ-Qe; Tue, 01 Jun 2010 19:30:36 +0200
In-Reply-To: <20100601171359.GD9702@sigill.intra.peff.net> (Jeff King's message of "Tue\, 1 Jun 2010 13\:14\:00 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Tue, 01 Jun 2010 19:23:18 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o51HNHvo006849
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1276017801.06793@HHimK9P0aygZygH7d9k8Bw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148146>

Jeff King <peff@peff.net> writes:

>> git cat-file --textconv <blob-sha1>            # Run textconv on blo=
b
>
> This wouldn't work. The textconv is defined by the diff driver, which=
 is
> associated with a pathname,

Right, forget it.

>> git cat-file --textconv <tree-sha1>:<filename> # Run textconv on fil=
e
>>                                                # (in object database=
)
>
> This could work in theory, but will not be as easy to implement as yo=
u
> hope.

Actually, Cl=E9ment has already hit the issue.

> complex as "HEAD@{12:00 yesterday}:foo.c"

_that_ is the actual example I was looking for ;-) (with a : inside
the pathname to make sure you can't search it from the right).

> It would be nice if there was some way in the get_sha1* functions to
> save some context, like tree context and filename. This would be help=
ful
> for something like "git show HEAD:foo.txt", which probably should be
> respecting autocrlf and smudge/clean filters.

Yup. The code to do the parsing is already there, it "just" needs to
be made available through a clean API.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
