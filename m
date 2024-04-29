Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25FE57F
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714370756; cv=none; b=r8tseCv0NXzHwYdnwLEphpLdVQI5sYi5L4UkkPNDIi3tj+7/iSEbBnl+vMv52l4ttQ2LJVq0VKCL387Wxc73hwyoGXiTQESVGY8p8RmiszsCjLkPFYyGvcgHDMvZwvi4+B9q/zRiS/rFmMyQpTE/e56A7Xn1mOBL9wGnQV9pCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714370756; c=relaxed/simple;
	bh=Ad36O4HEYWyQBGI5RY9re8Qp8YZnsUIEkFoR2PSC/0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpfIVOHjxm3fPlaR8AdCYDYkBWMQE2TtxwD8x3+v/acsD6dBYt3FAYnSSzPoLkjCgEkiDaDBCLaXKr4i6dUv0AbTsX88HObomexTd+fMt4UzP9bsnwuOBKhiaHupZFnz/VJn8yi23cCapULcyswQSt6S3dqT+nF/s2rvxNjv4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QGXMEy0Z; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JFpnaRdY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QGXMEy0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JFpnaRdY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 622861380367;
	Mon, 29 Apr 2024 02:05:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 02:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714370752; x=1714457152; bh=+YS8BYERoL
	6pmItCD4igLT4qf5zxZtukek0o3Qu4Jto=; b=QGXMEy0Z2L8T0vr14Z2ueRrHMg
	mUPC0UKih3xUhS5BW8sx40Mhfg/xrwM1XByW2L0bY7Aa6j5vvLsFHGIsOY8Spir2
	hycGpe9MGIVF6LS2AhQCV6bBEHdQbzAYy4kkSGaY9gOdLrzPmp/qGLWiy661bqcT
	K9QVWMoVed33R6ch4GFN00dlcL7WfOaxcyLSyo2/HYegORD4MjENyC0Hvs8grpsV
	MSg6cbv0ympDSw88q0JFtAgHJI4Lnc34bAQuhWWhuqd4pbE9sHhckZzvYetuox3L
	lUg9sga6RqwbByVzoqJuvGs+PYF6XHbuOnsY4KlAFupT7zxzxvJxXP/vkG+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714370752; x=1714457152; bh=+YS8BYERoL6pmItCD4igLT4qf5zx
	Ztukek0o3Qu4Jto=; b=JFpnaRdYrxS512E+V811PDaeQ0Y0FfmCSig+ZWlb8yZ8
	zuNd0n3AZ8U9QKfXNqAIQmzLE8uxFY1knboLgYRKqRLryrAre9ZY1WFvpcIGBHT6
	frCChwH2zsFyICgYnfdlr3LdI8BXEsv4voAn7nvjt0kzJpN0ZJUF6fXzQX0aO6oP
	JunSPKk1SMnpIzlv8S1kFdf5VLrPy/0g3obgAKJn/+mO/HH1FE/2Dlgs4+0FpnzH
	Fitp4/gC3yVr/HyAYrWHhRrRxSB6Gt8EkzNxVf0xRm3mgwI7vhsy9C5rZRIJpJIE
	f42RTxu00S7jVbDsVbtobtnd6dym4+ytkikYoKVDWw==
X-ME-Sender: <xms:vzgvZveXyiPD2MfwqnPCBFHjKqhFpDLm2WIOKL_XI6ltQz6sTHNRXg>
    <xme:vzgvZlO6dNPOjjo5L5i_PlKxT4CbxnmqJt_MyAsDqdPneKgiQ4ZmqIehfSLhahupk
    O6IamM8wEpcrbisKw>
X-ME-Received: <xmr:vzgvZog__p3EpChWjzZ0wyWTLRdUUjkQMfhwHSdkUMyYvUC035LksfppZ0bKOeXhQJAcrGwLwor979TI9iCEBVSLSpwrd2XbtGl6xizyQohwWKF->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtledgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vzgvZg-pmHgI-UwMM96WtRA0fAlkWkxnReEPEi26d1jogJrf383Cgw>
    <xmx:vzgvZrs5-5iu6HDe0qC3Bq-a5_MaaIqy1KVCMhj-F3mfnd_ipf3z4g>
    <xmx:vzgvZvEyILw_zg4ge1pXCsRDsT-yBmZgQWIm6WDy-vVFYzwQZ7Alqw>
    <xmx:vzgvZiPIQ26P10DdjbME4DOv7eGEdxxnIJgWD3apWah0tghQ-pPMxw>
    <xmx:wDgvZhX9c1vaWDMmuZMQJf8QTAHeE7ccLTxK1eB0nWxNvAHYELez37Xz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:05:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3a3abb3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:05:29 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:05:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>,
	Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v2 00/12] Stop relying on SHA1 fallback for
 `the_hash_algo`
