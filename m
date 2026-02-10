Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF61339844
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 22:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770761718; cv=none; b=F5zNOUv7t0NoLeK6DYRDI8ZC//o+/rNHx2MdqMnwc4MKYeqFsPFj0osOHOv6n8kWSclli1hy9Oj86pNxgN8y7pWiLkszeFOtTRockKPu3OrUOuawMP0HEur8MRx7CUspkBYdunXLu8bCT+y4jnrxlJB8kwOh511gHnqoltEBzEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770761718; c=relaxed/simple;
	bh=2e4d65pTEFy1L/0X/M0+JfYWRTVvLmqF3/SCg4ajOmc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UxLxMVTcj5u7xFvTwu5BepdkAXrbLHAAu9u2gvnCjd7CbOAeccRWarxogcJ5Ek68Agber0pNjpY86RsrROF3JE4ub6Nnbo5eAkFItrs2XQG1fWHVkf98ishwJdQHUFmv1hB6W9vcEArLH7ci2pcNj3ga+njamNLuuPtrjEvOW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gcqC6BXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kivDYTHS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gcqC6BXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kivDYTHS"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 1054D1D00147;
	Tue, 10 Feb 2026 17:15:15 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 10 Feb 2026 17:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770761715;
	 x=1770848115; bh=qP8QU1Dg2diFQBxLhci6AKqGMHiYYQ1F9sRMgOX6Zgg=; b=
	gcqC6BXsODjToJbx+uN4bGsjtzMKAvy0fy0Zo+Se0yr550olwLX+3lCaqbBGzsjR
	wRVap8lHKB1jmtgiJQgzQM4ysulhRivqyj9sjEJ0H/6fstp3pmqyOFJu91gSza+U
	gnvRG5zlvr8zeIbqft9TgQZwiIFg1yn9Ps7/JtOP2pEVmHKyETFDJ5n4Rn9Ynu8F
	SPVrhLT0FWPL0e7Z2AsbM8IX+VwC0ykdPEc6fb+ZNdvYWlncCB/ir9SEUVfKYm6b
	5mkNdiEBYmLm63y5dgrI9LJxa+aUYbD83iCqKa2gvOfDvC8lTYBy9qf/k45MS8/8
	V0xM2oJwrZbHzKBcri+sHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770761715; x=
	1770848115; bh=qP8QU1Dg2diFQBxLhci6AKqGMHiYYQ1F9sRMgOX6Zgg=; b=k
	ivDYTHSbn5WzjjzDC+BdFZk46r034GwF9ZbBodz3hsKxiF+C6HOb/rjjoG3AaktE
	T7KOUW+9hceM0IJrIxnr7hr2v/+NuPSdQFGIhKJZMkaYYU1Fn4OerShF0SzcKhlA
	SpT6Ya5awtsA1ua2mtuoep2h7pskH24zTPfXB/WAADGlegWyQRDxL/gcNjnPpyUJ
	vG2l5u8Od7Kf3qHT3SZt8L0uu/kimjY0lJrDRktMS6RiY9hdXtOwz3uIZ3XrzNEi
	/pC6KARsQcG2d7rhi548KrfuNqaIS6nXyMNhhNsfVKyK4CsUVDZDo0YEZNCHFSEw
	IHhaK9ihD57kgk/uM5Vvw==
X-ME-Sender: <xms:862LaZvswG8_vHcm7IoMzkpQyX1XEnBJ0J9m-Ri8sVFUBHmvAQXESA>
    <xme:862LaZ73bSRakIqiA6Cik6um811XZiIusy8EHR7dzfTgZEgwQpq706tYsIEKvKDkp
    PdxQvjFGei1x6UFz3h40cZUeTiwZMgMvyQ43zDooXXuLnokstJk7w>
X-ME-Received: <xmr:862LaaJqcM08RoV9pFdK1wngScenonUhT6i81Toz0E1tC04nH6oAmlAjYTBGJ6ZgmvYT3AWbcTNS4r-u4Q45c1BE2K8v0Q4wsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeggefhudefkeegueeigfejhfejvdejvedtheeguedukefgieelfeeuteej
    ieeuleenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:862LaZ52zSqoYhEuZ1mNIpGwsU1IdgipNVGSKsLEsmPhFebbF77TOg>
    <xmx:862LadzwFpodBarTSUXwAZjGmNvXUsajI5YQykcNK_A0szE1NSwg-Q>
    <xmx:862Lada2ixWXiaOCgE5JOnIWq_9gGvP4bA4ZaregmTbLeJzfcIrHmA>
    <xmx:862LafQm3EEu6i1qyJZ7Np75lUOlgJ4ol33H8fzEH0STHT5Wqj79sw>
    <xmx:862LaaCMQ4DJLlJSHZWz3y9BzbJhhVhIHzuDtStJDGNZjMDPGng5iTB6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Feb 2026 17:15:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: make test slicing consistent across Meson/Make
In-Reply-To: <20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>
	(Patrick Steinhardt's message of "Mon, 09 Feb 2026 17:56:13 +0100")
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
	<20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>
Date: Tue, 10 Feb 2026 14:15:13 -0800
Message-ID: <xmqqa4xgxn2m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:

> In the preceding commit we have adjusted test slicing to be one-based
> when using the "ci/run-test-slice.sh" script. But we also have an
> equivalent script for Meson that is still zero-based, which is of course
> inconsistent.
>
> Adapt the script to be one-based, as well, and adapt the GitHub workflow
> accordingly. Note that GitLab doesn't yet use the script, so it does not
> need to be adapted. This will change in the next commit though.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 2 +-
>  ci/run-test-slice-meson.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> index 2b175dc5c6..1b7a16e1f1 100644
> --- a/.github/workflows/main.yml
> +++ b/.github/workflows/main.yml
> @@ -298,7 +298,7 @@ jobs:
>          path: build
>      - name: Test
>        shell: pwsh
> -      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
> +      run: ci/run-test-slice-meson.sh build ${{matrix.nr + 1}} 10
>      - name: print test failures
>        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
>        shell: bash

Have we successfully run this one?

I am getting

Invalid workflow file: .github/workflows/main.yml#L1
(Line: 153, Col: 12): Unexpected symbol: '+'. Located at position 11
within expression: matrix.nr + 1, (Line: 301, Col: 12): Unexpected
symbol: '+'. Located at position 11 within expression: matrix.nr + 1

https://github.com/orgs/community/discussions/25386 is a 6-year old
discussion so things may have changed quite a lot, but at least back
then the claim was

    Github actions doesn’t support math operations in expressions
    inside ${{ }}. You could add up these two numbers in bash script and
    then use set-env command to give its value to an environment
    variable ...

though.

In the meantime I'll revert the topic out of 'next'.  Sorry for not
catching it while it was in 'seen',.

