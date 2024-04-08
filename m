Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C235912B6C
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556769; cv=none; b=IyaUJJzq0CG0lM6CnuvZfzKN2Xpy3B0qWqPNiRoL+omIxssDUVWMqsDtgFUoOSmWH/om4+qlqhfjqEPl7WAvzk+fbAl/rK3rRGsWweDpjmMpqVBrVxj/7J0YVwPKOAY3Eftm0CDDkBe5DsJBKN4aHvst2ueDJHxDc9A7O73W8j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556769; c=relaxed/simple;
	bh=rCCmtfo7iYF3wS6pe0LRwivj48WSQb7BXMHh70kWys4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/P/YGiQk+lCVWvRsylo/bMOzuU8ZhjlBhmOB25MfL1tHrB6NIK1pUiFJpCs0FUud/byRFSZv+UeSPBZ1bx7e4s9UxgJAwVWqPtowOi0yfmbVIBEe0S5/Q1J4MJN+hlDxpbbQ1QXWNij3HIJ8jOooKOGmKliVxXwU8WY5ILEnZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lzb5yyJT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dCTOQs2T; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lzb5yyJT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dCTOQs2T"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 0D2E71140078;
	Mon,  8 Apr 2024 02:12:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 02:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712556767; x=1712643167; bh=N02Zlx694E
	Fcb+pWBtUKsX+5g5SW27lHKt2OvjBeTY4=; b=lzb5yyJTQNK5fRT27eAJp+okVq
	Oi1h+mXemmFq+ezl5kBVgsFSVUXHsoSuZd4G8jaXkckcP7uwSOCvqiYE57mVPjkT
	i1YWUBdBUkkDEaoEXZ9KoKvWF2/xhX05cHiJZEP0TWv4KACwoZiBfkZ8pwL3OAME
	ni/wR8q5CAbPsE93o5vXMAT5sGvnybgA2ZWOVG40u0souufv9QHl+79VoCEwzAIy
	bm4IseY5qhhkjbPpOGvkMtH4XXVJPmRAyZCYcMrIcx6dVyqlkrvvjxFVcWU2HPy1
	4oFL7mSifGfUzWd+0SFSaVLxDJgp2gSJtJrhcUDK8QhfxgS6I+pUchZMEZAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712556767; x=1712643167; bh=N02Zlx694EFcb+pWBtUKsX+5g5SW
	27lHKt2OvjBeTY4=; b=dCTOQs2Tu2kijaVGJF9595CFCKtZC5Lp/lTZWKJ2T8e9
	59lUwme2f1lFDzVRd2ft0TCmq2KD44Ici8hvOVNpIWWW+u1+StIX2apZeTBFnpZw
	jYrXfI2XETsVjBkFyX6aiUyoI2H5GOoX4rmI424L0nnaZp6rIEwq2ROvO/XCN/1k
	H77JI+SXneSP6fZeYx3CL6c70XpBCs0SgVKIU8UcvvRNA0PA0xOXpmVbWsu4qI5Z
	8E9fEWLTFGMbZe+HYX74ht6tW9yItkK1d7ReTDZ8bO6oc9EabA4RKdeQh7R3/NRZ
	t/Dy2I/3jL+x4wNcYF3SkLBsMBRl0wg2lkAfB7i3LQ==
X-ME-Sender: <xms:3ooTZlwbs3Fe-f8Hpf2fQQA0LkZVCviRkQrSf58AWPqdSk0YJFFI_Q>
    <xme:3ooTZlRqnZxG7zbG0GanJsxxFc44wcruj8b7a6LFx9jiuVVmOmdKLwzrsjZpPGxBQ
    fkKgmo6lCCbDaRmRQ>
X-ME-Received: <xmr:3ooTZvUVXvFkKBeUglPrpN02zrxMYsE_YM6wvrhHJNa53pWAuhpM5Gy-hQBEXrBCKao2PdnrBAvbhnDsw-hJopX4iy8rvzfOqxl03JZadFLjGTEnLQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeghedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:3ooTZnjjiEWhRWx_RRtl0Wkkxch7QZ7qupCxgzb-Ufagky5PwJpa2g>
    <xmx:3ooTZnBuipbbfNi_YUsxZ9aULD1_DHCVr-Or36-2YZOdamgYJztEnQ>
    <xmx:3ooTZgJCUOjkWKeZSKnTYJLzgSihkUj7wX5kt0sLfPVJV5UzGzaDxg>
    <xmx:3ooTZmB47w1rntxv0BKrWLaGVG8abcy2KxOtw6BxiQywdv9SDHZnFw>
    <xmx:34oTZi573IOUoLfo8I2j6OKL2M1MaiKVaWzEj-BOQ-rsi1NRZ1gQVd9c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 02:12:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7eed0800 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 06:12:39 +0000 (UTC)
