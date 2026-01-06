Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35933309F0D
	for <git@vger.kernel.org>; Tue,  6 Jan 2026 07:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767684352; cv=none; b=bze2ylYUHQ2GWztvc7R1qpKUDWFQ5YVsznM+C1HybCetl/27gbn9cbr4fxUKtRfGGoRVuyFDAdJFbYi7r5Blr5oHqC80NMynHq+Z5q88ThWHZI/7/I+WGbpYF7dIZMs4SNPLNifZi+KWfWnggDi2hH6LoebOaJttVgxnxa3vgBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767684352; c=relaxed/simple;
	bh=q+JEFHY2iSSL2o7ScxtnIlSNkmLaeHG9bRJ9i6o1Ffw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dhRiD7sdv6EwbcwS4VQf+bJiLMv3xvspe6f96ChbQDozbzB5EZc8Z0VvH2lf6i5EcSYzUOZx4bi9uDz1uVXLW/7wq55PO20vYe6OvQFL5vbe71+FoS95syrbmhgCwcT4dZ6LBpkLQbBow0ixrcAxZJTSt+SNc0LlL16W0T3yTVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iZoiKL/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hPLN8Yty; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iZoiKL/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hPLN8Yty"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 68F847A0021;
	Tue,  6 Jan 2026 02:25:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 06 Jan 2026 02:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767684349; x=1767770749; bh=6okbvSGemp
	K7UPOR4+0xz8s/Msx+B7+rHJADHIwmNIc=; b=iZoiKL/lvegEDd2kumR95wYds0
	4KHgO9ilCtCmujjAxA1sVDtdXFAIwgVEjGt7shOsd2cd5qWJeYWXwgYVj1smTtnT
	h5xcZviwL695S0WCalNSVQLh8t9B/maW8LUUf3+8aXzrTEqtBclGfaIHRaB0wdrl
	ZLBrCt0cGPXd9LyKthNStnSv7VaDEX7JWyKb3QS+fXGsGrUUggkeWFebRCr7RacE
	BkI+49zOIuw4Cq73oWO+njtwlORzGHSy9R6Z2I8UURQ5gw/QGtPbEfoZZZKh/5OG
	0ORZz2n8D1cg0ppil2BrYsGoNuEZzKKBNeEpBe3OorQ9xmtIUR0NjB38HvSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767684349; x=1767770749; bh=6okbvSGempK7UPOR4+0xz8s/Msx+B7+rHJA
	DHIwmNIc=; b=hPLN8YtyQrsWnbXVps30iYoDY09Dp6z2/FCj8+srGgtCga18Bgo
	8TsSxGBIlJjdo4QVpDQ7Z2kQzZlbewyu5hNa0kB+GG9V9A2seuPN00T9bnja2iID
	/FpVx+6kAkTJhzb2HXkrf8gaBs3qOuXLAyS1CxJ9SPPdESUiNL88sge00Tp4uJA7
	PHX7EKW0Z0Iwd3P8kV+nlyX600302M/k0IVO2xnBv85LRh4dckEEbTW/n6YxAO+i
	WS4U05L/CTfXWKoFyKbED3W/7tcvAtyHk0l34mc1XBVcE/lyF08uAl5f6bOwL4xI
	cGF6Ewg74spaNe0yixjxKh9F4XgGS26MR/g==
X-ME-Sender: <xms:_bhcaaEG_sODBWAdeJgv4H7lcrIoCftF8SNIYfjOCeYmiSdQ4Ouy3g>
    <xme:_bhcaTiJ-ykhNwX7X6m2HAXf26hLAdmi2XLxoecben4WSa9rrdSV9iI8WL9kgfJEk
    errigRoVEfxegFh1qHwfoY1RiFgE99NNX2MSrT8_cLiFoDs4ElTTg>
X-ME-Received: <xmr:_bhcaft-fHYjGjCOLtGt2PjGZc5gErjMGGvuQTehZGOagQnvXOZgLOtDDEfe_DeXdaGfSC_NZkIoYNj9JoEQsBwWrzwXNuiw9RKkciJf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelleehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhilhihshhh
    rghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhm
