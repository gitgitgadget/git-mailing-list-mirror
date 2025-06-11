Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEA29ACDA
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749651914; cv=none; b=rtV0nSNfaA157svXwl0mGzRff6R70DEb8NvQDhf+OFahrsJVtBUBk/uqOplFrEf22CwsusgOoXkS6ubymiyb1S0bpthlrEz7hXRyoTJ3EmDr8GFWKPuGDyFB++mzji4qScZB5j2tasisxrK/guWZH7ryHl59Oc29mMfFXz+6eXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749651914; c=relaxed/simple;
	bh=x/MsV6j6Yx3bUQZpAUk3COHTOu/HoabtfLYiIFnb7xE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U21S4wyHzvkQjSbw+NF6ghJSF5eMzcJN2XbL+gt773cKE+RkZRFTou+VRKnZ/6nc/ebBaVVQP/Q/AhwRzr19SUWLUMjSVLP9amoDeerPWT8D/kXWoNHD+ffFSS1w21RSAiSLXN9USa9kpPw4A2/SsgHdcY9snffXnrNJY2Jy+Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O7x+DMUH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z3U979tL; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7x+DMUH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z3U979tL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id CF97D13804F7;
	Wed, 11 Jun 2025 10:25:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 11 Jun 2025 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749651911; x=1749738311; bh=6Qkg0Zfond
	6Xp1ELNF+CzrE/T0kLMiFCNk9iLv42dDM=; b=O7x+DMUH+r57DRv8VRtAzLyWoC
	WwsLjhFK5NVBbosBWBkvEGmowC2qjlwPmUVxrhcL8SYrL+cHO8/LVVnvLRKP6FMy
	DxrRqOuBvUmjS7IjVkW4H/AAG5I8WjIKMQ1kNJimgsvWjdXSbfhfj/1Q3eF9LMek
	BFLBhjY0khS6abUHjdzOR2kCnnoHfpxr/rBf82UzdCGdb20GdU0qkFik+l8bUiiz
	yoPKFEz6tYVl736zMenNRrpIuY7gLhxNqCxN5ubsdAMLBfw24BRzsd7RY1xhjsqV
	ZccReOQdPxi4phYnbhSveKokuIa/JM1a2uTwM1vqAbMQ0tbKj5qWG61hEsTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749651911; x=1749738311; bh=6Qkg0Zfond6Xp1ELNF+CzrE/T0kLMiFCNk9
	iLv42dDM=; b=Z3U979tL7jUTqpKB3xjipIKc0NnRfbnoj5auWEf3aN/m1zNGtCA
	tDLK/pGhzAiObHVH598WRmiF7CpsE/VjOx7UzfT93LtwnqwMjUuyl3tdeBLr68Tv
	R7k1D5Nej7X2jyNqVd4MabGyGxbpE3tZReiyZ1VAAqvgBmAJj34B/yo90H2cCFRI
	TpTXaOMKuwGfJt7DLEQYrS7pGrgIcvQmHo6FZEYd1t2lIzZ4jSh7OAF4QtCICN8m
	EE6yC4BBLW+r8brJBf3doyL7dg5dPkqXJiknRKSB4UBM1OttfsZlT/PBMm3h366J
	dqnVdz1xbuBMOGTBvhl7xIGH5wZqwRg+12g==
X-ME-Sender: <xms:x5FJaAlbJv5-Qc0V_8CduNVwW3D_3jDNFXWVfVe5Zu7X2pFAGD8Wkw>
    <xme:x5FJaP30YK5Q9AzGCzeMNgqmGW3iUxl42iudElKBjTQdSXRW9Tj7bIRZyRyuow_tJ
    M6E-o8wyDA82imGAw>
X-ME-Received: <xmr:x5FJaOr1_5EDomcDSgXE0ppe40E2luv-FzbG3cyWKcV2yHLKESHnzDAcFcPDV8SSHAJlRYApQomWcrGbXW0O4Wz1E4wJ2K_vYQSO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesgh
    hmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:x5FJaMlchwVYqaFCaiNeiFig9hZqeWF3CM97Bi20tJwTaC_N1ilT6g>
    <xmx:x5FJaO3bjgtYn3Fr06-bWjnhGZC_57kZbBvOZAXpbGfj13OFlLVWng>
    <xmx:x5FJaDsuzQr4p2EgTnQ3W-RFVSBDcKS3iVr395RjxRtANkwlepL4Cw>
    <xmx:x5FJaKVC5yuPZutYWiiqulUESongyUsTI9EMke1NBKVY5S2_aYiibA>
    <xmx:x5FJaBCeIUhiEhA52l1OfwEwO6F6V3sEgsM6m6Cj7XFuP9qN7-unK89G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 10:25:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] ci(coverity): output the build log upon error
In-Reply-To: <3a829f11c07ddbb0a57a1ac832db686f29a9b632.1749650552.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 11 Jun 2025
	14:02:32 +0000")
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
	<3a829f11c07ddbb0a57a1ac832db686f29a9b632.1749650552.git.gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 07:25:10 -0700
Message-ID: <xmqqplfajqyh.fsf@gitster.g>
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

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is quite helpful to know what Coverity said, exactly, in case it
> fails to analyze the code.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  .github/workflows/coverity.yml | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Wonderful.  Will queue, together with 1/2.  Thanks.

>
> diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
> index a5d99e59d4eb..1e8bd85ecd4e 100644
> --- a/.github/workflows/coverity.yml
> +++ b/.github/workflows/coverity.yml
> @@ -149,7 +149,11 @@ jobs:
>          run: |
>            export PATH="$PATH:$(cygpath -au "$RUNNER_TEMP")/cov-analysis/bin" &&
>            cov-configure --gcc &&
> -          cov-build --dir cov-int make
> +          if ! cov-build --dir cov-int make
> +          then
> +            cat cov-int/build-log.txt
> +            exit 1
> +          fi
>        - name: package the build
>          run: tar -czvf cov-int.tgz cov-int
>        - name: submit the build to Coverity Scan
