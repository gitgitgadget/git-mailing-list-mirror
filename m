Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E28C372AAE
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 20:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763585989; cv=none; b=hndewVY1nN69s+6d362CoWyiDVua+gX1WaaT+r6K0U6e99y4+2VnFEx3C2/d6mvN4i82jYcvz0zfzslLVDcOb72FrR6EuoY9griy9BXIGNz31KnPXylz2CQQT+cJqsDrWOgoCPjQX9em9Tekt7TJgGwJKx5sqIhbF9AcInWs0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763585989; c=relaxed/simple;
	bh=PYxrvhcnqeuTUafZVsmoZcg0epErXm5beT/NP49QHZg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oKQZgAlTdVRtooMckmdDNbdXWZUs+bdVp3EEnHAbQnuH2u5HlO6NmV05FgrxiFGAFQ6pZ/LT7SdsylXSRGIwnpxSgrdkk9cPJI10IsTUsNCO/h35L40k7NcYQnMgxs5OC+Kx9T+4mVPctf6eVqA8Kh7eb46P3FzPyGxDsoP5ULk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V8cCM3Rg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCnNxcfW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V8cCM3Rg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CCnNxcfW"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35AA01400195;
	Wed, 19 Nov 2025 15:59:46 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 15:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763585986; x=1763672386; bh=PYxrvhcnqe
	uTUafZVsmoZcg0epErXm5beT/NP49QHZg=; b=V8cCM3RgFEGsp0VFLEULgjj1N+
	PI2b4KfsZEV3QhyGL9jERb7YbCSW3+TKgERzox7ISPuLe1K7/OO74tqEna2yOwvh
	QJc58fgFodzVD/uVVEUn+HP07TOH0+zIKrv6Y0y+UUkuO1R6JQb40AH6yxUUvSF5
	+hM4yN2NqdZ4RDyzi9eF+FtzHHLZRjAu0EuGX8nZAqybX8FelsIssnUxEMrKVrKk
	0wPasmPca1ET3HogExNpWMeQ1GFb6PfOs1cLEJdhPmcZiSIxw66KROIpTRosyZ+o
	MjZ4kP+YvRRe+zGYS8sYqGsxU5OrcaFf4O0NiW+JmzuyPhEzt4w2wyATwxzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763585986; x=1763672386; bh=PYxrvhcnqeuTUafZVsmoZcg0epErXm5beT/
	NP49QHZg=; b=CCnNxcfWkEZLy3iI6v71lzuikqGZ/5BK6Hoi6bS5firlY1oVd9m
	LrELGuCfj/oatTWKt1AHt3IDCvT2gefduiRNLAuSumvGA57BMOc+iUoachX196YZ
	KgwqAQpmXSA8C1Fqzlvg+18Z0VQVWuIm8PnzBhZsAiWx5RWhltgeVRfNwaj/0UDM
	5FlNTcM9RRtrHKS4ZY1VbMa2e/mShBRHzmU+e+65XRgRvLL8CY93YMkrAdsXe5Px
	4ZcnoEXRigVLACSvRoFLtbGMZKs7ZXLDzWe2YF5eIQq9YPKQtQ/xUJfj9WRYMMW0
	DzWVa5NIGHv/gNNqRk/gQ7faeV9lvfB5AIg==
X-ME-Sender: <xms:wi8eaUcn0Lc2c_Cx-0-iaZm9SjmEZrTuEGH3OFwgy2m_p_WG3G9-pg>
    <xme:wi8eadp6MMDbrfgVSCIK8sgrnCTY_ObR9ynP-2HD5ILV6bMIz31O31hfQKCKxJ4CO
    IDeVKtJGpjQWJjZhon_25_NRBRmJF2GxyrOvbkbUgmSM3zmAaf4xw>
X-ME-Received: <xmr:wi8eaS4zeuTeezBJMJfIWa5HNuNi6nNipqw9-KIDmCaTRvllCdxQnaSw-oN8xx-dHYcYPpYvOOILg_S0XVVunSxRskaivhY89pXP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:wi8eaTqiNQ2AKJwUB-n0IxoKR6UE4Xf_7qnS_-hk3-0c4jM2XO-_tA>
    <xmx:wi8eaUiqbxOrSU4l9Nb2MswWwl-1ncDLY8TrBA0fe_gF1IHl_Ch-3Q>
    <xmx:wi8eadKxeQ7zVprI0DiOaz9f_-VFEsSill5RcojT1KowwJ2AFrNvvw>
    <xmx:wi8eaUBs_vY-HoYNKh5XG3aTkXwq1wDUnvPdGeJwDdnp4Xe58mGF7Q>
    <xmx:wi8eadxdFAYxuKPpbXCpNuYeF63ld0YoY8jwxCKFQC9NTESukVjhCbPt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 15:59:45 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/13] oidset: introduce `oidset_equal()`
In-Reply-To: <20251119-b4-pks-odb-creation-v1-6-2b2ed2612cb6@pks.im> (Patrick
	Steinhardt's message of "Wed, 19 Nov 2025 08:50:54 +0100")
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
	<20251119-b4-pks-odb-creation-v1-6-2b2ed2612cb6@pks.im>
Date: Wed, 19 Nov 2025 12:59:44 -0800
Message-ID: <xmqq8qg1buwv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Introduce a new function that allows the caller to verify whether two
> oidsets contain the exact same object IDs.
>
> Note that this change requires us to change `oidset_iter_init()` to
> accept a `const struct oidset`.

Iterator shouldn't mutate the set it is iterating over, so
that sounds good.

