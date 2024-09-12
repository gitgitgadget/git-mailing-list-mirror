Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A01B19E963
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135501; cv=none; b=A8cSnTBdyhyl+EXnDdY0IRVYiZ5IUdtXSR+Cu0DVfCM3N41w4IGaww1PWBeX//O4zSFMR970Sdkn0Q3Ep+5F9sWhUu68ppqhEvlTZipDXCMOGpRevY+WLRhsVvhkZHYZyQnHEYt4iCD8XOeVEn7I3qI5ObHMEUJGfBxn7Flcozc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135501; c=relaxed/simple;
	bh=d8d92iua/e1QAODNaOUUc3XyJJh/YQqdUFDaUw6PT9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKJxKETj5WXUIXgrbsvPnMRB+lgvu9NXJWRe9xyS3DjuNTd58puz9gkQzCEhHwQPbpKsSuz9C5yYETmSL6L02aQTY6MvUh+SdY83MH8s2gbBN6/DUWKTH55peENOu7HN6qmT2CFHDy/nqROg/CjewdBjxa1b5g8Ga/dYcLZSXcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=svCH4RpF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tdBUXUxC; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="svCH4RpF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdBUXUxC"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id C0B551380404;
	Thu, 12 Sep 2024 06:04:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 12 Sep 2024 06:04:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726135498; x=1726221898; bh=3s7b5cX5JD
	UbM27EN0un/t7TTQFw8tx+RYcfwzKDVrw=; b=svCH4RpFVwat2f2cZS6FxCRk9v
	u666GFZfkMYYLkgAYz/m/zzM5sVL/c5KxE2406QmjF7D6nh3XSkGJFFJXm7fFDNj
	1eo0S0VCQ+ejbEQ3GYQWDZwzxCuO7xTZbDqb+/sHODrCtC1gWvfogzACJbm0ILrO
	Udy+zw0NRhO5+M4yN2foqSwWwG4f0X69Wv9SwCn7KAB0/O+XCYEjG4KHAWDzfY8X
	5LShJdXwvMgWg9D2yIhlD17KdiWkS5xr/BJQ6oGQx9Yey9RWZSGX7wABEs7fEqsx
	QwSJNC3dE+xfZJswW4u/6IgwR103jFUshpim2NZy4R2zb3iSlFVM/03hg+yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726135498; x=1726221898; bh=3s7b5cX5JDUbM27EN0un/t7TTQFw
	8tx+RYcfwzKDVrw=; b=tdBUXUxC/HP0FRxzz01oXeK9TQklicz8cWUbfJug9Nt+
	PIZeHxes3z9YSYjg/0mEHWzTutE0u6U43sLMVt/2nM4e2QUJaz7NWMFvivbepSDN
	MmnENJfSwTYYPGsL7fd0YIx8t8o1Kuh8OYWfGTNldnIPFLngGctrsZYq0Hgz0BiY
	Njer/9CMLprQFWcJ8B/qv4eIhxjzGyL30TRxM10HlB/gYN8kzp75Z65sF8O88JsC
	txQewNaCpZMgVhUBjjMmYpEmYNhnCg2B3SiRW9ExTnTfZOyljGir8rkw+9A3NxsY
	UHU72eGf6b8+VTLnk6qF1qajGkBo01YQu2dMabi9EQ==
X-ME-Sender: <xms:yrziZpfdeQBuyCWdcmXDOZmLoYYLDccdHaHlQ5VWa2_AlWZIfNfZSQ>
    <xme:yrziZnMfIzKiWIyyKIwiodIX3z9_K3_mQ8HSkagRtZ4xQliOuo-FI5KCwR6wRUBmj
    ZTZIs4fk6mGuXBb6g>
