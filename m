From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 09:51:07 +0200
Message-ID: <20130903075107.GA25540@goldbirke>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:51:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlON-00013o-1w
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315Ab3ICHvL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 03:51:11 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:51173 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759537Ab3ICHvK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:51:10 -0400
Received: from localhost6.localdomain6 (94-21-69-136.pool.digikabel.hu [94.21.69.136])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0MXjM2-1VTUoX3jvC-00WZ1r; Tue, 03 Sep 2013 09:51:08 +0200
Content-Disposition: inline
In-Reply-To: <20130903071256.GD3608@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:la8L5t4y6dBf5kbwSDYH2Z3XnDUHzrf/A9chXGzF5o+
 kIuasAt3AyCAOOBq8PCnQ4b2mlBFxtoRaxj7KOWsvrimHVfXZD
 gr6Or44Ae1gA3m+kK+WwUdxB+YccvMOaTvDjRqF2ofvG59shrj
 256GGScncv9Rqq4A7fiv709/tAHN1cYAo9imwIFy+abzdm+BSP
 3D1ySWZKq5FysM4cuyuEeA5E6S9j1v4bb0vbBoql6YoT9Z02ur
 8/2Q4YGhbkzohGh1HyM7hc2dQxonCdKugzrlOZ2ZUBzqwf3kXS
 2X19QUS3kYG8snLSzx1E1ZjFkCYMlIH1TOxEuXYmDMHJRq13IU
 zHm+c4ln8Vccq65IsT6E=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233705>

Hi,

On Tue, Sep 03, 2013 at 03:12:56AM -0400, Jeff King wrote:
> On Mon, Sep 02, 2013 at 01:30:38AM -0500, Felipe Contreras wrote:
>=20
> > Just as 5 =3D=3D X is weird, so is comparing first the expected val=
ue, and
> > then the value we are testing. So switch them around.
>=20
> Actually, our normal comparison order for test output is "test_cmp
> expect actual", as it shows a test failure as a diff with the expecte=
d
> output as the base (i.e., the diff shows what went wrong).
>=20
> That reasoning does not apply to "test a =3D b", which shows no outpu=
t at
> all. However, if you want to clean up and modernize these tests, it
> would probably be better to simply convert them to use test_cmp.
>=20
> I wonder if we should have a:
>=20
>   test_cmp_args () {
>           echo "$1" >expect &&
>           echo "$1" >actual &&
>           test_cmp expect actual
>   }
>=20
> to let these remain one-liners like:
>=20
>   test_cmp_args "$(git rev-parse start)" "$(git rev-parse final^1^1^1=
)"

This idea come up before, but there is one flaw which makes this
function less useful: a non-zero exit code of the commands in the
command substitutions would be lost.

  http://thread.gmane.org/gmane.comp.version-control.git/226699/focus=3D=
227361


Best,
G=E1bor
