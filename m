Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E86221FCD
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757570810; cv=none; b=M0perir/mi0y4lKrfo89wecKO0Uy7sBDP7HX4bkm5r1unTaLLTgdoTfgGN3XVgdjgCfdCegETZQB8q4fttNleTIjvgCZmLHhiblJN5n0Ffk2ScRBb/Mk8LApx5z5vSwksA9hE+quhJqUXt6YLFtg07aocwJkBVL1YlvJStV3VyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757570810; c=relaxed/simple;
	bh=cA2Khn2j8GBoyRp6THXVs0mGH2CFVbvdKsA0qriuhTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUyChCgiuvOkQ44Y8kTG+dClQ1gHFRvsobuWTwfnFk1FaKAu2ju8p6svuwelO0Fk+0n/P0BVC9o3X83IkeaxuIgCq40Fv3mN/8mWv6Eb0eEKm/PqGqktapDQz1ZBuB6KZjm5Su0S46m6HAVDAbxJhhN607IFoqzAvzWSUFPqLSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cnVguJW/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fiw3x0bn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cnVguJW/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiw3x0bn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E357D7A00BC;
	Thu, 11 Sep 2025 02:06:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 11 Sep 2025 02:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757570806; x=1757657206; bh=12fzQusYdK
	AafYk/cF83JhKQ+tAyIh+BIStC8KEy2aw=; b=cnVguJW/XweVvptysotmz3UiEr
	U0YyOwn/1k2C69HgyzFoue8gWnZJHvcM7oTR7jDQRHuNoxMibdc1N4xVIqh6KXdK
	HsgztRm/VBDv9ODfjzVZpRWX1b/v+uM6zj7mlnge3MjA+9Q/Y9grGg9+zfd3Y0wk
	7LGFyBd1VwEfFGtUdeVXEoSfM6F4Lbzh/KUVtqlmb9NqeUIcy9wpR6lWL/6uwA0h
	r0X/a5z9OOv9Kl/wy4gUSFl39L7jjIBF72LdVTtUpl40HEGHZGbaweaFbGdOs5kU
	A0PcMmZIdxIT3quY9dr+067jsZZWY4YsdYjxLSXCkmbeSnb4BBRHW/m8tebw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757570806; x=1757657206; bh=12fzQusYdKAafYk/cF83JhKQ+tAyIh+BISt
	C8KEy2aw=; b=fiw3x0bnQqMOP2nLFHXIrUtVgpO3VJKOGXImr4eFfbpDAUFxq+j
	3r+q69ZjOlZ/u/7In+XOPaEhma+FzG9UAk2W/B8OP48wwIghyDMZjcwV9/kfFpN5
	s1zBwZpZD1RXTVPhgrOXO+3B1qjpPNasJjlG4NvvVX1t73tQ4HM21tdaAyXPd+/J
	ZrfyHeRJUsm87bVeH5/5oCRTPojocj/HImcgSJWxowrc49O6EiTZN0DfAZcmUkI8
	hXnzYSO67hTwyVOHTznW/e7hnsYc6NnscCXWob3K79XRcCjqSlQTlgWPmrbRLH14
	hktI4q55uJWefvkZaVFbmRTM1i0HP+lD+/A==
X-ME-Sender: <xms:9mbCaDYEfArexHPhNqUE4JE5r5TEwGvrqUUvJ_zocXCC0tcvAJyWaQ>
    <xme:9mbCaPUM6yulfNgg7QPNCp7fZgorfAY_vKr-CfeLk2_HetTvlR7dQLyMlH0s3vKku
    i5hb7LP8Jzjp1cbYQ>
X-ME-Received: <xmr:9mbCaBnAfb0Oa_sWiO_d627iyQLb9nuZ5wFxSfow2nTUDIydYTpJ8oK4YGR0ugsGZtyZ8HcL46B6bhvLfSD0DFoLFaXo9cmb2EiYc5iGqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvfihrvghn
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtph
    htthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphht
    thhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghhrhhishgtohho
    lhesthhugihfrghmihhlhidrohhrgh
