Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65AE323ABA6
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752162197; cv=none; b=d8i74TcoJBw/s7My2B0R+zF6CreZlpKekx6FPRHddEC2ZX04SF/9dlXBqNg4Q0ekHO+F9U51nwBkgb7WYAv8X5lpMzwNTdeWv8rQAT9r+m0gi+quYaK/JJvZv6OnnFF9pl5Xd9YT2DG//0wyodlLrDePgRTvvEhOf5jsTCqkT3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752162197; c=relaxed/simple;
	bh=h6tl/m4FWEySaNUk140TOH09L5REVdzcp5FNL6xNJ1M=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HOBGiHt0OnSMk9m7DYPLkTZdid20VAq9KXUVgdlPujG7fx6l6MuDBQSw+Pu70VgiKOoXiVDJeT6z12oE//2oHogarSV+DfHUrrXSTe096yg5otC7CagYYg3FgffcePIAxzFptHymSHePnMd5fKGDTJ7VlMRM4Y0f7a3nWcoMf0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz5t1752162151t8465dbd2
X-QQ-Originating-IP: ZqPCqTelPFAWqFlGyEhivyZx4u0o8W3WPU+YPYshFjs=
Received: from smtpclient.apple ( [202.119.44.124])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 10 Jul 2025 23:42:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 753868210525157199
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v5.1 3.5/4] revision: make helper for pathspec to bloom
 key
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <3c59af48-23fe-4cc7-87e9-1de94f509a2b@gmail.com>
Date: Thu, 10 Jul 2025 23:42:18 +0800
Cc: git@vger.kernel.org,
 gitster@pobox.com,
 toon@iotcl.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <7885EBB2-0D99-4456-A704-86362219AC17@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
 <20250710084829.2171855-5-502024330056@smail.nju.edu.cn>
 <3c59af48-23fe-4cc7-87e9-1de94f509a2b@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MX2TrL0qDY4jN5fuC5bfkacSvFZyV44KGL9wWiBX5vsrqiYNWVAzT9Ys
	9/WldiT+IRI064kPUD256xz0m48XIriDTLiPO/m5/oFUM2e9fhwH9TC75OOKFOBZj/POf+M
	AYMFBFncLFf5jWDkO8o4a1Phkl1SHoYr58pWZDWgwenQo0VP9mWqqmLZQgvWjD4hSpMT0IA
	NW75eDFqPZJhaiRbS8tWC2dfd90xq1nl2CpmHHlnI/ONNYrULbYGvJwOpM2DEE20eAC+ywi
	k9JogebTR3z6Y27zZb/OZcbS3wN+E5JN6JXgOl8hbldobwiAaOexxp5o6jFshzg1CMg/pNc
	pSrYyD0/iDaBS1Rz6hBYprloUdvGlNVZgqNBlC57OO5aKLRQxLg1iqu627Obv0sbue8HT9s
	cA4ngrzrz6lBrhrFmCFAqJkrWEzynVWvJtzQ1UTxN5rCdy6+aaBFyhApaZDUv3ZXtD74oTk
	5oWcFnE2S2F9iWSTDyN50BYKwza4rlgh4onV6zPRPp5ufPlQ3xk5X/ENwotqezi10LJ3oYu
	0xflcj9nJIrWmSEeu6ehEiD6qF19Cb+cwBn3ZUK0LernTgjhHjh6wQ9GzBFAiHTN08oVJCv
	ezKkSw86cX9r/apDf73NJEwoWECLD4M+WfXNFUEoEaafbjOSeN2JACqroFUvE0VcZA0cz8B
	qnMHflJlg3CrnQbjncHbbKS/NHGGTqgMVKNU+rF32RH7NF/JZZq/1zW62BJNPsWicjUFyQe
	OI+XMUr2HoDoqEIzXTqSkKqJV2YPMQSzVKVGcEnUS0pc2Ei4ftxK51C0d8pqCxjCNH2/5lh
	4ofCuHkMY9HnPAYmHpqrYQObrH1wvpCbnYmzUQey/DhUhITpw/FICVxcLOr9KPk3GnkcPUx
	w+T0yJmw3cqUyqQtfXhdUEN5ufFVLUgabH5GEMsAkNOKCsK8FbPH97bH2/B3/kROahP/UGY
	rU8zRT47hcQdAi+YUeayrYD+C0xdklpEgzuXN4k9Jt1y1tA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Derrick Stolee <stolee@gmail.com> wrote:
