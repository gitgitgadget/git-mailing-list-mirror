Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F938F77
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016341; cv=none; b=Boh9Sa8NftNOE7dpcsH4wjKcBEyhdKcjCbw/ZyGjwtUjn829K5HklQRAjLxpYJVFnieHLxFA1EzPIFlkx9w6TPNWhwiqzgfkqO/bNcLYwzFGA5yywdLnsKuphxtjUsWXaZ76A9SrlSjJLX7mEE7sAh+bYauTkZ2Mx+M5g7ZbcLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016341; c=relaxed/simple;
	bh=OMwcjENJmp/LllmCqp23NXWJl1QYmKVO7sHl4UiYat0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGSPUvT62pZflepHF+OgzM4HSUBH62VVhvdAsCMRcDLM/mj9GsDvhN6JHrSX9u/HNoSYMvBhddM3w0DkJqu6ZhSFPdh/mLABQfpxrjop4NohitE+XVM8WmUI+looKE5ssVzYK9m6C9okTgjfv0UM4cJ6PIgsBa22WYtAXilyFxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iVw7xjyV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B95gJ2gL; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iVw7xjyV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B95gJ2gL"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9A9941151B42;
	Wed,  7 Aug 2024 03:38:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 07 Aug 2024 03:38:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723016338; x=1723102738; bh=tR/BSgMRbF
	M6xjb5DNHBLKTWbs64Up1nQ8fkElmk6E0=; b=iVw7xjyVrzk9hhyXDq/lm+A5DL
	mo9xQIhYlcM8/iz3HVM/4kB/aTa0qPdw+dvH2QvQhDHf4KjNS/CWFu08C5kDFTnn
	qNMmiP41c3sXJ8vsBgDf/IZoZmBKuvFztD7PWa0jLf3ZKvvKeCcvZ7zaw4m709X6
	duKwCwsSG8i7p07OAJKUaU8kbUahP8QLyxeYDIRK/TPolCUEh77odzF/lh+7VCku
	Qt5F6fbt/J4mcL7itTtuJ5zV5TRQcWtiKTc3WIPFvQkqau5uzv+0nP9cupgMpiBB
	1x5wken+h9zezWElhLpS8fUplsHSVsqGOhULB4k5OD2p0akjDlb4VgdXsRTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723016338; x=1723102738; bh=tR/BSgMRbFM6xjb5DNHBLKTWbs64
	Up1nQ8fkElmk6E0=; b=B95gJ2gL8rJ/4/sKfQWcrOoyf423uyfYvb4gCKX1yLWb
	/zlRIzfEK+S3a+97kzOAao00Eug8/fWJgix/mmqMw9uu7g0r2xBkjzRFEba4Drbz
	xfSFcrl+4twJIzOwXehwAIvhK7qQTfPVhp5GSEPW/6WcObkjU6yjVjGvJyFsaRjH
	6IG9XTRzfrWzrMzhkODsqpjcGuLIjTOgs6Th8NodX2J+aJqsrZRQMcuEkhWgaluR
	h3suy96dglPiFAStvYB2jf+jvDEsYLAw8xbh36U5k6Mlaqz8RhzJZMnj+D19Asys
	S5jPICm8ZJv8c7YcZOaX50oxO6JXWx3trtaJLU0wfQ==
X-ME-Sender: <xms:kiSzZlHqYgvx7p20Wmioi8XZrQrA0BRCjm8l9bXNhEZumGqtQqgBfQ>
    <xme:kiSzZqWmREDB9LaQqlNZrFE4UF4JJI7jdmkD2Mjrh-pHm9HOMEtA_XySR4YU8lhHN
    4nrOeqvcJg3_wu8yQ>
X-ME-Received: <xmr:kiSzZnKKb7jW6LwRYmdDmm9YWofp817pXSg5IUEeOPgyyIbb2IcKxXyNubDCQ4MlOtAiKbupdSdh6bNE5T9E3ILsHcpIDhyMEZGLpq2fvN5_cvBt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:kiSzZrHK238cfWBurMug-qDHwTDMpwF6HWSzyV_TGgAMqA40gMJb1Q>
    <xmx:kiSzZrUXIH6z2nviBq0WTH-fuCLS34HkxcWA33a3iPy6agQ1O3mF0g>
    <xmx:kiSzZmNSudqGsEQqH1kFnns5enzeHLhu8qidme6rtzVV4LTynLyH6g>
    <xmx:kiSzZq2XzuCViktDwPJLt1xzUeLs_vB3970t35S8NIXLfCGyywwTPg>
    <xmx:kiSzZmSBBpcmWjrhEpkvI0mMHzGsGr9Qp0NdXauHW5wOHpmLO24VTB3Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 03:38:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 795e7edf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 07:38:51 +0000 (UTC)
Date: Wed, 7 Aug 2024 09:38:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>, git@vger.kernel.org
Subject: Re: 2.46 submodule breakage
Message-ID: <ZrMkje9VugtKz-gB@tanuki>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <CA+osTZX4FBT5za3Nw2Hc=DCNNbFg=xL4b3AhNmN8S2XKb5BXUA@mail.gmail.com>
 <CAPig+cQ05ocHKELovvEhvptAn09DLuitQkdJyFQ=N5qvje-GhQ@mail.gmail.com>
 <ZrMWylPWZ8Tm5i45@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VWnjuLIRLB+14QBU"
