Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E8D369D4F
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113716; cv=none; b=HUJbWuKIWvNKWTxYIGanL4Fk6mdu78xTFQ6bxFd7fou9ibC5mFqQ6uLp02Tn4zfVoZA9bIipM5KURyuySrLqYrXlvTcA5YWtP5vfpw2WzMw4VoVuKe75XYYHRqUiDMLNNkyJH+C2p7uKhfgmz2A38dIV2/xDmQPeRKe6kOuISGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113716; c=relaxed/simple;
	bh=PPuM23g5q9AAgJeFfDIGyX34xvU5d86oPkB6mLeRv1Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b8wqjrjTSFfxidS/WvN08JZRVjlZLkUwBg2LunFXwelh9VQVmvvSj5st+8VIk9vvalmhaHAvyEWaHuS1Xf0zSZ4x6y0FxRBLj3SX3258Q8Zc3SnoVykk5PyCfwrogSOpaol2QgxCCmpa3/dWIo2AccUpP+efPTpiIYHYw00x8/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B5FvihuD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AfS5LzJ6; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5FvihuD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AfS5LzJ6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1DEE57A017A;
	Mon, 22 Jun 2026 03:35:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 22 Jun 2026 03:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782113712; x=1782200112; bh=J1BMNn5Hir
	dABDVY2g0t6tnL22pg2H4qkK2lsecU+Jw=; b=B5FvihuD7IfTAXtHJlqGO8Mpao
	ig7sUq0083LANARj0MvtZb7raKARCGBjVinKPTARXKM6PzT4JYFxZ4KjEeY+oYhv
	tOL6NXt+RyH9ifH7X2qgfnB+nbh2pjZFb0j3wCnj4aNEQJiRQBSyKrYIACzUru3w
	vN7g1mc42ZpjT733AVyKSfDK3PQYXiQj98NnBMWxtJAmlz7wpemE86oBJ9oREOBs
	EQwL3Ox/uYShMnjJsBfbu+ciJq8L1TnR/R+sUG2dWRb6FFjtC0mZ2kw6NtZ4VT49
	RNSqAk0e8PbQjnuntmzf1JfQaFO/tdwNWI5vexW0dVwWwrmduRskLyrAYl+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782113712; x=1782200112; bh=J1BMNn5HirdABDVY2g0t6tnL22pg2H4qkK2
	lsecU+Jw=; b=AfS5LzJ6Es0SEgmsvyDzjf5772RocXYJp2+o1lEDV31HvcdTi4O
	jiqITcusZm2i6Dr/zRQ0a4trbymu000uw0GMLaFTjpKRRfLar0xVOTj76/fM+X4l
	0U2092syZeVbVf+eI6P+HsxD1rgXxGdAh9luCaI6+IjSZT6Dr/yM2OrLggqt1zqN
	PwEbWi/y9Fu6oQlF5ndbAfa39nLnRP6klgBNuaHVkrdUy1zFRx3Hh03Xc1OcULBn
	erR+6z1E7vUPheygsjnp/cWJYj8iLXJafTLuD4Z3ZbGW1o5q+rWRmvkxsZ2lKJny
	rV1VpDZBY1pYUWSQALq5SbVb9PSPm6RDQyQ==
X-ME-Sender: <xms:sOU4ahM2kbdxmdIW8P0LTdTq9W9uEHHpdtvXqCeei5KXduIFJ6b3fw>
    <xme:sOU4anpZXuqOywSY58gPpUfcx7L693TzKfnsqDY4LSf5kf_z4n24679Ji2ikCgcJ3
    nzbwq03GQfnKTfftrTGXTGBxUb34LQJWuGBVZvcsS3BKQK6-o0AsA>
