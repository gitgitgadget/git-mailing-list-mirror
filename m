Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8501F4A35
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 06:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748931161; cv=none; b=uhFK3CtnWA/m1a2szDlc3QPydmxOYTyG//j8AhMt+geNmROolKrKYlpGXvhzZPZti1R1rVLSYPc0wdQytzqYKRIBhEL1X0Fe7N3WiAsEZFSqTktZvRkvYNO+LWfr/dVsqegfl73xXdnJHkamL4ng8yYOD8aq66ARtN/dlEXNX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748931161; c=relaxed/simple;
	bh=7TKiKNNm/gvPio8XRowmncBl3UytzYZo03NFFtGuXuo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcouwOsis2QkTLwy5EUSwvZ9iE/TzeNb4NN2OzquDd050b5IDkN/sy31S7tZQc9d3LMb4LBQ3jAy+PcPCpyPiqM3DeihH3u9xPgxAgtknc9wv91irUjiqVWZKMrk9bvT3e+b3jYzdblg55y+4Bw9hDDRqfD248JpniBCgTP8SX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QJhj1B/h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVjE5aSb; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QJhj1B/h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVjE5aSb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C78D1380090;
	Tue,  3 Jun 2025 02:12:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 03 Jun 2025 02:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1748931158; x=1749017558; bh=TigyVRpXmw
	kHDrQ+4NX/IOPKQYc26NEG9GwiQ3I+0Tw=; b=QJhj1B/hZS6z+8a9Iq/xg90fz4
	nOQMBriS1pFxPDJWGs5l+970YTfFM97/QgYJjg7zlqt71EVG84DMseGmg6R8txSR
	+fu8iadsMLRZX3WFtt7Cy1I2+hq5rbt80/PEtsMdBp5GR1A4IWWLoANZVEEibIjn
	Sbjrh+jDxaxxnSWrtLoI1IlvsjTlQ60BTRpVrPEDKQnDCaRHp4eaEKJjEUuYih6X
	b1ozoFN5XrC1J3U/L8qImJ0V9tdb44fzI9y6mzTIVoHDeUL3rgdcJtuvyQx9DX5D
	JMAYzJ9uOjs62gqY1MKkJ7WzNUKYUEsJEa+325NHzCSHYYmSKLOcOAEsYo6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748931158; x=1749017558; bh=TigyVRpXmwkHDrQ+4NX/IOPKQYc26NEG9Gw
	iQ3I+0Tw=; b=KVjE5aSbrzreM8LWZ6tqkxF120zEY6Kt9chWr5JazLOtW9jVl9V
	pSyeFAmcZ4e6YMiedO+vB5sFdMq32u1hciyDp2skTMeL7CyygTtaq8g9vRc0pqd3
	mwPLdBXxB/QF0/68VsoCwUl9pYwbzGqERVNMc07Obl4smiLkzbuXTgu/M52KdWK+
	rRRYJCXMQvEs+yc+9SDXustxH2LS+2Rp0wBW+BfhgvWaKCwytJZow72lmc+JP01A
	EVU5gbInb2IcbV1TTuuFYLyu4SMOAbaszJNMYj4poPSNcH/rku/wOZpbVLAIqPYo
	Zdb9tFM7XorwjpeI9xx0RqXnV5wIGomEGsw==
X-ME-Sender: <xms:VJI-aNI5jbtwf_K2YqwxZLs9XZWX8KGVLwCnkC7UE3Lx3hDHYw2z3w>
    <xme:VJI-aJJmom6JGFL9-NVIVYaf59JcCFcIqtlanpblKZHHkb_qnp2-U5hSrSVeSs2AK
    5bB8IXz-ig1uaLVCw>
X-ME-Received: <xmr:VJI-aFswRSVnbgjRJbsScSw47mkqExbYDl-QNu4_8VKfba8nYtsEPrgIzw5h_n4UCWHlER0TI0b_zggWTWX3t5nltrM45nrzWmSB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefleektdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoe
    hgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteej
    heeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrdhnjhhurdgvughurdgtnhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VJI-aObErsqZUeP49_0UYiJG7bhQQzgo4OwxhwJ8mZ_NPQo_pxZuGA>
    <xmx:VJI-aEY-nIWRrZEQKUiNTmOnk4DjQfYsgoJuNv195CsweUEPi1NA8Q>
    <xmx:VJI-aCAE6OD_iznZHUq_s9sEGgN64yTrDOAUbstTg66jp0lWO2ga8w>
    <xmx:VJI-aCYTnDasKx-6dvXVj9C6Pe3vpZnqcj5SpA87quSD9MHCTnCCqg>
    <xmx:VpI-aFnENnUqn6jUaBcjJdQPhQFsjD55a-E6YJ1K5mftgKnDatBt-HMe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 02:12:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3] pack-bitmap: remove checks before bitmap_free
In-Reply-To: <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
	(Lidong Yan via GitGitGadget's message of "Tue, 03 Jun 2025 01:46:20
	+0000")
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
	<pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
Date: Mon, 02 Jun 2025 23:12:35 -0700
Message-ID: <xmqq1ps1s698.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'use pseudo-merge in boundary traversal' '
> +	git init pseudo-merge-boundary-traversal &&
> +	(
> +		cd pseudo-merge-boundary-traversal &&
> +
> +		git config bitmapPseudoMerge.test.pattern refs/ &&
> +		git config bitmapPseudoMerge.test.threshold now &&
> +		git config bitmapPseudoMerge.test.stableThreshold now &&


> +		GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=1 &&

Either before or after that line, don't you need to 

		export GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL &&

as well?

And if the test passed without exporting the variable, is it really
testing what we want to test?

> +		test_commit A &&
> +		git repack -adb &&
> +		test_commit B &&
> +
> +		echo '1' >expect &&
> +		git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_done
>
> base-commit: 845c48a16a7f7b2c44d8cb137b16a4a1f0140229
