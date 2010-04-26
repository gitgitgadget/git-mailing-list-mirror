From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Mon, 26 Apr 2010 14:07:32 -0400
Message-ID: <20100426180731.GB4012@coredump.intra.peff.net>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
 <20100425194800.GB14736@coredump.intra.peff.net>
 <20100425220955.GA25620@progeny.tock>
 <20100426172235.GA626@coredump.intra.peff.net>
 <20100426175707.GB11022@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Cheng Renquan <crquan@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 20:07:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Sia-0001Cf-UC
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 20:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753482Ab0DZSHe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 14:07:34 -0400
Received: from peff.net ([208.65.91.99]:50858 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab0DZSHd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 14:07:33 -0400
Received: (qmail 12852 invoked by uid 107); 26 Apr 2010 18:07:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 26 Apr 2010 14:07:43 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Apr 2010 14:07:32 -0400
Content-Disposition: inline
In-Reply-To: <20100426175707.GB11022@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145839>

On Mon, Apr 26, 2010 at 12:57:08PM -0500, Jonathan Nieder wrote:

> > To be clear, I don't have any problem with the _functionality_. I j=
ust
> > think it probably should have been log.pretty, or pretty.default or
> > something. Too late now, though.
>=20
> Ah, sorry to be dense.  Maybe something like the following would work=
:
>=20
>  [log "format"]
> 	changelog =3D "* [%h] %s"

We usually reserve the [log "format"] for when "format" can be an
arbitrary string. I'm not sure if we can use some nicer syntax like
[log.format]; I'd have to experiment.

> This is rev-list=E2=80=99s code, and log is its most noticeable manif=
estation.

We also tend to refer to the log/show/whatchanged as "the log family of
commands". I think whatchanged is pretty much dead and historical at
this point, though.

> By the way: I just noticed today that rev-list is not very friendly
> when given a --pretty=3Dformat: specification:
>=20
>   $ git rev-list -1 --oneline HEAD
>   651b91e log --format=3Demail: fix confusing variable name
>   $ git rev-list -1 --format=3D'%h %s' HEAD
>   commit 651b91ef7a15a46145d65193c8709670b969161f
>   651b91e log --format=3Demail: fix confusing variable name
>=20
> Is this deliberate?  I mention it because I seem to remember from the
> discussion of --decorate configuration that scripts should be using
> rev-list in preference to log even when a --format option is involved=
=2E

I'm not sure it's deliberate, as in somebody thought it was a good idea=
=2E
But it has always been that way, and I think it has been deliberate tha=
t
we not change it. I agree it is unfriendly.

I think we have accepted that scripts will use log because of its
enhanced features (gitk does), but we generally suppress extra output
(like decorations or notes) for at least --pretty=3Draw and
--pretty=3Dformat.

-Peff
