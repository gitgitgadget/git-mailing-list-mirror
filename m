From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 3/4] t: rev-parse-parents: avoid yoda conditions
Date: Tue, 3 Sep 2013 13:10:06 +0200
Message-ID: <20130903111006.GJ29840@goldbirke>
References: <1378103439-3225-1-git-send-email-felipe.contreras@gmail.com>
 <1378103439-3225-4-git-send-email-felipe.contreras@gmail.com>
 <20130903071256.GD3608@sigill.intra.peff.net>
 <20130903075107.GA25540@goldbirke>
 <20130903080358.GA30158@sigill.intra.peff.net>
 <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 13:10:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGoV9-0000g9-5V
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 13:10:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755598Ab3ICLKX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Sep 2013 07:10:23 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:55841 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752699Ab3ICLKW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 07:10:22 -0400
Received: from localhost6.localdomain6 (94-21-69-136.pool.digikabel.hu [94.21.69.136])
	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)
	id 0MQOHk-1VQgwl0I8q-00TpGs; Tue, 03 Sep 2013 13:10:07 +0200
Content-Disposition: inline
In-Reply-To: <CAMP44s112mwgs=8n0XCnTtPM2V-O5RYE2ns+fjCvgkxj+kEY8Q@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:Ji7plfNhJwA8eZSKc441vRgGhd8j1caj0NqPYASCqS1
 PDNbgSeeTAb1UvNo/VD3vfpyBci+1oNNf6jBJ7UghbBdE4l4Lc
 6CUFlS6k0IgGLde3YCAIoJushiKkb0AWf5L2WnLEpV/we0VKTC
 Z2LlO/7RdBGPqrkjcjRGyyZWH+MlbuoIKFmgZK9Ji5+QUOiqSX
 UFkmsQPypANfpJisx1vhuRLeISC4sz0CiuoJ9crDnT7GWsKqCm
 2rgYcJcxYNtwcXNp3qVfX3HwXCKJd1wqLUGUIP/zb+lCQOOq/g
 4+wRcwUnyxFsrglm2iBGaPlm7LZVsmT2vdWdqZ+a2IoqtOAj5X
 jWZuLyl5EQa+ZeZqu1fiHdPOrti4D7WpxIwRB26R0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233715>

On Tue, Sep 03, 2013 at 05:45:06AM -0500, Felipe Contreras wrote:
> On Tue, Sep 3, 2013 at 3:03 AM, Jeff King <peff@peff.net> wrote:
> > On Tue, Sep 03, 2013 at 09:51:07AM +0200, SZEDER G=E1bor wrote:
> >
> >> > I wonder if we should have a:
> >> >
> >> >   test_cmp_args () {
> >> >           echo "$1" >expect &&
> >> >           echo "$1" >actual &&
> >> >           test_cmp expect actual
> >> >   }
> >> >
> >> > to let these remain one-liners like:
> >> >
> >> >   test_cmp_args "$(git rev-parse start)" "$(git rev-parse final^=
1^1^1)"
> >>
> >> This idea come up before, but there is one flaw which makes this
> >> function less useful: a non-zero exit code of the commands in the
> >> command substitutions would be lost.
> >
> > Good point. You'd probably have to do something gross with eval, li=
ke:
> >
> >   test_cmp_args () {
> >     eval "$1" >expect &&
> >     eval "$2" >actual &&
>=20
> I don't see any reason to perpetuate these yoda comparisons.
>=20
> eval "$2" >expect &&
> eval "$1" >actual &&

I do.  Your proposal requires the arguments in the reverse order
compared to test_cmp.  That inconsistency would be far worse than
test_cmp_args "$expect" "$actual".

> >     test_cmp expect actual
> >   }


Best,
G=E1bor