Content-Disposition: inline
In-Reply-To: <ZrMWylPWZ8Tm5i45@tanuki>


--VWnjuLIRLB+14QBU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 07, 2024 at 08:40:10AM +0200, Patrick Steinhardt wrote:
> On Tue, Aug 06, 2024 at 02:26:35PM -0400, Eric Sunshine wrote:
> > On Tue, Aug 6, 2024 at 9:21=E2=80=AFAM Jeppe =C3=98land <joland@gmail.c=
om> wrote:
> > > I did a bunch of testing to narrow down the cause:
> > >
> > > It is not related to the Windows port - all the testing was done in W=
SL.
> > > It only happens when the clone containing submodules is done with
> > > --ref-format=3Dreftable.
> > > The commit breaking it is: 129cb1b99d hash: drop (mostly) unused
> > > `is_empty_{blob,tree}_sha1()` functions
> >=20
> > Cc:'ing Patrick, the author of that change.
>=20
> Thanks for Cc'ing me, and thanks for the report.
>=20
> I just wanted to say that I couldn't reproduce, but then spotted that
> you said that it only happens when using `--ref-format=3Dreftable` during
> the git-clone(1) step. And indeed, that causes the following test to
> fail:
>=20
>     test_expect_success 'recursive pull with different non-default ref fo=
rmat' '
>         # Set up the initial structure. This is an upstream repository th=
at has
>         # a submodule, as well as a downstream clone of the upstream
>         # repository.
>         git init submodule &&
>         test_commit -C submodule submodule-base &&
>         git init upstream &&
>         test_commit -C upstream upstream-base &&
>         git -C upstream submodule add "file://$(pwd)/submodule" &&
>         git -C upstream commit -m "upstream submodule" &&
>         git clone --ref-format=3Dreftable --recurse-submodules "file://$(=
pwd)/upstream" downstream &&
>=20
>         # Update the submodule.
>         test_commit -C submodule submodule-update &&
>         git -C upstream/submodule pull &&
>         git -C upstream commit -am "update the submodule" &&
>=20
>         git -C downstream pull --recurse-submodules
>     '
>=20
> The issue here is that the recursive clone causes a mixture of ref
> formats: the parent repository uses the "reftable" backend, whereas the
> child repository uses "files". In theory, I think Git should be able to
> handle a mixture of ref formats like this, but I'm not surprised that it
> actually fails in practice. The question is whether this is sensible, or
> whether submodules should use the same ref format as their parent.
>=20
> So it feels like the commit you have bisected this to only unearths this
> issue, but isn't the actual root cause.
>=20
> I'll investigate further and will try to come up with a patch later this
> week.

For the record, the fix is as simple as the below diff. We indeed end up
initializing submodule ref stores with the parent ref storage format,
not with the one of the subrepo. I'll spend some more time though to
check whether other commands are impacted, as well, and write some more
tests.

Patrick

diff --git a/refs.c b/refs.c
index 915aeb4d1d..e4b1f4f8b1 100644
--- a/refs.c
+++ b/refs.c
@@ -2011,7 +2011,7 @@ struct ref_store *repo_get_submodule_ref_store(struct=
 repository *repo,
        free(subrepo);
        goto done;
    }
-	refs =3D ref_store_init(subrepo, the_repository->ref_storage_format,
+	refs =3D ref_store_init(subrepo, subrepo->ref_storage_format,
                  submodule_sb.buf,
                  REF_STORE_READ | REF_STORE_ODB);
    register_ref_store_map(&repo->submodule_ref_stores, "submodule",

--VWnjuLIRLB+14QBU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazJIwACgkQVbJhu7ck
PpTB5A/+NLnmi6SJohq+FRxf9sI0/Ju8iGKfs/aRUfi+HA7i77VBEyEeaFhk4WmS
IFo9SZOHcJe7M8jKiTyok4197GOTFLANEwDFosotm0ZmBgyVnPlR2aGSUKYaUdQJ
kyaUsJrT2E+5yUklJLNN9WupmP8eH3lOJjASVv46K1u0e5/zu/jSaxMY7NxSs0MQ
JnHLThaj/lQGeygoNfr0ZEholGcvg4UituVnuhcnJdSnntKjh8XjLZnr5iBPDsXj
XW4j8nhUAf5Td3KsFULjrJrDqg2Rm5r0Q+HpoDb2OPwMmCRzaX2W/qvlSMPQ2rLj
NOvnQ3Bk/peYxFjAr480eGdJvsAtmAetuh/FIKllP3fGZsWM+j2o9KZHlOXlX/TN
pDYGwWz0X/pBlXgAQPE2NXF8PG1mN+OOMw2Ambtiq1HWnoPx/RDcC40kb+yGXgOL
yiOV7duXM6aJJ6C347D7GMaurI/D+WiUcFqhUXyjwUOa8WrjP2Vgn/RmiuCDc0lC
uLkOp4np8ja23bo9w6+UQA73WG2TStALP6c8wepTMt45BLBPXAgchLh9e4N61uwQ
8YolhpIp9ThLX3+6LY6PHpFio5kv18hMRByNzpjqlwntP20oBZp+W9mD9OAvmh81
XafHkJKNFQjCYHuql7lKc8rjr4Bu/1B2sapJ3tyXijAVoSpor2M=
=yawM
-----END PGP SIGNATURE-----

--VWnjuLIRLB+14QBU--