X-ME-Proxy: <xmx:9mbCaCDPa5YnENLR44qwW9lL1tG_x0-ELIDBPt_xz_h9P-_Ow04ZDA>
    <xmx:9mbCaIjuNXoJmJoNj36740lrC3crQkM2fRdHj4U7VMmxS6mecy5oPQ>
    <xmx:9mbCaHwQaNVxyOnIJQOndDcn17_E3ovbXrLhXdBkYD5L4aGmk4BOMg>
    <xmx:9mbCaB1NIkkz4ZsvD4uOVVxCfeGOex6GMUrN_80kCFJd3GL8e-CiQg>
    <xmx:9mbCaCa_hbcVaLrwdr6QAc7WQl5W2T-LW6kxNVg584j0CLzOM-doUhd4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 02:06:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a3135c01 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 06:06:45 +0000 (UTC)
Date: Thu, 11 Sep 2025 08:06:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/2] fast-import: add '--signed-commits=<mode>' option
Message-ID: <aMJm8rSOeQsO_qTG@pks.im>
References: <20250910080839.2142651-1-christian.couder@gmail.com>
 <20250910080839.2142651-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910080839.2142651-3-christian.couder@gmail.com>

On Wed, Sep 10, 2025 at 10:08:39AM +0200, Christian Couder wrote:
> diff --git a/Documentation/git-fast-import.adoc b/Documentation/git-fast-import.adoc
> index 3144ffcdb6..90f242d058 100644
> --- a/Documentation/git-fast-import.adoc
> +++ b/Documentation/git-fast-import.adoc
> @@ -66,6 +66,11 @@ OPTIONS
>  	remote-helpers that use the `import` capability, as they are
>  	already trusted to run their own code.
>  
> +--signed-commits=(verbatim|warn-verbatim|warn-strip|strip|abort)::
> +	Specify how to handle signed commits.  Behaves in the same way
> +	as the same option in linkgit:git-fast-export[1], except that
> +	default is 'verbatim' (instead of 'abort').

We could of course extract the description from git-fast-export(1) and
move it into a shared file so that we can include it from both commands.
Not sure whether that's worth it though.

> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 2c35f9345d..f932dd2c65 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2785,6 +2787,23 @@ static void store_signature(struct signature_data *stored_sig,
>  	}
>  }
>  
> +/* Process signatures (up to 2: one "sha1" and one "sha256") */

Hm. Does "up to 2" indicate that the commit may have two signatures at
once? If so...

