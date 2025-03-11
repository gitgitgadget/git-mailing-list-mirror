Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5A022257B
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741736654; cv=none; b=Pn1sItxHn4BFalyiCMApytGhID92i3ImFldMCV7ES7apsq6qpRKwmWb4d965Ig5JuLxnZ8NcAIek/rAjdjwTkZXI527uZj8sosAqGHDV/UT/9vwF+gB588nFoSjNQriaIbHG1AUevqleSdIZEFcd0gBFIe58wcHka9Aj0Vc24l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741736654; c=relaxed/simple;
	bh=4SbMtQ6iu4Hbm7u5LDerHcUat3i2u3FBGpV2ZV6Ft/I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lvuh7BL2RxYZSboPJDvJJVWLpPEyfLLt/Lkf0hhbCtIv5MCbZLwh2r1TcvDr45S+tQ0+fpdZGQAZE6T8qYxZIp6SNto5BjlsADMSNqSu3dj6ANtUxktNNOE/to5tRqXaBgs09wjG1aFTI7uhIjXFl0HWaulLsNZiko+c+pkR7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=xPe60ZgT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kMdrWe75; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="xPe60ZgT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kMdrWe75"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B90AA1382E05;
	Tue, 11 Mar 2025 19:44:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 11 Mar 2025 19:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741736651; x=1741823051; bh=C0xh6HBX/s
	N2OdGFEG14SJghTS47NwYd+Y9IUOO4yZg=; b=xPe60ZgTzHu8+ILQaNYCGtsnko
	uesSs2GwJMd02jIga9h3X99Znzfob8kMFaEx2WUm1CCXUEaNm+RhH3stZe0CVXsw
	4Znfdgn+d9Le2drfpjoZrxGRhZ/EeMJ1GX90ssWm3kxHeKz5XQEnFFyYjndC1any
	SmlLG5LfnlcMKXxljOvnPnYj87hv0MF1gbK/7+GkZSvVqR+os0r9eQpRvMEGFvOG
	AQ3PH2UPOV5IwLe9JCR0b1E7BkJuJG0whJoL5/W67Io3ro1ls7raZZgacvmHsaVr
	Mf0nF0h0uQ5jtQAXQwmJCiN+9PikPcrhpMGD5hTmFAwuHrjKGdznKaWUANpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741736651; x=1741823051; bh=C0xh6HBX/sN2OdGFEG14SJghTS47NwYd+Y9
	IUOO4yZg=; b=kMdrWe75cxYssOegx/M1i0Juo8erNIJ3gS0t3kR+dUiLV0wCily
	J8mpLd/PONH/JLt+S3IUm0s6cXAXEM6/xFU3c+5+id7zdmULWUr/K9PRfFc2ZTlm
	HALc2EZgwAsQRIPrK87FRm2J6a5KMu96gAv2En2KaaYGjnidONBL6V1/ca/iVDK3
	zuBCcGpG/3gB7ZPjSqlkEryg1MVNYpTJcD5GT38UIBH6cxcgpqBYSX/MTAweA1cZ
	dawhx59h8B0NdBdbd6t6feXa+jsV4KjT2xszgCv3AtWuCEyJtOfnFm9P1M0ZLvr7
	4agcLpDSS5oz31Y0fEJt1SapfrRskcaZ70A==
X-ME-Sender: <xms:y8rQZ3pojqgoN9EX3LdTsVWE2xiPkGJpmzFlVkBJX11W8_N5n5ue3g>
    <xme:y8rQZxo07hqvTK9tR0pP_6d4YQHMd0RugcHzMJalnn1uX9qy5fcYBSlIYPQ9Z4iAH
    J7Q0I1LKIwsOpo4kg>
X-ME-Received: <xmr:y8rQZ0PjkwWODUjorhaRhHkIsXMJAMenkSJ21cobWF2bVwBXycb4rQCWEfAjUE_cg27NJbnuVAbOaAKtiHBlr73GN5geMw5plCwX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheptghhrhhishhtih
    grnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:y8rQZ65hzR5GfDm_eMLEir5Gy9i-wSa7LidgXbzkNMVrRs3w4Jjo-Q>
    <xmx:y8rQZ26v4M_A0qgmbMGKOK0CbbBdCT1FoaNYA3taVvVklaFLx3NaxQ>
    <xmx:y8rQZygilv41GZyP-4nwjDmiealAox5uUoX8ZSLGRuiaXQjXT1MTRw>
    <xmx:y8rQZ44MGujGNXHPt4ZCsrtMJKnIn8tCwReYo01KAhLgZOYZFsNpdg>
    <xmx:y8rQZ4SDVCzzpoX-nJZUB_PsNlgAKoa_4xsKXgM-Qd0KOpoVSKhtncbK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 19:44:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  christian.couder@gmail.com
Subject: Re: [PATCH 0/4] rev-list: introduce NUL-delimited output mode
In-Reply-To: <nfrfyg56nq7m2bcko4v4tsfdklrafpkybc6uhqgo25swdeebh3@a7aneoylg46u>
	(Justin Tobler's message of "Tue, 11 Mar 2025 18:19:45 -0500")
References: <20250310192829.661692-1-jltobler@gmail.com>
	<xmqq34fk7hb7.fsf@gitster.g>
	<nfrfyg56nq7m2bcko4v4tsfdklrafpkybc6uhqgo25swdeebh3@a7aneoylg46u>
Date: Tue, 11 Mar 2025 16:44:10 -0700
Message-ID: <xmqq1pv32kvp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

>>  (4) The traditional "rev-list --missing" output loses the leading
>>      "?"; it is replaced by "missing" as the <attr> name, i.e. such
>>      a record may look like "<oid> NUL missing=yes NUL..." together
>>      with other "<token>=<value> NUL" pairs appended as needed at
>>      the end.
>
> I think this is good. Instead of prefixing missing OIDs with '?', we can
> just append another token/value pair `missing=yes`.

And we may want to avoid excessive bloat of the output that is not
primarily meant for human consumption, in which case perhaps a
common things like "missing" and "path" can be given a shorter
token, perhaps like "m=yes" and "p=Makefile"?
