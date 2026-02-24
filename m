Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB536A01A
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924726; cv=none; b=bQEDpCy+Ln8Ln7hs5xvRHFVzQ7kBXLmkdyvuMCyGIPuI7OkCrvjsijl7IoD/KTjw2VSrZr8Jyad3NeRTbE/Og28IMdryi42dmRHTN/sLLMS7R0StgHpXEMOa1KlXqsGyx4K7iC0FEQj5JhKT1WJdGnE51HnTM4n/fEfmcf4DsA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924726; c=relaxed/simple;
	bh=l+o3aVi7+xCvXY9bZQCYwQ/wU5+FJz9mubeRIsmD4Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4jiGrjeT69Wl0VFj4Rclh1lJQLxjRQ3JTp0wQh5geLkvDwvBQTPr0uR6UfRQVjQpK7115nL7D1E/K0r78AbjMb2OGLjpRn/EG0Uf3QjjDPWK9u85u99Lf6Ivb5HTpx5zcpTsGpe8LuBwLlsb8woQMQBPAWcGGW03Y2AMqtCbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YUPN8pCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iiji5sDl; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YUPN8pCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iiji5sDl"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1664B140016A;
	Tue, 24 Feb 2026 04:18:44 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Feb 2026 04:18:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771924724; x=1772011124; bh=MyL7XzymnB
	X67ao6JYuTRzoeU91+7ZFoKiQkCrYkGKI=; b=YUPN8pCa6OLrYEPbfdwRW+tljs
	owMqhTzvtvkhGDWefwsRFw9Y0VmXjYcgg/8ykJi0TEXrXHfW6BJRv0mLuPZ/xXZC
	ZbN/8ecU16tV67JvHEx943Ffcf5RfjiRh8rd9X2h582Ki8v4jRlU6LPrCM54XmER
	76Wp35M/R9zPZ8RX82AU2xGdhnG4eyAUeIfRJ/7Rl5+3j7EZ1S/aEfnLiF/CQ12y
	1E+7O0LJytuV1RAJD0qVz0fiBFup+ueOKrkmvNxHBM+neoVPL1LNVq33zoGT/2i3
	zuUt5GPuM5BvonimLjzLCYQLw71zD+ELM86Odcm9YM1U2SUY84FFPMw5lHtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771924724; x=1772011124; bh=MyL7XzymnBX67ao6JYuTRzoeU91+7ZFoKiQ
	kCrYkGKI=; b=iiji5sDlEb9urlC4JTd7dfvdky4SPaQ6BHrwsiD/1g6FBfTK2lW
	a69PHZZKJkF35IFBumDz26W6b3KeOT1QM57PhSOtVnkmaInPrAXaACC3SAeyY4Mm
	OHAqIVF4acWgXSeKslOcFXxil6KGRgmcEQKKrgYnKPLZ/1W9KzhHBPWyjZogqzYW
	gZJvsJ/5yfHgcC9uw9ukaLX3/SYcjO15C56O0RH64ICVya6rY9eoK97YBNHLxDQ8
	5UoesU5h8ofs9sqlp6l/Dxk0iAugFg1Vl79wu6jKJmqykrhYrj9T6CRZ+jNOdlNp
	RpAYTXMJE++AbOeqzc717yfT1+vS+YFzNxw==
X-ME-Sender: <xms:82ydadXAkole_wSPanHOLbbks66qs85nuachaYcHh3R320QlT8wxFA>
    <xme:82ydaUdfRAI39Yuf_RCNo4lAUKQj26rtxAdry0Xep-jvlk41Tj4zGceyO_khkmMVi
    fQTxIa0g82IuNnP1WWM__S6ojI20P-BmnUW6BSITeRO960boaCSsLo>
X-ME-Received: <xmr:82ydaRvuPG-1PY-WCAlsHKitgWAclYEqNGo3JnZzNG3nkiwqgw4Mg7RSuA9yJZ9SfTWDD2-qUOnnTqjBQKG6-HtElOvyEZQYmDIVuL-D_DQb8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepfhgrshhttggrthesghhmrghilhdrtghomhdprhgtphhtthhopehsthholhgvvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:82ydab_NYovKPiMuRqufm8zA2l1lSBGxaxPdN0fWtdp6IWouAcYNjw>
    <xmx:82ydaU3xFKFtTh-dGX0qWJhALhuHfPnPy8R4ADhPGt8g4CqeThGZcA>
    <xmx:82ydaYBFrqMFH1Oy7tOCGg9WX2q-MAXxJRlUNar-mo7FHMc5zkBzkQ>
    <xmx:82ydaYff3aux7gO8_rm3BalYwDsxL_H9Jq85jzlMYCCGCHIDe41Azw>
    <xmx:9GydaQP1E6bp0cS9P0qbPXU1X0VZMAJ3dQDTeGqyq1hbJhlQVexqxAjm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 04:18:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9d0204f6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 09:18:41 +0000 (UTC)
Date: Tue, 24 Feb 2026 10:18:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 1/2] for-each-repo: stop using the_repository
Message-ID: <aZ1s7tONvd9wiYZV@pks.im>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <86cd83f65b30aab3233e27b3e5c4f03041e68766.1771903950.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cd83f65b30aab3233e27b3e5c4f03041e68766.1771903950.git.gitgitgadget@gmail.com>

On Tue, Feb 24, 2026 at 03:32:29AM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> index 325a7925f1..478ccf1287 100644
> --- a/builtin/for-each-repo.c
> +++ b/builtin/for-each-repo.c
> @@ -1,5 +1,3 @@
> -#define USE_THE_REPOSITORY_VARIABLE
> -
>  #include "builtin.h"
>  #include "config.h"
>  #include "gettext.h"
> @@ -33,7 +31,7 @@ static int run_command_on_repo(const char *path, int argc, const char ** argv)
>  int cmd_for_each_repo(int argc,
>  		      const char **argv,
>  		      const char *prefix,
> -		      struct repository *repo UNUSED)
> +		      struct repository *repo)
>  {
>  	static const char *config_key = NULL;
>  	int keep_going = 0;
> @@ -55,7 +53,7 @@ int cmd_for_each_repo(int argc,
>  	if (!config_key)
>  		die(_("missing --config=<config>"));
>  
> -	err = repo_config_get_string_multi(the_repository, config_key, &values);
> +	err = repo_config_get_string_multi(repo, config_key, &values);
>  	if (err < 0)
>  		usage_msg_optf(_("got bad config --config=%s"),
>  			       for_each_repo_usage, options, config_key);

The command is marked as `RUN_SETUP_GENTLY`, so it may run in a context
where there is no repository. In such cases, `repo` would be `NULL`, and
that would cause the command to segfault here, wouldn't it?

Patrick
