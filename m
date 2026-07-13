Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105F3128B8
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 11:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783941394; cv=none; b=syTxntKniXK8Y2cdEVPCwxKe8R9mBbL8TXPzIiwVoxdy83f+a7jJw2HTBvjaWIwtJwpfTdD2An4ucQyo/zqKxJGfgWb7NXD7O4j0ajytbR5S+JED/nEHOmoLVJ01hWno4uUf5QeVZFYN3wXVxPN06IifQnXr8LJ0iDvhE3aVoFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783941394; c=relaxed/simple;
	bh=OwO4GLRZLMynPiYAjpiIoBqpugEj+4Hr3JGvkke+gAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfqWAvAMoofH7ojKm40wyThqJ1BUB7Y6DbZNtKP792tfyCxLXhZJ7her/d6pBtKXoT1+TFJyrVl1THvNUSYKdnu4/Y6VQKby13BwhkySZQSZUetFf5zx28DcIPsLz9T8wtwYhib+ED8npWzh0U1ZHulmuBOO3WRzCHNRB+De89c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UVyucNvy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dxMRkYlW; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UVyucNvy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dxMRkYlW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EB8DD7A00B0;
	Mon, 13 Jul 2026 07:16:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 13 Jul 2026 07:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783941391; x=1784027791; bh=M5VJ3DSg4I
	LMBpD5+2WFAlxUNMpGKSdsxL7C3+RpaSU=; b=UVyucNvygv64cD/P5A5Nap+EvA
	pBQMu97yx6ugablVjdfg4zpAxw2cUDErSoBx1grD8ykQj/EAYme1qpFIHgFvEgK0
	Ko3YHN0fDyp2aTAdRqidDFdCamWsqS7a3MpGn27h4WqXYirzvXccUW0Ays6KzBXE
	HvRsx9SEFlmNBu6MTLJ4Y+6D52iV5oF7dWSLdDRQHFOwH3dvHUnBCEn6fF5o+toi
	dkEmh0i3dNaDZ+b8Sd4vOmAiZFgcDw2Rx1l2QIZUa+qp1YGqHS/CtkPCpilepdmj
	BbqWb5a6iK+BU3IDwlPLJ2qAXqZW1ZqOeanbV4SqF+wfuQvaibd1epI+nuUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783941391; x=1784027791; bh=M5VJ3DSg4ILMBpD5+2WFAlxUNMpGKSdsxL7
	C3+RpaSU=; b=dxMRkYlWEQj1UTgvQUg5QVPSPemkHzm6jo/VfLcTzdQzU/FoRRI
	uCjrfoRs3wXhVsyK6BVb/N2Oxw+1Pigs8Vw1Y5j+PSfmCdj6i7FympQ2h+5KYlff
	ZR0bUAvt5iHuvquZGn/n39BM7WCSJfAZAsPl6/HI+qsl/STp1Z2D12ee+OPP+RPd
	k1sswUdFxRrX+JZW6VRxgGpHYYSP31GDJZzRDHfsc30QCOjnKSPzzQuZxVBCYXXa
	tzb0h4031a95PYWI9R2ZSBJwnS7JI21sQMOpb2kNEsoYfxfmAjaDNMlS6bymNKD/
	Dur20GZM0pzjPc3kQMVkeanhriPaTGhmqnw==
X-ME-Sender: <xms:D8lUait-tHNWU7dPKOIWMgprC34cBvtX-w4bINotJqAUXxCnSmBPtg>
    <xme:D8lUao-EeYwolZOnP70htW-CpW5TGPB3nXtgbmhKo6b9da3BtCoJfmNiuvz8N1t8A
    xAmSh0LTSQ49zTthft8ewB2M50ip7sTj8uhrrpC6dPYzHfXE9Bn-BI>
