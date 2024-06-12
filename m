Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A29310E3
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 07:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718176497; cv=none; b=KWOdiXR+XZt6sdokHd0WLNVAFdyo9kMy5tK9t6HpBcDoOUWFDwfKUCMubUJFGGeTr8xp4ZM8mrzsMGOhVEEqJiOOd7J96gXuKZdochIUhM6cVXDLali1fBBZ4uN823KJEhBzy1R+8pc5iAYtl5efoG7yGR2xdmG4cN7vRdy3EpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718176497; c=relaxed/simple;
	bh=Dy7q0xHg62zf9E+/Uhyisefgef3CO4jrK8vorpJpjeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAZCdtmZtWe8NHQvGlOir61n10382/qgETygpelC8lcfChYdAalE1RCzH0pU09KehqlS3bWXNut2pfwPSFaftswItjjq+dtTZrsnFeJHLnIzW4t7pgRSkkRllDjheCrKS6c5NuPFrNDlr2ikrWdzz+Y8tEjw07C7S8fqw+x0Xrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GIkzfwWq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FrDSJdjB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GIkzfwWq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FrDSJdjB"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4C70C11401DB;
	Wed, 12 Jun 2024 03:14:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 12 Jun 2024 03:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718176493; x=1718262893; bh=JlohQZL4OI
	yAyAgQUZO4xM6WtVVz7PfWVidH8YNOR40=; b=GIkzfwWqqRAJEtwavnh5CKvD8j
	XxLfEQeAOhpIai4jgVQPQpVZt0kKErJLBXrwacWtC+weKmmQ1FlHhhIATEpVZ5cd
	WV00r+0Ka8ScBzBBZ1f4Z8HBEITCjZYCf5Fc1BHQfz7UEuVIqo3BrzbhWz6wSMMk
	phCl24Esg/t6Nn3iyx8LbQPxZTszAjlzFw9zfTPhdtdnuPpZtHIpJpDG0xKrrN2T
	q1mBzzbCccUtVzd6q3gmvfWKKynoFQjZ4H5ncx+Bnbl9wyrABEJo+4tNW6+qSOAJ
	m0NYeAuhe8RY4Fb8QhmjFhTpAuxO7VBv9oiOeVIBlQCja7imzABzc54IW6Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718176493; x=1718262893; bh=JlohQZL4OIyAyAgQUZO4xM6WtVVz
	7PfWVidH8YNOR40=; b=FrDSJdjBGPDL0IMW7z/YRrpLznVPs+o8QRTA91wu7MHv
	g030q0NVNCw8dj5DKKdzmFM97rcCjBVEthk8b6I4bKWxOOgLVnSgrCCJ6bnRMW1h
	E5X5tnDKn2IQIsKDEfD3EWWoE4JLPcUKBbpEGSl/YvegRJAbAiL3erLw+xKk0AMt
	slJTRLGrmkr3Git7Yzf8s3p6RvFW+LrIWaad9HuBchttz9cKIzJgtu4+0xnMpSWc
	RMzuC53HuwM3Xl8W1bwt55Z8qCT6BPukeNg/BajIzzCzn0k1xqylPiHqQoghZjvW
	OARhpMyEDbwa9JFub7gyA+B6hjpoBq5zPAYwB92jxg==
X-ME-Sender: <xms:7UppZjMqSD4jZ9rW0WBhMV1EyoU_41oVh9Rigd2kv8c5bIM9BPeY4A>
    <xme:7UppZt_lncPSt77BVEGt46z11NNGaZBZ3KhBnlDbV2ne17LbnKVKvIl5S351ZA0Ya
    vY0SNRM95sfZK-YqA>
X-ME-Received: <xmr:7UppZiSStWnzx9ElECEPtOnDv5ZedvSryWgxFwGYoOIaa9e3NhnaeGSGvnHy0GT26wMQjGzj9M1NnFK4IqX3Hi6itSME67wKeIbt5iwy6PeOVnoiLRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeljeetffevheeggeetkeetieduieeiieegieegtdffheegkefhjeehfeekhfev
    leenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:7UppZnv9rlkwG_zE7hs5YfHdaGRj2exmuUPM3gG1wHpmhtYMyD_kow>
    <xmx:7UppZrcz5voQbKIkK2Urkk3AcjjoQodAudha79ecUBPfFPCYdii4_w>
    <xmx:7UppZj0LFYZ8Y6qZBHpdUWt6EUnGytQT-p8yzByV0wDTZzQtWwN_9Q>
    <xmx:7UppZn8o6LPPgEi6l-IIT3h6H197sVSPtfj2rMMP68t_RhhP0r0CDw>
    <xmx:7UppZi6oYHIKmwdNEiOOxwfd7r3B1OIEBVBdTvzAgqbl22Cyivp5Zgz1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 03:14:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3149c22c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 07:14:38 +0000 (UTC)
