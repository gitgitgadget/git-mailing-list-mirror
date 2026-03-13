Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BBF220F2A
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 04:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773376791; cv=none; b=eGkMAAj+r941HGTJdXTWpYHccmXC0fvY/nee/6AJTiEag8BWWIDmGcRhHJYPBgKvaX0KEfr78OMLuWh/ESaVGBTN1NYawxFGhuCV87dcOR0rUMFl6DmGlhUPNTSgo2ABuguGV1Y9p2YiK/fJd+L8WVzfOnlyP+Co0/MRTKZRvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773376791; c=relaxed/simple;
	bh=PvOJ5hby6xxrKazC98gjoq4J3mfTtMi1m9EuIShI78o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b+PPqd8IxNzI/3TcxE+v9+zHIzR5sOlm6EJRgf04fjen2LhKR1l4McNbSSfBwVGwStbllZmZNS9jDVUPdTNqqQ5rxrK+FoLS30wZQtTqxOPoSCEat80/zbWqAGnlOLfMwYYYZgzr0ODvZNmtSoGlMLpWLbjvHeu9aScczmKTYzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W9eKfmN2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTS3bvFx; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W9eKfmN2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTS3bvFx"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 748DB7A00DE;
	Fri, 13 Mar 2026 00:39:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 00:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773376789; x=1773463189; bh=gCaOGXGSKB
	oxzLJ4En32zinOzv6MM8a70Vm/CiS43oQ=; b=W9eKfmN2NnQUbYDu8ANUq8iNxd
	U6cJskQFGOzLyQVc/RvmNLVsFW6OBDsPYe8PdXcxetQnN4LBR9H5ADM1XSXYrAUm
	bDBQ2Mb+DGchsHEdt/nDVmg0b09BsGcA4Z7aWHb/xZmZ/wruHqqsDSDFKrFFIkD7
	H+PJS35uhI5sz/rofrXUXYnGG0LahyTOjESupmikLJn70iKk2ssX4zFHly4okmSa
	bByYzkFCDIIae0htQljQLLtAXP8QZkDV/yzY/zXja42hp47TTjqAX7vFyiIKQKlX
	Un8Llw7GuSDLCqQ8uXE4KRGvK+3OqRYns842gaCXx9qMY4jSURcTNXElH7tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773376789; x=1773463189; bh=gCaOGXGSKBoxzLJ4En32zinOzv6MM8a70Vm
	/CiS43oQ=; b=jTS3bvFxIMbWEZu+gFXVmEKdn5b6bWrNHLgIC4WWHTwiJkqgYkB
	W9QIvDl65AVBphl4O19iq5UK3OK7zbn40hGFaYU8e+q26DD9vGaE1v2n69Cw3LwD
	bDO7sFGmcdM2XcJHX6W75bZsaVwVlr4Pt2ug0RnVU5PmBglTxLmq8Dnhy9w3AFG5
	z8rqgwCkMHBDWOUniQNQ1XYjcMuv6Lm0sLlCBlDe4FCPP+Q3yCzuyYZoNwffOnlf
	qzKiFekk/yyJ5TqGj9i+4EhKVceqyxKVyh0Z6EmB3frjSBuyFdZmxqJHyTiJ5BQl
	sZh//mtrrKazUK+tRp8Ik0g+5YbmmsRhNyA==
X-ME-Sender: <xms:FZWzaTQivp-5SETwMNhz6AOv_YY7qxoFza_KETK2aX6SnBjgCEy4jA>
    <xme:FZWzabwIztmCBwk1b9Y8e5-M7TFMFGzKRpp0h80cndbAHxeG9khZcFYHe_WHzh7qF
    LKEmBCUITRjfCagcbKg9SZOlHYDxq2IKBkCbKDU6K5pzRbwxWqhEA>
X-ME-Received: <xmr:FZWzad2tzFtaOuyB_WJVEyuhv4SwPZL1yhAmnM7MrjzwGJOBK0j3t66qwLfjEb7RDFYxR1_VozvrMF3FWC3WJhA6ymwQsu4ofg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmrhhoihhk
    seguvghlrgihvggurdhsphgrtggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FZWzaR6jNsFODN6dZOh6aUUge5Z8L5GVjDhU1SDNYDuaMzGuYvxuxQ>
    <xmx:FZWzaYWduWtnGFq6aDoHu1qaLRpOCjULgjNRp8lZp7DXzBbyKYVrbw>
    <xmx:FZWzaYDdv3xMNOro6S4o0-VSZ_m5w2fVBgVABksmn7NiYwmG8O3zrQ>
    <xmx:FZWzaf5inThfn2pVi_fQTDkRctfA4JXqYp81D5SFwdlVmLJvsixVjg>
    <xmx:FZWzaYU6XpcSkIlO4Xz_bl3A87CvydiNMPssCAnKH1-SFbaMMyXTLcmn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 00:39:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] apply.c: fix -p argument parsing
In-Reply-To: <20260313031950.1695103-1-mroik@delayed.space> (Mirko Faina's
	message of "Fri, 13 Mar 2026 04:19:47 +0100")
References: <20260310050621.3849719-1-mroik@delayed.space>
	<20260313031950.1695103-1-mroik@delayed.space>
Date: Thu, 12 Mar 2026 21:39:47 -0700
Message-ID: <xmqqtsuk8hrg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> As Jeff pointed out, the previous patch doesn't pass tests on windows...
> Inlined as a workaround and to avoid adding additional folders to the
> existing test directory.

Thanks for working very well together.
> +test_expect_success 'git apply -p 1 patch' '
> +	cat >patch <<-\EOF &&
> +		From 90ad11d5b2d437e82d4d992f72fb44c2227798b5 Mon Sep 17 00:00:00 2001
> +		From: Mroik <mroik@delayed.space>
> +		Date: Mon, 9 Mar 2026 23:25:00 +0100
> +		Subject: [PATCH] Test
> +
> +		---
> +		 t/test/test | 0
> +		 1 file changed, 0 insertions(+), 0 deletions(-)
> +		 create mode 100644 t/test/test
> +
> +		diff --git a/t/test/test b/t/test/test
> +		new file mode 100644
> +		index 0000000000..e69de29bb2
> +		-- 
> +		2.53.0.851.ga537e3e6e9
> +
> +	EOF

It is more customary to indent the here-doc body to the same level
as surrounding <<EOF..EOF; no need to resend only to fix this, as I
can easily dedent it by one level.

> +	test_when_finished "rm -rf t" &&
> +	git apply -p 1 patch &&
> +	test_path_is_dir t
> +'
> +
> +test_expect_success 'apply fails due to non-num -p' '
> +	test_when_finished "rm -rf t test" &&
> +	test_must_fail git apply -p malformed patch
> +'
> +
> +test_expect_success 'apply fails due to trailing non-digit in -p' '
> +	test_when_finished "rm -rf t test" &&
> +	test_must_fail git apply -p 2q patch
> +'
> +
> +test_expect_success 'apply fails due to negative number in -p' '
> +	test_when_finished "rm -rf t test patch" &&
> +	test_must_fail git apply -p -1 patch
> +'

The test all make sense, but if we know what error message we are
expecting, it may not be a bad idea to do something like

	test_must_fail git apply -p -1 patch 2>err &&
	test_grep "<num> has to be a non-negative" err

to ensure that the command did not fail for a wrong reason.

THanks.


