Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8440212542
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 15:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390144; cv=none; b=tg3hzl98wfb95AOAL1S3c4DkHuaM71GK4OYwCVNW4KECiIxKMRBXrGtcsMYD9QbLHRQ4Qeqge5dZIOxapkiM3QkjZHZgkN4/rmohT+3oGE5DFAPFHjHhRkdZwoAL/42utLx/bq4EbLIBcBlL1oQ71AIBX3pEfc+6RiL3e0t+g2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390144; c=relaxed/simple;
	bh=YpSF1V4Hqal0GkBqHfpNnTzIcxuF2uVYiFYvaMI0jHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obfp/W170h66xR7bfgL/tIgu07pce8J5KRWH6Q05qMLTo05kFzx5VTifLxyFmPJzZj/g8l35Ts3AtJ3/iHDiXYKUaG4si8emR4Y5M0qonAfPZJjNXgaguIGzuM2sx3DdRvGpBV8ict+zIq7f4+NObYb4CBvBdZM1Xul8MdeiLtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IkKNvyhP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PZ5jGksy; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IkKNvyhP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PZ5jGksy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 208E21D0017C;
	Fri,  6 Feb 2026 10:02:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 06 Feb 2026 10:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770390143; x=1770476543; bh=9oexe5obbp
	ml1Rst4OIXzfwCUscFoGnxo3t5YSAVFiY=; b=IkKNvyhPZKlBnUWg5t44NU4cOb
	yiTsdEAhb/vCw1C4CAn4NuowihECvIzTrB+sSOROrwvIc2Kzes2y/kSqmLDNHsQs
	afHdOzZOxAEL8jODrpgywPX67Qf2KJcLntbKd6+wKpCjl8hZLe/do0w3eo2VvpBx
	QQLQV9OVfkB6mWBu49RrdrcOfGqikWb/9HUdLPYvCUi5uAY62lhqp68YxzpfHveh
	ziFgy/YQ8WPYdHDIYQqOkPl6nARzLQFk8Qu/3bOM7QF7HPhhU4BnqrO5Ew31rSoc
	5VMvk8eMK0KV1QUVFiOo0afuLJlLBculOBhUY8OsU4n6os3gEgX5uAwnswqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770390143; x=1770476543; bh=9oexe5obbpml1Rst4OIXzfwCUscFoGnxo3t
	5YSAVFiY=; b=PZ5jGksy189NrXfIV4iBmo1vJgulvs158HTPHvXflnmctKRTmc9
	qOA72giE7gogY03vWxdaqBHk7m9FKoX2sWHmXGduRsyYMdNKplvKB/o6XQMVwM4O
	ZGH+uxwxwNEcKcYWvxJaUX5O/8edemmqYHrsz73RqbbF+G+m/GjlyGL6Nhl0giT8
	US42MbC/WDk/Dxg6GNj7Gh1PBQWt6iYdtDe51Z1BOdu6/iVN9vcB6eXOZcVEEk5l
	ep+z8ZxGcm9W/uN7wsGqLHtt1msQWIpU73pvNrwaSq9hfyIlKBXtpsEUyedbHPO/
	wtCp540CsMlCACCUxaw3NjxGu1A1QUqGuIA==
X-ME-Sender: <xms:fwKGaVWAPKN9fABtmg4M1Wn5qVAdpl8EoOIXfW4QfqF-7w6tWHwlYQ>
    <xme:fwKGadD5PJKzF3iDumK-4WQbumfCDMa5LZn3seUsCfW7uuxSqoyFD0tsr0emCiDg8
    euWCjuNNqJFM68yajWU-CmLRoUOckJcldw0ZUzyDJ46oZRanN0ZMQ>
X-ME-Received: <xmr:fwKGaexFpewloeEjdKimgUMllSON8SN2HA20tB-tUmTOf2qwsKoqs1AyepnqGlpSD3sErblnweKAmgDA_3BfFeefwpHUhj-zBcL28g-nIww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehsrghmsehsrghmsghoshht
    ohgtkhdrtggr
X-ME-Proxy: <xmx:fwKGaSBRi0Vp9zFQFBduRKDx7Zpf6RE8jJPV8cB_BB-qE1RWKQyNvA>
    <xmx:fwKGaTbGFbvpJtEX9dK8xAIJHIdgWrFHAZW7durNWHru1TFCSK370A>
    <xmx:fwKGaShqs9Aipv5XTymxNtb6i6nkm6sXg9sRdjqdDdeG-28tOcVR-Q>
    <xmx:fwKGad4sdwhv-9khOQlcjMr5gkC4e-GoipBgJAWRt-m3A0mycuuTWg>
    <xmx:fwKGaRAI5_hMO5SJQ_h5gKs-We86IBsZyeNRB4-BtP02dNgGUvfXN6ts>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 10:02:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6897a8bf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Feb 2026 15:02:21 +0000 (UTC)
Date: Fri, 6 Feb 2026 16:02:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Sam Bostock <sam@sambostock.ca>
Subject: Re: [PATCH 1/2] merge-ours: drop USE_THE_REPOSITORY_VARIABLE
Message-ID: <aYYCesJsZMdHu1Ia@pks.im>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
 <6cb970e512c02f0db11b8aae247aaa1675b31ef0.1770345124.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cb970e512c02f0db11b8aae247aaa1675b31ef0.1770345124.git.gitgitgadget@gmail.com>

On Fri, Feb 06, 2026 at 02:32:03AM +0000, Sam Bostock via GitGitGadget wrote:
> From: Sam Bostock <sam@sambostock.ca>
> 
> Use the `repo` parameter passed to cmd_merge_ours() instead of
> `the_repository`, and drop the USE_THE_REPOSITORY_VARIABLE macro that
> is no longer needed.
> 
> While at it, remove a stray double blank line between the #include
> block and the usage string.

Nice to see that the required changes are this small, only :)

> diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> index 97b8a792c7..2312e58ab3 100644
> --- a/builtin/merge-ours.c
> +++ b/builtin/merge-ours.c
> @@ -8,20 +8,17 @@
>   * Pretend we resolved the heads, but declare our tree trumps everybody else.
>   */
>  
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "git-compat-util.h"
>  #include "builtin.h"
>  #include "diff.h"
>  
> -
>  static const char builtin_merge_ours_usage[] =
>  	"git merge-ours <base>... -- HEAD <remote>...";
>  
>  int cmd_merge_ours(int argc,
>  		   const char **argv,
>  		   const char *prefix UNUSED,
> -		   struct repository *repo UNUSED)
> +		   struct repository *repo)
>  {
>  	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);

One important part of the puzzle here is that git-merge-ours(1) cannot
run outside of a repository, as it is tagged with `RUN_SETUP`. So as a
consequence, `repo` will never be `NULL`, and thus all the changes to
s/the_repository/repo/ are safe.

Patrick
