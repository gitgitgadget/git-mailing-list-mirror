Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE144199920
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 15:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771515361; cv=none; b=C7gR2J+opn+qT6OlVB7nTxZgeEiXJswEtWrr/FKPrvA1W4vNNDtcwScwjGciKWSYly+YaOoLbZohgTvu/F0Rg9A7WWwuEAACeLpBGmmU4sCX5s7XJW7bxHIh8drAAN7Mbinj17PrN0QbXZpkEagkGOxfSKsu1Y+TBbCafilPeyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771515361; c=relaxed/simple;
	bh=PuwfDdu0bFIr+3RMPGmJ4mtAvtX0Jy3lN7QtL7Ee5NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOmfZexPYvEsRX9vXFpyarTsLHeiTSbbYORkE5T35Zi4ktG2Zl/c+jh+/knW6bS67wn7bVBSjSHXNu+zFIhZizy0StA/m0AjHgAfPsBoWqzQetwE6XiuhjFoWpUb5Pk8Dd6lrieswkhzOIc8y83iMp57yr+HAEGUHekTYMOGH3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ocXKa4XQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jeh5xwDh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ocXKa4XQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jeh5xwDh"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 314A3EC0578;
	Thu, 19 Feb 2026 10:35:59 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 10:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771515359; x=1771601759; bh=x3HuHxGJ0j
	11EzsgXd2NXYENyvJrtAqr2kx9p6QMT3Q=; b=ocXKa4XQjuIk5NcZBNlaNKTvc1
	A6RGHmao8e4F0b9x1U4cWHIgEEmTDwmnujsv0kcHmegZHxW8FdAFlun54+OV0ohZ
	CPwM4ol//01K0kRiBAUGToYWfYoT+wRo4G9ewbylWcjfSx/68wHqm5JUaYML2N4A
	zjFY7OGRlHTHKO47LutruUWlH6mBCNHofPB/cCIBWkECnf1ysj0+H3kv3DwllvNJ
	P5Nt9vwWdXwaMWNcwl+atuX5RqxtueerMGJAdE/dYddm5gEyZV7PiHfvnrWV7YIO
	dZVPfHFcwmeH+LBIkUZU7bHk0xq6feVuLCcx0RERK4/UTbsLe/2w7g7g1e/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771515359; x=1771601759; bh=x3HuHxGJ0j11EzsgXd2NXYENyvJrtAqr2kx
	9p6QMT3Q=; b=jeh5xwDhK81rNTgtG60D7DsOyHfcBciwabL9K0FVCiaVPuAB1l0
	6uAhbEDMq4ddOZ081FCL0cvNYGEJkFith/E6MXXLbV9y9BMzRFRwR2UgQQQOJCha
	ZtoNxV6FqLRD7NlC5zgyMS675OuxBQW5gGUaqq2tVjCF5+g9FThBuDNXqsamK7yx
	BtUdHAgvzNm19z5UlYCdaajnzLsyd1lGMVEMYvSVkyz7jXQv2qLGw8ZF662T/m/k
	BMRo4dV7lHRgTC6BFViPWnjvYWe+an5UxtaZYdJY2eIG2n2+dgb+awoeGlMDhxZg
	rqnEyn6ryRHYPxZ2pwJ8KtVVY4pH759Knzg==
X-ME-Sender: <xms:3i2XaTpUQ3T6bMCeDKTmahIw7WqcSAPdeV1vyeyFYmi_laUmmjv1mQ>
    <xme:3i2XaUjf-woGkY_BNin18i4KUwwzoBxxDN3fzpzAKjct1K-r8B5mVB4UtnxtUX2lO
    un4xjNjuUs5Bi5fxlpp99PqD3FtXChi9McwdUlV0p6Um30sV6XO>
