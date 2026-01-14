Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65730393DD9
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 10:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768388335; cv=none; b=H+SZDZsnM1RAF2/8GuNvcfzQmjxNv1YHDacdHJHBZGRkbSpt36O7nv2Am5+eBn9qCI7xL9CqHWkaCVX5nW02yoYtYyx0kXvOIpncFivQD2mTlkN3yA0Dekjf6OZJCtVPUj6edq2VmZT/nQSx7G6lr2Y+a/lwPJd+o0KGLr1oDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768388335; c=relaxed/simple;
	bh=BEJ8/Rq0LxtpR44rLGeDABU2U+frgKlsjb91tSfScmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmzV/A0E5jyZyC5Ur8e718o1aWKFyrsZRl7Nrp7qr5Ty01fIuCea/R2XWS3p8DODjlBTknYaRSqiTQs4gEUf1Aq1QKKkAwi1ShrEtSXh/CwPrMyp1b30VP4g0Nje0RTM8oJWIUnUU3UL63NTYLrEJi3937hlDli+3x2Kb0zytQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GCgGYeJX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HHmetAMW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GCgGYeJX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HHmetAMW"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A90F5140012C;
	Wed, 14 Jan 2026 05:56:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 14 Jan 2026 05:56:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768388185; x=1768474585; bh=HIIXgpEyy3
	szu5j2fmSXigcae1oBm/hq9iPhOnTt7q0=; b=GCgGYeJXGwdIqgTGiTQyGYZhxI
	2v9ap40C37YfZnTjnsfRuVj1n62Uh8oyQ+MGNlLz0hxSBiA5lMuuelRfRRIAWk+E
	3+RmDyEuGJVVsS3K+nAmHv5uC7xUIHIkm/Df9+jVzQHOLcW2tUH9rnu75T4jV3LV
	IlUGeXV/tOWYWL91IjnIfRfG8HdkW3VVZaB8m5eXRbIOuUAZeqijrGKPCYYRrq2d
	PT2uunoiIpAm/qdhC6jmc/A4+q+xtDRfAxPAQ/wG/fZ9MHetcQiyCaKMpZ1obk3E
	wTO6CogIIqa9KAWDNFLKYYPDaUCs1NtUaCcxb9ge43S9zSpnFoJQXNvcotLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768388185; x=1768474585; bh=HIIXgpEyy3szu5j2fmSXigcae1oBm/hq9iP
	hOnTt7q0=; b=HHmetAMWKMcTpGNnDXlvtJ4d7QmrULwjxAT5Dt7QPbkTB7Z4IAY
	E0yil2WxKCclYCQhReEeR1RDLtSgmuvSZU1iU1PpFohDx8kMmyzE/HX6cI7TkT/c
	KSrw1OpuJLzER+7Atqfzzlh6hXNC+z5QtL1jOXgi0i9wR7/9x1N/dv8aSL49yJ9y
	xUlwoTg6310Ppkf1YzUE1zH93MdX0zucsGOeVRBwMkI/JCKqXaAfKKxqEefC4eOJ
	/grTc4gHzEbYqDeeGlU0umeZXiwKHtzZ8lk5CmCv6jMRccDwUwUbpPvMbT3dPfAh
	vK2Suoopy0m2NvkuEf968dOEyreoOmtlH8A==
X-ME-Sender: <xms:WXZnaZcSVKOazxSxJY9ErM0GfhCYuN-fANQ7raWdVaDTpWRf9WU05w>
    <xme:WXZnaeqLhdpXrJzK0Eg8dVeepBqN60WRo4ZLHJ83_V1HHW0cdihWyT-nXW3uZs-J2
    a7sNCb_E0MGHz1x_kIDbEK2QzDmAiEnn709StzERxAbZcIgwuwy>
X-ME-Received: <xmr:WXZnaf7WxiLXQvFH-t8CRnGLonPb7QGcXQnx1-pEd76i0NXW2G6NNsOTTW8JVwMO56FIp_UFxw3ozC_MEzKo8g5izfVsTNEs2f1XRzDyaTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddvleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:WXZnacpBxNJQ7_9x4HD8x4eIQzl89LKpih4JdADGC6Y9EB78hWpGwg>
    <xmx:WXZnaZj6RE12zA_Y_GUtyEEIREV9GSHFkgZpygaN19-uzOEtOzEIPw>
    <xmx:WXZnaeLDNL4Y_yiLihSRPp1qorO0if2dbnJyYLaZYZ68myOyTQU2Yg>
    <xmx:WXZnaRB9n2KrLr5kdot-2Qz1oXC87qTcX9TTehzm5UADjnbSXzE7tA>
    <xmx:WXZnaVVhRUVZJzVVOTt_NVDYWt91eClU5pE7Omvng-y_xmhVZbKyeCAv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Jan 2026 05:56:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a0793107 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Jan 2026 10:56:23 +0000 (UTC)
Date: Wed, 14 Jan 2026 11:56:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v2 3/3] last-modified: verify revision argument is a
 commit-ish
Message-ID: <aWd2VcX7gERTDK2t@pks.im>
References: <20260114-toon-last-modified-tree-v2-0-ba3b1860898f@iotcl.com>
 <20260114-toon-last-modified-tree-v2-3-ba3b1860898f@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114-toon-last-modified-tree-v2-3-ba3b1860898f@iotcl.com>

On Wed, Jan 14, 2026 at 11:24:47AM +0100, Toon Claes wrote:
> Passing a tree OID to git-last-modified(1) would trigger BUG behavior.

I guess passing a blob OID would cause the same. So maybe:

    Passing a non-committish revision to git-lsat-modified(1) triggers
    the following BUG:

>     git last-modified HEAD^{tree}
>     BUG: builtin/last-modified.c:456: paths remaining beyond boundary in last-modified
> 
> Fix this error by verifying the parsed revision peels to a commit-ish.
> 
> While at it, also fix a memory leak in populate_paths_from_revs().

You fixed this memory leak in a preceding commit now, so this remark is
not accurate anymore.

> diff --git a/t/t8020-last-modified.sh b/t/t8020-last-modified.sh
> index 1183ae667b..22635de447 100755
> --- a/t/t8020-last-modified.sh
> +++ b/t/t8020-last-modified.sh
> @@ -55,6 +56,13 @@ test_expect_success 'last-modified recursive' '
>  	EOF
>  '
>  
> +test_expect_success 'last-modified on annotated tag' '
> +	check_last_modified t2 <<-\EOF
> +	2 a
> +	1 file
> +	EOF
> +'
> +
>  test_expect_success 'last-modified recursive with show-trees' '
>  	check_last_modified -r -t <<-\EOF
>  	3 a/b

Nice, thanks for adding this test.

> @@ -235,4 +243,9 @@ test_expect_success 'last-modified complains about unknown arguments' '
>  	grep "unknown last-modified argument: --foo" err
>  '
>  
> +test_expect_success 'last-modified expects commit-ish' '
> +	test_must_fail git last-modified HEAD^{tree} 2>err &&
> +	grep "revision argument is not a commit-ish" err
> +'

We typically use `test_grep ()` so that we know what the actual contents
are in case the assertion ever fails.

Patrick
