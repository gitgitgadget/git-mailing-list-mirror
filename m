Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102C3A32
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753193366; cv=none; b=dCLm0j6scxgNslTS4otwv00oxAs5ekJDrfJynl7EW8p+ow2cKScA7TK2xoYsDjf/oYEwUnS12EOG/D63RTGnB/jgPMOQAApWouVNKe/nJ0B0tZouSCtb9YOHdChmB20l9u1ZziUbZ6RKuQB2CBw7f3LQr2GeG4ygbj9EAWnTGV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753193366; c=relaxed/simple;
	bh=8OXfWVvhmEQBAFZNP334gkGucq0Y8AV3woIwSLcX3tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BXtm2qfYMni5TDq/4jQK41mf0QSrqVbwgiqLcW7XjqxdL/8fCweVrt9CxPnZH4fZwCW2uBMwXKsBhtXGYATfLA3KawMCqLAVezWymbdad0ldAtM9O4XP6V/tm/q460JdRc/iQMDU9kket4llGRnhZoEDYumh5OmIZTke2gC2Qsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GeRm7P9g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cfBfE9+l; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GeRm7P9g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cfBfE9+l"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 16F8214000E7;
	Tue, 22 Jul 2025 10:09:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 22 Jul 2025 10:09:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1753193363; x=1753279763; bh=Q6CfzyJWHj
	dVhPu4n1BXoEheZP+L0WwCxqHftz4OYXc=; b=GeRm7P9gU+eSk0HWyayYiOXUyg
	hcskRo+xHwN8Qk+QW2HgRSOJgb8Hy7+pXTsa8gllLz9VsmONcThOkKrrwjUKy25B
	GXFYwqiRqdar+ATBEoEbdFiygeMmhAC0Q4kF2i7ofT4BSD/4yv12DEy9GkCkl58j
	kieTwMAfTPNTa2vyRNWlc8/S6Vq9LFivVCip1CnGOGvhtDIIiYl30E4Vd3zysJlJ
	jNetez2m3P3rEWn0gEfM7onFOAzP4RXV7BlOMFBCd7kbVyt9rLd3lSc6r/KLWKsB
	6VD/+TmUtiXf58I23MaS9plN4QPdNfZgYCmv+QqvKKi69Wa9uNJ2qqZf3N7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753193363; x=1753279763; bh=Q6CfzyJWHjdVhPu4n1BXoEheZP+L0WwCxqH
	ftz4OYXc=; b=cfBfE9+lPQvmnGGOBJx4yVQIn4XqbKGwclb8Ya9He2utUMC7Ykn
	0CagHPUPogw/mCcxD3q8GrpNsod+rTtrFtbk/IfYaQCfaYLi8wBwLScxj92T/0KK
	yPDMW0oitYRA70cbf+JhmmewSND3iI+ULcuJjs2MXKF9USIBDZHya0NjEUayIZ9p
	u9XGRAINXGEs8bvLX8O9raZ13w630ruEuSP7r4PsYul3Kr0VWwsl1l0MfscYQw4a
	xGSuuVaxm08+2PXEbiilKNQ6NCnuiaUwfZI9z18HTUvHmZbV1rIZIByQpFr3yM6S
	s3SJ35nqFuJJjuqKoPq0i3Jxop6PWgBpXqA==
X-ME-Sender: <xms:kpt_aP-mVwYbz1l7fyC8s5cVfR5vRudfo5b5y98sHqp3ba2SzsKZbQ>
    <xme:kpt_aHPHgSvLRg4ZdHBPTSo5U-hkHqYuEtdFv7_xn1GJjuLE4tRd2bsnpC394nRBu
    79Vd_psAaiVVjMowQ>