X-ME-Received: <xmr:3i2XaYhUS-HyEivNqjsEDXWmdZoU7u22XWzFv5ArCKaso9fNTowkhYfmFIuDtrgNtMSDUPJhTVpfHLqWmds6rr-0_b8W6AUVYKssaRkOeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:3i2XaShYBv5AoB_kp3YWR0JTE7hxdCsZgLckXQO4BCNg6JcoxoS-mw>
    <xmx:3i2XaQI23QUor1hILpDlJY0OgRZ3PBU_fQ-P-4n4EqHNlHTpXtny4g>
    <xmx:3i2XaZEkisdBXzCsP1T4qbou0r1uXcV4bjS6Km3avbqSeUB5tyCbmA>
    <xmx:3i2XacQfkdwv_nueZ83bhHk4n3Gdmn-17YKC9HqcSTGH3O3BkrZcmw>
    <xmx:3y2Xad-tkLpQVpe8YqIcBY-jwUAS6GJjkTKPb-AyMIoVc4DPj9b8w6vs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 10:35:57 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dcb76e14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 15:35:55 +0000 (UTC)
Date: Thu, 19 Feb 2026 16:35:52 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, toon@iotcl.com,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH v7 6/6] refs: add GIT_REFERENCE_BACKEND to specify
 reference backend
Message-ID: <aZct2M3sbQSduK2q@pks.im>
References: <20260219-kn-alternate-ref-dir-v7-0-16f27860dbdf@gmail.com>
 <20260219-kn-alternate-ref-dir-v7-6-16f27860dbdf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219-kn-alternate-ref-dir-v7-6-16f27860dbdf@gmail.com>

On Thu, Feb 19, 2026 at 10:38:25AM +0100, Karthik Nayak wrote:
> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> index 9912433b8c..d69aea3f7f 100755
> --- a/t/t1423-ref-backend.sh
> +++ b/t/t1423-ref-backend.sh
> @@ -30,44 +39,86 @@ run_with_uri() {
>  #   <repo> is the relative path to the repo to run the command in.
>  #   <backend> is the original ref storage of the repo.
>  #   <uri> is the new URI to be set for the ref storage.
> +#   <via> if 'config', set the backend via the 'extensions.refStorage' config.
> +#         if 'env', set the backend via the 'GIT_REFERENCE_BACKEND' env.
>  #   <err_msg> (optional) if set, check if 'git-refs(1)' failed with the provided msg.
>  test_refs_backend() {
>  	repo=$1 &&
>  	backend=$2 &&
>  	uri=$3 &&
> -	err_msg=$4 &&
> +	via=$4 &&
> +	err_msg=$5 &&
> +
>  
> -	git -C "$repo" config set core.repositoryformatversion 1 &&
>  	if test -n "$err_msg";
>  	then
> -		git -C "$repo" config set extensions.refStorage "$uri" &&
> -		test_must_fail git -C "$repo" refs list 2>err &&
> -		test_grep "$err_msg" err
> +		if test "$via" = "env"
> +		then
> +			test_env GIT_REFERENCE_BACKEND="$uri" test_must_fail git -C "$repo" refs list 2>err
> +		elif test "$via" = "config"
> +		then
> +			git -C "$repo" config set extensions.refStorage "$uri" &&
> +			test_must_fail git -C "$repo" refs list 2>err &&
> +			test_grep "$err_msg" err
> +		fi
>  	else
>  		git -C "$repo" refs list >expect &&
> -		run_with_uri "$repo" "$backend" "$uri" "refs list" >actual &&
> +		run_with_uri "$repo" "$backend" "$uri" "refs list" "$via">actual &&
>  		test_cmp expect actual
>  	fi
>  }
>  
> -test_expect_success 'URI is invalid' '
> +# Verify that the expected files are present in the gitdir and the refsdir.
> +# Usage: verify_files_exist <gitdir> <refdir>
> +#   <gitdir> is the path for the gitdir.
> +#   <refdir> is the path for the refdir.
> +verify_files_exist() {
> +	gitdir=$1 &&
> +	refdir=$2 &&
> +
> +	# verify that the stubs were added to the $GITDIR.
> +	cat $gitdir/refs/heads >actual &&
> +	echo "repository uses alternate refs storage" >expect &&
> +	test_cmp expect actual &&

Tiny nit, not worth addressing on its own: we could simply `test_cmp
expect "$gitdir/refs/heads", without the need to copy that file first.

> +	cat $gitdir/HEAD >actual &&
> +	echo "ref: refs/heads/.invalid" >expect &&
> +	test_cmp expect actual

Same here, no need to copy the file around.

Other than that I'm happy with this patch series now, thanks!

Patrick