X-ME-Received: <xmr:D8lUat2nv2dK_Ac4oUgdoUD3WRcdhHK0DXiKsJw4rb0q1aV5I04vYjo-ZcuPzHZIyYkohhjL7iAGkNlq8I99glePR89RBxVqTtohxFg7>
X-ME-Proxy-Cause: dmFkZTF0pBCZ0Z8ZpgDsnOMCfjmNHEIilWJ8P+k8LOG01VJSLaV7LYUa42WvsvN3I8Ygpa
    m9OxnzLxoGYZaMuidfXQPfnlplHXLFDpV8lBE2p7wJSnJmoVsp8uJWojVkG6n55a9uMUHx
    DA9cr7x+5gqcxIR+6WLo5Ug6c5FesQpEhQgOG73OwSHK+9Fd3fWNfLQKu2VqBQ1Q8vzCBx
    XVCDokk+Sa/ofu+gVBjfFRsZbQ4WRi0IO2OBwJlconfwXIDshyUZUj9TEBVf3dgB82fsHw
    7T5ppAkB7ZGy+WEBFStU7yJyVZv5z/r+2KJYjdVlCchTtqJxHpfNhBKGp2v+MJVjvl5bb7
    ZXeyc97G6nSFEC/i6VEEUi95UhjnE+P3wdo1TsbfXTEfEFkTIGg19QO8EIkQwupSWbRcPI
    btZvfHKwLOxQ+O3nP2g78S8kUm28m8rmANOTs9RkMWU7g3gerpIqshArGkXgl0rLfrVy1s
    N6sZPYeKEwxbn5qUpc2cbjv0gtWNOvwjG9w2b0Ep309570Y+iwDcLv9MnYYiPUvzDCoKYq
    0kDXB701uVdVKqucmRaLWnLgpNLR+Mms4YE583uc3uFhFHVAiNVfYhCPbS5tr15N80+m1r
    lNKNgp+awqiHmRUD5qFjLV+jQFGTk6jClybK5RH0nOwxzV6pi8EkBaU/TYAA
X-ME-Proxy: <xmx:D8lUatBgI8d3hI4Gy7z2Nhaa-Gv1oI2Kezmq3oK4X8-0kjAdqa0x0g>
    <xmx:D8lUapdgBIlfzdxpaVziyx9yyvxabzyrIn_0JyYPonSgkM0HeHb1Zg>
    <xmx:D8lUaq4LSjp-1GlZ_5z_KoDq58R9X6yYROC4y3GATcDWv3wpTVfLYw>
    <xmx:D8lUasWnMEk5j2AcSuVuVXHeY3khxI9oTyTDFV8nUZrIU-jxZsqi7g>
    <xmx:D8lUavDlJsgAVD0UAepE8_1GMFWopi6edgmCLT25V3NvNfIGY5oAKCOx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 07:16:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bc75c3c5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 11:16:28 +0000 (UTC)
Date: Mon, 13 Jul 2026 13:16:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: me@black-desk.cn
Cc: git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v8 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
Message-ID: <alTJCTKR9jOWfgbk@pks.im>
References: <20260710-includeif-worktree-v8-0-04686d8a616c@black-desk.cn>
 <20260710-includeif-worktree-v8-2-04686d8a616c@black-desk.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-includeif-worktree-v8-2-04686d8a616c@black-desk.cn>

On Fri, Jul 10, 2026 at 02:43:30PM +0800, Chen Linxuan via B4 Relay wrote:
> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
> index 15b1a4d59347..1ef72de62f2b 100644
> --- a/Documentation/config.adoc
> +++ b/Documentation/config.adoc
> @@ -146,6 +146,51 @@ refer to linkgit:gitignore[5] for details. For convenience:
>  	This is the same as `gitdir` except that matching is done
>  	case-insensitively (e.g. on case-insensitive file systems)
>  
> +`worktree`::
> +	The data that follows the keyword `worktree` and a colon is used as a
> +	glob pattern. If the working directory of the current worktree matches
> +	the pattern, the include condition is met.
> ++
> +The worktree location is the path where files are checked out (as returned
> +by `git rev-parse --show-toplevel`). This is different from `gitdir`, which
> +matches the `.git` directory path. In a linked worktree, the worktree path
> +is the directory where that worktree's files are located, not the main
> +repository's `.git` directory.
> ++
> +The pattern uses the same glob syntax as `gitdir` (including `~/`, `./`,
> +`**/`, and trailing-`/` prefix matching). This condition will never match
> +in a bare repository (which has no worktree).
> ++
> +Unlike `gitdir`, the `worktree` condition currently matches only the
> +realpath-resolved worktree location. If the working tree was entered via a
> +symbolic link, a pattern that uses the symbolic-link spelling may not match;
> +use the real path instead.

