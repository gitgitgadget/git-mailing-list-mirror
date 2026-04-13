Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551931354F
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099886; cv=none; b=U5rDLIWsnFlxsY4wobY6GhYrHumzGuP+bwF/Ttlgr8CpLitHa9x2R2wX/1a2JyDRBpULgzuQuNHFzhhJSWvuS4z4fuZgY2+9CzwEFml4s/OcgE4P0qKWNySDmv0pVZ7cqO1OpoUl4OGxPo6s2fHBRWzfgO8C3ZRPoHpcygExxCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099886; c=relaxed/simple;
	bh=8as+nwIeaWpRCZCBtojRe6laxU5k5g2xX6AxaX5yFko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RfRAyULC0/VUa76J/E74nCXkhw1p02z/CkWZ2ZZcqVJR/GrkXi6Ymvaujc9NoKaFeLofUP24PvzYTFH+n5ssu9AJZLnBdBxwFO6xS0JIVBp3Ef/LkqwFL9SqpSext6bhQiBSg2YE5EJvaL9xHjrTsZcaO9JL4IyCOV0cX3jO6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dU0UVPMq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JL38GaU3; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dU0UVPMq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JL38GaU3"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0ABAF1D00247;
	Mon, 13 Apr 2026 13:04:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 13:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776099883; x=1776186283; bh=d6n8ZEPvXn
	0HRH3OWhaN3GVSnO3gdzSEisDCcTiwTF0=; b=dU0UVPMq0pHDxOtwzb2p+SmYzz
	rAigI6q8P3frYp8gTmccj4AloWIxeHag27IdopwtEnsU1Iqzq7IDDvqdIj2PlleH
	vDiBv4c4w/RU/XfuHuAgFY/PLZkIxSt/p/p/9/mHza/yTd2e83EvWr+2Z5dnb9g9
	V+qMMLkz9CLTfAyWOVB8e5LOu7xMOVV4Fl2eldZcF78mIjNwajYU4tpA2eiOqWHd
	6LhubRzKBI269wOycmboB/WKU7yX6RlvlL1eelgXEiO2PV4G0Yv9QeQq1PlyvcF3
	2Obf3Uy7I7W0cIIPSqkT0DB7M+uAdM/s7wL/empMjObMCvszXIPDxnFOp1LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776099883; x=1776186283; bh=d6n8ZEPvXn0HRH3OWhaN3GVSnO3gdzSEisD
	CcTiwTF0=; b=JL38GaU3PBwDy41/v2GgpGeuMAOUOJB3QEXmC0Bya8nbpiVviKz
	GiFok+22qByOOGLLYe5ORYLRBHP0rPKXnEW0PyyCHJm4iYYRGW6+Os9vnBd0QG6j
	Pbj/qhr5iuWuPGP8FyaKcNm4mwnO3siSgEkEomwCLTaCGoe0qCv5tOqhBn0wniYR
	nep2xvUkyaiYzt/EDFWIrilFf8pA28GwkBtwzX8fOS3byu3MnoI/jxmSr52WO4gc
	O5W1GbMjhit7qC43qQotztSIOZD5dexDbQJizx9fd9bbmTaJ0TjE5e2HqZncLdQb
	s5ktjb8shKdXSxP16/9HMKoLgWw38teCeKQ==
X-ME-Sender: <xms:KyLdafBXsxK031Bx9J0VMkD27Y0g2uw1OAT3fWXO3oOv7d2g1s7LtA>
    <xme:KyLdac8IcPptZ3BqdQuyOxMonxoIY4RjxGkOwckFUZMvUV3r0ILlKnMJuJf86pn3M
    i8Dz4Di45180yw4gMQAXb-ApAQLvL-u8O8jUv9oEYVhiAUDTYOYqEw>
