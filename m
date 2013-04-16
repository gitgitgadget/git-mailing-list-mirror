From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Mon, 15 Apr 2013 20:53:22 -0400
Message-ID: <20130416005322.GB14995@sigill.intra.peff.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <20130415232532.GA7134@sigill.intra.peff.net>
 <CAA787rmJKNGF_4koHJpdzbAVjvLB-sWxT__secVRDBi1ieBYnQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?Q?=C3=98yvind_A=2E?= Holm <sunny@sunbase.org>
X-From: git-owner@vger.kernel.org Tue Apr 16 02:53:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URu9S-0005c8-St
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 02:53:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934799Ab3DPAxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Apr 2013 20:53:34 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47313 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935113Ab3DPAx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 20:53:29 -0400
Received: (qmail 31535 invoked by uid 107); 16 Apr 2013 00:55:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 20:55:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 20:53:22 -0400
Content-Disposition: inline
In-Reply-To: <CAA787rmJKNGF_4koHJpdzbAVjvLB-sWxT__secVRDBi1ieBYnQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221338>

On Tue, Apr 16, 2013 at 01:49:13AM +0200, =C3=98yvind A. Holm wrote:

> > [1] I know you always test master before pushing it out, but I susp=
ect
> >     you do not run the GIT_TEST_HTTPD tests. The failures are in t5=
541
> >     and t5551.
>=20
> Ah, that explains why the test suite passed here, I built a new
> version an hour ago from current master (v1.8.2.1-418-gaec3f77,
> 2013-04-15 12:45:15 -0700), and no errors were found. I build new git=
s
> almost every day for testing purposes (master, and next and maint ver=
y
> often) on several machines with different setups, and of course also
> to have the newest version. I'd like to run as many tests as possible=
=2E
> Is there any list of environment variables or make directives
> available to enable most of them?

I don't think there's a master list anywhere. The simplest thing is
probably to run the whole suite and grep for skipped tests, each of
which should usually explain their reasoning for the skip. Like:

  make test | grep '# skip'

Note that this will turn up more than just environment variables to set=
=2E
It will also turn up missing programs you might need to install to run
the tests (e.g., we do not do subversion tests if svn is not installed)=
=2E
Which is a good thing if you are trying for complete test coverage. But
it will also turn up useless things that are just fundamental to your
platform (e.g., you cannot do both the case-sensitive and the
case-insensitive filesystem tests).

Most of the tests are on by default, unless necessary programs are
missing or you explicitly disable them. GIT_TEST_HTTPD and
GIT_TEST_GIT_DAEMON seem to be the exceptions.

-Peff
