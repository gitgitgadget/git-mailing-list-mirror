Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C08B14B08C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742270349; cv=none; b=u8mL8abXdwvVH0RoOoOPLApH/Oa6oI6jla6t7HaBRiuimaK6v0kK9nWk+p6oViErmdps2x262DhEYxEmeh+mqgf53wyDNcTTciFCJcu0TMpjdgT8fmH8qHxGyZchDT3iBZn7F/SWAGlFcg7HTdtq7hAARqTtPu73EnIiInKgCQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742270349; c=relaxed/simple;
	bh=WI9sRAc/SC0egNwz4PCKO4A/q+jB3usv51d5VTPXpTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVW7it65iz1R1XROwAynL4du4qqFp5LWLcgoGzCTLDG5BY5lGkqWMnbFBr9h4+M/4KPBWBdR5S+ZEwjeQ6hblZHQAldAFiT2798RVGlK61Hnv6OwIH40ugzwkT7XsnwvVrnzo8T5Yj0Yampyn03/qPJTFv7VD9U649nyJsIoq+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=KpvV/fXH; arc=none smtp.client-ip=212.27.42.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="KpvV/fXH"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:c2d2:c7d2:a4cd:bda7])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 3D9CD13F88D;
	Tue, 18 Mar 2025 04:58:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1742270334;
	bh=WI9sRAc/SC0egNwz4PCKO4A/q+jB3usv51d5VTPXpTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KpvV/fXHvcBczhYcw0u8CXYhQOv7lyB9LMTrNndm1cN2SgKNHnRQjTFkfXa/Q/LLj
	 NxuEGqOgvkc6M3NIbnp0ZleJsV3P9d+27erOskLe8QlJXcbJwmVAwPlWTmIi1Y5zLN
	 JWtp7ODOMGbdTE7BkhEmo6IOmjSLPrSs0DhE80Wp/WBDFFhDT1VThZzuY5VOsdSyg7
	 HEwTXt66litXdDVblBdbwbDJPTvSXY3JJk7f8dpXhZogcJUnEt5uVqNmFpQ0cpMLaB
	 tkI19YvYOGD6JcxvhEDvgwRncMPUc9ZghWbWUVseWgafsmBu/Gqa4gFF5EiHEK+pJ8
	 c0kmz68peZO3g==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH 1/2] completion: take into account the formatting backticks for
 options
Date: Tue, 18 Mar 2025 04:58:51 +0100
Message-ID: <2773494.mvXUDI8C0e@cayenne>
In-Reply-To: <xmqqplif8jnm.fsf@gitster.g>
References:
 <pull.1880.git.1742056310.gitgitgadget@gmail.com>
 <f8883d83f3096ce16e5dfc9647a41970396693f4.1742056310.git.gitgitgadget@gmail.com>
 <xmqqplif8jnm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 17 March 2025 21:52:13 CET Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
> >=20
> > With the modern formatting of the manpages, the options and commands ar=
e=20
now
> > backticked in their definition lists. This patch updates the generation=
 of
> > the completion list to take into account this new format.
> >=20
> > Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> > ---
> >=20
> >  generate-configlist.sh | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/generate-configlist.sh b/generate-configlist.sh
> > index dffdaada8b5..802178daad4 100755
> > --- a/generate-configlist.sh
> > +++ b/generate-configlist.sh
> > @@ -13,8 +13,8 @@ print_config_list () {
> >=20
> >  	cat <<EOF
> > =20
> >  static const char *config_name_list[] =3D {
> >  EOF
> >=20
> > -	grep -h '^[a-zA-Z].*\..*::$' "$SOURCE_DIR"/Documentation/
*config.adoc
> > "$SOURCE_DIR"/Documentation/config/*.adoc | -	sed '/deprecated/d; s/::$=
//;
> > s/,  */\n/g' |
> > +	grep -h '^`\?[a-zA-Z].*\..*`\?::$'
> > "$SOURCE_DIR"/Documentation/*config.adoc
> > "$SOURCE_DIR"/Documentation/config/*.adoc |
> Using \? in BRE as a short-hand for \{0,1\} (or trying to use any
> single regexp magic in BRE by adding a backslash when that magic is
> only available in ERE) is a GNUism, isn't it?
>=20
> We probably should rewrite the thing as ERE, perhaps like
>=20
> 	grep -E -h '^`?[a-zA-Z].*\..*`?::$' ...
>=20
> Also, if we can avoid piping grep into sed or awk, we should do so,
> when it does not lose readability.  Perhaps we can do something like
>=20
> 	sed -E -n -e '/... that pattern .../{
> 		/deprecated/d;
> 		s/::$//;
> 		...
> 	}' "$SOURCE_DIR"/Documentation/*config.adoc ... |
>         sort |
> 	...
>=20
> in this case?

=46or the GNUism, the tests on MacOS and Windows by gitgitgadget passed. Bu=
t I=20
get your point and will reroll.




