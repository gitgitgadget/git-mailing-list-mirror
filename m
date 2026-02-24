Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056913A1E66
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771946549; cv=none; b=DAFe4pSu5F0d3UrPW2wIfLE7fgzTT2u0Cur3tfII9A0ZSzM+fUXGCmzteWV9j4WBi+raZHl0hmOIIEPV6n2J3zqwomjnP/aqM+joLpWSVobx7na6p26QZ+cIcrjJsPlXBzR/FFI8oRcPfun+unbxP3l7s9hlLIZMkFLh9LrbcCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771946549; c=relaxed/simple;
	bh=/ykdogMn27YwGa69vRev41i2TyQn15ciBo93gJROBHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJc2oJi0ds2tCY1S+C35GcGkS5AFnLNcxCn4f+T64MNGOeBNY3B75GQHkxLwy87Jd9ImsByTuv5C2gNAYPhHSXx4Xupyb0NBVlSDuJElRbleLjfD+/8ozwScExNfTMWceSBG+g2Lm3sPcg/7TYSswcsw5hdOzq+ZiQkHRjiH2rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LoFaPn4S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dVw1yrqQ; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LoFaPn4S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dVw1yrqQ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 2887AEC05B1;
	Tue, 24 Feb 2026 10:22:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 24 Feb 2026 10:22:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771946547; x=1772032947; bh=pKhPIMBd58
	gn9zAuonNBMxzf3IPoE+totBBFicpQf/Y=; b=LoFaPn4S+1xaf3jk/1TC5rA3xk
	at+k/ipAjKO7DQjfmFzEaPAesKvtYxo5/VjDrs4QgXLPgYV5Rp5hBxLQ1tFkX4Sk
	TpEVQfii+Qdss4rPnv2kl73JbbP4DLhdqz4E7Kvuyy8sI6Usw2lqUEfpkNZNWh7E
	szm3S7gDoXJeyB1QV5X9c6JxH+ZIZeUFi8SCiYVST5V1vkJqvfXwAV1Lu/+XWaz8
	FsPLOrHzAxFC/7pp26p6deEJh3grFrjxVLDW/sOnAvgTSI1J9Q+hru588fsbYk2O
	Jwk3P/XSJ3Y+q1rI3330E8WP6umFxUrwJbQlfhFU0PFDx34M+8ASNyk4PDvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771946547; x=1772032947; bh=pKhPIMBd58gn9zAuonNBMxzf3IPoE+totBB
	FicpQf/Y=; b=dVw1yrqQyexJh5exiqShiqNIzhAHvDrFRb2Efa4FTSt/0ce+IKc
	XBnEEwBZgH9QJ+03KGsXYbiIHjsw2CB8HRfhrTEwpfdFI518ijSqpdKV4VNkBnvY
	A2STgrPAQbcDrU95uAwjsz1fZKPL2lfT5LFImmlVZKPjAFI1JZSbTfy46k5RZxCH
	uNE+PWc3ENV+iA1gISXDDb+kCLrwtDOLzOGpAbH695i2zJsL9q3XuxRl6k3cCmew
	q/7ZC95xWd+1EH1brCwD8J9O8venx4siBEQ3v/qMpvFzpGTC4JoC/3Gk1z7sHjq3
	MDwDVTKmPYPiHkSzEKc+ifWkqkRZbsbDkpA==
X-ME-Sender: <xms:MsKdafw-n8Wq_e7TJskKfjs4HklwKQQu3dFo32Q3rffvIGhgZKRTYQ>
    <xme:MsKdaeswhoFcBWueFCN2-7m4g-f5uyJHXj6xD5DwwMebBQGMsSFXhwtqx7zO5rA6e
    6i_68FIbk--iv8rhhWc_I4VWfLHFsuBeeyYJVjKXxjZb-KpBKewnA>
X-ME-Received: <xmr:MsKdaWv-N82W5vcz55PfOPBHnwArKyYdYCxObPsJXf-VpvPSgh-ugY_kpE3BmIwZM4nr8ZWLfmrukyqoVqD_C1U9so6Nk5KG5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedtheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:MsKdaTP52ezkvGB_ULZNDcKwy6X5bkm_zYWI7iJBEJpC3zfuFwUzTA>
    <xmx:MsKdaU1oGA4xlkUD6y0tBRX3qnPtlDAHgZwCElbHbKXsWgWiucBoFg>
    <xmx:MsKdafMXp-VdIZLxaSzuO4hubRjNXa7dKVlUQ9D1ZG9qm0W4JqQZVw>
    <xmx:MsKdaU2OgCNZk_zYx94rgf2l1THaXRdyyVvL6EY7IieAFWv2jfggRw>
    <xmx:M8KdaedpvqtWxPkc47M2cLnj4sQNj6IEc5UDcs0RZ6wd_LQMaAQnJCrT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 10:22:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Han Young <hanyang.tony@bytedance.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 0/1] diffcore-break: avoid segfault with freed entries
In-Reply-To: <20260224061329.60364-1-hanyang.tony@bytedance.com> (Han Young's
	message of "Tue, 24 Feb 2026 14:13:28 +0800")
References: <20260212072002.2347-1-hanyang.tony@bytedance.com>
	<20260224061329.60364-1-hanyang.tony@bytedance.com>
Date: Tue, 24 Feb 2026 07:22:25 -0800
Message-ID: <xmqq8qcijhe6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Han Young <hanyang.tony@bytedance.com> writes:

> Changes since v2:
> * fixed the ' in test, and removed unused lines
> * clarify the cause of segfault in commit message
>
> Han Young (1):
>   diffcore-break: avoid segfault with freed entries
>
>  diffcore-break.c              |  1 +
>  t/t4067-diff-partial-clone.sh | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)

Thanks, will replace.
