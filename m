Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D543117A583
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725950529; cv=none; b=DfiludGvYPZcZns5TfK+8CmQN43x2Bz72hs65tmv9W2BNMOso9z+x04LXKPFaMcQDysk/yXaM5J3sTheP8H3rMUss6QBswlQWMwx9K9q7IDDZROvEs6eEEQW+KO5AmpYLSnoDTo1WzwB40NRjmMZWpQPeFNCsd/SHnTSj38VXeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725950529; c=relaxed/simple;
	bh=ZCxNfKA0Fb+Nd+kKkT9WGrQLz3JHP3ATcfXUkr1zXHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nf3LqKRKRjGSsLaEuThX9MUmy3H0b4i+bTsCcODcEvyiUCVEXi4oAu+OxqASfoYZEtXx5NzO+emWeqsuDQTHxxNbrzb07SLb+vZfMytuj/XMcPciFFjnCBQinwsw7BPmkg1u4zD5BkiOy6LFk2F1gV1vxf4d+POsL54eFY5kefA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LpCS8Dw+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFwkDiPx; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LpCS8Dw+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFwkDiPx"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id E54A213802CB;
	Tue, 10 Sep 2024 02:42:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 10 Sep 2024 02:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725950526; x=1726036926; bh=YfkkD5P/bV
	pMx0TdvJs0Dd5N/owppOwxEPi4LOlZDR4=; b=LpCS8Dw+qw+/YsjtnUY6DIqIA1
	pZA2k3xrHRc8gpAxiBlZcR2oYskcro51qGlKUTP3f1oW3Pf5oQK6gPm38DPHcz8n
	TH2OU4g396qWuuecsfJCfm9tDK9jQ7v7auL000lv/b+uO33J+8u/ntWEt3MIvBvo
	2BZ9Dy7I+fQH885ItdmDfGgfEtD66Ma2C0rm06u3trrQia8AzNgTSZu6FvUYZW8t
	KFjn31ooU/1Pa5QePnAQnO9ahk8QIj4NRKjFi7TNfaIilvgK2fd2PfgxTcSASX4D
	eIVIB257GhUywUr1myTcgK7vjgHg2H6cv0t317AvOww1BobnMq8CQZvsWl7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725950526; x=1726036926; bh=YfkkD5P/bVpMx0TdvJs0Dd5N/owp
	pOwxEPi4LOlZDR4=; b=kFwkDiPx9CxT76cCsScUlIza7nAjbs4KZY60l4VcTev8
	KkLd8ERAQk+RVyfA/ZEapD7sTD73USALrjOWoo1ISIJsBUOG0JrnydbQXpjKkspj
	Fwc0RI/d08XTRYMREtvYE1TAZ3tMRMT6HlB3R/lf0uceDwlYtNbYqcrGLsMzt38c
	7miC4lex1oN/Ve8nHLHXxveLOvtztefus1fhfTmSTDLsFiQfeFMAhn/qWrH1WpLZ
	rU4ERW5eo/snh8TwYU2sUK3hZZ/VeoWl+M7t2Y5r+JdFVnJee6p8YBPrwNp8PCjt
	zvVxD8SbqX+ny2eeWKCKLEVyIRw4ExFubQfJqwgoTQ==
X-ME-Sender: <xms:PurfZqUoB6JbUMRSRmfVGUdK0Refo3cm8KIdf8vE31SNgl6SjPKVxQ>
    <xme:PurfZmmookGFVXP4dwEYSwgGLjHnPL59EBEpXyvXjGtS-RXtaDFlsuttPL3gMCg5X
    92QCWZiz4uYrJEyGg>
X-ME-Received: <xmr:PurfZuZivFtHGG-tbM647cZxa4PvX7cAzaKHSjKlEMlV2UPOV-gtW3IQskUZqDV9xGT8duNlP9trfOSHoI0PSTH19B2LNMSXnpd4XFmcRmblr1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghsohhnseiigidvtgegrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmhhesghhl
    rghnughiuhhmrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohepughsihhmihgtsehmrghnjhgrrhhordhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegvmhhrrghsshesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghrihgugh
    gvrdgtohhm
X-ME-Proxy: <xmx:PurfZhUs_DSsLuNr7BCsxQ7gA6eA3m5XnF5nYrAIg5aJ_F_Xjf65Cw>
    <xmx:PurfZklnmTQ5N9dOVqtZUZGWuKWyDuYSvBQryVy5kmWaGnr8RUM2yA>
    <xmx:PurfZmcsTz4du_WuWHg7VwYPOJXXQxMcnz4fUR4TjnOrYAb9xwcmhA>
    <xmx:PurfZmEDLF0QQh1d1TRTZSZCjGkOcAxiENrz7qmbG0zZoPlgB6iqmQ>
    <xmx:PurfZv-d044k73p7VNG_0DX3x7rpbG_6Zw0BLzxpD7d2T6zrW7e7zU9F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:42:04 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ffa35735 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:42:00 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:42:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, steadmon@google.com, spectral@google.com,
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com,
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net,
	Jason@zx2c4.com, dsimic@manjaro.org
Subject: Re: [PATCH v3 3/6] libgit-sys: add repo initialization and config
 access
Message-ID: <Zt_qOrrWubdU_yvx@pks.im>
References: <20240906221853.257984-1-calvinwan@google.com>
 <20240906222116.270196-3-calvinwan@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906222116.270196-3-calvinwan@google.com>

On Fri, Sep 06, 2024 at 10:21:13PM +0000, Calvin Wan wrote:
> diff --git a/contrib/libgit-rs/libgit-sys/public_symbol_export.c b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> index 39c27d9c1a..65d1620d28 100644
> --- a/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> +++ b/contrib/libgit-rs/libgit-sys/public_symbol_export.c
> @@ -2,11 +2,37 @@
>  // original symbols can be hidden. Renaming these with a "libgit_" prefix also
>  // avoid conflicts with other libraries such as libgit2.
>  
> +#include "git-compat-util.h"
>  #include "contrib/libgit-rs/libgit-sys/public_symbol_export.h"
> +#include "common-init.h"
> +#include "config.h"
> +#include "setup.h"
>  #include "version.h"
>  
> +extern struct repository *the_repository;
> +
>  #pragma GCC visibility push(default)
>  
> +const char *libgit_setup_git_directory(void)
> +{
> +	return setup_git_directory();
> +}
> +
> +int libgit_config_get_int(const char *key, int *dest)
> +{
> +	return repo_config_get_int(the_repository, key, dest);
> +}
> +
> +void libgit_init_git(const char **argv)
> +{
> +	init_git(argv);
> +}
> +
> +int libgit_parse_maybe_bool(const char *val)
> +{
> +	return git_parse_maybe_bool(val);
> +}
> +

I don't quite get why we expose functionality that is inherently not
libified. Exposing the current state to library users certainly does not
feel right to me, doubly so because `the_repository` is deprecated and
will eventually go away. So we already know that we'll have to break the
API here once that has happened. I'd rather want to see that introducing
the library makes us double down on providing properly encapsulated
interfaces from hereon.

Also, we already have ways to initialize a repository and read their
config without relying on `the_repository`. So shouldn't we expose that
instead?

Patrick
