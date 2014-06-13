From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git-fetch obey -c "remote.origin.url" on the
 command-line?
Date: Fri, 13 Jun 2014 03:51:11 -0400
Message-ID: <20140613075110.GH7908@sigill.intra.peff.net>
References: <CACBZZX4MyaOKkCvTSKhZtyRMFvpBMiMGz2ix3OxMz_s=P-=p=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:51:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvMGd-00058p-QV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbaFMHvO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jun 2014 03:51:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:43255 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751536AbaFMHvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:51:12 -0400
Received: (qmail 10623 invoked by uid 102); 13 Jun 2014 07:51:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 02:51:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 03:51:11 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX4MyaOKkCvTSKhZtyRMFvpBMiMGz2ix3OxMz_s=P-=p=w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251529>

On Fri, Jun 13, 2014 at 09:37:07AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On a git built from the master branch just now:
>=20
>  $ ./git config remote.origin.url
> https://code.google.com/p/git-core/
> $ ./git -c remote.origin.url=3Dgit://git.sourceforge.jp/gitroot/git-c=
ore/git.git
> config remote.origin.url
> git://git.sourceforge.jp/gitroot/git-core/git.git
> $ GIT_TRACE=3D1 ./git -c
> remote.origin.url=3Dgit://git.sourceforge.jp/gitroot/git-core/git.git
> fetch 2>&1 | head -n 2
> trace: built-in: git 'fetch'
> trace: run_command: 'git-remote-https' 'origin'
> 'https://code.google.com/p/git-core/'
>=20
> I'd expect this to try to fetch from the remote.origin.url I specifie=
d
> on the command-line, but for some reason fetch doesn't pick that up.
> Isn't this a bug?

I think this is an alternate version of the report in [1].

The short answer is: remote.*.url is a multi-valued config option, and
you can only append to (not override) such options with "git -c". Try
using insteadOf.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/250427
