Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9311632DF
	for <git@vger.kernel.org>; Thu, 20 Feb 2025 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740032764; cv=none; b=VN+vkjFkI4x1MQtPVHw9H7a6Xv1MEBYLLEpNNe783yOKfZA4TqqjjT/+GI/Qyb71oyFwyYr2XmnNPHZOEJql42mryTo7DUJEP+QU1n8on/693Vnbxn9jA1UwprwPu+o0UKYZTAZDN3xqkHHzNfqBYGLWFgh/kfK1afpkw6HL44w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740032764; c=relaxed/simple;
	bh=fEURvDcmfSdRmKAiWuzyLlxcP/GGQrXwfh2RQja1zj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS5Qu7aaOwIjnArjV/b/5uVzoEJa5/2c2glDsv4OA4Twk1GvXVC1NwZUH9hA31DCDrud1toiRp8Xmn774StCoxuFw1iLIPtGqQZg5LjMGt6QBCDLitzRFsbULu0gWwXWsCqaDax8BzrmwIv9vL+OLENrY0G9trvy25KbsLh+UMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mXJ7ayfq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c97JUarQ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mXJ7ayfq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c97JUarQ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A9F372540220;
	Thu, 20 Feb 2025 01:25:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Feb 2025 01:25:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740032759; x=1740119159; bh=XyUOxL6kSh
	bVI9SBImaSBQjY13yw8J8lVMFLskzTtl4=; b=mXJ7ayfqkpRgFn7PsJZa5Dp6Nh
	qO0hbKUWPHYLykTO5cVJoyu8MOp9A3xxnfoc365vK889EBJt6/q1l9c3xartog5C
	/AFDPqyisiBdYy54zYgEKU/iosR5d+bd96eg6TcJTDAj7TZuWIGkr2edfeT0whw3
	i0qsnvmAGNif6eK2zA5p/7A7FLXMLd9Rx/4pIF/39FiIctjQKk63fb2cZlngQJAG
	yv/XNiob6AITGWvL4kAqgwvP7D91cpqkoX4PQdI5PWHEYQ+VKuH2iXjGHyhw+DwH
	z+0xhGoFRubzI6QY2H5GzPsHfiOCT0rYNA0APgDr4TlQV3nSmZcAJp3FVIxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1740032759; x=1740119159; bh=XyUOxL6kShbVI9SBImaSBQjY13yw8J8lVMF
	LskzTtl4=; b=c97JUarQjY3zbS7WU5XCqn+EqD711dNN07KC3M6ZFxBJ24YR5sQ
	k0BeyJyU70HKiiesSt+0Ub0lvl578OCeNrhtbIScVvWn4iyfNFEE+qKfOgc/k2+r
	IjU2E5bCL8q+gWzhWvbCuUJMt8VLtF0Qtw5BBgK76TD8VhoQNTBH/uVyoehZFdH9
	pwQDWzCV0G4b0Q7yUhDByCtJFxWxhjEMBy+1vvfXYE9XNFydszJx0aLV4OnW9gDD
	r8hGnEwx3k6EnB4UPJMonRsRElKEdLHLructsNU11bQgTptevi4uPvuWP5uSoHmu
	7BxPCYUIdHIPvKFigL72P+J10kU3al0dPKA==
X-ME-Sender: <xms:9sq2Z1m08kJRUuTXIEp_yML-D2_maKAZYM3nY78asMovdwG97X_-KA>
    <xme:9sq2Zw3cYEdRtpazFoqKAbL76LpR_iG9NPmpZmjVreabnkYRLGu8AVMiRib_lRhf6
    ygKc0lV23pgC5KuLw>
X-ME-Received: <xmr:9sq2Z7q3TYMo7zhVEMGGsuKrLfb5Brq467otACSWtfQpFoPua3Qx2UY1Kr1n682VwMiQf6R0JpccGg27vtJDSYtNaftGhtt7bVhDW9EA3NJb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiieegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjieht
    sehkuggsghdrohhrghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrg
    hilhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhl
    uhhsrdgtohhm
X-ME-Proxy: <xmx:9sq2Z1nCg6tXtDOA7_lUJhZqnOyH_slCQUlInQl3_OVBe1a5Rc4Ysg>
    <xmx:9sq2Zz16BfwlvZoxf1vY4VGCmRJ0HXInZSX674HRt8uswGt248IA-w>
    <xmx:9sq2Z0t2SlGhs-bI4Lx0LrI_EMj3mPqcCfoQh9eWROvJ1uknZxdbzQ>
    <xmx:9sq2Z3VRvQxPkTuMUbL6sRTRZYy2pgr-DtPOsrFZovopI3eZ0SHDbQ>
    <xmx:98q2Zz_0L9cp2e3Djf_gDwBf7gMqhEH9o4FTyTG5M-7T-S2V_KB2MFTZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Feb 2025 01:25:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c53498c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Feb 2025 06:25:55 +0000 (UTC)
Date: Thu, 20 Feb 2025 07:25:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, M Hickford <mirth.hickford@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [-SPAM-] [PATCH v2 00/10] meson: wire up bits and pieces from
 "contrib/"
Message-ID: <Z7bK8jDhJT4qRxvI@pks.im>
References: <20250218-b4-pks-meson-contrib-v1-0-c3edd292beb8@pks.im>
 <20250219-b4-pks-meson-contrib-v2-0-1ba5d7fde0b9@pks.im>
 <390a138a-fc0d-4011-93d6-71efcb19e863@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <390a138a-fc0d-4011-93d6-71efcb19e863@ramsayjones.plus.com>

On Thu, Feb 20, 2025 at 01:25:59AM +0000, Ramsay Jones wrote:
> 
> 
> On 19/02/2025 13:13, Patrick Steinhardt wrote:
> > Hi,
> > 
> > this patch series wires up a couple more bits and pieces, mostly from
> > "contrib/". Included are:
> > 
> >   - The "libsecret", "netrc", "osxkeychain" and "wincred" credential
> >     helpers.
> > 
> >   - The git-contact(1) script.
> > 
> >   - Coccinelle via a new "coccicheck" target that generates the semantic
> >     check.
> > 
> > Not a lot of stuff is missing after this small patch series, as far as I
> > am aware. Omissions that I know of include "git-gui", "sparse" and perf
> > tests.
> 
> I regularly do 'make sparse' and 'make hdr-check' as part of my routine.
> 
> Note that ci/run-static-analysis.sh uses several targets:
> 
>   ci/run-static-analysis.sh:8:make coccicheck
>   ci/run-static-analysis.sh:29:make hdr-check ||
>   ci/run-static-analysis.sh:32:make check-pot
> 
>   ... and ci/test-documentation.sh some more:
> 
>   ci/test-documentation.sh:18:make check-builtins
>   ci/test-documentation.sh:19:make check-docs
> 
>   ... and then there are some coverage targets like 'coverage-test' and
> 'coverage-report' (I haven't actually used them in decades ... ;) ).

Ah, `make hdr-check` is something I forgot about indeed, yes. I guess
introducing those two targets will be one of the next patch series then
once the current patch series both land.

Coverage reports are something that Meson already does natively:

    meson setup build -Db_coverage=true
    meson compile -C build
    meson test -C build
    ninja -C build coverage-html

Patrick
