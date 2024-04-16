Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5A8539C
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 05:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713246706; cv=none; b=TodzvFEopCHC3zVOfjJAIspHOR1oO4kXRvirMjtdunicKGj0IPQIhrnbyd9AK+D2t+mibMObv5/ZmSQgtMcjCV7AsjeX3B9uQiJ5tOB7fOptAXppUAfXa+/nw9noK6+oFPOkRcaYP5Zy/yr25pR6PlEHhWRmaR6nja2akMLBCws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713246706; c=relaxed/simple;
	bh=3e7E/Dmu5qy4bJzxn2ezmlA2YtfP4//Q05MpRerUSEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mgeeqpl8s1CzeKLul4XG1PLFPb8CZLRZu5nsmjIGsYM1UZTjezWVB1KSDSGwN53IROUadG12Hmg3ZPcKWvjd6PxalpYkFp7R2CwPqROehOgqSzcRd+yRSU/yeY8sBa2fBU4IPpwuJqWEqjkN/zFW8FMTBDc2Zbw3Ek7XaLg3idk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N/Gbg9bq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fgU1svVi; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N/Gbg9bq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fgU1svVi"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D4E221C00124;
	Tue, 16 Apr 2024 01:51:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 16 Apr 2024 01:51:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713246702; x=1713333102; bh=st6dU/TZZ5
	+tgSHXSbWSBLIrUiXmqdOAIkuQHJ6qXeM=; b=N/Gbg9bqK9CenVYlMhGLhmNTOx
	snbNNnyUM6bL3J30HGOpVwcVWPDCNuNp20zgaqW13VnRkmM2qR7UuXi2x42UIk5D
	P94V7BSdloOGcqAgNrNnbqWh0+Qvi0IKm5f3dZHD+ujrR1lWbUU7CBlaEdn+hJVo
	Vw9oFjolYmWxRzZU9dsQkBbIQsMBiJnGsWesQRicuzzr7U4LyZWhccux80PcmcDh
	tgRzvtSCGAoYog6WUsk0sMUtMt6H7YlmMmfoBQ4XUKjAeQAuqI84/0seYnugwkUX
	sp468LpW21Io+TfluKP7hxEbS6/ttmId6Q6rctxeUwMzDEp6FGWGMSSe3o3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713246702; x=1713333102; bh=st6dU/TZZ5+tgSHXSbWSBLIrUiXm
	qdOAIkuQHJ6qXeM=; b=fgU1svVikxCods0SmV0z5Xa9Kcg4J4UJ7SspEODbMVAw
	DhYZpYuoqdGNYoPHVOGPydUltOvTwNSHMFSE7Iw5jyJLgY/EFvvlZRibWvX416iY
	7PRb3DpJf1Ne3YXm3Id80cnC92MPFkmpJxDHEIRujimGomuOzutucAUCsyjv50Hu
	3BMEBC94CKhiLHn8Rf/5E7q4DZvhzT3bAnIEKVqa5EfhbWYeSpcvAHNlSo+7muZ5
	coyuy6RQ4Jz/AkACjclaDO0RHZuWDZqfETGNxDx8/uH4TpV7pHbXVEFKr/t0qv5c
	Ubt6otzTTSmYaQXK3xlql7CWVPMRyka7yChRt8KFuQ==
X-ME-Sender: <xms:7hEeZp9JXKHd1VHR_E74ty3bRPA_ZS6hWWO0m2DLudA25u-7rMKBng>
    <xme:7hEeZttO-qZPiZb8SsKlNwUbCWqKbGNjjinNChj6p7-1UU1aDKqs7ONUu6ZuA8S6H
    cchB8sOCrVVQ4nKjg>
X-ME-Received: <xmr:7hEeZnCtsI4MXXJpYQftcTABC_MHfxruDcsW59nbOMHuPI6-FKGATkE6njXXWqZiVWXJJkI_D9qJytZXn5eaL32uFg4pxeS8ns_JEPPmHrz6BSWTSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejfedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeefvdelfeeuteegiedtkeehleffkeekgfffudfhuddvfefftdehkeeihfekjeek
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:7hEeZtfkL8WRtYfLmttO__zTgjcivaERDJrVt7tnCwLgvsfkjx55QA>
    <xmx:7hEeZuNddaGWAMiYU569Q5D5lRho2bkkRBEJnOWnThXV8rdjRjQMQA>
    <xmx:7hEeZvmHfRkyzsrC8OeOpyNb7lei_NBa76i_joMagYeTKZHl9a-3bQ>
    <xmx:7hEeZossxlx-zz9qp27FaifzAk770tqFwjX6-qj0p1LKQM5Oul0vBg>
    <xmx:7hEeZrqTR3Q5C-hccLrYkY7QktnTVmQLWzzrrl846n_7nGn7T1beIb7p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Apr 2024 01:51:41 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 132ae80e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Apr 2024 05:51:16 +0000 (UTC)
