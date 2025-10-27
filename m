Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7434315D4E
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 17:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585498; cv=none; b=c0XnrEvYInjipPY/U0GfhJUOmp74sIHEBwlMLxSgi/5C0zm6IiA9BPHq2nvaQ1CrvcfVXenE3ffvVzVOQUeYOA8E+Gg00NULrzMqUl0ShUCv3jpYrVPQYyc3cKsQRnlJP3r4Um009AnV4TobKKl+Mjacx/VXTSCLzIES99jYnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585498; c=relaxed/simple;
	bh=skoHwHYzhCTxq2Uyw+PBTD4thlyZALR4nQ42mWVqaFw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=asMJXeHugo0fJUxm3ImDBvBsZeWK6T1hDR9ONEWk/hKY6/mqPHqWGbNgqzosQVFWR4M4hzZWL58gz3SddXK+S02TVJiRL481YNcGd5zH9yxyjT4xHL7VCCYPAwj73Rz0BXzfLWY9RT/+lDIr+sHoumFkn6d37gWapb+zW+czKxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ICL70/ah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qAkPB2w1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ICL70/ah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qAkPB2w1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2DA96EC02B8;
	Mon, 27 Oct 2025 13:18:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 27 Oct 2025 13:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761585495; x=1761671895; bh=skoHwHYzhC
	Txq2Uyw+PBTD4thlyZALR4nQ42mWVqaFw=; b=ICL70/ahaLzNB6T6nZ1SUT1kMh
	ObDVnYje7lMsWJkad6tCJuhRLn+5k4/EiATF86Z8Am+ZUbu+M/7woHwLiH6E/8Ym
	ZQQZxbKg3TD4uDHXk4yspCgFkEwNyTn+MnDoPnZunWlha6g6CpSLycpuuPosXD6F
	5y3IcsqKBO17/smzyYulZarjZecK0S2hfi4Aps46Bar3Ng/WCKAy315e2KqxfUNJ
	Yf0hmuEa/eTaHghWO+mwHLT/JQy4zuPFPIYBYlwzMSitKqlocYg54Gg3ZfCdF8HZ
	O9tUZCwuaJRa4VMPbHX/yXixCoEPa7HJrXehW9f6o7ssAQkwGo05JVQ6Cdlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761585495; x=1761671895; bh=skoHwHYzhCTxq2Uyw+PBTD4thlyZALR4nQ4
	2mWVqaFw=; b=qAkPB2w170iL3LzII7MCcLa1UU5KkGuGSvkQEHI2Tu8IgoYmRjD
	odiV9jwkzUYtGigrkEUS4rkggKq0sRxGgqkt+OtNM4nd2P9v/1ppZMwUHouqx8E/
	3ZAaIiJwMiffDJcw03ID6S6W5SDMJ4Q2PRhGhJvTZeveJv0tquX1QTGIboKj+po7
	fHMITHP9Q5kYUeE1ImCdUGalTAWRGGy7aqvO+JBGPYNSv0rVXag17ht0co3eHlU3
	MtNlRvyxTs1xqW5iOes6/Cgey2gV8BkRz45uSXsYbG+ob36BRrg0Fg2K6Pe7GwfO
	OS/al0KVSlReG+6c9Sj2kAPWM4MpX6PK1TA==
X-ME-Sender: <xms:Vqn_aI-bs1bucb_p5kMZEexYvqiguMVo6YlxWNuQo7kFx2Hziw4haA>
    <xme:Vqn_aHmcPM3-xpd6EmLcDnWT0O_bu24hoV720qF8H6c-xkn6JSDwAhR3Avluobe86
    GJp_wmnjEppxbnva6euzoZ_gJjkpZN9_rjj9JdzqvTtadjVcH-agw>
X-ME-Received: <xmr:Vqn_aGXoAagEkg7JjtoswRtqAgFcLZppeQL4AvvooqypU7hu2cRtyJDbLGB_jDCmxo5qDP6lUe-yf6sT0f0VJ-JPMmqGCFC1y0BC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheekheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepqhhjvghsshgrieeivdesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghh
    rhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuhhsmh
    grnhgrkhhinhihvghmihdvtddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:V6n_aEHbV5gk99n-wbp2qHogXypIRondPxrCUpy4AdD0QOINWtLdnw>
    <xmx:V6n_aKd9Zn_QoHcYXdpdpMAj--8ZCHk2pctV5pYqGV0POrU6S2T48Q>
    <xmx:V6n_aNLjd_8nHcgCFH8jqf4ZhV15csCU2fgyziAEZXM9zUv_nz2oaA>
    <xmx:V6n_aHH0i_SU5dLWjoVvkT72hPMg2acC1ZTtAmwAzbthVmLMv55KUw>
    <xmx:V6n_aO2l0-Awa16l9NyE96YyUbTU7IhL0j2njRpNsG_eV0ZDtxUy3il6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 13:18:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Queen Jessa <qjessa662@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  usmanakinyemi202@gmail.com
Subject: Re: [PATCH v3] MyFirstContribution: add note on confirming patches
In-Reply-To: <CA+JX8Fq-7Vy7TXB4cfxCJNouBAYzjyaqtA-mxSiGUiNm1DRs8Q@mail.gmail.com>
	(Queen Jessa's message of "Mon, 27 Oct 2025 18:09:30 +0100")
References: <20251027111600.1481-1-qjessa662@gmail.com>
	<xmqqms5cl6t8.fsf@gitster.g>
	<CA+JX8Fq+HwKX0Zkf59kiC=GaQwFJ1DPTgHGVnJ25t8c8vjw9yg@mail.gmail.com>
	<xmqq8qgwjpo5.fsf@gitster.g> <xmqq4irkjpek.fsf@gitster.g>
	<CA+JX8Fq-7Vy7TXB4cfxCJNouBAYzjyaqtA-mxSiGUiNm1DRs8Q@mail.gmail.com>
Date: Mon, 27 Oct 2025 10:18:13 -0700
Message-ID: <xmqqzf9ci7qi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Queen Jessa <qjessa662@gmail.com> writes:

> okay. Thank you
>

Thank you for improving the documentation.
