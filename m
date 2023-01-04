Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E6C4708D
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 14:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234953AbjADO5D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 09:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239532AbjADO45 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 09:56:57 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089EFE0
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 06:56:56 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0A1795C011B;
        Wed,  4 Jan 2023 09:56:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 04 Jan 2023 09:56:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672844216; x=1672930616; bh=If2LYYmC8v
        RrtFzHMctYKPrT4UbXesYAlDCQlbax3sA=; b=HnmuKI1SuH2ySz6t0Av3GxypHo
        fPPODM4sWw/aojKNZYfJXdnDJHLVwi2D8Mrv/T2Z87J4dUYcUBRKmGHymV7Gr88X
        ySJll1mo4UG9ZkmXwzmJ+Q+n09aZ4vCq72oR+DWUcA04QzfG1Z+xXpqt5u9FzmJ1
        MnIuE1KIKr35U6evDyObimscinBhL8BXV7wwcZhxgpssjawMlcs9bL5hsyktmZFv
        mS00r6OTb1UuN8OJCYXpbXy8YeAnl0b5LaSzhC8twPdJil7GnHJjU2e/CI0kO7ND
        +8lWtthqmIygiQO/Z+porgjocAeupAYiklH/S/FV443w58Y6Wz5izD+q6fUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672844216; x=1672930616; bh=If2LYYmC8vRrtFzHMctYKPrT4UbX
        esYAlDCQlbax3sA=; b=I7EojBBpLpdEM0KOW5Et+Loug2G1ZBH3sCSwkX9LQVAs
        p0xXQyFZtGyMUxVPJUhadRfvOBH/zfEvDDvapI/ek6hiqi26PQLdSAaAfBXIe5DV
        PA8LPYagAndEQ6OyCrVKEnLcigCsqmWht/dAD9btmVk3apJiVSOJQBEUbriZcFLM
        Idd3c0Oh7+HRwYJasuMR7gXoSpXJ3LYlWbh06QbVtzUudLxFrsr67WYcvXclzpPC
        ZW2xVYJgEMVLunFkZ2mAxWqYEOD65MKG5YhoukjMiiolAj1fISNdU+eirXxoM3sR
        r4Rjzs+W/FcZ5CzhqRNj1ZtC96MP2GDo6ci0DXtAHw==
X-ME-Sender: <xms:t5O1Y9aBNSbopLC7f_BvwRvZbVd2kk4c4CUfI2ZzKWCPS1SSlhdeoQ>
    <xme:t5O1Y0aorOQrCEI22T4qhi4J2PphHrWXvzjfsFdVcqgaWAqTQYGUSxeKbwuwYzN4L
    iEOjwWLsJGmxHKyVw>
X-ME-Received: <xmr:t5O1Y__hmkiTFXG-0KLH5tu1WIAxSlJ04OdO5gmKm4xTprkiWOPM5hrdQuQuB1P9VJbRB_uvY6JwVYsPUoIPA0zqtka93_HKRRge_AXG02wx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:t5O1Y7q_9M5BUigt6JiIbvipeyntLRqIFk_23JP8A4k11BZha8A5Mw>
    <xmx:t5O1Y4qCMkoVeHv6OhWfe4al48KyvV2ya99c33QHOoNNcy2QH4-2kA>
    <xmx:t5O1YxQt6HxuK0dTb1C-OmE0ZUFTFb1KRW70rSKMv6MfKOnm6QCc3Q>
    <xmx:uJO1YwLQSNv8d3iXt1HZtSKNgCus51uqq_dZbIB7U5MNgiE0GBrg8w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jan 2023 09:56:53 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e7ea1421 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 4 Jan 2023 14:56:36 +0000 (UTC)
Date:   Wed, 4 Jan 2023 15:56:44 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 1/3] pack-objects: allow --filter without --stdout
Message-ID: <Y7WTrHO1bWNFCRrp@ncase>
References: <20221122175150.366828-1-christian.couder@gmail.com>
 <20221221040446.2860985-1-christian.couder@gmail.com>
 <20221221040446.2860985-2-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1huvdFvfNfdRhstD"
Content-Disposition: inline
In-Reply-To: <20221221040446.2860985-2-christian.couder@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--1huvdFvfNfdRhstD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 21, 2022 at 05:04:44AM +0100, Christian Couder wrote:
> From: Christian Couder <chriscool@tuxfamily.org>
>=20
> 9535ce7337 (pack-objects: add list-objects filtering, 2017-11-21)
> taught pack-objects to use --filter, but required the use of
> --stdout since a partial clone mechanism was not yet in place to
> handle missing objects. Since then, changes like 9e27beaa23
> (promisor-remote: implement promisor_remote_get_direct(), 2019-06-25)
> and others added support to dynamically fetch objects that were missing.
>=20
> Remove the --stdout requirement so that in a follow-up commit, repack
> can pass --filter to pack-objects to omit certain objects from the
> resulting packfile.
>=20
> Signed-off-by: John Cai <johncai86@gmail.com>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/pack-objects.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 2193f80b89..aa0b13d015 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -4371,12 +4371,8 @@ int cmd_pack_objects(int argc, const char **argv, =
const char *prefix)
>  	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
>  		unpack_unreachable_expiration =3D 0;
> =20
> -	if (filter_options.choice) {
> -		if (!pack_to_stdout)
> -			die(_("cannot use --filter without --stdout"));
> -		if (stdin_packs)
> -			die(_("cannot use --filter with --stdin-packs"));
> -	}
> +	if (stdin_packs && filter_options.choice)
> +		die(_("cannot use --filter with --stdin-packs"));
> =20
>  	if (stdin_packs && use_internal_rev_list)
>  		die(_("cannot use internal rev list with --stdin-packs"));

Can we add a test to exercise this now-allowed combination of options?

Patrick

--1huvdFvfNfdRhstD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmO1k6sACgkQVbJhu7ck
PpRn+BAAgBSyZychjfS4zD1CvauDU5gncS3YKevxN83lAw4KT39baMBYWFoB98gY
/PHD8X6N7QU0q70k4DSQLlX3sM/ohIK/Eta+w3EuXnuZuQ33rAvmXomzBhipe9Ve
/KPSfD+YIaS5QSEtFGBaooJXF69MEXE3MwQh3apiT4qn4VBU5ZHeHwE8fvVUeOVW
H4fIMmOlvr3P/yFzoQGHSGNxOVIqE5ma1TroFDZK5GT76h07z3Woe/rPkhHGW95u
nrtViPWpPZCNuCoxJy32I0vVvzjVqFNIgzpFN0vtigx/0MjEb+803P655YQR/Wry
aBQma5wyhDfeKtpVK6EOpwy1AdEhzNd4xRh9EsCso4Ry9r4jBQCpGCSt0aKc1+3h
efHMqXGTEhGKxUObgUn8n5oxbMy21M+TA0YxxcaI8tavvYJenBK+GBEDWogAC/AJ
t2nhN48xuc2FR4QdFQ1MmzXsqATMeZxZK2AxlguC/MSeS4O9T6PeZUWJcvquUk9t
7IiBw2zXVx7tWG+N8Ep/TSBTSxBlCaP4NysC8gcghbehF2Dv0DUGSNY6olTnaRym
jrkL+4T/OMoNxIw0d4SdSwJgt5eFNbbFmCJthIH5WpleuPNyyQGufQohPGR1HQPn
m1io/Qpx1TyWY+60BUGhEbnQuS4rKJy8pzvz+x56gX8XMN9/WEw=
=nxSg
-----END PGP SIGNATURE-----

--1huvdFvfNfdRhstD--
