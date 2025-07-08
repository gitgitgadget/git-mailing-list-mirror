Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EAC191
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 00:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751933770; cv=none; b=sEo7hKjnu5G+YnrOXyUl/FNGcWQkdciRCKzmznCfTNgReUVOzfVx9zOeyiFAdtN+D+Lpy3a4pTBmA3o9ECzF67hhM4x9BwueyTdfQO7/7ZStK0PF3gB/unLF/Yytu39nK+b2u/Fek+amQ9wSd08PZDbL7ISxYA4KOAtDSfJGjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751933770; c=relaxed/simple;
	bh=BRxy95HhtAz1qdLTTXr7jMyiS+Mi3IIpDbIRxy4qV6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TlFtsPQr1L9YOzDb5INjXgfJkfu+5OumnKUZNhqY/S0u0P+KIKFVZk9hakpxyEyPn8hjLy7FXfhFuTEQoHT2U1rmLAaEvJIRkj4T4BAMZXKhidEeze8OSVMSaMztE7fIzL9vh0eaR4g0uNoN5cTMkV0pw29+XyXjmtmOzBtNhWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nvAsfFw/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f90+OTDC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nvAsfFw/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f90+OTDC"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 17DB51400426;
	Mon,  7 Jul 2025 20:16:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 07 Jul 2025 20:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1751933765; x=1752020165; bh=TBafOHmlU8
	68EY2rDcauATFnG/OrmJmDuaKuLL4iai0=; b=nvAsfFw/qNIPI0ZF/rTh+xLjvs
	41tY1vjDsW4gyUP4XEw3qXjQXYmZHFu47KZBz/NGrrAvmjR/TUx1/d4OwNcoJtfm
	BCWGhNGPaPCzthybl9tgnoVHEgwxogRBXOKN6kasZXgpdl+RNgsCzqQ+0UKW/Nve
	Ry8RdFDByu6k4dFvHubNfv3tittS4w38AlcP9KPBfimBM4WhPJHxUlIfKHi533SK
	ikC5CYZ5dXJnEIty6kSKK17g7Ya9uILqWlpi9ZQS8G/7EOZcA+RhFy3G3HnAMqEG
	tXZM1Q25wO//7xrxGjtcX/g0PCvU1f2d57MHaK9yoHOt/iwJ0zyAbRxug3Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751933765; x=1752020165; bh=TBafOHmlU868EY2rDcauATFnG/OrmJmDuaK
	uLL4iai0=; b=f90+OTDCUaX2m7ae+Fbc7DI3vYyoNX1By9/q7XieT+NTlz1A0QP
	MHUFiZ6QoU58Xhrk15rwq2L/Pz4DhwL3sj8od41N9ABto+Y+fn8TK1i9oHPuqZ0l
	GjPpfn1DYbIHhJlyNDaQEvYhgBxvD4pqn6+5iaQngcLi4xWhGYPE0kTZAxZn+gG3
	rYFuBAypnWZ1kqwZZi+/GiizudONotoooLot1wZClHSYZuOUDgoU3Hq/hXgLS5Re
	lYn7Sg/evG8hNl09V0n51epEddos28w/UuF6dBF9QlBwoXfn7GLfLDUxY9uAB++A
	y8J25UJ4Hf0pwwjNMKrup9F7P8eGh/RUmYw==
X-ME-Sender: <xms:RGNsaFRh3_jpwHVJOoQiXXpu4OqrphqI7EV0UBDTmZEJO0ILR8p7Vw>
    <xme:RGNsaPi3c6DGX8YL3jSvbVPqxgJEqqxqRejDixS8Ry9xEpbJs-5KPNhGIN-U5mraZ
    Hn4S0yY-SCxGL0thw>