X-ME-Received: <xmr:yrziZigOmpYVdTLHcoC8m3_LCt-SrP_rV6qOLku_YmI6IJa4Kj_GhXejpsIN_yEAscO8qcBINpgMdqU23-VOrZP94okuUmGXIjBxLDMzbHB6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdroh
    hrghdruhhkpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yrziZi9jE4raMYXXGk9Ysc-eVwx-LOQ1HwztQXEM7UDAazdfu2JvXA>
    <xmx:yrziZls59aLJRUByqn2vY3AHCLRX9klqXldSJTme_ltPtfu_CnV5JQ>
    <xmx:yrziZhHKu_6ZyG_2lL2njZHYHHCN8U7DnUKmueDI-9x_HArHDGwCUQ>
    <xmx:yrziZsPgyaWMKByhrQKk9u3aw0kUVI0a661u6yCrrP63Ehkw5WnRkw>
    <xmx:yrziZvKkv68zULPVoMuGKncTXr_Z5owE6G8pLEjWNS3W9ngpnC-JaDTL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:04:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d74a8ac1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:04:46 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:04:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Han Jiang <jhcarl0814@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/4] remote: fix set-branches when no branches are set
Message-ID: <ZuK8xgBroR0WbmzX@pks.im>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
 <d95a07a22aadccd0c0e0e63bbb98b3a4306545d2.1726067917.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d95a07a22aadccd0c0e0e63bbb98b3a4306545d2.1726067917.git.gitgitgadget@gmail.com>

On Wed, Sep 11, 2024 at 03:18:34PM +0000, Phillip Wood via GitGitGadget wrote:
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> 
> To replace the list of branches to be fetched "git remote set-branches"
> first removes the fetch refspecs for the remote and then creates a new
> set of fetch refspecs based and the branches passed on the commandline.

s/and/on/

> When deleting the existing refspecs git_config_set_multivar_gently()
> will return a non-zero result if there was nothing to delete.
> Unfortunately the calling code treats that as an error and bails out
> rather than setting up the new branches. Fix this by not treating a
> return value of CONFIG_NOTHING_SET as an error.
> 
> Reported-by: Han Jiang <jhcarl0814@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/remote.c  |  8 ++++++--
>  t/t5505-remote.sh | 14 +++++++++++---
>  2 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/builtin/remote.c b/builtin/remote.c
> index d1f9292ed2b..794396ba02f 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1567,8 +1567,12 @@ static int update(int argc, const char **argv, const char *prefix)
>  
>  static int remove_all_fetch_refspecs(const char *key)
>  {
> -	return git_config_set_multivar_gently(key, NULL, NULL,
> -					      CONFIG_FLAGS_MULTI_REPLACE);
> +	int res = git_config_set_multivar_gently(key, NULL, NULL,
> +						 CONFIG_FLAGS_MULTI_REPLACE);
> +	if (res == CONFIG_NOTHING_SET)
> +		res = 0;
> +
> +	return res;
>  }

Makes sense.

>  static void add_branches(struct remote *remote, const char **branches,
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 08424e878e1..cfbd6139e00 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -1131,7 +1131,9 @@ test_expect_success 'remote set-branches' '
>  	+refs/heads/next:refs/remotes/scratch/next
>  	+refs/heads/seen:refs/remotes/scratch/seen
>  	EOF
> -
> +	cat  <<-\EOF >expect.replace-missing &&

s/  / /

Also, the redirect typically comes before the heredoc marker.

> +	+refs/heads/topic:refs/remotes/scratch/topic
> +	EOF
>  	git clone .git/ setbranches &&
>  	(
>  		cd setbranches &&
> @@ -1161,14 +1163,20 @@ test_expect_success 'remote set-branches' '
>  
>  		git remote set-branches --add scratch seen &&
>  		git config --get-all remote.scratch.fetch >config-result &&
> -		sort <config-result >../actual.respect-ffonly
> +		sort <config-result >../actual.respect-ffonly &&
> +
> +		git config --unset-all remote.scratch.fetch &&
> +		git remote set-branches scratch topic &&
> +		git config --get-all remote.scratch.fetch \
> +					>../actual.replace-missing

I wonder whether we'd rather wnat to wire this up in a new test instead
of altering an existing one.

Patrick
