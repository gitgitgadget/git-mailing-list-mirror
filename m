From: Jeff King <peff@peff.net>
Subject: Re: Silent maintenance
Date: Sat, 14 Aug 2010 18:04:10 -0400
Message-ID: <20100814220410.GA16592@coredump.intra.peff.net>
References: <20100814131156.GA24769@nibiru.local>
 <20100814210556.GB2372@burratino>
 <AANLkTimLHand0g965TJmk=Y4Q+0uTFovZZRZXf9Fx4UB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 00:04:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkOqD-0006EG-2e
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 00:04:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756731Ab0HNWEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 18:04:20 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756490Ab0HNWET (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 18:04:19 -0400
Received: (qmail 15969 invoked by uid 111); 14 Aug 2010 22:04:18 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO coredump.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) ESMTPSA; Sat, 14 Aug 2010 22:04:18 +0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Aug 2010 18:04:10 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTimLHand0g965TJmk=Y4Q+0uTFovZZRZXf9Fx4UB@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153585>

On Sat, Aug 14, 2010 at 09:41:44PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> On Sat, Aug 14, 2010 at 21:05, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> > Enrico Weigelt wrote:
> >
> >> are there some flags to make the maintenance commands like
> >> git-repack and git-gc silent, so they only output errors ?
> >
> > Does --quiet work? =C2=A0If not, patches would be welcome.
>=20
> I intentionally neglected to mention that. That inevitably leads to
> cases where something fails, but you didn't record the output.

I'm confused. Isn't the point of quiet to silence all of the cruft, and
leave only actual errors?

  $ git gc
  Counting objects: 128, done.
  Compressing objects: 100% (49/49), done.
  Writing objects: 100% (128/128), done.
  Total 128 (delta 71), reused 121 (delta 68)

  $ git gc --quiet

  $ chmod -w .git/objects/pack
  $ git gc --quiet
  fatal: Unable to create temporary file: Permission denied
  error: failed to run repack

Isn't that what the OP wanted?

> cronjob(1) will consume all the output, and either print it all or
> nothing, depending on the exit code of the program it's running.

That is a good solution for broken programs that have no "print only
errors" mode, but I don't think git is one of those (and if it is, we
should fix it).

-Peff