X-ME-Received: <xmr:KyLdaX_C7x5tUUh1FRRwiMiBTvv2WYSwvruwhsP3vAsouhuouRy25cRHz-OD-LdWj6NFEtwLPhW1pm2_hV4kYyFki-IhpFIkrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeejkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:KyLdabdtsuw5UxP8q3Rv9vuRVlmiEJdlLUkyfwXTtkZvgEq5gCZ6Pw>
    <xmx:KyLdaYGcoFdFUpLnZd0kLRTrByBvZdVDWX0gyPngixRD0NHEvUtqsg>
    <xmx:KyLdaRcKfMsDq_VOfAtXTiq6Uv4hXRIiEjUXQORWYOLJZ-C8FotNpg>
    <xmx:KyLdaaH_58G0g8qZ7BjEUgaR682fKfV5JHEIziZlPSVa8IwC2gugZg>
    <xmx:KyLdaVEKAxUkGc5jl0EliUqeFth27QJ02k7r0PkCYChwwO759Qim95eF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 13:04:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 05/12] t: prepare conditional test execution for `set -e`
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-5-5b83763a0e84@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Apr 2026 11:49:26 +0200")
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
	<20260413-b4-pks-tests-with-set-e-v1-5-5b83763a0e84@pks.im>
Date: Mon, 13 Apr 2026 10:04:42 -0700
Message-ID: <xmqqy0iqiyfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> We have some test in our test suite where we use the pattern of
> `test ... && test_expect_succeess` to conditionally execute a test. The
> problem is that when we decide to not execute the test, we'll indeed
> skip the test, but the overall statement will also be unsuccessful. This
> will become a problem once we enable `set -e`.
>
> Prepare for this future by turning this into a proper conditional, which
> is also a bit easier to read overall.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  t/t4032-diff-inter-hunk-context.sh | 12 +++++++-----
>  t/t7450-bad-git-dotfiles.sh        | 24 +++++++++++++-----------
>  2 files changed, 20 insertions(+), 16 deletions(-)

Unlike the ones that involve $?, I very much prefer the explicit
uses of if/then/else in these changes.  Compared to a potential
alternative to rewrite the existing

	check &&
	test_expect_success ...

into

	! check ||
	test_expect_success ...

it is much more clear to explicitly say

	if check
	then
		test_expect_success ...
	fi

> diff --git a/t/t4032-diff-inter-hunk-context.sh b/t/t4032-diff-inter-hunk-context.sh
> index c98eb6abb2..2d216fb70f 100755
> --- a/t/t4032-diff-inter-hunk-context.sh
> +++ b/t/t4032-diff-inter-hunk-context.sh
> @@ -40,11 +40,13 @@ t() {
>  		test $(git $cmd $file | grep '^@@ ' | wc -l) = $hunks
>  	"
>  
> -	test -f $expected &&
> -	test_expect_success "$label: check output" "
> -		git $cmd $file | grep -v '^index ' >actual &&
> -		test_cmp $expected actual
> -	"
> +	if test -f $expected
> +	then
> +		test_expect_success "$label: check output" "
> +			git $cmd $file | grep -v '^index ' >actual &&
> +			test_cmp $expected actual
> +		"
> +	fi
>  }
>  
>  cat <<EOF >expected.f1.0.1 || exit 1
> diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
> index f512eed278..8cc86522b2 100755
> --- a/t/t7450-bad-git-dotfiles.sh
> +++ b/t/t7450-bad-git-dotfiles.sh
> @@ -220,17 +220,19 @@ check_dotx_symlink () {
>  		)
>  	'
>  
> -	test -n "$refuse_index" &&
> -	test_expect_success "refuse to load symlinked $name into index ($type)" '
> -		test_must_fail \
> -			git -C $dir \
> -			    -c core.protectntfs \
> -			    -c core.protecthfs \
> -			    read-tree $tree 2>err &&
> -		grep "invalid path.*$name" err &&
> -		git -C $dir ls-files -s >out &&
> -		test_must_be_empty out
> -	'
> +	if test -n "$refuse_index"
> +	then
> +		test_expect_success "refuse to load symlinked $name into index ($type)" '
> +			test_must_fail \
> +				git -C $dir \
> +				    -c core.protectntfs \
> +				    -c core.protecthfs \
> +				    read-tree $tree 2>err &&
> +			grep "invalid path.*$name" err &&
> +			git -C $dir ls-files -s >out &&
> +			test_must_be_empty out
> +		'
> +	fi
>  }
>  
>  check_dotx_symlink gitmodules vanilla .gitmodules
