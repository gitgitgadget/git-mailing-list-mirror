Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387DC150997
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940579; cv=none; b=MtrA7lLw7+rg9NCL1UsyJti6tSY6Ck0iDjGHDMirBsDi+HLzfyUhM+sUlE+sp4XlF25uAXl8BrYYc86gRsWIeUZ9YJPhICkh0ABe9asVmnPCBnwKKQj2xv2Xf1KWmjFy22NGZAKdDGasqKoP2oEExlnsyGrPO2Vi2eShR0XHXNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940579; c=relaxed/simple;
	bh=8uEG6kjTMQAiPsnnH/S2VlRRNKdiVkK+Uj3TWOHLDWk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M2NT+Iy4qXz9RPVjpXr94J8X0l6VxeFHOc76o/wbJuVSmtUNInfKjDhWNMjHWjslvBuL8NcnJGCOdYSKdUQs98C1BEbiaUjx8II5kMKDct3B6o5mVHRp7SO0GUyKM5Gtoq4jPOevFIPipKlnVVaQ6KYmNKai1w/G6+WjFV+4ShM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZfsFs6A1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sy8MvdC1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZfsFs6A1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sy8MvdC1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEA1F25400D6;
	Thu, 22 May 2025 15:02:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 22 May 2025 15:02:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747940575; x=1748026975; bh=8uEG6kjTMQ
	AiPsnnH/S2VlRRNKdiVkK+Uj3TWOHLDWk=; b=ZfsFs6A1lxt4tT1/DGzFjpo6ol
	zjP3bhgbCEgcVmaIRY/qqCNFoHzmq4xMyadDRycgRp4OxQyBfxL3e1eYOFPELE4e
	bpU5TPE4b0dNu5E3is2vLpedfQNp22rFJ7JwG5vQIQNdQiqm/lU5bPw6zuH04Xlh
	qu6cJhp7NbIdw5ohSJLG9h5gFwvrIVpjy5GgQ+tzFI//FNzexJ3NToiK64MnUcOU
	Qm3jzT1fskersBGx/4B1uqvagLfId0YtPNV/KkJuO2+nNK5iJBGjahpV6ZqE0Pff
	L+JQhf1tTalKGbxWwPbJtqy1zxQfDD3I3KdOFWGU9/76cWK9l6C50bTk/s8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747940575; x=1748026975; bh=8uEG6kjTMQAiPsnnH/S2VlRRNKdiVkK+Uj3
	TWOHLDWk=; b=sy8MvdC1zPKakXnj8xmVzJwqIg1IdA0n0Fm9dgDj0eYs5ozNjZn
	GG5FKhBdr7oBUdZXasUilE69HZ0caBeN4/MnLPA7JNkpnz2XNIgJviC/IaFleK6V
	LvYKHB6Q/iMW1XdqvpPexSfvY1G5hXLaB5bfj9r8Ycgr2fLY7fNv8qCoWL7qpkTZ
	ntXJ8tHKRS1f+EKCEkIRzG+9ZRvMEnrPEznH9eZpofHXd+/qTpgbhNDFVfuWbHfD
	1xyruSJ1LbSC75sVc7pcWVK8+WXg3rfjv+vRw13BvEgMCHA2vmrF5PAbguft7n1o
	zCPbbq+Ztvx/jHCsaFUsQQNpsRxGgUqbicA==
X-ME-Sender: <xms:3nQvaAVlrkzMO_fZx3J9xhTvsY_0ep26jqlH8d96j39aU9YTae7bkA>
    <xme:3nQvaEmdlROKsCZ2zgtSac8sUGukB0zTQZ9IuJkLU1gxhQPUmawEbCrir3JHNodQ7
    d_Ak2vKT0uVcDb1FQ>
X-ME-Received: <xmr:3nQvaEbmrwYyGOmogJ8EzUlWZzUNmtFk6fGRxob4S8zrA8a6nXj7dQck1OwkaPLNxM_6qqDDsAFoM7Z9o_Ykf7ca2ZvJmkZxMngXoAM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdeijeehucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeeh
    ueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosgho
    gidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehg
    rghrghgrughithihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehjuhhlihgrnhesshifrghgvghmrg
    hkvghrshdrohhrghdprhgtphhtthhopeifihgrghhnvdeffeesohhuthhlohhokhdrtgho
    mhdprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdhorhhgpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3nQvaPVbMyP-XRnKdVlT7h8jYviOz1kTsMGAEfCL9t6L7LmCUhjkMw>
    <xmx:3nQvaKkJnJk8imDrdL8rl_xPqAEH7zSH9vOG_apDAlrBcgwG_R48qw>
    <xmx:3nQvaEeP0I72ma3VHTwc-cWNBzA6JlZakrSiV0tyIcGy_qes5mZCAA>
    <xmx:3nQvaMFcmEnXx0OPij-NQXu-WEgPP36or5HIwMSwTw3Gk4uHkahGEQ>
    <xmx:33QvaLIbG-VpnbHiXr6InTotARrNJsCxBKYRoxbc4zWXx6qaDvHo_lIE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 May 2025 15:02:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Aditya Garg <gargaditya08@live.com>,  git@vger.kernel.org,  "brian m .
 carlson" <sandals@crustytoothpaste.net>,  Julian Swagemakers
 <julian@swagemakers.org>,  Shengyu Qu <wiagn233@outlook.com>,  Zi Yao
 <ziyao@disroot.org>
Subject: Re: [PATCH 1/2] imap-send: fix bug causing cfg->folder being set to
 NULL
In-Reply-To: <CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 22 May 2025 14:00:18 -0400")
References: <PN3PR01MB9597C5BC8528C0E068DDDA18B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB95970F8CF7527648EC4BE907B899A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<CAPig+cRNyEC5LjK1GhGBbEtf3xRu_ZS4RKizFhwjE8fP8sGwTA@mail.gmail.com>
Date: Thu, 22 May 2025 12:02:53 -0700
Message-ID: <xmqqldqo5uzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eric Sunshine <sunshine@sunshineco.com> writes:

> Okay, makes sense. It might be worth mentioning in the commit message
> that these copy/paste bugs were introduced by 6d1f198f34 (imap-send:
> fix leaking memory in `imap_server_conf`, 2024-06-07).

Definitely a good thing to note in the message, together with the
subtlety that the bug is dependenty on the order in which these
configuration variables appear in the file.

In any case, this may indicate that the population of those who
tried to use imap-send since mid last year, whether they used to use
it happily before last year or they tried to use it anew, must be
very small, or we would have heard about this obvious gotcha by now.