X-ME-Received: <xmr:sOU4aqEPyx-xq2shwEHtfd-e0LOqgvMx-A2heGNtEwE5bQZ6YMlNzGpz13Gp5dp3GFNQGG21Zg5a3fMWXJFa5E6T7cWk2u_F-Dgo2D8>
X-ME-Proxy-Cause: dmFkZTEaSHs7vsDE74UzfeoF3VC38mQXciGC+9lsf6AZLYqLqTU6e2nFRqksRXVkmNBZTw
    hL5yWu8Yzo/g56jeg/B8AMwlGfFWzwsAqUjNOS5ZTPGXHznOMS9KkQTc1q4khIFAndEWr9
    RepC6i3wrOyiRMWilR5oCuArA7x/PALIuQyg3Y45UoYFQbz11a2/Qw8WtDzNllR64CcEuk
    /EZRSxZl5M29dUpozQnbm2ZSSaqBp8zMLqavFGkJrP28WaUgXQrJzw72WzdiTjKoNXjN65
    7lg5Hk9mJTuqHCzTm2CwIh7U1i1FgKFjlAzF4i5zlOm7CIhrhxmIF0n9Z2C4rVytA7l7sG
    sZ/exVUIJixh1vqxlCxeEW+DDCg89FRBYtnKUHFlMIgMvIzNhc+uR05mz8IpA0oReV3eau
    Pqcm/PtrhbM1zTTmieZ0g5kI8Y2di029HS003sBdanbJFqAmnHpRO6FMMd6+GzgXtdLUq2
    gYV5fQEUj1xIVrrWnqhXy0Jh+LW4HZT00qMgWGZLdNJIQy0SIU8vLiWwNlqkFcpL1C5Ca/
    7LCmyHobjrVrpw6VTzxh0WIIgape+ozKFmkXfjOIQ6aThZy6ae9DvqpoVBjvNQ3QgnvcZe
    pW3Bs2L/mcAzakSUzN/40Pqu8Q0fuiWeoidVBeIVtjYy7yqGAjEzI7oOen0Q
X-ME-Proxy: <xmx:sOU4akq92eM0ctO-DDY3iR5-0IAXyoJB5jHN5SWyp0j6Y-TU5FoE3A>
    <xmx:sOU4arbjc7bKvNTaF48ZeS-84eJieL5u5tKQ6Tvz0LVcoE40aHZTug>
    <xmx:sOU4alWX5RxAgXRf87-lgw3KVDujfI2YZVP1xM_OWqAtcfSTYNf_Jw>
    <xmx:sOU4as9DHNrRTVORzSHoP30IMPNxWCt2ns2BhtA2oTYh_rySHHagZQ>
    <xmx:sOU4apr53RsA47p6N-7LbFREaRZG_qdI6kBHeOOW2M-2G71L8kAEzQU2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 03:35:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Jeff King
 <peff@peff.net>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 0/4] pack-objects: support bitmaps and delta-islands
 with `--path-walk`
In-Reply-To: <cover.1782082975.git.me@ttaylorr.com> (Taylor Blau's message of
	"Sun, 21 Jun 2026 19:02:55 -0400")
References: <cover.1779923907.git.me@ttaylorr.com>
	<cover.1782082975.git.me@ttaylorr.com>
Date: Mon, 22 Jun 2026 00:35:10 -0700
Message-ID: <xmqqmrwn3u4x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Note to the maintainer:
>
>  * This series is still based on 'ds/path-walk-filters' with Patrick's
>    'ps/clang-w-glibc-2.43-and-_Generic' merged in.
>
> Here is another small reroll of my series to make `--path-walk` work
> with reachability bitmaps and delta-islands.
>
> This round addresses Stolee's request to demonstrate the repack-size
> side of the integration between `--path-walk` and bitmap writing, and
> fixes an errant "grep" in the test suite.
>
> Changes since v2 include:
>
>  * p5311 now forces a fresh repack with '-F' when building its bitmapped
>    test repository. This avoids reusing deltas from a non-'--path-walk'
>    pack when we are trying to measure a pack produced by `--path-walk`.
>
>  * p5311 now records the size of the bitmapped pack, both with and
>    without `--path-walk`, to show that writing bitmaps during a
>    `--path-walk` repack does not lose the pack-size improvement that
>    `--path-walk` provides in repositories where it helps.
>
>  * The second patch's commit message has updated p5311 numbers from a
>    recent fluentui clone, fixing the "pack sizes" typo and documenting
>    the new bitmapped-pack-size comparison.
>
>  * The t5310 grep assertion now uses `test_grep`, as suggested by Junio.
>
> Outside of the above, the series is functionally unchanged.
>
> Thanks in advance for another look.
>
> Taylor Blau (4):
>   t/perf: drop p5311's lookup-table permutation
>   pack-objects: support reachability bitmaps with `--path-walk`
>   pack-objects: extract `record_tree_depth()` helper
>   pack-objects: support `--delta-islands` with `--path-walk`

Very cleanly implemented.  I am not confident that I have followed
the detailed logic around delta islands in the last step but the
earlier three patches looked trivially good.

Thanks.  Will replace.
