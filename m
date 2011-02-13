From: Jeff King <peff@peff.net>
Subject: Re: a bug about format-patch of multibyte characters comment
Date: Sun, 13 Feb 2011 05:03:50 -0500
Message-ID: <20110213100349.GA5483@sigill.intra.peff.net>
References: <4D565D3B.7060808@gmail.com>
 <20110213075337.GA12112@sigill.intra.peff.net>
 <201102131048.58111.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: xiaozhu <xiaozhu@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Feb 13 11:04:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoYoI-0000IG-R5
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 11:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab1BMKDw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Feb 2011 05:03:52 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59534 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753985Ab1BMKDu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 05:03:50 -0500
Received: (qmail 12725 invoked by uid 111); 13 Feb 2011 10:03:48 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sun, 13 Feb 2011 10:03:48 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 13 Feb 2011 05:03:50 -0500
Content-Disposition: inline
In-Reply-To: <201102131048.58111.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166652>

On Sun, Feb 13, 2011 at 10:48:58AM +0100, Johannes Sixt wrote:

> On Sonntag, 13. Februar 2011, Jeff King wrote:
> > On Sat, Feb 12, 2011 at 07:13:15PM +0900, xiaozhu wrote:
> > > Subject: [PATCH]
> > > =3D?UTF-8?q?=3DE6=3D97=3DA5=3DE6=3D9C=3DAC=3DE8=3DAA=3D9E=3DE3=3D=
81=3D8C=3DE5=3DA4=3DA7=3DE4=3DB8=3D88=3DE5=3DA4=3DAB
> > > =3D20=3DE6=3D94=3DB9=3DE8=3DA1=3D8C=3DE3=3D81=3D99=3DE3=3D82=3D8B=
?=3D
> >
> > Yeah, this is wrong. There should be a whitespace indentation in a
> > multi-line header, or the whole thing should be on one line. The ne=
wline
> > in your commit subject is apparently leaking through, and it should=
 be
> > qp-encoded.
>=20
> Isn't it wrong that format-patch (and --pretty=3Demail) does any quot=
ing in the=20
> first place? Isn't it the task of the MUA (git-send-email) to do the =
quoting?

I dunno. I guess it depends on how you view the output of format-patch.
Is it an mbox containing rfc2822-valid messages? Then it ought to be
quoted.

Certainly when opening the output in an editor, it is prettier to have
it unquoted. But what do MUAs expect when opening such an mbox? mutt
seems to handle unencoded utf8 just fine, but I don't know about other
MUAs.

> For example, when I import a format-patch generated patch into a mail=
 message,=20
> I don't want to see:
>=20
>  From: =3D?UTF-8?q?Joh=3DC3=3DA4nnes=3D20S=3DC3=3DBCxt?=3D <me@localh=
ost>
>=20
> but rather:
>=20
>  From: Joh=C3=A4nnes S=C3=BCxt <me@localhost>
>=20
> I know this is a bit late, but this really comes as a surprise. (I've=
 never=20
> had to pay attention to this behavior in the past...)

I can see how that would be annoying if your workflow is to paste
format-patch output into an email. But it has been that way literally
for years (I just tried v1.5.0, and format-patch produces
rfc2047-encoded headers). So yes, you are a bit late. :)

-Peff
