Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A417A300
	for <git@vger.kernel.org>; Thu, 28 Aug 2025 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414708; cv=none; b=l+aJzypJ/6FJme9KhScC34XeTkMqfOJmSpqOs5DwYfybRhEaWnmenwAXqMxVCUDUWaTbO2DtGcAfHyzCURIVC3tFiTrxFS1cihjOevqYopRuk2p9V3Akw25g+UjxACnqu5rEkQOtjEPKGpxPw9Xv+1hBGS95JPAO38SSiLNUmZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414708; c=relaxed/simple;
	bh=z3xubKx86uujgGLB0yeHDOwSEoAziIKQlqYGK/4OmRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tca8ZqBw1Yw37eXvWzudvE+7EhppXsLQ8+dYmLQak/X07p/xlo7VKoWkkpZDPUJvLtq8nJ+4NxFEFcA2g8hFv8A27O9cD6otXlXU7qboTiGKhPMUwxNrOrf5BiIF4LtQ2cjnyyrqcj1trNFB/DBieTLovwakceRyhjMMflFbcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hBGl+/03; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hj5bPrjS; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hBGl+/03";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hj5bPrjS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C777D1D000ED;
	Thu, 28 Aug 2025 16:58:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 28 Aug 2025 16:58:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756414705; x=1756501105; bh=0De/Co4SMq
	yLJOHvBU5NOD9XUwp0TTlcjuHsQm6cJA0=; b=hBGl+/03kbr+UhoqQqJKrSpH35
	RJiuly3qUQXPo45INuXz4jEC6jwpdj1yPjaZx5kziaPBtr07UfFfw2f9+28ixwl+
	XAkwJ5K6QPzPXI4JugNrnmRWJuh7QWEJmo8LIjaacx9eh81rCpUVgwbOE5ZqN9K3
	n7l0WIF9g2TQNjFUbKaRLygjlhkpwvQG/6H8areQ8eBK/Wx/m2SlmkII+P3ymssh
	UsWEZhxSGZlq2ETNv1vwUi2QDxmSLT7PqLgaFeZ7nXQ7q4Qwd7TMmbIOrK9PF4Zu
	X9zd8qsbr6x0a1PJQbcx7nGAgsOi5/1CRaEdzifhagG9DgWJQgp4QkChqGLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756414705; x=1756501105; bh=0De/Co4SMqyLJOHvBU5NOD9XUwp0TTlcjuH
	sQm6cJA0=; b=Hj5bPrjSDa4hvkwbI1lug+ftgIDsXAHzz8Ic33YTo1GnlD63aR/
	j6fYgTQzK2lgMpBKS+FKW/5HuVwGIS8uDa/H2vAVix5BYQFzhgdAbtoxrQeVTY8P
	QHrtseS6dJNITEARcNijB/0p2fznnSMajIoAZyT6Q/PVQP3kQ4FypzLxFesNSXUB
	h/O9BUxMvTFGAqNhSSAQeLqHYd8iMBM0R5D2lTCgafShg/fZ2ISC+e7eiPLXmlYf
	jiI6koQSc4sn7WRVOtcpD4J8g1EEbP6FltKTpuq/5wfRye2SbDwy64jKk+F3Vblo
	2LMflhVlSRCKY44D07vC/cDsEzx0EcxTiiA==
X-ME-Sender: <xms:8cKwaNqsjMxX9lyiWJRLitREWBkhv5nH4yo6X-4LafQBzzr77amnxQ>
    <xme:8cKwaLIHPIMDvzVG1Pltfz8gZGiQvowOdC4m7lSTLWTNxnbsXxNe8eNRtR8ja3ZER
    jF3Sk1ws1NERpXC6g>
X-ME-Received: <xmr:8cKwaApdMsloIjHTBT3b_qUldugRdGrM_PbXEszW2o8eWJSHQhnwBA7mMgfYwFfiPlTr0xbfk3xDg20LfE_ygrMvoSYkLWEmVkh26nM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukedvtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:8cKwaDxWVpA1EEn1ioIdxGZkJAPgQvLwTdjFwuyNvF-Hd7wtMRDwJA>
    <xmx:8cKwaEP5iJEtKMRuEv2Wvxs8HIFqHu-7zqjIdJ1eOGItmLyXANz0Aw>
    <xmx:8cKwaI6bQUGkRItonm_y0ARVV859kX3bkjSk3lHlEqcv6EBT0SL_rg>
    <xmx:8cKwaNkQCj0J2jAjcC_4npAo929fPdpn1ywypXGVsNzzHJzej5hApA>
    <xmx:8cKwaPvWBxklybxrsWk1xFez9WxS5ZIoAUj-AB2EsVwo3ZqVbAn5PXr2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Aug 2025 16:58:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  me@ttaylorr.com,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 4/5] midx-write: use uint32_t for preferred_pack_idx
In-Reply-To: <bd97db26f7f789315134dc796403b1ab9976135b.1756402795.git.gitgitgadget@gmail.com>
	(Derrick Stolee via GitGitGadget's message of "Thu, 28 Aug 2025
	17:39:54 +0000")
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
	<bd97db26f7f789315134dc796403b1ab9976135b.1756402795.git.gitgitgadget@gmail.com>
Date: Thu, 28 Aug 2025 13:58:24 -0700
Message-ID: <xmqqsehbtb7z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> For now, replace the use of -1 with a 'NO_PREFERRED_PACK' macro and an
> equality check. The macro stores the max value of a uint32_t, so we
> cannot store a preferred pack that appears last in a list of 2^32 total
> packs, but that's expected to be unreasonable already. This improves the
> range from 2^31 already.

;-)  

I very much like this change.  An obvious alternative may be to use
int instead of uint32_t to number and index into in-core packs, as
we all know that not just 2^32 but 2^31 is still unreasonably too
many anyway.

> There are some careful things to worry about with initializing the
> preferred pack in the struct and using that value when searching for a
> preferred pack that was already incorrect but accidentally working when
> the index was initialized to zero.

True.

> -	struct write_midx_context ctx = { 0 };
> +	struct write_midx_context ctx = {
> +		.preferred_pack_idx = NO_PREFERRED_PACK,
> +	 };

Good.

>  	if (preferred_pack_name) {
> -		ctx.preferred_pack_idx = -1;
> +		ctx.preferred_pack_idx = NO_PREFERRED_PACK;

This too.

Thanks.