X-ME-Received: <xmr:kpt_aDdoGD3-3ka68ujajERmicHwYNKILj6GS_lYPSTaUqJ8mJmimaslYJRmxhS-9dy-sUhxiiFDRC1g8jLM7NwpPsJ3DRtn16o2XGA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejhedutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepjh
    grtghosgdrvgdrkhgvlhhlvghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjrggtohgsrdhkvghllhgvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:kpt_aGWGz-p7M-sHuxkyQ1YqPIaoUfqixgZIjENiD9HQF3SrtOD70A>
    <xmx:kpt_aLhQM-xA4TBX6hIiGjTU0dzOrKcdmHYPbPf2LGbbugIikL26Hg>
    <xmx:kpt_aF_2N_w3I4VlkQ_i3nizObnyeesHmuUDGsgvt6SIaPBONDI7_w>
    <xmx:kpt_aNaBMiR2xjMuQx09Ab0n1oP_SHjJMAKpL7VDSWmXOTsKs-Og0g>
    <xmx:k5t_aFxo4DCmNiu2Ijta2rQtWpZ2SxNskN6ofxp6KTQxTTY7G6oLkSGK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Jul 2025 10:09:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org,  Jacob
 Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v3] reflog: close leak of reflog expire entry
In-Reply-To: <20250722045456.GA824456@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 22 Jul 2025 00:54:56 -0400")
References: <20250721-jk-fix-leak-reflog-expire-config-v3-1-c488b0586e80@gmail.com>
	<20250722045456.GA824456@coredump.intra.peff.net>
Date: Tue, 22 Jul 2025 07:09:20 -0700
Message-ID: <xmqqms8wuxkf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> Subject: [PATCH] t1410: add test of gc.<pattern>.reflogExpire config
>
> We have long supported the ability to set reflog expiration config for
> individual, going back to 3cb22b8efe (Per-ref reflog expiry
> configuration, 2008-06-15). But we have never had any tests.

Yikes.  I completely forgot adding that feature, but it seems I also
forgot to add tests when I added it.  My bad.

"individual" -> "individual refs" or something?  I was confused
after my initial read, which sounded as if we are talking about
allowing individual users to set the configuration variable ;-)

> Let's add a very basic one that checks that we apply the config
> correctly to a subset of refs (and not elsewhere). This also
> triggers the leaky code fixed by the previous commit.

Thanks.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t1410-reflog.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
> index 42b501f163..362e90d7d6 100755
> --- a/t/t1410-reflog.sh
> +++ b/t/t1410-reflog.sh
> @@ -320,6 +320,34 @@ test_expect_success 'git reflog expire unknown reference' '
>  	test_grep "error: reflog could not be found: ${SQ}does-not-exist${SQ}" stderr
>  '
>  
> +test_expect_success 'expire with pattern config' '
> +	# Split refs/heads/ into two roots so we can apply config to each. Make
> +	# two branches per root to verify that config is applied correctly
> +	# multiple times.
> +	git branch root1/branch1 &&
> +	git branch root1/branch2 &&
> +	git branch root2/branch1 &&
> +	git branch root2/branch2 &&
> +
> +	test_config "gc.reflogexpire" "never" &&
> +	test_config "gc.refs/heads/root2/*.reflogExpire" "now" &&
> +	git reflog expire \
> +		root1/branch1 root1/branch2 \
> +		root2/branch1 root2/branch2 &&
> +
> +	cat >expect <<-\EOF &&
> +	root1/branch1@{0}
> +	root1/branch2@{0}
> +	EOF
> +	git log -g --branches="root*" --format=%gD >actual.raw &&
> +	# The sole reflog entry of each branch points to the same commit, so
> +	# the order in which they are shown is nondeterministic. We just care
> +	# about the what was expired (and what was not), so sort to get a known
> +	# order.
> +	sort <actual.raw >actual.sorted &&
> +	test_cmp expect actual.sorted
> +'
> +
>  test_expect_success 'checkout should not delete log for packed ref' '
>  	test $(git reflog main | wc -l) = 4 &&
>  	git branch foo &&
