Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733571CB518
	for <git@vger.kernel.org>; Fri, 23 May 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748015918; cv=none; b=obgpn3LDOJPFITdpjl0nCbEzc8P7/85BwLh/YBZxRGEazuH3CcoQ4nKY4PKd5wALEhsTMe9VcbaE4Pae2KZFzbJGT0iqv3fdq2pXowlrhx4JFrkpjZ0FSfMiguBC9BbUIJzDB2ysn68LRjtuPKdykrB5TAlU7GINDeY/afL4wus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748015918; c=relaxed/simple;
	bh=fsBHj7+vYVzALzuf2XrCVFZ3i0DbXz6JAgq6kh4O9Tc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HLmng2e6+TPHsQlG8iLXn6zzfow9+TvMrKkh2cThKJwol8atF3/sM5DCntLCDmvXoy/6L7ePTpXCQGiGWuQqraV2cIjYLm+TC/l77tzIOxOREZQulKQg8Bkva6Pgrmr//Dgtaj0AOV5eOtNWGHbF9eaYIT2kQXbUyH8syV8x6C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EscrSTQ2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZCfUeR4u; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EscrSTQ2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZCfUeR4u"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 3DCD2114011F;
	Fri, 23 May 2025 11:58:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Fri, 23 May 2025 11:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1748015915;
	 x=1748102315; bh=mSo2eJ2/Vc68D6SkrFmgTo0nXtUz1Fd0DdA34ea5H2Q=; b=
	EscrSTQ2XOTbdPzv2AUlsowo3nfxd1n+5huw/dEJzzDc/7EMngPrsIqM4I2IBirc
	ld2YEV2AWlNrQ1/FxTKvI6Q+Jmgngm2Ce4hiSm1q0u3e+JaF69iKzLBmrKZS468m
	uH1nRagdjKuEyPz5vugjExC/5ghauyZPYuVIDu2kL1hUT5htpiRvOaz4yDmD1NMi
	3NCdv7dpnCwirvWN3O9TR/tfc7Atbjp+kAwFf+9V9nXoZf1aD/c6hHdDzsfhC9vl
	A8ZRqnG60lkPkdc5x01XHrcHMpnMQh1Tmnd22mLhJkAd+qlZNNHxUUHNAlXbTtNi
	CvT/79Rl/phhzh6nGK7lCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1748015915; x=
	1748102315; bh=mSo2eJ2/Vc68D6SkrFmgTo0nXtUz1Fd0DdA34ea5H2Q=; b=Z
	CfUeR4uIHBRQg49agp0asgA5O3XwbBo+fxqm5p3urF6MjVRw69o02NrDb626Njnn
	MSh3MaTQbz7JGiVt8kXySxW7OYPlrf/pr0MChwOwcFIeeRRppXhJUN3KGqGgi6Kp
	t1v6czto0QNTdNxIizPO9hl/Mip2QMI84AfRjUpIkgIZoj70vuCu/mH0gxP0LjAu
	eXAY8nVHlk4zjcg6XISdYFfnNV9E9UtKu5HRuzV+OrSVq3eKYPJfhCJIc395+NF2
	u2nmYnpsvTQjgS0NcoqotbBDkAFmE+dwi+gjCX1Ri966hyU01r40+LUUrLX8yEzL
	g+lVDUVkhVJ3VS8IQohhA==
X-ME-Sender: <xms:KpswaCvo_Yb7c0iG4TqjRX16M7iJ3ji4rfcMwy7lt4sbWZGCQAkeFQ>
    <xme:KpswaHeYTDLHMH6JKmYjiIlLY5mJuFy1Vbr37B4bKy1NzjMvxazTgWwiRhhPMxM7j
    2VIq5i8rl7LHheImQ>
X-ME-Received: <xmr:KpswaNwsrPKFI0782s7i2BhebW0SevbgkQxmv-rcmIf_owIKoMHF71gvScscq_eORmj_TiruGAEZiimVBwUwIN70NPZZqGu8WE9YMrM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdelvdejucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteeg
    vddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:KpswaNMtUGuS9Hh5weOh9t3nMnuAlfZr9FG9PlRhB76NnkQxJnkikQ>
    <xmx:KpswaC_ZFi-kPlrHVIyUi1aIkUcripqMjI-amPL4TkXXUfsZFmff5g>
    <xmx:KpswaFVPFQ69aWCf7Kf-gt36pmDkQqJy89qJmfY6h7Is30LtCqCO0w>
    <xmx:KpswaLe2Um_eUwy7YdxYouornuxSLPTNfRa0UudrZkcz-bQlbcd4Zw>
    <xmx:K5swaL37g_NafXzz_E0FIzIqkCvIipq74ibmx6qgFP00lLF3ef-kuR2g>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 May 2025 11:58:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
In-Reply-To: <aDCNqRAoGygwnAbq@pks.im> (Patrick Steinhardt's message of "Fri,
	23 May 2025 17:00:57 +0200")
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
	<aC2xp4Cdb0j6OX-G@pks.im> <xmqqcyc2aqy7.fsf@gitster.g>
	<xmqqfrgx8xkw.fsf@gitster.g> <aDBH7G-oKKxAXWBp@pks.im>
	<aDCNqRAoGygwnAbq@pks.im>
Date: Fri, 23 May 2025 08:58:32 -0700
Message-ID: <xmqqo6vjz5cn.fsf@gitster.g>
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

> ... The problem is that we have a test that unexpectedly
> passes on macOS:
>
>     ▶  868/1023 - git grep .fi a                             UNEXPECTEDPASS
>
> The test in question is this one:
>
>     test_expect_failure !CYGWIN 'git grep .fi a' '
>         git grep .fi a
>     '
>
> The test passes if '.' matches a NUL byte, which we expect to only
> happen on Cygwin. 064eed36c7f (config.mak.uname: only set NO_REGEX on
> cygwin for v1.7, 2025-04-17) mentions that this behaviour was probably
> imported from FreeBSD, which makes me wonder whether macOS eventually
> also inherited the same code given its BSD lineage.

Yup, I was wondering about the same thing.  Thanks for confirming.
It is unfortunate that we have blanket USES_BSD_REGEXP prerequisite
;-)

> I think we probably want something like the below patch to fix this. We
> could also have a prereq, but that prereq would look almost the exact
> same as the test. It does make me question the value of the test itself
> as the behaviour is completely platform specific.

Curious.

Don't we run the same set of tests on macOS without Meson?  the
exact same test must be passing unexpectedly.  Why do we see the
complaint on only osx-meson job without osx-{clang,reftable,gcc}
jobs?

> diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
> index b7d83f9a5de..55d5e6de17c 100755
> --- a/t/t7815-grep-binary.sh
> +++ b/t/t7815-grep-binary.sh
> @@ -63,7 +63,7 @@ test_expect_success 'git grep ile a' '
>  	git grep ile a
>  '
>  
> -test_expect_failure !CYGWIN 'git grep .fi a' '
> +test_expect_failure !CYGWIN,!MACOS 'git grep .fi a' '
>  	git grep .fi a
>  '
>  
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 6ce8570226c..fef522327f2 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1636,6 +1636,9 @@ fi
>  # Fix some commands on Windows, and other OS-specific things
>  uname_s=$(uname -s)
>  case $uname_s in
> +Darwin)
> +	test_set_prereq MACOS
> +	;;
>  *MINGW*)
>  	# Windows has its own (incompatible) sort and find
>  	sort () {
