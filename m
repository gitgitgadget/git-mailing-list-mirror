Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2262727A455
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162817; cv=none; b=LD/vVtK5l6Tt+7oXVWveNxjMkkWCgyK/zT7I1d5r8HbyVmWycjMe8uM3jgJoz1LarK9j5LkT7aH0lbLNufZ6N98VZT9OApTRa7Lmcd4UAxqrgPj2xdjOBgI1jx9LLqW2uN7GU1Dd7WjfxrHs+/buBMWhj0Nabn1PuzbsXn9dyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162817; c=relaxed/simple;
	bh=6nDq32AuG1VTFrvtyr+p6ops6T23Ckwhtp0Z3UGRb3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r9h/Je0OgA1tEr5qwV+euU1WRrLE4LevW6IYKVSEu9XixSp1MfC25ZrQzEIf/IubI/d68SGkBqVyDbWM5mMI23GYV8rUVtZXYKL62p7l+TOn6ebWysgDwPzIsKvIHVFP6xJlv+VtCaIlaYEgsBbPUG63D6Wqy4UYkqnXUQ2mfXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EOJMaGbr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XEll66Rh; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EOJMaGbr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XEll66Rh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 3504EEC0485;
	Mon, 25 Aug 2025 19:00:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 25 Aug 2025 19:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756162813; x=1756249213; bh=fotx69T0He
	83m+SOIOl1FNPlSMNS6z6lnqUKUls1yfQ=; b=EOJMaGbrIvMCcZQIg72PJd5AgJ
	zOZnorAIU4VRSGzIENtH9KftFkem3K2hiei7s9W2MnE8CLpeiYD578Q4y2zQmQJS
	VpY16guQ7ceJFtZLwsGa8Kky0+Z9R76m2U3f02vbApzwUnLFXZdChLsIvFb9aYN4
	Q1tkImVdg3jpMTT3jiejkkhm1Oy0llnMiP6cHryLJmybm2fcNcDjOAhxpyjaHz0p
	s/I3MbRYSA6GoFQ811YXJEIi48ikSq8Dkj6pZl2le2n3P6rUNH219O6dFpVWcx23
	raEocEhZJ76iUBrLT0In8QdcRSKTvMB01KBa20LpLA8A2bxbuHc/0Xu3HcfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756162813; x=1756249213; bh=fotx69T0He83m+SOIOl1FNPlSMNS6z6lnqU
	KUls1yfQ=; b=XEll66Rhtx1BBUrCnCJIcWD3Og2svHzzCA26l0j6M+WEHyRF3aZ
	/dQFW237ee0bZE3FBMQe4C4VUhjuhtzOspUa9OpysqibSbEqS6uUl6Euq6wxAn9D
	tmHCKwZ2yyyFP+37CHG6cI2Dn8wNdeBoPAFwyi03tvfshKZPKwClYgFRAZOrr9D3
	bU9zE+E4/5FyLyQnS6AZ/3yjVCbLBTVuFmgfNLgPsn6jH3Dy58DbcWu65lRtiv0f
	1ArBldSaOi9fMXvJRzzY22sjor1GdCUfEA8ZmVhRzs6uhcke6xYtUPOVHROnlpla
	1xkGkVmewZt9i616Qp2qpRLtX90OzgtGiVg==
X-ME-Sender: <xms:_eqsaGK8MO5Bz8VOgDJS9pmi85s0J5twXs8zj0tM4P2smDPmm8HM7g>
    <xme:_eqsaBZK1g7lo9Eg4SncR5UUBhZrGm4TtWdG8iTNOIu_4wGm1Iha4MtXaPlPKff5h
    Tyr25jCQ3epeg18Wg>
X-ME-Received: <xmr:_eqsaALT3yDG6kJhnP6y6BK-36aNVpEOHCCdzXsvgAtVgRzGaJkPWfFP4oB1AMNh_gHsxbeNNRlb5F2sal0O1Ykm1bOiNrmovXezL1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeefieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggr
    lhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:_eqsaHAfGsNW5Evp38LCFl0-eALY37mGfLLZzso6ORpHw6EIePfw9w>
    <xmx:_eqsaNqDL7A56AJ-UiJqszJhFyg48PE-Iv0rs1M4DOycxv5d-GKjag>
    <xmx:_eqsaKgJfLt-TDqPVo4defQwXaR93pNtzqTGXFnUS6AIdnsQJw_dUA>
    <xmx:_eqsaCDNiz4uKikFMqUicMZlQSiWSAZD2BTh0ph0uJzJujpjaEzUjQ>
    <xmx:_eqsaFulIEQx0_SC2FAsKfkIGsOgpk3Xxj9gN-KUDsvRlPzxhjLszNQK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 19:00:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] docs: note that extensions.compatobjectformat is
 incomplete
In-Reply-To: <aKzoyFbdohhpiEzK@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Mon, 25 Aug 2025 22:50:48 +0000")
References: <20250823220601.336079-1-sandals@crustytoothpaste.net>
	<20250825221101.611876-1-sandals@crustytoothpaste.net>
	<xmqqms7nnhod.fsf@gitster.g>
	<aKzoyFbdohhpiEzK@fruit.crustytoothpaste.net>
Date: Mon, 25 Aug 2025 16:00:11 -0700
Message-ID: <xmqqcy8jnh1g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2025-08-25 at 22:46:26, Junio C Hamano wrote:
>> Much better.  Let's further do "This option" -> "This extension", as
>> all the others described in this document call themselves as such.
>
> Great, I've just sent a v3 that does that.

As there are two of them, I'll use my local fixup! instead ;-)
