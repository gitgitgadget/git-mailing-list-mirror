Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51D830B510
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 07:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767685490; cv=none; b=udbkWPDeUr2Q2mzwxnSYvgpjdTJ+fNmw/qZ1AqjOFoKF5bNK1xibokfPQlYNjE1k/p3fQZOTZWfNmGOdajagtJBroVo6XDDbjcIOhZaOCYhAz98Q4uwK2ma3/E1rER3EwJWTN4uF1ecoUMnxOJ33PDvLqW/scs0GmRIey+dNed0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767685490; c=relaxed/simple;
	bh=+jy2p7Lr/982tHwkq++dLSUyQj+OKZ8G64imNnCQkng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sw2FM8+AOM1JqAlPNC7BlJ25AF6U31SEDdwLd7jF1uji7lr7IqgR9WArfTV1wuxlLAwrt0VF4243b7D7OUvD2IZwOvi7zXpalY+00F0fwbIW0qu6IkmcgJ+1g0Jwbmw2bDeTeny2oMy+AyxGONHXQkKuGoMX8ZNufo4VtokP7ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cvegKzeJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JUlYaVde; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cvegKzeJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JUlYaVde"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0F3A37A0150;
	Tue,  6 Jan 2026 02:44:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 06 Jan 2026 02:44:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767685487;
	 x=1767771887; bh=njPm7/ioHMcYaB4rg0nZb5UkgY31kJ3yh9E6g51t0x0=; b=
	cvegKzeJ2dJKOBmkJLUObLoHOLv7gpdg4SXrWmGrRYXWD/KL/S3Oizc86GW08K8I
	BLeQwEuMkE0GUEDeU+nFoITTTrfePYBIeVFbpMuWAZooqhqgsGeIJHwOJ1s3kF6B
	4x3tELVsQ35Ks7WlbAY1+aIYXLWCxHHSl8wp4IpcP04ZqeeLvH/jsDp4dN/Eq3i8
	QnddJj5Td+MN4h9C9Joc7vAu6fQJkJpz8MAclOYQtP7a3dcaL8S2piyPDtL1d9IA
	QEtCsKF4azPEGUNRfkkr13WRYKn1WEI9E3nF3cntokGBNRcBVxS5GVhWCVfvce2r
	n9Iw+y3WaB2Ck90/BfYm9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767685487; x=
	1767771887; bh=njPm7/ioHMcYaB4rg0nZb5UkgY31kJ3yh9E6g51t0x0=; b=J
	UlYaVdeGr/5LNsWKwF/wSG+xWTm5gV7z4KxbzybFjPslfh332MgSJlU+Ca1LFCL1
	BXeA6xn+SIbzL7TvDnDaOv1N7L4XhfyJSe9mLq4/u0nhWKgsjbtb4NhYXojSgJ9i
	9UU1MWqki3316h911BKbbfCBjRSWstt4qkO9OuNeAIsCp5HsuGoAn6/87UHEy/yo
	8HNLiiZgw1znJ1wc4QlU3vDzX0zANwZBzQVKLx8gybHVW6K6m+Wl4NzbkKqHsT1K
	M0LpyGm0O61qaX0MYMoYYjl0TMNGQ9dvPEC0bQyZAkslUvBJAwknQU/u2/WHJEG9
	zCxi+A/62YuT5kmJYbr8Q==
X-ME-Sender: <xms:b71caQc80RQTDBjfLHErKG3PH8rnluJCiV7doBLQjnIT3wNnKEUfdQ>
    <xme:b71caZrQSvPux96vyRD3jfiQZoRXqCTYHzgYk4IGt2mPRkClEdorwJH6zp_rm5y4W
    IAMbU47SEDg8D7YqEe_wrOMeZ-t01MekRWlqtt4mQo22Y5T3GnZiA>
X-ME-Received: <xmr:b71cae41u9wvkdBy1n3OVgV10sj2mECFAbDVLsGxAUGd1jF9FnrtPsnKjVN43yM0T9K-lLhjoI2agT_DCnDAAhZSfAgoV3KcGETtxyw2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvdefjeeitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghmohgpph
    hoghgrtghnihhksehtqddvrdhnvghtpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:b71cafpNXDJmq9YDW7LWjKh0b16OswbilYybft7SnEFzn3qucUNEAQ>
    <xmx:b71caQhLNXiVSKPQXoA5tnyB9fldzzser9KcEov1iexp7EHQzAnx-g>
    <xmx:b71caZKjCzbMMafsSIMdl9kwhoo2vkNzs7QQoXccZXIgrLI6dRLbug>
    <xmx:b71caQDbVExUrMM1ZN4fYezyfroQGxMNE6OqN539EnT08Hc7C1QKPQ>
    <xmx:b71caVp_D5zOfk-9W4MFQX-TnB8lpv2Z4Z3CHLY9W16Nyv844gxamtUn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 02:44:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c02aed77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 07:44:45 +0000 (UTC)
Date: Tue, 6 Jan 2026 08:44:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Samo =?utf-8?B?UG9nYcSNbmlr?= via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,
	Samo =?utf-8?B?UG9nYcSNbmlr?= <samo_pogacnik@t-2.net>
