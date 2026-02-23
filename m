Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26442853FD
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 19:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874826; cv=none; b=bPZhEMKgFGAA+GMKEMyLWzpEl/GGfR2AJdsP/gN90GPkJagtjk8s7uDHltE2M/tRnWeK6wfkunq/AzDSAyO6HAh4sm9e5z12RZQzyOruK2X3rhS/yePjVfmYqZmnbJ299sTt4/t3hGsIclN387dDIFxVZb+tRnmLP5h22RyDu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874826; c=relaxed/simple;
	bh=qzSWYHlojmLNB0eKfsHsYDKqwiqnk3LVIse589qZ90Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=avrF3Cmt6Va42OlMRDrllLiHcf2ihyQoSIqbmve954L5zwx75uvGrvhMmurc6htfbzyeaZckYNwfdueK3pgIlNEGwvXpV2gXJU9LsaHW35KlJvy8d/qN6xRHXLhHS4xUPH8u5spaVHWAWYcK1IOJsdwLnlFKJVkYE1PEpStQw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VgOacdCf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+TtGqvW; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VgOacdCf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+TtGqvW"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD2DA14001AB;
	Mon, 23 Feb 2026 14:27:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 23 Feb 2026 14:27:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771874823; x=1771961223; bh=yl5R27nDft
	2jTg5Q/bOtheYngSDALLP5J6oFFkREceU=; b=VgOacdCfuCyTA5LXQew1DmxBnZ
	prfZuTJnGuz6TnCuhN8OPodJ9WkrZ9rQcoxEtdG7i79aWApwLBoOwxuNbakkJdgE
	MHZKPPxEjebIyOpkwr/QFQeSXLWslFjCh/axjCAklDNf1gNDRWcgJSXPOnNnSl5Q
	70qa5ukXh5YR74HHxsNBv4l30blnMNjHhpqpgoarFqU9L1GGXja/7gHqZYrwDrO+
	X/zNME9re2NkJnBQ4mhJD6dP4uouAt9Lkza9+lHwYeK6sxhu3iVgtvjdov8Zroap
	vq1t+G8/KEvgClYPvbtj3ymW8rMhguTzzePbmcxfu5U72V1p2uXh44syNFHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771874823; x=1771961223; bh=yl5R27nDft2jTg5Q/bOtheYngSDALLP5J6o
	FFkREceU=; b=s+TtGqvWdGlHSxNW1YFhmRd+XhffYXZxgtArIvNPxcmhG5+5Vuj
	djg2u0WU7uTr7llDVhxAngIGpxc9djoMlbXpsjHQvNeIAwUnZoSAZYK7Qes/aSw4
	NK9Vn50VRkMtzkHQnY0OYcRXcwwNfDYDu8UsxmAHIchhYAYBxzFJioh7rvVBZmnZ
	OfBJWqHhm6UpD4qDy/JeHpe0C9mOhQWkRsrrvTcqtv9KSilIHjfrfpETE0EcOF4U
	A3NPrlAswjLfkaPoW3NtfkhpKY1Vio3vuTM8tEhP+/M/R0x6IzWkvhZsCVWfbFTQ
	LUCFUtoCUEnYfz47RzTwnIwN+JIfPepQr8Q==
X-ME-Sender: <xms:B6qcaUI2gvT4M3MrWrFnQttDWRMqtVc5AQGY5Z0VgiJ3G_z5iIuHIA>
    <xme:B6qcabImN7xF067UsGERCOhmbv6kg2PukSsHN9nwnUZJFPLGI3fRGlSBK_OMHGnRD
    lsZiqm8pvmcxOE0pf0tetqIKg_pGI31qHySw4NpGNYJ4eF5gqUJdA>
X-ME-Received: <xmr:B6qcaZtzQSaDEBKayK4sSq9RQr-4Tq8MO5OpmDDXnTRKB1RShnj3jnLGc3VZ8t3P6vIl8KKEiTs9y_vyYjNPPSkQh2IGpKj4Og>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeektdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    khgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:B6qcaQSJv-1WbEekLDTXSo4UZB1yVQfBvYDF3VN36U6ly3bvAukK2A>
    <xmx:B6qcaXMkmMRTmYKYFylu7czj-cViI1ujOq9i7zW-Ge5OaaazayvDMQ>
    <xmx:B6qcadYkIQgr8-QkaX_rwk5qENvO6sW4l2TcnfQj8qS52x77O2Hd5Q>
    <xmx:B6qcaZwGaE4TXb6GwtZoKoU52Yua84hufypADVOwcOiMHO3670zx-w>
    <xmx:B6qcaZMJZEsLpu3yqKPrCLdMM-XjbQ3YKDTKw14O--89kvByxqqXxNDu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 14:27:03 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10] setup: improve error diagnosis for invalid .git files
In-Reply-To: <a2b2e581-18ba-42ad-9bf1-a3e16b85f4e9@gmail.com> (Tian Yuchen's
	message of "Tue, 24 Feb 2026 01:17:52 +0800")
References: <20260221083001.220061-1-a3205153416@gmail.com>
	<20260222102928.377519-1-a3205153416@gmail.com>
	<xmqq4in8quxn.fsf@gitster.g> <xmqqqzqcpatz.fsf@gitster.g>
	<5263825f-163c-43af-bac7-152d670919d9@gmail.com>
	<xmqqfr6soxjq.fsf@gitster.g> <xmqq7bs3piz7.fsf@gitster.g>
	<a2b2e581-18ba-42ad-9bf1-a3e16b85f4e9@gmail.com>
Date: Mon, 23 Feb 2026 11:27:02 -0800
Message-ID: <xmqqwm03mfax.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <a3205153416@gmail.com> writes:

> Hi Junio,
>
>  > But at some point, we may want to drop _ERR in those two new "these 
> are not
>  > errors" return values.
>
> For the v11 I sent earlier, I kept `READ_GITFILE_ERR_MISSING` to 
> maintain namespace consistency with the existing `READ_GITFILE_ERR_*` 
> macros. However, I can't deny that decoupling these into neutral status 
> codes (e.g., `READ_GITFILE_MISSING` vs actual fatal errors) also makes 
> sense.
>
> I'd be more than happy to drop the `_ERR` prefix in a v12 if you think 
> it's better to address this cleanup right now, or we can definitely 
> leave it for a future cleanup patch as you suggested.

Nah, we are quickly approaching the point of diminishing return.
Let's see if we need to kill more fundamental bugs before
bikeshedding the constant names.

Thanks.