Date: Tue, 16 Apr 2024 07:51:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: =?iso-8859-1?Q?Rub=E9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] add-patch: response to invalid option
Message-ID: <Zh4R5yonRLBcunCR@tanuki>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CBXPeNxOltOZ+yq8"
Content-Disposition: inline
In-Reply-To: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>


--CBXPeNxOltOZ+yq8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 09:00:28PM +0200, Rub=E9n Justo wrote:
> When the user introduces an invalid option, we respond with the whole
> help text.
>=20
> Instead of displaying the long help description, display a short error
> message indicating the incorrectly introduced option with a note on how
> to get the help text.
>=20
> Signed-off-by: Rub=E9n Justo <rjusto@gmail.com>
> ---
>  add-patch.c                |  5 ++++-
>  t/t3701-add-interactive.sh | 10 ++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/add-patch.c b/add-patch.c
> index a06dd18985..c77902fec5 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -1667,7 +1667,7 @@ static int patch_update_file(struct add_p_state *s,
>  			}
>  		} else if (s->answer.buf[0] =3D=3D 'p') {
>  			rendered_hunk_index =3D -1;
> -		} else {
> +		} else if (s->answer.buf[0] =3D=3D '?') {
>  			const char *p =3D _(help_patch_remainder), *eol =3D p;
> =20
>  			color_fprintf(stdout, s->s.help_color, "%s",

I think it would've made sense to describe this change in the commit
message, as well. Currently, the reader is left wondering whether "?" is
a new shortcut that you introduce in this patch or whether it is already
documented as such.

> @@ -1691,6 +1691,9 @@ static int patch_update_file(struct add_p_state *s,
>  				color_fprintf_ln(stdout, s->s.help_color,
>  						 "%.*s", (int)(eol - p), p);
>  			}
> +		} else {
> +			err(s, _("Unknown option '%s' (use '?' for help)"),
> +			    s->answer.buf);
>  		}
>  	}
> =20

I was wondering why we have `err()` here, and whether we shouldn't
convert this to use `error()` instead. Similarly, I was wondering
whether we should convert the error message to start with a lower-case
letter to match our other errors.

But scanning through "add-patch.c" I don't think that makes sense.
`err()` knows to handle colors, which `error()` doesn't. And given that
this is an interactive interface where all the other error messages
start with an upper-case letter, too, it would feel out of place to
adapt the error message.

So all of this is just to say that this looks sensible to me.

> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index bc55255b0a..b38fd5388a 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -61,6 +61,16 @@ test_expect_success 'setup (initial)' '
>  	echo more >>file &&
>  	echo lines >>file
>  '
> +
> +test_expect_success 'invalid option' '
> +	cat >expect <<-EOF &&
> +	Unknown option ${SQ}W${SQ} (use ${SQ}?${SQ} for help)
> +	EOF
> +	test_write_lines W |
> +	git -c core.filemode=3Dtrue add -p 2>actual &&

Nit: it might be sensible to write the lines into a temporary file first
so that Git isn't spawned as part of a pipeline. But on the other hand
it's fine to have Git on the right-hand side of pipelines, so this way
to write it is fine, too.

Patrick

> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'status works (initial)' '
>  	git add -i </dev/null >output &&
>  	grep "+1/-0 *+2/-0 file" output
> --=20
> 2.44.0.782.g480309b2c8
>=20
>=20
>=20

--CBXPeNxOltOZ+yq8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYeEeYACgkQVbJhu7ck
PpQSThAAijKaxaTsHwga86oVVr9l/HcA+dHZea0j8iBGGcY14ujuiuzVEJALiDne
pieo5E06oHAqguOgrjh09EUZpPmhNtOl3hLxuXBm9unQUIk2QwTrsdkccwdJav7u
4kV2DDOHc8ZajN0fLc0buE1lelD0H1cyvxGEJJPQ+yi/EFaw21hzLvZN+cutBf7d
oreDLe3rQDm0+ZleOSt1+CJzVOcSS9kTFQDbBBZRWWUXVNVfQfE0SslU7058Fv5v
ToY3+QOXJXvWaWezvLLjqEBncaZZy/jJQ5foEKhcILb2uGL/Sq2JfCzAITHo+3NO
47FTYLFmokN1rlCMGdkekLDt0zRm9m/Mmo5AduZpW+czJWcJF+Eax+tfd+9ZAxRR
Jo5Ww9YZnXHs6vMuppkyUaexJiRkfD1x0XKQ2xV2sxfgXEpsrCEAce8TmyltoPPJ
JxIUZENQFp5m6uEQydNcPac4tmhr+9Eo8PqIKdhNMqJFJw4REJYrVc2fL6qo0Li/
eCMuPpiWLHJzO/qqsRJz7fmlJibCWxTFPmw5CjTqCCL/kF3qd2K54YY+3N5wDBQA
Y5hyvlcBL0cVDu8GtUG4rKOdgqbxgfHlgNXfb/q1KYrbK7AC15Rko+/WG8pd9klX
ohRCBccbyUJqxi/KdzH4ciTwuAA096IueFKHHZLTRzX7gUILPOo=
=4vfD
-----END PGP SIGNATURE-----

--CBXPeNxOltOZ+yq8--
