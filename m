From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 18:15:15 +0200
Message-ID: <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net> <vpqhb8049m3.fsf@bauges.imag.fr>
 <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com> <vpqtyc0wc1j.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, thomas@xteddy.org, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:15:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULPx-0000PR-2t
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912Ab1FHQPg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 12:15:36 -0400
Received: from mail-px0-f179.google.com ([209.85.212.179]:56289 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884Ab1FHQPf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 12:15:35 -0400
Received: by pxi2 with SMTP id 2so466973pxi.10
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 09:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=xgKEFPj76bB5duMHcJrSvgLbAQpvPsWQssih7KhrA5Q=;
        b=q0/P/MYmr5qJosZ7nZgbaP045K2GsHNQn6dZUcTiEOJDOS6A5v2IMaqGm4XI968/H+
         3U2ednbVD1mFDmPVlX1umK/dfKAtoisXM+vwNepzJjdOrdBHXB73CJfzjh3NBotpNVY+
         P6zM0N1scZIGEUBQwxpz3hce8ZiU8r2oIsrtc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RW9468lXofDPVcoWY30jZxDxl/JCnBYZxGYw8Tv05PJuq+PkEe/63w+nYDzjc3eYUI
         /yolbkIqa4QFFcDkm8cafmyBXblumkzdS3WISRMpn7TwNMulrhFdP/2sa75PaA2MQHwi
         pnjMrZQecRmvMRN4bhckCIXjGzkav4H6Pb+PE=
Received: by 10.142.208.21 with SMTP id f21mr302066wfg.243.1307549735112; Wed,
 08 Jun 2011 09:15:35 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 09:15:15 -0700 (PDT)
In-Reply-To: <vpqtyc0wc1j.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175391>

2011/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:

> there should probably have been a $/ =3D 1; or some other perl magic =
to
> make sure we don't read only the first line there:
>

Yes, it indeed currently reads only the first line. I'm going to see
what kind of magic I need to use.

> Then, make it a helper function to call like
>
> my $file_content =3D run_git("cat-file -p $sha1");
>
> and use it where needed.

Good idea, doing it right now


> My advice, at least in the short-term (already discussed offline): us=
e
> urlencode ( http://php.net/manual/en/function.urlencode.php ) on pull=
,
> and don't bother with encoding on push. Non-ascii characters in
> filenames are a nightmare ...
>

Yes I tried uri_escape, but that only works in the direction mediawiki =
-> git.
A page named "Et=E9" on mediawiki comes as a Et%C3%A9.mw file on the re=
po.
However, when I try to send that file "Et%C3%A9" with the mediawiki
API, I get this error

"Can't use an undefined value as a HASH reference at
/usr/local/share/perl/5.10.1/MediaWiki/API.pm line 554."

So I tried to backslash the '%' but it does not do it...
Any idea ? Thanks

--
J=E9r=E9mie Nikaes
