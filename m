Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E823340DFAE
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 12:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773146950; cv=none; b=HONwekBnL0SpishyypMiCMsll3yHnDYbxIRfUNGIAW9DD+EWP0BoTzsslcUnjI2/nTTRz45TEvCGFUz6TkN6no03Gi1tooriORX8q8ND85eamtDSXh7AbNv4FkcIeN5fJL2feAXMgP4xVDrj5JqrYdDxMOnLfSDQnCoHFvdzv+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773146950; c=relaxed/simple;
	bh=KdmaIdx2JGGbYBYeAYhRkgwbeu5gfKhI09pa2mZyWK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZYpiqxTHfO2Pv5oxLrkXyHAnj6GUN6/Rfm2rY8iNRt4yctxwslkFvjHNcNs0B8EVPTDKNhuvAIx3NTgVg7wagFMw5Qu8fkw99a7vHp0aYO9YTyX3/vfC4vZSX3SdxWsZ6czDcQxhN5vf3v6ZP2wAferJW9oXhvIXs15el1uhtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C1aoGtut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fYWJZ8Yp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C1aoGtut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fYWJZ8Yp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 3A81EEC0B43;
	Tue, 10 Mar 2026 08:49:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 08:49:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773146948; x=1773233348; bh=SWyD30zId8
	Xt0e/Q2ka+JQM8p8GJ32DbbePbv/AMbro=; b=C1aoGtutDJl5NlH6IvkQe5jT4A
	/sE6bd2hKMvclcf9g2eQkvoIGwBmj5XlFikLz7PR2DKi2/kWNMSKjPMLGa2VQUFh
	9Epv/68JLEBh5agQn0TdL2md6qQLhFY2BnJNxo+BMj1IM0+KOq3nC11PI0ZGVsjv
	i+Ybv+bE+SDtfWs8n1anCw3IgAvSFbX8PeiaQbglotc/FNqnqRCEVY6FjMI3QZ1U
	e3rWj22ZqsCnmKNOOZ67rBeppYH/fKpqw0zl6LkHwNI6vD8IJNrirgtUg4N/+wOW
	zqyZYXYG/5EFtbwiLOd44AIs+J+4S4THKu4rYeUWVVMgGfs/Gd5HoX4DVtNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773146948; x=1773233348; bh=SWyD30zId8Xt0e/Q2ka+JQM8p8GJ32DbbeP
	bv/AMbro=; b=fYWJZ8YpbgYPbk3Ew4Nj2vv3cGIalxPoyBQsXyBTyGzIB7NTqLy
	4WHhiJt2z18yLg8/qKySWzwSjRtTSQEkduaTeCbblGDmiQCqnhqsr3x19bvTtaJr
	1xdI8Su+PF5KZK0DhUDF4/2sY1qRYus9hpMPP5cUYAndNCOZDFAz9WgI9LMJCo6z
	KkCorfS7SEdPhwG2RfydARmvT/kGumpwdxiD/IvNg0Sl2sx1GfgqOVWJ6lqbklYB
	IvlRieDXCUEYkPjO8cyhntOq7raboFebKsaCktAiuFJt68TAA4mjjvm/RYFgeiuu
	YBPkxiMbUzloroompPJq/3y+Mo439PBxpJQ==
X-ME-Sender: <xms:QxOwadXOSdQ3yLBE-UcBkxm5XKzBH5j3GJZD2DjN83vcIcRaG2hgQQ>
    <xme:QxOwaXrO6Wc0Eskmzupcutd5bNkZalR6LNKd_O_GxzMAI9cNZo3XiuyAU5d1vOFuM
    1FwB2QGsz2PVuXXevUu8qQXFv-T0htAZfqlPa6ji1NOVNmxGaCLcw>
X-ME-Received: <xmr:QxOwaZThYOZFogCQlUyYPspCUtoIFe2azY-2BQpBrd2ydmenkg2axaZZpQoyxwspqTQ4oUJxlz1c87kUxKOOoIRrH1PZZO51ItwOO4-o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedutdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehmsehgihhtrd
    hsthhrohhvrgdrughkpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghv
    rghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsth
    ihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:QxOwaR3_w_z4Jif7-95CGDHxoecpgHv-r-iwt1UmTjEnGTaIdFTE6w>
    <xmx:QxOwaVBr8J4SbKadychohNFRguelyOvDMlhKgM_0jzUPjEdXK1OJXA>
    <xmx:QxOwadiucG8YkF4Om4ijA6NZxja8n6gHrgfvGdM2p0Yzkmm6HghJ1Q>
    <xmx:QxOwaXMQb1ewVJQuaK8_62wHHLqvla_HlfuqRVA3rYUjkp3IMtJqfA>
    <xmx:RBOwaf-LrpK69cjCHA0D_lRWoDASUhFHxZKEStrdA38atkwpRKABSY5J>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 08:49:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dad208b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 12:49:05 +0000 (UTC)
Date: Tue, 10 Mar 2026 13:49:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mathias Rav <m@git.strova.dk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	John Cai <johncai86@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] merge-file: fix BUG when --object-id is used in a
 worktree
Message-ID: <abATPiRUczb8fe4t@pks.im>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>

On Tue, Mar 10, 2026 at 11:46:01AM +0000, Mathias Rav wrote:

Which commit is this patch based on? It doesn't apply in its current
form on top of "master" since at least 8600b4ec9e (merge-file: honor
merge.conflictStyle outside of a repository, 2026-02-07). Please rebase
the patch.

> diff --git a/builtin/merge-file.c b/builtin/merge-file.c
> index 46775d0c79..a8768c6e0c 100644
> --- a/builtin/merge-file.c
> +++ b/builtin/merge-file.c
> @@ -110,7 +110,7 @@ int cmd_merge_file(int argc,
>  			return error_errno("failed to redirect stderr to /dev/null");
>  	}
>  
> -	if (object_id)
> +	if (object_id && !repo)
>  		setup_git_directory();
>  
>  	for (i = 0; i < 3; i++) {

Okay, makes sense. Makes me wonder whether we have other cases of the
same error class.

> diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
> index 06ab4d7aed..60cc43775f 100755
> --- a/t/t6403-merge-file.sh
> +++ b/t/t6403-merge-file.sh
> @@ -506,6 +506,15 @@ test_expect_success '--object-id fails without repository' '
>  	grep "not a git repository" err
>  '
>  
> +test_expect_success 'run inside worktree with --object-id' '
> +	empty="$(test_oid empty_blob)" &&
> +	git worktree add work &&
> +	(cd work && git merge-file --object-id $empty $empty $empty) >actual &&

This can be written without a subshell by saying `git -C work
merge-file`.

Thanks!

Patrick
