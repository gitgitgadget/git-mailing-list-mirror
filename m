Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74E52F76
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 06:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728281107; cv=none; b=eC8dpR4bmNAmDC07SgUMDy9F2UYwuDpFpHSw8Ji0ilbXerTSgf6Vsa46ev4muhcy1yf0N/n2m0XXhrdufFJWS8gkny2Y4uWfssCRTcv3P+yQYyGLyOh4ynlKej9ELg6OSQszHMo/q6tdYBPmTq9KCjiIfr7z/hoZqsIfFp4Axk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728281107; c=relaxed/simple;
	bh=uISfSaqZUWEsf5+5IZ+wcVcn8z3kzIfEArV6HoFVUWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEZ+I9P5thDg6bVma66oo/mHrZ84w7fkTcOO9Wqjy5S2hg7VqefvmTh+jOlcunJoOpQ3z09iaRDRy5F9gMYypGhcpe72hSYFZe80KtXZA79qOAcdkBdv65U4zB7BzRW7oUJ7xsPj7UY25nW+jc3xJ6MIOT1H560tmcv5AQEQSkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rQ7lVE53; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bAqJkXA2; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rQ7lVE53";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bAqJkXA2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 530A425400C2;
	Mon,  7 Oct 2024 02:05:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 07 Oct 2024 02:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728281104; x=1728367504; bh=zG6WNnRGaH
	SLxjAPkyS1aLDhKt6d7zgmkkXa7ah2/u8=; b=rQ7lVE53uzTmzvvwNDr7FRRHht
	k5Eh3hSPuD4NnHQnWl4xLfDtD+tvj/Dzb80o7Vz4tdk2/n5OmiPBFBCkk8pAqm0k
	4i5/nMmTSlApB5vA/vI61uFvbsw8kTh+ljsxfIFiKMoJq4SD8Bm1Kt5+kwTk0bj/
	lg0lhwjZUbedhVHAQOCqA3Bg2SdW7bdTpNVD/XiRwsvvPdGELZOrqnG7uteOFujs
	AUSdAZqbVi/D4994GOBhb60AqD8SliO/JokHf8wrRZXH2po1TXnqhMchegcT9s2K
	bdPPrmXxuyaXZoa8QbUd4KmMQqqGShcd1fDJnGYR2U/JTlTLIBI8MDIEI4cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728281104; x=1728367504; bh=zG6WNnRGaHSLxjAPkyS1aLDhKt6d
	7zgmkkXa7ah2/u8=; b=bAqJkXA27JY/PaMMYhHyka2bl/pSFvMburFm5OCMByo1
	+3BTXBmm3oYefSdpN7KuTk9K6KMoGP9GKM+00hBlAn3YFNRxnAiePicgLkgK4Q6X
	xWsel0nBFbcHTigkk1HafvjVw2jLfIpfnk1knH3aK4mJTa+nuJDV/zS8Bb24mHQR
	vEHNcki1y32+6YfJcQl/9vFTX0qv0w9hxZM7VnbiblDFcv4mVkiupZ52lIkiEwXU
	T+bS1lFzK/oInsto/tFUjMykIGC2sa2C4OnjD9U5Rv+6DLvaHqJZSNKcO1K6r4Zl
	SJvghk6ZfCJLvMBYEn+q5Ill0DHqDXLdv1QH4NRCYA==
X-ME-Sender: <xms:EHoDZ4DHzmH4pnZdYNpCSgtt6r2ZN4y1zL86dNwtnAiv71xZEnac1A>
    <xme:EHoDZ6gNPp6jEduNEsWf0_1npBdMcmPH3Ugk4x53ChQ4mwkkFwgr7qojLELUmOm1Q
    uclN2rW4A9Ml4E75w>
X-ME-Received: <xmr:EHoDZ7kY8V4lbfLr0sSBxnx5jueq2XnHy9dbFMlgsAdOoqwE_Zmh_1xEp-vWWBnVrv7qrgAci5HEm3HXcKQZY-NN0OSnxlyWpFtob4WtrJOmU7Qr2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvkedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrd
    horhhgrdhukhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjh
    hirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtgho
    uhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EHoDZ-woTYZTB1NYY6XqH6_IMNL-FRbliJhBJG2TF-eBPPsa0mA5Xg>
    <xmx:EHoDZ9Q4ch_d65F0fWJmDvaasroFsjaOL2mVD0Kjh0T8dkeVGMV2LQ>
    <xmx:EHoDZ5ZGB79PhhwMnwu_HkaJJuJVJvwPcmtsI7jE5-YNLLdlozdfaA>
    <xmx:EHoDZ2RjaXjjgwhBnQ8K5mk99Ua0HxzE-4WqLaUCPp1QhJaC5CIR1A>
    <xmx:EHoDZ-RRZsx7r1643HYAgpg-Q5ftDSzNVJCVEWkz00_y0-SdEw94Abyh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Oct 2024 02:05:02 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c8acb2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 06:04:03 +0000 (UTC)
