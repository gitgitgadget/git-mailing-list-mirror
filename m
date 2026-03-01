Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FF01F5847
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772375585; cv=none; b=L20i9Rf5Lszw2kC6bq9m8X/+te5OBXemt7DbdwR5iCjv6BIYkno8lW/8CoX8xhX/XRNlEa4EDUsMmSQ1DOrS19x2hgyU1YHVZ719NPrgb09NaA8yrPa88ykXqzQOo0Hy3ZqvglLG2tcD6MM+iY70sBmux6g9fYDvSwy72EwTOIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772375585; c=relaxed/simple;
	bh=F/rw1zPCrVAg4yICzK9UAjGh00V7XtNgIhDft3KZEEw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j7WtHMdCFa+U4QpBKMRMg3fOfMeLf1HF08IXyo2gCMCOA+WozP4DmavHgkXrbABTtrlmLxHwtVFdqKvOUPavHiHKDktBWIvoVjYsItMCwp1u5FM+nSxaEO5R1vUqEPECVizu9d8+zSJzztoLYnz/U8tKvBgWz6J0WJoRYljGZeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jBjnOlto; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y0R9O39s; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jBjnOlto";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y0R9O39s"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 07B4C1D00128;
	Sun,  1 Mar 2026 09:33:02 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 01 Mar 2026 09:33:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772375582;
	 x=1772461982; bh=DUlCQafs63IyKptTBNkLDr2RmgWajyvPMFjU8jy6sMg=; b=
	jBjnOltoVGTEnaADjGdZz+5aZpd3sKu8JOAvIlEk68ZIfRMuTHhkvjuys8N4EkFr
	uO+leCNneREskQt6siIZEXJzIQnTwyurOy/JLfUVul22AeE4tDUy9/5WETk1r+CH
	cURjEjUSD8hZ3V0NroD9wmjwgOVUBjtEMBej9uLQVQwpCBumhAp2BwoZP0yhLJNY
	ihUxsI4TyguxNV88lsgyfhlwj9KKKzBjxx4H4gZpdtTBH57Tl+7upKmYuEdrkcFM
	IS9dToMDdBUnm2Sn3O1uf0V28LzxBeN98TcPRPVV4iiXr9AHO+POOK960RqtZ0kj
	suR2QXc5zkrbBHWfRK5QuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772375582; x=
	1772461982; bh=DUlCQafs63IyKptTBNkLDr2RmgWajyvPMFjU8jy6sMg=; b=Y
	0R9O39s8AnYjAYvwQx9tqPXPq5XTh6rNYAB7vst7mVHhOw8vzPHBfY0YKtvYCUFY
	1NU4YuUPAQz7ggNbhL2sXCDsGWc5Ppj9+aGNX6NMpNE1upc3hIBrlIaGMsKxGaph
	Aqu+JohMv8DFrHJov892SHsYCOGBKTlqb3lg4wmMDosCOznuSQfoVyJlrMaoiNk+
	dYpadjRQkkB/Kyr5M2HUiNUH8MvUfjsHdRV9v+i/PcXFVwApiCujit53QUdrVKzT
	r+JUiHIZH5hnYdDMugUbgr3j3hVK+PBJd7ymUsyWTVSpBSyZtYhvfCzET+cCGCzX
	QqVfvbZMeyPHU2kqs4HoA==
X-ME-Sender: <xms:Hk6kaXugRiRFi55ir8IKt-4HB8btFOayiQT_v4CZy0kPSN6HeYrk-w>
    <xme:Hk6kafeW0-SqNemIkjUGSLnbiwjWKtjomndAHHuFXz-KALsOjlLVDyUot2vitkg38
    B5TkQOJUrZ_f_zko6Rhq_ijbLQcNjYj28QCSgGTPNsd-KlJMZ6rkg>
X-ME-Received: <xmr:Hk6kafw-V1MEKVD6Qdiroliwp0a5gChCiyB8YoQsa_F5IKOeVJ7If3gtW7m12X17T_hQRN06N7zMKxdHBh6eyYsbk2WA9-OzHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheehtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Hk6kaVFHLFCxui58EMq2jt7RYrxepHx8j1Qw89_VtI6nlRKWif5L1g>
    <xmx:Hk6kaTxZ2pSm_3KHKIh_GmehilwIRwDmQsaMN7q8DFeKP2tgZ3aDcw>
    <xmx:Hk6kaWs0CicpeAd7czC2dYe6N4n4H4ThYyzoRdXQtSXDDr-U0oFL6Q>
    <xmx:Hk6kaQ2H_26lkSOYG-ovh38h4t5mStgklx3CeMK9d4asqVqcMm8WWQ>
    <xmx:Hk6kaQgM5MhDdjqb9NnLVBuuSWkZVVIoSc1K_61NnNn_9XnQzx2tohMf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Mar 2026 09:33:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] parseopt: check for duplicate long names and
 numerical options
In-Reply-To: <20260228105849.GA3626520@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 28 Feb 2026 05:58:49 -0500")
References: <xmqq5x7jujqb.fsf@gitster.g>
	<7693799a-91a2-480a-ae3e-29f8eed5b55a@web.de>
	<6b674316-9a6e-4f57-b32c-f1824869ba7e@web.de>
	<20260228105849.GA3626520@coredump.intra.peff.net>
Date: Sun, 01 Mar 2026 06:33:01 -0800
Message-ID: <xmqqldgb62n6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Jeff King <peff@peff.net> writes:

> On Sat, Feb 28, 2026 at 10:19:16AM +0100, René Scharfe wrote:
>
>> Perform the slightly expensive string duplicate check only when showing
>> the usage to keep the cost of normal invocations low.  t0012-help.sh
>> covers it.
>
> Nice, this seems like the perfect compromise to me. We get a runtime
> switch that kicks in at the moment we want, and we don't even have to
> pollute the world with a new switch or environment variable.

Yes, absolutely.  This is very nice.