Date: Wed, 12 Jun 2024 09:14:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] commit-graph: increment progress indicator
Message-ID: <ZmlK59HYWY_aXgv5@tanuki>
References: <pull.1743.git.1718118555197.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E88Sh0crk9CY2YKn"
Content-Disposition: inline
In-Reply-To: <pull.1743.git.1718118555197.gitgitgadget@gmail.com>


--E88Sh0crk9CY2YKn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 03:09:15PM +0000, Johannes Schindelin via GitGitGad=
get wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>=20
> This fixes a bug that was introduced by 368d19b0b7 (commit-graph:
> refactor compute_topological_levels(), 2023-03-20): Previously, the
> progress indicator was updated from `i + 1` where `i` is the loop
> variable of the enclosing `for` loop. After this patch, the update used
> `info->progress_cnt + 1` instead, however, unlike `i`, the
> `progress_cnt` attribute was not incremented. Let's increment it.
>=20
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     commit-graph: fix a progress indicator bug
>    =20
>     Stolee noticed this bug when integrating the for-each-ref --ahead-beh=
ind
>     patches into GitHub's internal fork of Git, and fixed it. For a varie=
ty
>     of reasons, upstreaming this fix fell between the cracks. Until now.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1743%2F=
dscho%2Fincrement-progress-in-commit-graph-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1743/dscho=
/increment-progress-in-commit-graph-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1743
>=20
>  commit-graph.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/commit-graph.c b/commit-graph.c
> index e5dd3553dfe..41a2e1b4c6d 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -1597,7 +1597,7 @@ static void compute_reachable_generation_numbers(
>  		timestamp_t gen;
>  		repo_parse_commit(info->r, c);
>  		gen =3D info->get_generation(c, info->data);
> -		display_progress(info->progress, info->progress_cnt + 1);
> +		display_progress(info->progress, ++info->progress_cnt);
> =20
>  		if (gen !=3D GENERATION_NUMBER_ZERO && gen !=3D GENERATION_NUMBER_INFI=
NITY)
>  			continue;

The fix looks obviously correct. Do we also want to amend tests? We have
e.g. "t6500-gc.sh", "gc --no-quiet", where we already grep for the
progress report without verifying numbers. The output there is:

    Computing commit graph topological levels:  25% (1/4), done.
    Computing commit graph generation numbers:  25% (1/4), done.

, which clearly demonstrates the bug for both callsites of the buggy
function.

The following change would thus detect such regressions in the future:

    diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
    index 43d40175f8..1b5909d1b7 100755
    --- a/t/t6500-gc.sh
    +++ b/t/t6500-gc.sh
    @@ -158,7 +158,7 @@ test_expect_success TTY 'with TTY: gc --no-quiet' '
            git -c gc.writeCommitGraph=3Dtrue gc --no-quiet >stdout 2>stder=
r &&
        test_must_be_empty stdout &&
        test_grep "Enumerating objects" stderr &&
    -	test_grep "Computing commit graph generation numbers" stderr
    +	test_grep "Computing commit graph generation numbers: 100% (4/4), don=
e." stderr
     '
    =20
     test_expect_success 'gc --quiet' '

Patrick

--E88Sh0crk9CY2YKn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpSuYACgkQVbJhu7ck
PpQ3Ww/9Eh3nJ1hiWCKB7NWxqRgrty1ZbjVTpMRzVGCyNUXCaOx6PoNmN6QaHTAJ
Dv0DoTw6akz7nbSOy4J0brUdwF410LWpOin7NAEv3/v00YntxNGZhsoEgVTGSR+9
TIqjaWEWsKPSI+DpOquHpaICHglKnGaLyRxVM+UMfh3rO3hq7MoOvMbUQLAExwFL
skJ5iOAdIkEjqUPBeA3LzpCdfLd4SCJV2M4YVI2sme6+oOmgKarGzzEusQqCrI/+
eZQg3q6sybw77b9vtRHlpIcKO+VYrJFBj/IaQi+BRyJ4bkJtRqombY+ByKxVcjrP
j72s8xQUQ+JDLVrmvGoCu1HP6MRCCIfCQBoJo2uZ37+xSpOR45fudrT8O9eZ+oH8
YKW/A0+kGGYcGCpbkvYah6d5DYp5n4GqNj1rK8CtfGfHzYrapwh1sBo7WfzaWqr9
dFMg/hQ3xJhfLPXABm1USEGobeMhXZu2fcxsQzOsdH2Fh9CwInKr/i3lQcrsK/g0
/viJV83nEu9HtgfIUOM29fmnC6E829KBfpj7HO8wdWwmu3yX2MrrD/jb1uHLDmOr
RDykpGRAUdQECTMzMTMDSemU/mey582J9YII6fEXxlROhA5LAwBx4AHdOa7ICqnw
mKZ2OiASMvr09gSvvRvlsaPR7MTT2d8AgeqBwXjXEHB81Uj7zSg=
=uUhY
-----END PGP SIGNATURE-----

--E88Sh0crk9CY2YKn--
