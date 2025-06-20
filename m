Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F098942A9D
	for <git@vger.kernel.org>; Fri, 20 Jun 2025 23:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750462566; cv=none; b=JYJEriOTbyNmG/k68Sui3ndw7JZu3GpEHh6AM90utp+iPk3pB/8oSJhfsX0YMY4lAPXxX15UK7xDiXAG33sJoHxLCN8NQ2rUpLuJIAW2Rjgg8e93FqkfmfiszqYSTck1x4vuTSRioOcy8N90wLjJLo5akFQ9qKyV3Sib+1Mpmxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750462566; c=relaxed/simple;
	bh=Bvz/y2MWd/6jOarwTQpJY7AJKatzUkdo9m2c1A4jvOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ci1T4MgDaa2X5GwBHLs82VS88TaK6Y8+Q2imlXXMGplGMX7piNetORLy3yjxm8565MrrroN+w77jGDbBPYBZUqDbgq0fB2x3rJyP+DmzUhjxke1YK40GMGbGMWY7d4VQl1q3gKAwctYCuyqviFh8Mg1f788nMSSlamaLPyY4wLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TLXqq0iR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o+ETJqyG; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TLXqq0iR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o+ETJqyG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A7F9C114016C;
	Fri, 20 Jun 2025 19:36:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 20 Jun 2025 19:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750462562; x=1750548962; bh=ePgBYjkRJ7
	eMgNXTbe9zgoEv1MSWgT9ifWWuRu1dcWc=; b=TLXqq0iRna4dVgYE2giGQkOyou
	8I0FOT7RxUDuqQh2wAV/pZq3TpxbAh5Q11S0L9pUVpd6GyMhajqZW75ErmiWlp3b
	TpzNrpbgnWyMTf8kDGfzM6FLUlm2XFnytWp5O7pzHGAvhJIRKVAU+C279NXyfLKR
	VlNALsQJ8FmWUQOT1JYq4nmad+McmW79d9apbjlcLRH6o5oUOcok5LmZirCW5o06
	QW0FTFzZlTasHK0vIwuF/ufheCuLCuEOP1fZbaMwyGVo4LxIojh74/e8U11SZRnM
	RjJjHK7PWws35CjQayW1xD5ezNoe8BfKfBdU2CXLPUr7d22hUFzdrsQPt/hQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750462562; x=1750548962; bh=ePgBYjkRJ7eMgNXTbe9zgoEv1MSWgT9ifWW
	uRu1dcWc=; b=o+ETJqyGtELLt6u469P5PSeKM7niKeu/HAklNyrd5Le59aN+iL2
	jkGG5MZoO5Q4WE0V0FaFUMac7hXBQ/BH9tZA8JY/v5edTt30/tMwA7pKiWurK2RT
	rb1khI17jufPqn409Cup8EPSz1HPoEtQHZkRpxnvDPj6aVTUoHfHvrhbtSbiHVtL
	r0/5PIfeGMqFlcC3u3i+U6XxKgVexdzheBnpB8xNuxX8n65Rsl894cscpz8x/6lb
	vIgNvaZiUfgbE/ItnCAX5fDstxnoYhWTYnP+uaGFYTxi3udzTqiAv6tKRBDi0Nps
	A1IoaszrHTz3f2pvwlkfLY+hF5MYvpJi1kA==
X-ME-Sender: <xms:YvBVaPUjtMMHhKwm1injX1BYyOf39JnQGWGIebkHkHTfeIwIe4wQjw>
    <xme:YvBVaHmJ0w9quqZ2ic25NhSeaxpNNpWQTh2aAc1uRlzoacjrAqzEbzuBew8ea5Gyk
    29nnl9LUFtpzLzUkQ>
X-ME-Received: <xmr:YvBVaLaWgGtykQcqMYasVRZNryvjm-dfa8R-qa0wczGIGzUQNJvi_dX2J4CVz5934zEABjofh9YtHd3u-vLVJno42TqiKEeNGzkW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdeljeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdejledu
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhn
    sggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjrggtoh
    gsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:YvBVaKUb01XhJ3bYeousBZq4DWcrNN-PUb95EWzuolRWlas8XP-18g>
    <xmx:YvBVaJnHGASoaZrUVo19OCrwglXLujnOYXwuPLV7AoXa3ALBGKHbDA>
    <xmx:YvBVaHcO0zEAgZ56QNCdQnCxP3s92OTgHqlfTUqmqnqCvaSE1Lca4w>
    <xmx:YvBVaDGkLdAEaikQE5JNmo01mKW3AuR8qKkCiIO8aXqEIp9EBRHXhQ>
    <xmx:YvBVaCTZ9eb2JJlOml9bKNZSOrnLkEwZkwuCmE1yydhE-m6UyIRkXQNs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jun 2025 19:36:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Lidong Yan
 <yldhome2d2@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 1/7] remote: remove branch->merge_name and fix
 branch_release()
In-Reply-To: <20250618-jk-submodule-helper-use-url-v3-1-7c60f2679271@gmail.com>
	(Jacob Keller's message of "Wed, 18 Jun 2025 16:08:15 -0700")
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
	<20250618-jk-submodule-helper-use-url-v3-1-7c60f2679271@gmail.com>
Date: Fri, 20 Jun 2025 16:36:00 -0700
Message-ID: <xmqqecve0yvz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> This end result is cleaner, and avoids duplicating the merge names
> twice.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> Link: [1] https://lore.kernel.org/git/20250617-jk-submodule-helper-use-url-v2-1-04cbb003177d@gmail.com/
> ---
>  remote.h       |  4 ++--
>  branch.c       |  4 ++--
>  builtin/pull.c |  2 +-
>  remote.c       | 42 +++++++++++++++++++++++++++---------------
>  4 files changed, 32 insertions(+), 20 deletions(-)

This unfortunately makes t5582 segfault.