Date: Mon, 8 Apr 2024 08:12:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v5 2/3] reftable/stack: add env to disable autocompaction
Message-ID: <ZhOK262a5WCxS9MN@tanuki>
References: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
 <pull.1683.v5.git.1712255369.gitgitgadget@gmail.com>
 <7c4fe0e9ec597203ee37d2c2503be319e87ff5ee.1712255369.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MCYY+DmLwNRMCrYH"
Content-Disposition: inline
In-Reply-To: <7c4fe0e9ec597203ee37d2c2503be319e87ff5ee.1712255369.git.gitgitgadget@gmail.com>


--MCYY+DmLwNRMCrYH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2024 at 06:29:28PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> From: Justin Tobler <jltobler@gmail.com>
>=20
> In future tests it will be neccesary to create repositories with a set
> number of tables. To make this easier, introduce the
> `GIT_TEST_REFTABLE_AUTOCOMPACTION` environment variable that, when set
> to false, disables autocompaction of reftables.
>=20
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  refs/reftable-backend.c    |  4 ++++
>  t/t0610-reftable-basics.sh | 21 +++++++++++++++++++++
>  2 files changed, 25 insertions(+)
>=20
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index 0bed6d2ab48..6b6191f89dd 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -18,6 +18,7 @@
>  #include "../reftable/reftable-merged.h"
>  #include "../setup.h"
>  #include "../strmap.h"
> +#include "parse.h"
>  #include "refs-internal.h"
> =20
>  /*
> @@ -248,6 +249,9 @@ static struct ref_store *reftable_be_init(struct repo=
sitory *repo,
>  	refs->write_options.hash_id =3D repo->hash_algo->format_id;
>  	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~ma=
sk);
> =20
> +	if (!git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
> +		refs->write_options.disable_auto_compact =3D 1;
> +

This could be simplified to:

    ```
    refs->write_options.disable_auto_compact =3D
            !git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1);
    ```

Patrick

>  	/*
>  	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
>  	 * This stack contains both the shared and the main worktree refs.
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 931d888bbbc..c9e10b34684 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -299,6 +299,27 @@ test_expect_success 'ref transaction: writes cause a=
uto-compaction' '
>  	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '
> =20
> +test_expect_success 'ref transaction: env var disables compaction' '
> +	test_when_finished "rm -rf repo" &&
> +
> +	git init repo &&
> +	test_commit -C repo A &&
> +
> +	start=3D$(wc -l <repo/.git/reftable/tables.list) &&
> +	iterations=3D5 &&
> +	expected=3D$((start + iterations)) &&
> +
> +	for i in $(test_seq $iterations)
> +	do
> +		GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
> +		git -C repo update-ref branch-$i HEAD || return 1
> +	done &&
> +	test_line_count =3D $expected repo/.git/reftable/tables.list &&
> +
> +	git -C repo update-ref foo HEAD &&
> +	test_line_count -lt $expected repo/.git/reftable/tables.list
> +'
> +
>  check_fsync_events () {
>  	local trace=3D"$1" &&
>  	shift &&
> --=20
> gitgitgadget
>=20

--MCYY+DmLwNRMCrYH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYTitoACgkQVbJhu7ck
PpQtbxAAqurxKtazGCMEbWqYHEcW63WDqBTGEhR9gk3LZ5w03RwKIrBa4dm0IQYJ
yh1hoi+H7l1QGNC505waW6odeF5G/ugbKNEay/1GviQhE0JrG+dRatbw53v+5jYj
UMkNFQU2QHwU3mCWycNkiAo3djUKsZeDIR9d+tmOuG8OR7WY3uBwlTJS896/ox3J
Q/7wm9GnY1na5jc/jrUj0kP1/cAN6m2cZ0weJBRiVcxePgyWnYq0ukpKyAWC8hUq
Kc5sl7YSiTZs/Io0iLha9IDTVwp6fmcfA/ybE79OTM5yt39RCn2BE26LgtCsRd4o
scu711gMF7aXHh6K8HfmbgIt0HK18fldJR5pCGakh5VCgV1NxaHXxHweEd+MM71k
RBvcH6tKhbSamQV5jlzawbgcRTWK/AOgcOqYq+KaVGJKC/AT6+3PM0AdmJ/ljiuI
0b14Op6tkacW4xPoc3cvY+/QixlhHyeN0zvF36MEYb5nDsFfKvSxtw0JAYvoZvs3
TtCEBEWVe2ywwSwtr1PuezcN3vSxyLPwcrt6Koey1a0ubcVRNwRe5aDkzTMbCK83
1C2wutv1vlUu0wqo24g6V+HyIGaJ37wBd4Lunkxc0N7igz6ipwjGgE/KP713AZQF
ydKLdxaeUGzmZRj21NjqoXgcpbI0yLoN+lP77dd6N8bOzo+bJ/0=
=SZhz
-----END PGP SIGNATURE-----

--MCYY+DmLwNRMCrYH--