>=20
> This diff is still bigger than I was hoping, so I'm sending a couple
> of patches that simplify this code movement. Feel free to ignore
> them as being too nit-picky.
>=20
> --- >8 ---
>=20
> =46rom 69fa36dc615e140ae842b536f7da792beaebb272 Mon Sep 17 00:00:00 =
2001
> From: Derrick Stolee <stolee@gmail.com>
> Date: Thu, 10 Jul 2025 08:06:29 -0400
> Subject: [PATCH v5.1 3.5/4] revision: make helper for pathspec to =
bloom key
>=20
> When preparing to use bloom filters in a revision walk, Git populates =
a
> boom_keyvec with an array of bloom keys for the components of a path.
> Before we create the ability to map multiple pathspecs to multiple
> bloom_keyvecs, extract the conversion from a pathspec to a =
bloom_keyvec
> into its own helper method. This simplifies the state that persists in
> prepare_to_use_bloom_filter() as well as makes the next change much
> simpler.
>=20
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
> revision.c | 50 +++++++++++++++++++++++++++++++-------------------
> 1 file changed, 31 insertions(+), 19 deletions(-)
>=20
> diff --git a/revision.c b/revision.c
> index 22bcfab7f93..4c09b594c55 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -687,14 +687,37 @@ static int forbid_bloom_filters(struct pathspec =
*spec)
>=20
> static void release_revisions_bloom_keyvecs(struct rev_info *revs);
>=20
> -static void prepare_to_use_bloom_filter(struct rev_info *revs)
> +static int convert_pathspec_to_filter(const struct pathspec_item *pi,
> +      struct bloom_keyvec **bloom_keyvec,
> +      const struct bloom_filter_settings *settings)
> {
> - struct pathspec_item *pi;
> - struct bloom_keyvec *bloom_keyvec;
> - char *path_alloc =3D NULL;
> - const char *path, *p;
> size_t len;
> + const char *path;
> + char *path_alloc =3D NULL;
> + int res =3D 0;
> +
> + /* remove single trailing slash from path, if needed */
> + if (pi->len > 0 && pi->match[pi->len - 1] =3D=3D '/') {
> + path_alloc =3D xmemdupz(pi->match, pi->len - 1);
> + path =3D path_alloc;
> + } else
> + path =3D pi->match;
> +
> + len =3D strlen(path);
> + if (!len) {
> + res =3D -1;
> + goto cleanup;
> + }
> +
> + *bloom_keyvec =3D bloom_keyvec_new(path, len, settings);
>=20
> +cleanup:
> + FREE_AND_NULL(path_alloc);

I think we don=E2=80=99t need to NULL path_alloc here, but it doesn=E2=80=99=
t hurt.

> + return res;
> +}
> +
> +static void prepare_to_use_bloom_filter(struct rev_info *revs)
> +{
> if (!revs->commits)
> return;
>=20
> @@ -712,22 +735,12 @@ static void prepare_to_use_bloom_filter(struct =
rev_info *revs)
>=20
> revs->bloom_keyvecs_nr =3D 1;
> CALLOC_ARRAY(revs->bloom_keyvecs, 1);
> - pi =3D &revs->pruning.pathspec.items[0];
>=20
> - /* remove single trailing slash from path, if needed */
> - if (pi->len > 0 && pi->match[pi->len - 1] =3D=3D '/') {
> - path_alloc =3D xmemdupz(pi->match, pi->len - 1);
> - path =3D path_alloc;
> - } else
> - path =3D pi->match;
> -
> - len =3D strlen(path);
> - if (!len)
> + if (convert_pathspec_to_filter(&revs->pruning.pathspec.items[0],
> +       &revs->bloom_keyvecs[0],
> +       revs->bloom_filter_settings))
> goto fail;
>=20
> - revs->bloom_keyvecs[0] =3D
> - bloom_keyvec_new(path, len, revs->bloom_filter_settings);
> -
> if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
> atexit(trace2_bloom_filter_statistics_atexit);
> bloom_filter_atexit_registered =3D 1;
> @@ -737,7 +750,6 @@ static void prepare_to_use_bloom_filter(struct =
rev_info *revs)
>=20
> fail:
> revs->bloom_filter_settings =3D NULL;
> - free(path_alloc);
> release_revisions_bloom_keyvecs(revs);
> }
>=20
> --=20
> 2.47.2.vfs.0.2

This looks perfect to me. I would squash patch 3.5 to patch 3 in v6.

Thanks for your patch,
Lidong