It might be worth noticing that this is essentially a limitation and
that this limitation may be fixed at a later point in time. But that
alone is not worth a reroll.

> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index f3892578e4ff..4e840dfdb35b 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -396,4 +396,132 @@ test_expect_success 'onbranch without repository but explicit nonexistent Git di
>  	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
>  '
>  
> +# worktree: conditional include tests
> +
> +test_expect_success 'conditional include, worktree bare repo' '
> +	git init --bare wt-bare &&
> +	(
> +		cd wt-bare &&
> +		echo "[includeIf \"worktree:/\"]path=bar-bare" >>config &&
> +		echo "[test]wtbare=1" >bar-bare &&
> +		test_must_fail git config test.wtbare
> +	)
> +'
> +
> +test_expect_success 'conditional include, worktree multiple worktrees' '
> +	git init wt-multi &&
> +	(
> +		cd wt-multi &&
> +		test_commit initial &&
> +		git worktree add -b linked-branch ../wt-linked HEAD &&
> +		git worktree add -b prefix-branch ../wt-prefix/linked HEAD
> +	) &&
> +	wt_main="$(cd wt-multi && pwd)" &&
> +	wt_linked="$(cd wt-linked && pwd)" &&
> +	wt_prefix_parent="$(cd wt-prefix && pwd)" &&
> +	cat >>wt-multi/.git/config <<-EOF &&
> +	[includeIf "worktree:$wt_main"]
> +		path = main-config
> +	[includeIf "worktree:$wt_linked"]
> +		path = linked-config
> +	[includeIf "worktree:$wt_prefix_parent/"]
> +		path = prefix-config
> +	EOF
> +	echo "[test]mainvar=main" >wt-multi/.git/main-config &&
> +	echo "[test]linkedvar=linked" >wt-multi/.git/linked-config &&
> +	echo "[test]prefixvar=prefix" >wt-multi/.git/prefix-config &&
> +	echo main >expect &&
> +	git -C wt-multi config test.mainvar >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git -C wt-multi config test.linkedvar &&
> +	test_must_fail git -C wt-multi config test.prefixvar &&
> +	echo linked >expect &&
> +	git -C wt-linked config test.linkedvar >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git -C wt-linked config test.mainvar &&
> +	test_must_fail git -C wt-linked config test.prefixvar &&
> +	echo prefix >expect &&
> +	git -C wt-prefix/linked config test.prefixvar >actual &&
> +	test_cmp expect actual &&
> +	test_must_fail git -C wt-prefix/linked config test.mainvar &&
> +	test_must_fail git -C wt-prefix/linked config test.linkedvar
> +'
> +
> +test_expect_success SYMLINKS 'conditional include, worktree resolves symlinks' '
> +	mkdir real-wt &&
> +	ln -s real-wt link-wt &&
> +	git init link-wt/repo &&
> +	(
> +		cd link-wt/repo &&
> +		# repo->worktree resolves symlinks, so use real path in pattern
> +		echo "[includeIf \"worktree:**/real-wt/repo\"]path=bar-link" >>.git/config &&
> +		echo "[test]wtlink=2" >.git/bar-link &&
> +		echo 2 >expect &&
> +		git config test.wtlink >actual &&
> +		test_cmp expect actual
> +	)
> +'

There should arguably be a test with `test_expect_failure` that shows
that we in theory _want_ to use both the realpath, but also the
symlinked path to resolve this.

In any case, I think this version is good enough. It's a bit sad that we
cannot easily handle symlinked paths right now, but I'd say that this is
acceptable for now. We might fix this eventually, once we have cleaned
up "setup.c" to not modify global state left and right.

Thanks!

Patrick
