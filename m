Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6CF1F8EE4
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 20:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467596; cv=none; b=p65DVTnLsroSE3Nxxw5QgvBPDBhwESEnfAtf+/fZZncQVwxsKSUfuRNYaIpH6lkdfUdmwH5zCeOCz8unsgfHRURFoj3c645Tigy1uz3/sIwDhjNF8RQY2XWHrk1ufcDQ8jtZAswzTaZEDXVEySlryc4HPO/bwBD0JbsOVH/GZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467596; c=relaxed/simple;
	bh=sauER7aykasmdonuRx1x8ADnZsZv1C2jr4VHEzxCXwY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KO83ujj2g4n+jEQQr6FtecZ13vyTxpFAxFrbInC5lWjguw2irhdoUZKUUNPPa0H0VYLlAXrYIARklxzMspdrE2Yr0foMkhicCJK1pgWZpnkedVW18FC/nubIZMYiLTVb5XBWXTS90LY22XCq4pALkQqib0+PySuNjnn6YE/4kzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HDolQ+js; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xOeZ/n1a; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HDolQ+js";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xOeZ/n1a"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C01B52540169;
	Tue, 17 Dec 2024 15:33:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 17 Dec 2024 15:33:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734467592; x=1734553992; bh=2UmRcIusT/
	Ugug+CTS7gwjF4ZDlXJP/8qOgoQkNNZQk=; b=HDolQ+jsKuypGI101XNef5lkyU
	dYiOBxX88lvWHIzLAFjUj3pwnI2/MRzHGY7EfactaE/Pi6DjEshNaKPM5O0TrqDI
	XWO3gsCAHYNTaonTvGesAKcOXueAzqR29CJy9NubnTzPCrYgWtqiPg7Ha0DAWT+/
	PdNVT0vslbCfSnMbn0MZ8O+H9uBzzkPkcMpU5tQCSLk/LQhaoq8DxivIW1Q+OoM5
	FsHa9SFWNW21DCgZNnE2OA4xxA1oPujQZDxkP1xjiLd1JyHKNVNX5QzmesZSiLZ0
	mcM+Gxpa3Ocg9pGy01bNZurGcWIUA86tS/FX+cNZTm3yA3J8jZJbyDeuzqJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734467592; x=1734553992; bh=2UmRcIusT/Ugug+CTS7gwjF4ZDlXJP/8qOg
	oQkNNZQk=; b=xOeZ/n1aLZZ4Lfs/UycECEe/eWEMpkLIirj0TMufkmixHgaMRMX
	ckmAQB8fyg2ndHQodVtS+aMw9Isu3BRUZX0pk3Z9DbxdJx/5Oum0u0jhzNWM7WtP
	k5zu2spAuupyreb48SECnKcmfQwFJIhBkeTT84Rz7TPnPVHC2v3an++AzdBLOEsz
	ugUIGQCup1Yz9KdAJS8h74073tk8Gymvy3USurJCCjHy92IVREk3I4h1X1SxP+UO
	WTSvZHiFiiRPnMRqtrpfCsDfwCjVuew7C4rD5rxrybbEl/ivdEndLZ35yS+bRdZo
	/A7z9cBr/8u8PXlihRC35/cH2RW4uVLb8EQ==
X-ME-Sender: <xms:COBhZ8A84i5HAXCbqRcaAAS_IF1cpd1mQWcYU6uzV1zpPfuQphre3w>
    <xme:COBhZ-h53gHybd65--19JMiFrdB2QB0qz5NjrSnxSdVqU9Mj9NWxsLbCE0IKvf9we
    0SjWXmNfE91SYLQkw>
X-ME-Received: <xmr:COBhZ_mvgDb9N-_vIx7qGIYa3NMupmFOpgHwdX37OYLGQ1LbVGXSsQyI9Sh2GWJmkT88HD2LsNX3Fa12si7suCA_VttbLQqU0qSP_D0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddugedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhgrnh
    hnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:COBhZywPVD_xg0ZZfcuYQouCRwsO4gWVzTxHKYJDlZlVMPIP4lEpJA>
    <xmx:COBhZxTCP90GT_ELjEwUNshgJZfyv-Qv3JBpXA10Wvi160F2Ll2R9Q>
    <xmx:COBhZ9Y22j-LG0suFt4igP-jKuHxcF3_sG6lCgDuWjYY8DIODQ4XwQ>
    <xmx:COBhZ6QuE9FafcL50-lTxaMHrBlIQj5jTlI9koqpldqNqCbqKDyXEQ>
    <xmx:COBhZ6IYolZEqeCGEhRzgYZOVVJGsdE-Dg8PJOdZ_VYUO6jUR0wKUyI8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 15:33:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] GitHub ci(windows): speed up initializing Git for
 Windows' minimal SDK again
In-Reply-To: <pull.1841.git.1734447458896.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 17 Dec 2024 14:57:38
	+0000")
References: <pull.1841.git.1734447458896.gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 12:33:10 -0800
Message-ID: <xmqqldweyrqx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This commit partially reverts 91839a88277 (ci: create script to set up
> Git for Windows SDK, 2024-10-09).

Thanks, will queue.

> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 9301a1edd6d..916a64b6736 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -113,15 +113,13 @@ jobs:
>        cancel-in-progress: ${{ needs.ci-config.outputs.skip_concurrent == 'yes' }}
>      steps:
>      - uses: actions/checkout@v4
> -    - name: setup SDK
> -      shell: powershell
> -      run: ci/install-sdk.ps1
> +    - uses: git-for-windows/setup-git-for-windows-sdk@v1
>      - name: build
> -      shell: powershell
> +      shell: bash
>        env:
>          HOME: ${{runner.workspace}}
>          NO_PERL: 1
> -      run: git-sdk/usr/bin/bash.exe -l -c 'ci/make-test-artifacts.sh artifacts'
> +      run: . /etc/profile && ci/make-test-artifacts.sh artifacts
>      - name: zip up tracked files
>        run: git archive -o artifacts/tracked.tar.gz HEAD
>      - name: upload tracked files and build artifacts
> @@ -149,12 +147,10 @@ jobs:
>      - name: extract tracked files and build artifacts
>        shell: bash
>        run: tar xf artifacts.tar.gz && tar xf tracked.tar.gz
> -    - name: setup SDK
> -      shell: powershell
> -      run: ci/install-sdk.ps1
> +    - uses: git-for-windows/setup-git-for-windows-sdk@v1
>      - name: test
> -      shell: powershell
> -      run: git-sdk/usr/bin/bash.exe -l -c 'ci/run-test-slice.sh ${{matrix.nr}} 10'
> +      shell: bash
> +      run: . /etc/profile && ci/run-test-slice.sh ${{matrix.nr}} 10
>      - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>        shell: bash
>
> base-commit: 631ddbbcbd912530e1b78e5d782e72879f7f1fb2