Message-ID: <Zi84rykU_qxE-aq6@tanuki>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
 <xmqqwmoi31aw.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wdA2PLRMMvNU4m5Y"
Content-Disposition: inline
In-Reply-To: <xmqqwmoi31aw.fsf@gitster.g>


--wdA2PLRMMvNU4m5Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 27, 2024 at 03:09:43PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> [cc: added Josh as the commit-graph fuzzer was his creation].
>=20
> > this is the second version of my patch series that causes us to stop
> > relying on the SHA1 default hash.
>=20
> With this topic merged, 'seen' fails "fuzz smoke test"; I think this
>=20
>     https://github.com/git/git/actions/runs/8807729398/job/24175445340
>=20
> is the first merge of this topic into 'seen' where "fuzz smoke test"
> started failing.
>=20
> With the merge of the topic from 'seen' reverted tentatively,
>=20
>     https://github.com/git/git/actions/runs/8862811497/job/24336185541
>=20
> the same test seems happy.

Indeed, thanks for the heads up! Another test gap that we have in the
GitLab CI setup. I'll add a separate patch series to plug this gap and
add the job to GitLab CI, too.

The fix for the failure is easy:

    diff --git a/oss-fuzz/fuzz-commit-graph.c b/oss-fuzz/fuzz-commit-graph.c
    index 2992079dd9..94ecbb9242 100644
    --- a/oss-fuzz/fuzz-commit-graph.c
    +++ b/oss-fuzz/fuzz-commit-graph.c
    @@ -18,6 +18,7 @@ int LLVMFuzzerTestOneInput(const uint8_t *data, size_=
t size)
         * touching the disk to keep the individual fuzz-test cases as fast=
 as
         * possible.
         */
    +	repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
        the_repository->settings.commit_graph_generation_version =3D 2;
        the_repository->settings.commit_graph_read_changed_paths =3D 1;
        g =3D parse_commit_graph(&the_repository->settings, (void *)data, s=
ize);

I'll send a v3.

Thanks!

Patrick

--wdA2PLRMMvNU4m5Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvOLkACgkQVbJhu7ck
PpQHYQ//djqSB/5kBZVHxnlFUINK0m3zxZZmwZXdPGksDrgCE3M6AzMCioYAgjC0
u1/gnPBw8q1Cdv6dBUJSRnvr3bgTlFFsoEyPBR4wtczDblleUgnGz/RY9bRvuc0w
F6l03ty3YcP0A5WmIZmslArgH0qewGOX5fU1fGIdjbZBbPAdMoDF69rVZFJTYen8
5hm9RtfrzgSf89gCfimCDPGArLY6mvz0Jps+ogBixvxLFZr/pFH3NiUoBKL7q4wv
f59wPnYb5QRuQ8FoKWHQCVnzBEFUautJoMDm45akKX2RvsblAnEAN0QSuq2ytRYE
ZxWBik+8l0anuyr0TR3vM7IiUGIxBN4Vv8MH5dnAWvErmdIIl6VkddpIRzovriv0
eCLXf20r3kv5as3VdTy8Olz9H6ACi2PPthFk8MRJpGiR83fZ9fVA/tQ9uR2GXElt
5Ew7ltXBE6zNmGQCsIIglEU2aQfIzLcsDoAWb3uNl2feerkOpU1hPnLMOv0xZkKi
1aMnUPgmvxMxtNq1cyUTQ5BC1z1FOghN5mNSE18/vWGCdo2Cf/E/nJmw7bYBqw+v
l6lZN/yUgvdJAuXwHDPAyKKlFuzvRtPD/qJt4Zmqad6e4WjimfbJ/oMTXdPMPg66
Ubb6DF9Go7xsUQ4jkqGOH5M4FyVevUPsWIKjWdVU5ajpcN+ZbYw=
=G2cQ
-----END PGP SIGNATURE-----

--wdA2PLRMMvNU4m5Y--