X-ME-Proxy: <xmx:_bhcaesY9Gi7A59E9S_l2iXj1IGsWbEkEzILnu5lVLXPtNGvtmTR0A>
    <xmx:_bhcacEBRLguIiKkRsOwOy4fTnvVTHi5OzepP4CRAxn9UAD3yYFIBw>
    <xmx:_bhcaRP4WIERl5eSVNrP--ngaT-wefqjyGKXtLIlYlV4l2-lAV4jYg>
    <xmx:_bhcaTLNEf1AK9vpdlGn8r6BNjh2jl6EyILL-9NVLbu4jZNVigTukw>
    <xmx:_bhcaRnj5KV65vYXcOY-z78MZC9qDjOaFNRzZsOat3WdlKm13zmFwLv->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jan 2026 02:25:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bb941d90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Jan 2026 07:25:47 +0000 (UTC)
Date: Tue, 6 Jan 2026 08:25:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 04/11] submodule: introduce
 extensions.submodulePathConfig
Message-ID: <aVy4-LZ7Lz_tuqdp@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-1-adrian.ratiu@collabora.com>
 <20251220101528.1227487-5-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220101528.1227487-5-adrian.ratiu@collabora.com>

On Sat, Dec 20, 2025 at 12:15:21PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/config/submodule.adoc b/Documentation/config/submodule.adoc
> index 0672d99117..9c260a69f6 100644
> --- a/Documentation/config/submodule.adoc
> +++ b/Documentation/config/submodule.adoc
> @@ -52,6 +52,13 @@ submodule.<name>.active::
>  	submodule.active config option. See linkgit:gitsubmodules[7] for
>  	details.
>  
> +submodule.<name>.gitdir::
> +	This sets the gitdir path for submodule <name>. This configuration is
> +	respected when `extensions.submodulePathConfig` is enabled, otherwise it
> +	has no effect. When enabled, this config becomes the single source of
> +	truth for submodule gitdir paths and git will error if it is missing.

Tiny nit: s/git/Git/

> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 3bc139ff9c..f8cae345a5 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -435,6 +435,48 @@ struct init_cb {
>  };
>  #define INIT_CB_INIT { 0 }
>  
> +static int validate_and_set_submodule_gitdir(struct strbuf *gitdir_path,
> +					     const char *submodule_name)
> +{
> +	const char *value;
> +	char *key;
> +
> +	if (validate_submodule_git_dir(gitdir_path->buf, submodule_name))
> +		return -1;
> +
> +	 key = xstrfmt("submodule.%s.gitdir", submodule_name);

Tiny nit: extra space before `key`.

> diff --git a/submodule.c b/submodule.c
> index f645372a18..e3692009cd 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -2570,30 +2571,35 @@ int submodule_to_gitdir(struct repository *repo,
>  void submodule_name_to_gitdir(struct strbuf *buf, struct repository *r,
>  			      const char *submodule_name)
>  {
> -	/*
> -	 * NEEDSWORK: The current way of mapping a submodule's name to
> -	 * its location in .git/modules/ has problems with some naming
> -	 * schemes. For example, if a submodule is named "foo" and
> -	 * another is named "foo/bar" (whether present in the same
> -	 * superproject commit or not - the problem will arise if both
> -	 * superproject commits have been checked out at any point in
> -	 * time), or if two submodule names only have different cases in
> -	 * a case-insensitive filesystem.
> -	 *
> -	 * There are several solutions, including encoding the path in
> -	 * some way, introducing a submodule.<name>.gitdir config in
> -	 * .git/config (not .gitmodules) that allows overriding what the
> -	 * gitdir of a submodule would be (and teach Git, upon noticing
> -	 * a clash, to automatically determine a non-clashing name and
> -	 * to write such a config), or introducing a
> -	 * submodule.<name>.gitdir config in .gitmodules that repo
> -	 * administrators can explicitly set. Nothing has been decided,
> -	 * so for now, just append the name at the end of the path.
> -	 */
> -	repo_git_path_append(r, buf, "modules/");
> -	strbuf_addstr(buf, submodule_name);
> +	if (!r->repository_format_submodule_path_cfg) {
> +		/*
> +		 * If extensions.submodulePathConfig is disabled,
> +		 * continue to use the plain path.
> +		 */
> +		repo_git_path_append(r, buf, "modules/%s", submodule_name);
> +	} else {
> +		const char *gitdir;
> +		char *key;
> +		int ret;
> +
> +		/* Otherwise the extension is enabled, so use the gitdir config. */
> +		key = xstrfmt("submodule.%s.gitdir", submodule_name);
> +		ret = repo_config_get_string_tmp(r, key, &gitdir);
> +		FREE_AND_NULL(key);
> +
> +		if (ret)
> +			die(_("the 'submodule.%s.gitdir' config does not exist for module '%s'. "
> +			      "Please ensure it is set, for example by running something like: "
> +			      "'git config submodule.%s.gitdir .git/modules/%s'. For details "
> +			      "see the extensions.submodulePathConfig documentation."),
> +			    submodule_name, submodule_name, submodule_name, submodule_name);
> +
> +		strbuf_addstr(buf, gitdir);
> +	}
>  
> -	if (validate_submodule_git_dir(buf->buf, submodule_name) < 0)
> -		die(_("refusing to create/use '%s' in another submodule's "
> -		      "git dir"), buf->buf);
> +	/* validate because users might have modified the config */
> +	if (validate_submodule_git_dir(buf->buf, submodule_name))
> +		die(_("invalid 'submodule.%s.gitdir' config: '%s' please check "
> +		      "if it is unique or conflicts with another module"),
> +		    submodule_name, buf->buf);
>  }

Nit: this error message may be misleading, as it is also used in the
case where the submodule path was derived from its name. I think the
original message should be retained, maybe followed by a call to
`advice()` that users may wish to enable the extension to fix this in
case it's not enabled already.

> diff --git a/t/lib-verify-submodule-gitdir-path.sh b/t/lib-verify-submodule-gitdir-path.sh
> new file mode 100644
> index 0000000000..62794df976
> --- /dev/null
> +++ b/t/lib-verify-submodule-gitdir-path.sh
> @@ -0,0 +1,24 @@
> +# Helper to verify if repo $1 contains a submodule named $2 with gitdir path $3
> +
> +# This does not check filesystem existence. That is done in submodule.c via the
> +# submodule_name_to_gitdir() API which this helper ends up calling. The gitdirs
> +# might or might not exist (e.g. when adding a new submodule), so this only
> +# checks the expected configuration path, which might be overridden by the user.
> +
> +verify_submodule_gitdir_path() {

Nit: there should be a space between function name and `()`.

> diff --git a/t/t7425-submodule-gitdir-path-extension.sh b/t/t7425-submodule-gitdir-path-extension.sh
> new file mode 100755
> index 0000000000..5d52a289f8
> --- /dev/null
> +++ b/t/t7425-submodule-gitdir-path-extension.sh
> @@ -0,0 +1,138 @@
> +#!/bin/sh
> +
> +test_description='submodulePathConfig extension works as expected'

I think I didn't spot any test that verifies the actual config values
that get written when the repository extension is enabled. Specifially,
what I think we ought to test there is that the generated submodule path
is relative to the repository and not an absolute path.

> +
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-verify-submodule-gitdir-path.sh
> +
> +test_expect_success 'setup: allow file protocol' '
> +       git config --global protocol.file.allow always
> +'
> +
> +test_expect_success 'create repo with mixed extension submodules' '
> +	git init -b main legacy-sub &&
> +	test_commit -C legacy-sub legacy-initial &&
> +	legacy_rev=$(git -C legacy-sub rev-parse HEAD) &&
> +
> +	git init -b main new-sub &&
> +	test_commit -C new-sub new-initial &&
> +	new_rev=$(git -C new-sub rev-parse HEAD) &&
> +
> +	git init -b main main &&
> +	(
> +		cd main &&
> +		git submodule add ../legacy-sub legacy &&
> +		test_commit legacy-sub &&
> +
> +		# trigger the "die_path_inside_submodule" check
> +		test_must_fail git submodule add ../new-sub "legacy/nested" &&
> +
> +		git config core.repositoryformatversion 1 &&
> +		git config extensions.submodulePathConfig true &&
> +
> +		git submodule add ../new-sub "New Sub" &&
> +		test_commit new &&
> +
> +		# retrigger the "die_path_inside_submodule" check with encoding
> +		test_must_fail git submodule add ../new-sub "New Sub/nested2"
> +       )
> +'
> +
> +test_expect_success 'verify new submodule gitdir config' '
> +	git -C main config submodule."New Sub".gitdir > actual &&
> +	echo ".git/modules/New Sub" > expect &&

Nit: we don't typically have a space between ">" and the target file.
Also true in other test cases.

Patrick