X-ME-Received: <xmr:RGNsaG9DXoChWcWSQIwiHukB29X9jMqnA_7Ho68cI-fdA5uUMgiyVz4OIcn_otxHbQoQlFSGQDaBtf9Y12Dnt0PRn-V5Y_iNXRGFKxw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeffedvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeduieeujeffgedvvddvkeejffevuefhlefhheeuueekfeehgefhhfefvdetvedv
    keenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhmrghtrhhigidrnhhrnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrd
    hplhhushdrtghomhdprhgtphhtthhopehirhgvtggtrgdrkhhunhesghhmrghilhdrtgho
    mhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:RGNsaOHmFNN4Bbx5nm23B9a_QKBBM1UAUJLBK768670qfl_tTRdqjA>
    <xmx:RGNsaBl4jpux79tvFjys92VyKgOWiwXM452Ap1Dgy6lhW_QAt2u8fg>
    <xmx:RGNsaKZ034sBxrEgxJym-sHvbgfzCMa75Zuas4PipydBRtdSoDvAWQ>
    <xmx:RGNsaOE8qVzZUxnvE0r_bIkezVH9gttFitcAcsMLFmLb1Hneu_NQlw>
    <xmx:RWNsaEyaTG-W158_MtVE-2NjMzw9OXwVQK_XLfCEuRAdqPYyqTRczTfl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Jul 2025 20:16:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  irecca.kun@gmail.com,  Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 8/8] ci: use Meson's new `--slice` option
In-Reply-To: <20250703-b4-pks-meson-cleanups-v1-8-2804c2932abe@pks.im>
	(Patrick Steinhardt's message of "Thu, 03 Jul 2025 11:28:50 +0200")
References: <20250703-b4-pks-meson-cleanups-v1-0-2804c2932abe@pks.im>
	<20250703-b4-pks-meson-cleanups-v1-8-2804c2932abe@pks.im>
Date: Mon, 07 Jul 2025 17:16:03 -0700
Message-ID: <xmqqldozzge4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> As executing our test suite is notoriously slow on Windows we use matrix
> jobs in our CI systems to slice up tests and run them via multiple jobs.
> On Meson this is done with a comparatively complex PowerShell invocation
> as Meson didn't yet have a native way to slice tests like this.
>
> I have upstreamed a new `--slice` option [1] that addresses this use
> case though, which has been merged and released with Meson 1.8. Both
> GitLab and GitHub CI have Meson 1.8.2 available by now, so let's update
> the jobs to use that new option.
>
> [1]: https://github.com/mesonbuild/meson/pull/14092
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 2 +-
>  .gitlab-ci.yml             | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

https://github.com/git/git/actions/runs/16129796573/job/45515034049#step:6:17

unfortunately ends like this:

Run meson test -C build --no-rebuild --print-errorlogs --slice 0/10
  meson test -C build --no-rebuild --print-errorlogs --slice 0/10
  shell: C:\Program Files\PowerShell\7\pwsh.EXE -command ". '{0}'"
  env:
    DEVELOPER: 1
usage: meson test [-h] [--maxfail MAXFAIL] [--repeat REPEAT] [--no-rebuild]
                  [--gdb] [--gdb-path GDB_PATH] [-i] [--list]
                  [--wrapper WRAPPER] [-C WD] [--suite SUITE] [--no-suite SUITE]
                  [--no-stdsplit] [--print-errorlogs] [--benchmark]
                  [--logbase LOGBASE] [-j NUM_PROCESSES] [-v] [-q]
                  [-t TIMEOUT_MULTIPLIER] [--setup SETUP]
                  [--test-args TEST_ARGS] [--max-lines MAX_LINES]
                  [--slice SLICE/NUM_SLICES]
                  [args ...]
meson test: error: argument --slice: SLICE is not a positive integer
Error: Process completed with exit code 1.


> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 7dbf9f7f123..f0f653bd853 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -298,7 +298,7 @@ jobs:
>          path: build
>      - name: Test
>        shell: pwsh
> -      run: meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % 10 } | Where-Object Name -EQ ${{ matrix.nr }} | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group }
> +      run: meson test -C build --no-rebuild --print-errorlogs --slice ${{ matrix.nr }}/10
>  
>    regular:
>      name: ${{matrix.vector.jobname}} (${{matrix.vector.pool}})
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index bb6d5b976cd..af10ebb59a3 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -178,7 +178,7 @@ test:msvc-meson:
>      - job: "build:msvc-meson"
>        artifacts: true
>    script:
> -    - meson test -C build --list | Select-Object -Skip 1 | Select-String .* | Group-Object -Property { $_.LineNumber % $Env:CI_NODE_TOTAL + 1 } | Where-Object Name -EQ $Env:CI_NODE_INDEX | ForEach-Object { meson test -C build --no-rebuild --print-errorlogs $_.Group; if (!$?) { exit $LASTEXITCODE } }
> +    - meson test -C build --no-rebuild --print-errorlogs --slice $Env:CI_NODE_INDEX/$Env:CI_NODE_TOTAL
>    parallel: 10
>  
>  test:fuzz-smoke-tests:
