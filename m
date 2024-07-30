Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62C197A72
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 08:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328316; cv=none; b=Wt2T3yjPKgoR9I8epn9rWeBcej0PGcZ5KqA5zvpkGVD+aFg95E8RdLXoEdfAmeS2BaOm7eQeLOUCM1n+BJO+e+/HRzHGzOktRAsowh/nZJfjkOrR1j5/NmIYMDZG0JnaHPa5vJNjztZaN+CwtOC6LLemgm5A+QIdUp4ndg6lq1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328316; c=relaxed/simple;
	bh=PiU2GQt8shQf21SGX0uABN1S2wtH2IEuldjPyeiuMIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPIHpG3IvDdjV6B8hZtmSzt6tQxXJfXAufGPO/n9dsiTOkIkVwYXZRcpyikyvbZCwaKJYiuH7bf+E5WTr2quMXVHpJtmuVecGprIY717Eb4XTzYYVIbZFPYZrlh03LDE2ZcaX5lOBoYxe7N6nP2c3/phykbTlSgL2bwJLAA5+xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yyo7LpCv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lXN+VcXD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yyo7LpCv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lXN+VcXD"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B63A91140485;
	Tue, 30 Jul 2024 04:31:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 30 Jul 2024 04:31:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722328312; x=1722414712; bh=TZgItCjdi7
	Jb+IW8j7CgANam+f7/XYuc0XF7Jvd2yy0=; b=Yyo7LpCvbI6h02R+XdyhTZYQMR
	zFCxf+OjKstS0eBXDAZ/6MwRrLdoN7vKcalUQUmjKgFdWzAAKYQ9WK1jjWh91WNB
	IRTz43PvF1CFi2L0w++j8iYC+4Cw9IOt9EDJ96EBVM83vHBdsIjdStG9nY/8jwmD
	KHSikhCKntYHXLs0jrJbfla/ehF2johIOlk9T70XyLvKevWvQmeeZeCdeBFNrCd5
	b6O/mMhfUQh5bviQzYXJd7tDTrA5vruVnv9Fos3YyGlUZBRk3nm1DKdV5PsXw2M4
	YH1YU5bOWJHbSVP2v9898qA67UbNxNf5oMSKxdaTZ6u+obNFc2EZR4ul+Jsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722328312; x=1722414712; bh=TZgItCjdi7Jb+IW8j7CgANam+f7/
	XYuc0XF7Jvd2yy0=; b=lXN+VcXDUlOl9D7saIiE4goPvsscazlC4FB6AKUtoYIk
	xWpRTs3Fg7IVfwY/+jyK/OVmChHQHpS6DB3vwCHcKZmTQaFUPHuODjeb58ps1WM3
	BjX6w3ARAQH+jE4lKAr9noeKE/NYk+84dd5X7I/+nC3InSQB6mezhz8kWd7UIMde
	cWJHBCYHiH+ykoQpfMjr7b14bP2ELFnYUo9Y/eB2Om6lYAP4+XkemC850hg/h5sT
	HFGF6HsElQ9O/wNfWjqka9AqcNZ9OJVC4NdHDI0i6o8JhgomeJa+I86VbSWOeQjv
	Hru2ajhPjhiZehPlrkW45kGGtNMk5gjpIRkv03p7CQ==
X-ME-Sender: <xms:-KSoZg3gZTvWHSj5YtDmdEcSbbW3YbVYEcMlHtcG7bH5AYZgpfDqgw>
    <xme:-KSoZrEvnuu6YSnmZf728SbP1emKtlDkSgkukS75FUxooex7YAIxCzwQQFxcr5_2f
    3sPsQ4YGia2OEu9WQ>
X-ME-Received: <xmr:-KSoZo6sv93qB64eNCO8Jl5KXYS7a8yqiJ6MXw4XEC6J9kYMcMfLAy-bkvouK0WcA3zdJ8WawJWN9k0GAJ4J4UzwM8kcpwlexHPyzmBPT7earUo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeggddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:-KSoZp14bxvMFsDfQehryR9tFtGaFBj2Hh7XAz11afF78wGfEmP1_w>
    <xmx:-KSoZjEt02fKlaka_GsONtncHodp2gPLPk6m4hv4sdfto4x70aLozw>
    <xmx:-KSoZi_glpcd6Eg8sCz4ltAMZx1c2jT15NhCUeuAqtuA3irupPhg5A>
    <xmx:-KSoZok_mfgAzLSJEhCTpsGa5xrz4yv21hTf-u-otlPJscIWJ-YZWQ>
    <xmx:-KSoZo5i7_FpB-yKGgtQxJsu1ZNiYor-GI-0zLa90_o9oGneADkXH2ZU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 04:31:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id de30ef36 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 08:30:23 +0000 (UTC)
Date: Tue, 30 Jul 2024 10:31:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v13 09/10] fsck: add ref name check for files
 backend
Message-ID: <Zqik9EOKd43WxGXp@tanuki>
References: <ZqeXrPROpEg_pRS2@ArchLinux>
 <ZqeY0eHNZjKhNvIH@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="NTlkP20Ok/alOLHC"
Content-Disposition: inline
In-Reply-To: <ZqeY0eHNZjKhNvIH@ArchLinux>


