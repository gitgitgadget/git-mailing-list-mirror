From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] Makefile: respect $LINGUAS variable on selecting .mo
 files to install
Date: Fri, 14 Sep 2012 15:06:22 +0200
Message-ID: <50532BCE.6070009@drmicha.warpmail.net>
References: <CACsJy8DKUdn-eY1P1d6vFz34SvEbUBm07ZR3xy5xLaKxE+Wnqg@mail.gmail.com> <1347626418-14032-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 14 15:06:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCVbN-0004Da-4R
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 15:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752732Ab2INNGZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2012 09:06:25 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54022 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751735Ab2INNGX (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 09:06:23 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 98A642057E;
	Fri, 14 Sep 2012 09:06:23 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute3.internal (MEProxy); Fri, 14 Sep 2012 09:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=oG9gQTSNs1ay/HZx//KfDx
	Rw6Uc=; b=Zjf7iFSCK+KzwC8vj9KJP0kkwwRZFLMDTjhokRU1oydpKylMAHmE7e
	dc6SfFUvA/EwM3rhLwkOO6Wr8cRYj2vYsEfGTxZnDL9R5gj55IpEf1/b9bnZnEXh
	l0Nr3HVPot8uKW+zDNuwD916LDJQPlsDU6u+90rkxa24IRccv/uZs=
X-Sasl-enc: 5/tsKWjMjePcwCpV1DPhccciMXCZns8B2zGhlKFZTGMc 1347627983
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id DE1D3482525;
	Fri, 14 Sep 2012 09:06:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <1347626418-14032-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205488>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy venit, vidit, dixit 14.09.201=
2 14:40:
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  On Fri, Sep 14, 2012 at 6:35 PM, Nguyen Thai Ngoc Duy <pclouds@gmail=
=2Ecom> wrote:
>  > We should honor LINGUAS variable on installation. Only languages
>  > listed in that variable are installed. Many if not most of project=
s do
>  > that already.
>=20
>  And here is a try.
>=20
>  Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index 56301dc..eeba645 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2437,7 +2437,11 @@ po/git.pot: $(LOCALIZED_C)
> =20
>  pot: po/git.pot
> =20
> +ifdef LINGUAS
> +POFILES :=3D $(shell sh -c "ls $(patsubst %,po/%.po,$(LINGUAS)) 2>/d=
ev/null")
> +else
>  POFILES :=3D $(wildcard po/*.po)
> +endif
>  MOFILES :=3D $(patsubst po/%.po,po/build/locale/%/LC_MESSAGES/git.mo=
,$(POFILES))
> =20
>  ifndef NO_GETTEXT
>=20

While that may be worthwhile if LINGUAS is some sort of standard I don'=
t
think it relates to the discussion at hand. The problem is not the set
to choose from but the choice and the specificity of the choice (which
parts of the code does it affect).

Michael
