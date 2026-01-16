Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167F1F1932
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591216; cv=none; b=OdukO9M5/thdJ7VpmmrL17gUm0OMebScZgVBazGEDRIBUi2Vlzb0D6mpkO48arsA3F9+E5ro/VD0JkG60ZyScYK8wXlRPdYJpoo/g01r0nb5igRdOai3abLV1XUEbymnw0EQCnnYWbixs0yDhSErSqEiNqCxAWvFdZLQh6wKvh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591216; c=relaxed/simple;
	bh=QYuoMhVIXNULHhnwxNA2cOJwnXzU4ZTAko7iZ2b+j4U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dYeA/XmffS6tvyBro+VjxgsSUDdnKmWFj6CIlsNFjRdTdhpvOHgenYx3dYFhaF7uYYRzogBttciu0YlYA9IMEh1dzGxur1zaKF+LINrmiAnanZBBWKtK11Ue455Ine/3PlS+ZIH2+XmBwgWehA9QCcbqd1TKR4rrBf2Y6aSwlCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HFg17kqY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PEFf/RXG; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HFg17kqY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PEFf/RXG"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A22D114000F9;
	Fri, 16 Jan 2026 14:20:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Fri, 16 Jan 2026 14:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768591214; x=1768677614; bh=DHotgOxteD
	p89XAPWC9/tI4ligRXgjvhdR0FkKkwzwU=; b=HFg17kqYKWf6BCW12wpQsjlaE8
	pUbq8+DY5JTwuD/r817/vBvrM8QXftaYyfqUNMY4xIS07oNTXtBuy6Gl6vynZ9Ys
	79QY50PIAX1GVX5PcIkXzYxbNjsVvbdCgLHT/ldqSXXpsEA0l6uKm3Dc/iHo0Mdz
	SkyRRzS6H+Ojnj4/667nyC35Y/oEwYPtb3g511lO+g5ZiyE+TxZvOZiVNLeoogd0
	DkL3HWvAwMWJLbP4jl173ut9/DGhYeKmpdZ+pPXQJ9IQlIgJAbLF6ty2IMZNUyt4
	bdyiuT3qJbxC3tfpUICZfwOQr0uZ+z5NcIk0ByLHkHX/2zOc91mBOkIcPH0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768591214; x=1768677614; bh=DHotgOxteDp89XAPWC9/tI4ligRXgjvhdR0
	FkKkwzwU=; b=PEFf/RXG+GQHpScewBJOEwHMUfT+TzGl9f3rO47Rlu8w+ftY2QW
	7Go+FQqYZbh1Rtj7ZJDt8EYutnjtQXPUucdOMYIB6kdFlzfq6BDxd/8uFykJgdkB
	GEv9KFYytvwcqLP55EL8/ArL2heeBTnsSWjVl0TxV9rXMvPm5LkkD98gUxXMDU+k
	Vsy+yS4vpIuC6F0ei9O9qE9ckVYsRWYJLSDO/cTviWEcm3IqC65/kPogCzIsWKjU
	XDZeQ3g3QdLRX/bFzk+RbW/dikik4GNa91/mD7iZ3reYZfW0s+hqgq3/k+XoK7t9
	rqKk4PK8Ko2Ca9MRerErNKkxFfBFF6a0Tag==
X-ME-Sender: <xms:bo9qaXB7bQlvjLNTIzpebZm6YvgV_-gGnxWlnAJVuiPPgJ_MEsIzgw>
    <xme:bo9qaUjv8q6OriTO_gye5L_k1H6TDf4ez2YBZ4rRzeCITa9ypKrMGeEKU6OthQT54
    DnGNHuQanS-QXG0EVARJHSkbmtV7ssfynCOTEwGEq4rTN7_CPtMXw>
X-ME-Received: <xmr:bo9qaXmftDRoyr-87992PixZewPPIIVqoduVhjTsZEKedVYkyTHZaknEF2sQs5Mq4N4CQyrV4HyRBVIx09T-4b6frVOevRvaQRfsghM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdeljeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:bo9qaYqq2oIqxC28VXNPiAKgXerNHNR1uZN0p37ie4Oa40zVPqBWJg>
    <xmx:bo9qaYHOy7ynQZvbNH5ScEtjXp8jAxE3ITObJ8DGM07J-hTrZ_NukA>
    <xmx:bo9qacwg0Ql4zHFv7HeuzUkwddchD5QX_6Hjub1FHOzRWPdOq2d4dA>
    <xmx:bo9qaVpSfb1wZTc_7OkBqri-ll73qOy_6V_pXKVt5kU1KS_IcTsjeA>
    <xmx:bo9qac-vO_t5fwCqrv7aDlHHBPk_112n00sNHxgb7KOdW9oAzsXAr4os>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Jan 2026 14:20:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(*-leaks): skip the git-svn tests to save time
In-Reply-To: <pull.2031.git.1768584676520.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 16 Jan 2026 17:31:16
	+0000")
References: <pull.2031.git.1768584676520.gitgitgadget@gmail.com>
Date: Fri, 16 Jan 2026 11:20:12 -0800
Message-ID: <xmqqms2d74b7.fsf@gitster.g>
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

> However, testing git-svn in the leak-checking jobs provides minimal
> value: git-svn is implemented as a Perl script, and leak checking only
> handles C code. While git-svn does call into Git's built-in commands
> that are implemented in C, these are standard Git operations that are
> already thoroughly exercised elsewhere in the test suite. Therefore,
> running the git-svn tests in the leak-checking jobs only adds to the
> overall run time with little value in return.

Very nicely reasoned.  And the implementation of this idea is ...

> diff --git a/ci/lib.sh b/ci/lib.sh
> index f561884d40..a165c7f268 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -356,6 +356,7 @@ linux-musl-meson)
>  	;;
>  linux-leaks|linux-reftable-leaks)
>  	export SANITIZE=leak
> +	export NO_SVN_TESTS=LetsSaveSomeTime
>  	;;

... surprisingly simple.  I very much like it.

Thanks.  Will queue.