--NTlkP20Ok/alOLHC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 29, 2024 at 09:27:45PM +0800, shejialuo wrote:
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index cb184953c1..0d4fc27768 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3419,6 +3419,27 @@ typedef int (*files_fsck_refs_fn)(struct fsck_opti=
ons *o,
>  				  const char *refs_check_dir,
>  				  struct dir_iterator *iter);
> =20
> +static int files_fsck_refs_name(struct fsck_options *o,
> +				const char *gitdir UNUSED,
> +				const char *refs_check_dir,
> +				struct dir_iterator *iter)
> +{
> +	struct strbuf sb =3D STRBUF_INIT;
> +	struct fsck_refs_info info;
> +	int ret =3D 0;
> +
> +	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> +		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
> +		info.path =3D sb.buf;
> +		ret =3D fsck_refs_report(o, NULL, &info,
> +				       FSCK_MSG_BAD_REF_NAME,
> +				       "invalid refname format");
> +	}
> +
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +
>  static int files_fsck_refs_dir(struct ref_store *ref_store,
>  			       struct fsck_options *o,
>  			       const char *refs_check_dir,
> @@ -3469,6 +3490,7 @@ static int files_fsck_refs(struct ref_store *ref_st=
ore,
>  			   struct fsck_options *o)
>  {
>  	files_fsck_refs_fn fsck_refs_fns[]=3D {
> +		files_fsck_refs_name,
>  		NULL

Neat. I very much like that we can simply add new checks to this
function and the rest is handled for us already. Makes this whole thing
nicely extensible.

>  	};
> =20
> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> new file mode 100755
> index 0000000000..b2db58d2c6
> --- /dev/null
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description=3D'Test reffiles backend consistency check'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +GIT_TEST_DEFAULT_REF_FORMAT=3Dfiles
> +export GIT_TEST_DEFAULT_REF_FORMAT
> +
> +. ./test-lib.sh

Is this test suite intentionally not marked with
`TEST_PASSES_SANITIZE_LEAK=3Dtrue`?

> +
> +test_expect_success 'ref name should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	branch_dir_prefix=3D.git/refs/heads &&
> +	tag_dir_prefix=3D.git/refs/tags &&
> +	(
> +		cd repo &&
> +		git commit --allow-empty -m initial &&
> +		git checkout -b branch-1 &&
> +		git tag tag-1 &&
> +		git commit --allow-empty -m second &&
> +		git checkout -b branch-2 &&
> +		git tag tag-2 &&
> +		git tag multi_hierarchy/tag-2
> +	) &&

I don't quite get why you create several subshells only to cd into
`repo` in each of them. Isn't a single subshell sufficient for all of
those tests? If you want to delimit blocks, then you can simply add an
empty newline between them.

> +	(
> +		cd repo &&
> +		cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
> +		test_must_fail git fsck 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/heads/.branch-1: badRefName: invalid refname format
> +		EOF
> +		rm $branch_dir_prefix/.branch-1 &&
> +		test_cmp expect err
> +	) &&
> +	(
> +		cd repo &&
> +		cp $tag_dir_prefix/tag-1 $tag_dir_prefix/tag-1.lock &&
> +		test_must_fail git fsck 2>err &&
> +		cat >expect <<-EOF &&
> +		error: refs/tags/tag-1.lock: badRefName: invalid refname format
> +		EOF
> +		rm $tag_dir_prefix/tag-1.lock &&
> +		test_cmp expect err
> +	) &&

The other cases all make sense, but I don't think that a file ending
with ".lock" should be marked as having a "badRefName". It is expected
that concurrent writers may have such lock files.

What could make sense is to eventually mark stale lock files older than
X amount of time as errors or warnings. But I'd think that this is
outside of the scope of this patch series.

Patrick

--NTlkP20Ok/alOLHC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaopPMACgkQVbJhu7ck
PpSayw//YPiokaIJK0c3lNe7f4YUoMbTINoo5kcKz+lO7FZhVzDWGRHLGVS20Etp
VVeJhVbNyODDJlyOq/gNb6LY+tid8SssSA71bIZu5vUG2RlpC83A6sjdGbfTmrKt
/xmcCMqfe1NCcLikMB12jnKY6yu04wB9XdmIKuBGz6SqB2heMv9xYTck5IMTlegI
m8bxHVllX9WRd8vSf4nJnQVcHqwTZx3MdScynVG/kGtSal4KAuzhzGUrMSAJHpEF
76JqLsaJCkqNv3yH2lN4pFKNU8jygUqyD2dotAckvOSAaUEe3zbiwIMzG4TaLt7X
pwVMx3M+IEsNCj2Lfxav/lj0esEqa50gKIZILH9PGjR9Cv+lISdNwpHbKPz8AedC
o8yAjgZO9/h2r9itURQ4mWFDcmliZKiWrwKgindLvdqe++dQEc2t6SQSbiDECDwT
lN1ohQOv+9P0oE7G32TlnPTCNKPisEj46g2RHwa3hCi4Xty4oP3RUmuOxeBpcx1K
0q4DP93Ynime66LyBNcEnbczDCxvRG4TWjAM8cbXgaWbPtL4a4JrMrHIiX2uPbBz
3Aayr6dcCkGcW07bx6SaGsG5PXJpSv+IpCjy6PrJPsoJlxI7HE0A/1K6JxQQ8zK7
P3vV/i8b2u98bRROh/yGOQdO8IZul/Lh8P6HZ8Z+03D54UGZu6o=
=kuMw
-----END PGP SIGNATURE-----

--NTlkP20Ok/alOLHC--