Date: Mon, 7 Oct 2024 08:04:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Usman Akinyemi via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Phillip Wood Phillip Wood <phillip.wood@dunelm.org.uk>,
	Eric Sunshine <sunshine@sunshineco.com>,
	shejialuo <shejialuo@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: Re: [PATCH v3 1/2] t3404: avoid losing exit status with focus on
 `git show` and `git cat-files`
Message-ID: <ZwN6BNPHiXyKGd1t@pks.im>
References: <pull.1805.v2.git.git.1728203495287.gitgitgadget@gmail.com>
 <pull.1805.v3.git.git.1728230769.gitgitgadget@gmail.com>
 <c9a0cca179bfad129017c7f1085ff87201afb417.1728230769.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9a0cca179bfad129017c7f1085ff87201afb417.1728230769.git.gitgitgadget@gmail.com>

On Sun, Oct 06, 2024 at 04:06:08PM +0000, Usman Akinyemi via GitGitGadget wrote:
> From: Usman Akinyemi <usmanakinyemi202@gmail.com>
> 
> The exit code of the preceding command in a pipe is disregarded. So
> if that preceding command is a Git command that fails, the test would
> not fail. Instead, by saving the output of that Git command to a file,
> and removing the pipe, we make sure the test will fail if that Git
> command fails. This particular patch focuses on some of the instances
> which include `git show` and `git cat-files`.

Well-described.

> Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
> ---
>  t/t3404-rebase-interactive.sh | 71 +++++++++++++++++++++++------------
>  1 file changed, 48 insertions(+), 23 deletions(-)
> 
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index f171af3061d..96a65783c47 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -319,7 +319,8 @@ test_expect_success 'retain authorship' '
>  	GIT_AUTHOR_NAME="Twerp Snog" git commit -m "different author" &&
>  	git tag twerp &&
>  	git rebase -i --onto primary HEAD^ &&
> -	git show HEAD | grep "^Author: Twerp Snog"
> +	git show HEAD >actual &&
> +	grep "^Author: Twerp Snog" actual
>  '

One thing to note is that it would be preferable to use `test_grep`
instead of `grep` here. `test_grep` brings in some additional benefits
over plain `grep` like better diagnosis of issues, and it would also
print the file if things didn't match. That makes it way easier e.g. in
our CI to see what the actual output was.

There is no need to reroll this patch series just because of that
though, as your changes are a strict improvement by themselves already.
But if you do end up rerolling it would be nice to incorporate this.

> @@ -397,7 +400,9 @@ test_expect_success 'multi-squash only fires up editor once' '
>  			git rebase -i $base
>  	) &&
>  	test $base = $(git rev-parse HEAD^) &&
> -	test 1 = $(git show | grep ONCE | wc -l)
> +	git show >output &&
> +	count=$(grep ONCE output | wc -l) &&
> +	test 1 = $count
>  '
>  
>  test_expect_success 'multi-fixup does not fire up editor' '

I was wondering whether the following might be nicer:

    git show >output &&
    grep ONCE output >output.filtered &&
    test_line_count = 1 output.filtered

But after seeing this I don't strongly lean into one or another
direction. So please feel free to use either your current or my proposed
style, I'm fine with either.

> @@ -470,10 +481,10 @@ test_expect_success 'squash and fixup generate correct log messages' '
>  	) &&
>  	git cat-file commit HEAD | sed -e 1,/^\$/d > actual-squash-fixup &&
>  	test_cmp expect-squash-fixup actual-squash-fixup &&
> -	git cat-file commit HEAD@{2} |
> -		grep "^# This is a combination of 3 commits\."  &&
> -	git cat-file commit HEAD@{3} |
> -		grep "^# This is a combination of 2 commits\."  &&
> +	git cat-file commit HEAD@{2} >actual &&
> +	grep "^# This is a combination of 3 commits\." actual &&
> +	git cat-file commit HEAD@{3} >actual &&
> +	grep "^# This is a combination of 2 commits\." actual  &&
>  	git checkout @{-1} &&
>  	git branch -D squash-fixup
>  '

Nice cleanups while at it.

Patrick