Subject: Re: [PATCH 2/2] shallow: handling fetch relative-deepen
Message-ID: <aVy9a9f1AZzTbBQa@pks.im>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
 <b352a33c90ca67f4ad68df08c0fd155ceeeb167c.1765303880.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b352a33c90ca67f4ad68df08c0fd155ceeeb167c.1765303880.git.gitgitgadget@gmail.com>

On Tue, Dec 09, 2025 at 06:11:20PM +0000, Samo Pogačnik via GitGitGadget wrote:
> From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
> 
> When a shallowed repository gets deepened beyond the beginning of a
> merged branch, we may endup with some shallows, that are behind the

s/endup/end up/
s/shallows, that/shallows that/

> reachable ones.

Hm, which reachable ones? Sorry, I can't quite follow, it would help the
reviewer to add a bit more context.

> Added test 'fetching deepen beyond merged branch' exposes that
> behaviour.
> 
> On the other hand, it seems that equivalent absolute depth driven
> fetches result in all the correct shallows. That led to this proposal,
> which unifies absolute and relative deepening in a way that the same
> get_shallow_commits() call is used in both cases. The difference is
> only that depth is adapted for relative deepening by measuring
> equivalent depth of current local shallow commits in the current remote
> repo. Thus a new function get_shallows_depth() has been added and the
> function get_reachable_list() became redundant / removed.
> 
> The get_shallows_depth() function also shares the logic of the
> get_shallow_commits() function, but it focuses on counting depth of
> each existing shallow commit. The minimum result is stored as
> 'data->deepen_relative', which is set not to be zero for relative
> deepening anyway. That way we can allways summ 'data->deepen_relative'
> and 'depth' values, because 'data->deepen_relative' is always 0 in
> absolute deepening.

I think the commit message needs some polishing. I myself am not that
familiar with our shallow logic, so I'm a bit lost here to be honest.

Typically, a commit message should be self-explanatory and guide the
reader through the problem space as well as the solution. It should, in
the following order:

  - Explain what the actual issue is as observed by the user. I'm not
    really sure about this part, only that it's something related to
    shallow clones, deepening and merge commits.

  - Explain what the root cause of the issue is.

  - Explain how the root cause is being fixed. Ideally, it should also
    explain why that is the correct fix, potentially referencing other
    code like you do.

Your commit message on the other hand explains more of the "what" and
less of the "why", which makes it hard to follow. Also, an ASCII commit
graph would probably go a long way in explaining the issue :)

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index 2677cd5faa..d05c45e32b 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -955,6 +955,30 @@ test_expect_success 'fetching deepen' '
>  	)
>  '
>  
> +test_expect_success 'fetching deepen beyond merged branch' '
> +	test_create_repo shallow-deepen-merged &&
> +	(
> +		cd shallow-deepen-merged &&
> +		git commit --allow-empty -m one &&
> +		git commit --allow-empty -m two &&
> +		git commit --allow-empty -m three &&
> +		git switch -c branch &&
> +		git commit --allow-empty -m four &&
> +		git commit --allow-empty -m five &&
> +		git switch main &&
> +		git merge --no-ff branch &&
> +		cd - &&
> +		git clone --bare --depth 3 "file://$(pwd)/shallow-deepen-merged" deepen.git &&
> +		git -C deepen.git fetch origin --deepen=1 &&
> +		echo "Shallow:" && cat deepen.git/shallow &&
> +		git -C deepen.git rev-list --all >actual &&
> +		echo "All rev-lis:" && cat actual &&

This statement and the one two lines further up look like debug code to
me.

> +		for commit in $(sed "/^$/d" deepen.git/shallow); do

Nit: loops should be formatted like this:

    for commit in ...
    do
        ...
    done

> diff --git a/upload-pack.c b/upload-pack.c
> index 2d2b70cbf2..ecd3e7f5ef 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -704,54 +705,82 @@ error:
>  	return -1;
>  }
>  
> -static int get_reachable_list(struct upload_pack_data *data,
> -			      struct object_array *reachable)
> +define_commit_slab(commit_depth, int *);
> +static void free_depth_in_slab(int **ptr)
>  {
> -	struct child_process cmd = CHILD_PROCESS_INIT;
> -	int i;
> -	struct object *o;
> -	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
> -	const unsigned hexsz = the_hash_algo->hexsz;
> -	int ret;
> -
> -	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
> -				 data->allow_uor) < 0) {
> -		ret = -1;
> -		goto out;
> -	}
> -
> -	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
> -		struct object_id oid;
> -		const char *p;
> -
> -		if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
> -			break;
> -
> -		o = lookup_object(the_repository, &oid);
> -		if (o && o->type == OBJ_COMMIT) {
> -			o->flags &= ~TMP_MARK;
> +	FREE_AND_NULL(*ptr);
> +}
> +static void get_shallows_depth(struct upload_pack_data *data)

This function looks very similar to `get_shallow_commits()`. Is it
possible to deduplicate the logic?

Thanks!

Patrick