> +static void import_signature(struct signature_data *sig_sha1,
> +			     struct signature_data *sig_sha256,
> +			     const char *v)
> +{
> +	struct signature_data sig = { NULL, NULL, STRBUF_INIT };
> +
> +	parse_one_signature(&sig, v);
> +
> +	if (!strcmp(sig.hash_algo, "sha1"))
> +		store_signature(sig_sha1, &sig, "SHA-1");
> +	else if (!strcmp(sig.hash_algo, "sha256"))
> +		store_signature(sig_sha256, &sig, "SHA-256");

... then the code here seems to indicate otherwise as you only parse
either the "sha1" signature or the "sha256" signature, but never both.

> +	else
> +		BUG("parse_one_signature() returned unknown hash algo");

I think we should not label this a bug. It is feasible that we introduce
a third hash algorithm in the future that we don't know to handle yet,
but that would not be a programming bug but a normal error. So we should
probably `die()` instead.

> @@ -2817,19 +2836,28 @@ static void parse_new_commit(const char *arg)
>  	if (!committer)
>  		die("Expected committer but didn't get one");
>  
> -	/* Process signatures (up to 2: one "sha1" and one "sha256") */

Aha, this is where the comment comes from! Here it makes sense as we
have a loop, but it doesn't really feel sensible for the extracted
function.

>  	while (skip_prefix(command_buf.buf, "gpgsig ", &v)) {
> -		struct signature_data sig = { NULL, NULL, STRBUF_INIT };
> -
> -		parse_one_signature(&sig, v);
> -
> -		if (!strcmp(sig.hash_algo, "sha1"))
> -			store_signature(&sig_sha1, &sig, "SHA-1");
> -		else if (!strcmp(sig.hash_algo, "sha256"))
> -			store_signature(&sig_sha256, &sig, "SHA-256");
> -		else
> -			BUG("parse_one_signature() returned unknown hash algo");

And the call to `BUG()` is preexisting, as well. How about we move the
extraction of this loop into a separate commit?

> +		struct strbuf data = STRBUF_INIT;
> +		switch (signed_commit_mode) {
> +		case SIGN_ABORT:
> +			die("encountered signed commit; use "
> +			    "--signed-commits=<mode> to handle it");

This message should be marked for translation.

> +		case SIGN_WARN_VERBATIM:
> +			warning("importing a commit signature");
> +			/* fallthru */

This and the other warning should be marked for translation.

> +		case SIGN_VERBATIM:
> +			import_signature(&sig_sha1, &sig_sha256, v);
> +			break;
> +		case SIGN_WARN_STRIP:
> +			warning("stripping a commit signature");
> +			/* fallthru */
> +		case SIGN_STRIP:
> +			/* Read signature data and discard it */
> +			read_next_command();
> +			parse_data(&data, 0, NULL);
> +			strbuf_release(&data);
> +			break;
> +		}
>  		read_next_command();
>  	}
>  
> @@ -3501,6 +3529,9 @@ static int parse_one_option(const char *option)
>  		option_active_branches(option);
>  	} else if (skip_prefix(option, "export-pack-edges=", &option)) {
>  		option_export_pack_edges(option);
> +	} else if (skip_prefix(option, "signed-commits=", &option)) {
> +		if (parse_sign_mode(option, &signed_commit_mode))
> +			die("unknown --signed-commits mode '%s'", option);

Do we want to use `usagef()` instead?

> diff --git a/t/meson.build b/t/meson.build
> index 82af229be3..08ad6938e2 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -1032,6 +1032,7 @@ integration_tests = [
>    't9302-fast-import-unpack-limit.sh',
>    't9303-fast-import-compression.sh',
>    't9304-fast-import-marks.sh',
> +  't9305-fast-import-signatures.sh',
>    't9350-fast-export.sh',
>    't9351-fast-export-anonymize.sh',
>    't9400-git-cvsserver-server.sh',
> diff --git a/t/t9305-fast-import-signatures.sh b/t/t9305-fast-import-signatures.sh
> new file mode 100755
> index 0000000000..5a52691b29
> --- /dev/null
> +++ b/t/t9305-fast-import-signatures.sh
> @@ -0,0 +1,108 @@
> +#!/bin/sh
> +
> +test_description='git fast-import --signed-commits=<mode>'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME

There shouldn't be a need to specify the initial branch name. You
already create the initial commit with `test_commit()`, so the calls to
git-checkout(1) can instead say `git checkout -b openpgp-signign first`
because `test_commit()` creates that tag for us.

> +. ./test-lib.sh
> +. "$TEST_DIRECTORY/lib-gpg.sh"
> +
> +test_expect_success 'set up unsigned initial commit and import repo' '
> +	test_commit first &&
> +	mkdir new &&
> +	git --git-dir=new/.git init

Hm. Why don't we just say `git init new` or `git init --bare new`? I
might be missing something here.

[snip]
> +test_expect_success GPG 'setup a commit with dual OpenPGP signatures on its SHA-1 and SHA-256 formats' '
> +	# Create a signed SHA-256 commit
> +	git init --object-format=sha256 explicit-sha256 &&
> +	git -C explicit-sha256 config extensions.compatObjectFormat sha1 &&
> +	git -C explicit-sha256 checkout -b dual-signed &&
> +	test_commit -C explicit-sha256 A &&
> +	echo B >explicit-sha256/B &&
> +	git -C explicit-sha256 add B &&
> +	test_tick &&
> +	git -C explicit-sha256 commit -S -m "signed" B &&
> +	SHA256_B=$(git -C explicit-sha256 rev-parse dual-signed) &&
> +
> +	# Create the corresponding SHA-1 commit
> +	SHA1_B=$(git -C explicit-sha256 rev-parse --output-object-format=sha1 dual-signed) &&
> +
> +	# Check that the resulting SHA-1 commit has both signatures
> +	echo $SHA1_B | git -C explicit-sha256 cat-file --batch >out &&

You can instead `git -c explicit-sha256 cat-file -p $SHA1_B >out`.

Patrick
