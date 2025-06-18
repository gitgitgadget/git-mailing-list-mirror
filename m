Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717917D2
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289643; cv=none; b=jpMhM9GKTlr5oBl8e737KrzhK6CsX16l+O35XXmiE78Y/CNxqRrnL8/mlvcl3HC98p8H/IZj7M5PA3gFGWzqES/NogGDv2efJFDyCWwu9pfOkYI1tJ01jbCJGNijPU/yG9GSpKBHH5p7NnEkEHomS9jt0Pjl9e6eUluvyPy7kFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289643; c=relaxed/simple;
	bh=gEc6OIIQR742bRHFlK/weJ79DN8lofWQxqi0LpRM/mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Apdfy01JgfblSHOQsO0Y7iiihYItxhFPv3bBXaPyNceWrGUT3UnPwQvFEkZMy8NLXwEvmyTN2/N4qeW3GX6mOxb4ImwyWNiMbdeBR70+ALeL/iNsj0RRXsS6/p4eIx/39yJhUR8kMdGOgqKiZOSUrtP34tm9Qfw1OQFyRLUAHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TONMNwgp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BTEBCA51; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TONMNwgp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BTEBCA51"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 0891D138041C;
	Wed, 18 Jun 2025 19:34:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 18 Jun 2025 19:34:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750289640; x=1750376040; bh=rUd/3FKagS
	vM9Zi17gdBBc6JJOC11eTkyW2vvBPxF6w=; b=TONMNwgpJQwdZfBTFTJNsweAkw
	tKN8xG7kOuU/o9Kz4olMAp5BTXDLnAQ1sYaOdF2Q3f+4+N2hbUlbbGGCutsbkIFW
	xKk/wCe3iWZRdxS5wMIkkgZmEMTRZ83XrPYiTFZFT3TW/vvBuoSh88IC5ftVugts
	5g2TP6XlxeJ+5DhEX49FQSd9sViKVfxj11XP5MQjXM7Xhmo0KUJmrVasHUGYex4i
	vBHRaukW4TSUyJI45B7VDZ4EwvhAo6PbAQyuIFeYTD8L8aUtWXy7QnM5DGh09N4A
	7m8jKQixJxrEy+sQvIvEAGtjDneOtOHOtotV73oyowR5mKc5zRG2HKz4he/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750289640; x=1750376040; bh=rUd/3FKagSvM9Zi17gdBBc6JJOC11eTkyW2
	vvBPxF6w=; b=BTEBCA518JJLaRsdvU9Y1dmH9SC93YaHtnD+rGfGRuWa8CyYpfC
	6x5SvTF3LprEer1Wz0KV9RYcO26d+OnwzCNM+poVDMHoJ9N/ylcxAzfHHJ/EkjE+
	WqadNQ6VK28/a9wrqDiF5nKC9gUKDZ1lHoKalNF9a5FohY+bTmFwlINgAUiHRyn/
	36tdoR2HOvSVgnrf0oEd8gM4Sj5jNZqAnHZf/pUUyVjXfI7oBcQBv9Xk+Mw0CPZn
	fvoDThQrW1dbfrBslU93SFYSMR/MXJOuXCMqsN9673UWYHO8zWJk5kTfXN5TxF+3
	Eciv+8AkGKdZI7bxehGeGSCh1S3U4NBlHHg==
X-ME-Sender: <xms:50xTaJ7kq2d3LIpTBr-5BBtaNRHKn6oQoD0eyFmMBCPlk66wsAaomQ>
    <xme:50xTaG5nNKFGV1ZCH0UW7dG5mQLLn-gBmsifoCAm9Mj3cqtxHEJQMYyD6cYZK3byD
    -fgXHi3kP6xI0dJiQ>
X-ME-Received: <xmr:50xTaAc2BW2N2GKfEktp-st9gS6NdTHnxqk1cj9MUg86tXfvyODQIsOvdbbN4AtlCfgz14qMsMRzsyS4UoUNf0l4xGLVPAGi7ESG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdefleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeekveet
    veevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehjrggtohgsrdgvrdhkvghllhgvrhesihhnthgvlhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjh
    grtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihlughhohhm
    vgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:50xTaCK3GT8MZK_Gdm5cyr7NafA4XgpykzBUvNB76wTSUmTJtkBsnQ>
    <xmx:50xTaNJJF4T9jSta2EpdVBpUoyrmYnutYmXdNY6vh5MeTMXomMT_UA>
    <xmx:50xTaLy2u9QJFriO6U5lbuMXfuyM68nhbMGLhK5iGV_P2lxq6KQ5mw>
    <xmx:50xTaJJHByqYFe-a-Jji4Bk8R_7WtkAjDC3y2n2at4RGVrLgNCHxGw>
    <xmx:50xTaDutxpv_2O6YKhgvkkdaKcVP8P1EaxDqwUxtlxHdAg6_-nt9AOb_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 19:33:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>,  Lidong Yan
 <yldhome2d2@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 0/7] submodule: improve remote lookup logic
In-Reply-To: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
	(Jacob Keller's message of "Wed, 18 Jun 2025 16:08:14 -0700")
References: <20250618-jk-submodule-helper-use-url-v3-0-7c60f2679271@gmail.com>
Date: Wed, 18 Jun 2025 16:33:57 -0700
Message-ID: <xmqqplf0d3q2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> Changes in v3:
> - Completely remove branch->merge_name, making the resulting logic much
>   easier to understand.
> - Link to v2: https://lore.kernel.org/r/20250617-jk-submodule-helper-use-url-v2-0-04cbb003177d@gmail.com

Sounds nice.  Will replace.
