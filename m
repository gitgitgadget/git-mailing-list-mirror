From: Jeff King <peff@peff.net>
Subject: Re: [RFC] control, what refs are honored by core.logAllRefUpdates
Date: Wed, 13 Jul 2011 04:59:15 -0400
Message-ID: <20110713085915.GA29900@sigill.intra.peff.net>
References: <CAKPyHN3_br-ndQo9oMzCcU1yOVEbAxmzvHQkwF15LgwQx12KZA@mail.gmail.com>
 <7vaacj8jq7.fsf@alter.siamese.dyndns.org>
 <CAKPyHN0+BaPtrRMVrWCZQ2mbJQz_vxsOOsG4Z=Ksqc1RJvF1Ew@mail.gmail.com>
 <20110712182517.GA17787@sigill.intra.peff.net>
 <CAKPyHN1GEkcyacQ_f4hhjaaZx4Fx4tmfz0qRSfTPXJDgUm8mow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Jul 13 10:59:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgvIA-0004z0-C2
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 10:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091Ab1GMI7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jul 2011 04:59:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45528
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965037Ab1GMI7U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 04:59:20 -0400
Received: (qmail 23308 invoked by uid 107); 13 Jul 2011 08:59:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 04:59:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 04:59:15 -0400
Content-Disposition: inline
In-Reply-To: <CAKPyHN1GEkcyacQ_f4hhjaaZx4Fx4tmfz0qRSfTPXJDgUm8mow@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177018>

On Wed, Jul 13, 2011 at 10:52:58AM +0200, Bert Wesarg wrote:

> On Tue, Jul 12, 2011 at 20:25, Jeff King <peff@peff.net> wrote:
>  [1] If we were starting from scratch, you could make that distinctio=
n
> > with a new operator, like:
> >
> > =C2=A0[core]
> > =C2=A0 =C2=A0autoLogRef =3D heads
> > =C2=A0 =C2=A0autoLogRef +=3D remotes
> > =C2=A0 =C2=A0autoLogRef +=3D notes
> > =C2=A0 =C2=A0autoLogRef =3D heads
> >
> > which would be equivalent to what you wrote above. But because it
> > switches the semantics of "=3D" to "replace" instead of "append" fo=
r
> > multi-value keys, it would break all current config that uses multi=
ple
> > "fetch" lines (for example).
>=20
> Adding ! as a negator would also break config files read by old git v=
ersions.

True. I consider that less bad than "existing config files are broken",
but it is still worth thinking about. It really only affects people who
move back and forth between git versions using the same set of config
files.

In general, our config stays pretty compatible between versions, but
there are exceptions. E.g., older versions of git will complain about:

  [pager]
    log =3D whatever

because "pager.*" previously had to be a bool. I run into this when
testing old git versions.

I have no idea how common that sort of thing is with regular users,
though.

-Peff
