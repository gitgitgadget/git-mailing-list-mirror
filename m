Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAD5287273
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 20:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756153523; cv=none; b=G3BDlpsX8UjUbbi1OII694zOzu9f6DsH9Z/tPowtBaoAbwv4WcC1lzVtu7b7nl+/QWPXUHU8na37RG53E5rAdbSjzyUE9cbLCU/IaQFC1/YVGGu+mKoa6GdB1WCL+r2F12BCx+DutE7nSamB9tS5Sf5aXJx7i9birRCA1WXNbBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756153523; c=relaxed/simple;
	bh=hY9iiza0XbKfnqsVEfMpdZlmj+15bxlhkUuImvCgFyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eNkRLRorp4aPEGSyuM9TQJc2RZ1IKskh5TD5srVUjuN2R+WVMLqtVLq5TY2xyr8IbwcdN0vSAm2981rkjl2gE7ragBYjDpP6icfn4JriqUk9jIgSj3AFWwa98srX3kr05eGM2D1kHO0XPwBJ+oLWPDzWRK+V+LmxZNKyGpycGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZwQ0T5eO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RX1fA4Lj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZwQ0T5eO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RX1fA4Lj"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A252714000A2;
	Mon, 25 Aug 2025 16:25:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 25 Aug 2025 16:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1756153520; x=1756239920; bh=kozoNPL87b
	gn9SE1M1Ief7LGtg60Ry2X+QEvxY7QlpY=; b=ZwQ0T5eOz+VzxvzjBjQFDlU/z/
	6UTbh7fFyj038kEMY7URY6K94QiieLgvvJaOooCyiNTZoa92J3o1KheYLvTSmNrd
	uTPi4q9+Xcg/iSEUH88k5pJgemTzba4VkR97mAuZJX9LVfXJOqT3sNiL6R0TEfdR
	GJ4By4fuBFYO8w3GRgbeYf9PXFN0cZtRr5P4x4UQ55fjLSqpkqv6Gv5209Iz/PJQ
	9vNKBQGRfLtMPfJRRm1hzZHYG2lItO9GiFqY3AN2zGppVspjCQuhIV11O4ZnkkEy
	Wmpzt8ixBw26d5N+JdiOyOG0DZUcyLNRsewXc2qjnz7SK/pctgero4SzcrjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1756153520; x=1756239920; bh=kozoNPL87bgn9SE1M1Ief7LGtg60Ry2X+QE
	vxY7QlpY=; b=RX1fA4Lja2h3MkWmkDzF969SlZU2RKHdIT4P6fH09EfYMLihfa3
	0HTNW6KxDK5ak2m+OSzGr8GbserTk4ME2W71+P368/epWNlGJ7C7ERS6z4Rd+mq6
	R4rfSHOD2xS23uAskCqtr9nkv9rdg5UG6maBM9yMT+tyvA+AaxszdR2BMhW3Aprp
	2jp4CdGzimPVA0xVkCZN1LjcGlJAyKrjakjtllDlf2WxY0EYM64DEIH6WpgFSvX1
	oslQxO54GidOGAg5caMOzUt8aG7xt6oaJqwMJKk8vHrbs+DUp40ktbWSHsOWC8IF
	7YE+wJet4YcTyKV0ksclOnd/G6pYmWTxl+g==
X-ME-Sender: <xms:sMasaD3AqIaUm-lPcCnWyKR15zvGBWlDTweT8mGyk3ZhDPiDO4JOsQ>
    <xme:sMasaMq1tn7NhlE6b5hG_eUX2453IlriFvTZ5CH_4IC-BhYBoYYXwZHFCvJw8uvvH
    LUAcaT4A3swucx8Qg>
X-ME-Received: <xmr:sMasaAfxdraJzZz6CRSe9iz2a1Kn6Fup0YqPS-P5x8LsUgxBc4GTWIxQLJSnojrqusX7yAcJSO4g_yrVogRP_yr4iz823ocW-azqIMo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeeffeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sMasaLof5n7MvXbBGpwRG1hBhjaN9fLHbQEef3Gvre4jaSd5yl96Sg>
    <xmx:sMasaBHsiqIWKNcj90txuxXLAWxTg_CIfVPocASGpMiYEgo0FWvnvQ>
    <xmx:sMasaLvc1OoUzAOra9lai2onEuoU3DmyNwuYA2D1Fo93Fq-8iyLDNw>
    <xmx:sMasaDXkgvycKOrjw3YOvKhiATNwE5-E946VQSEd_C3DMdI9TXyrwA>
    <xmx:sMasaJENFAUe2troT-qsu7s59ZFnapqm-JUrObGfObXi7-BHw7HVoLUn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Aug 2025 16:25:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH v3 0/4] bulk-checkin: remove global transaction state
In-Reply-To: <20250822213500.1488064-1-jltobler@gmail.com> (Justin Tobler's
	message of "Fri, 22 Aug 2025 16:34:56 -0500")
References: <20250821232249.319427-1-jltobler@gmail.com>
	<20250822213500.1488064-1-jltobler@gmail.com>
Date: Mon, 25 Aug 2025 13:25:18 -0700
Message-ID: <xmqqsehfp2s1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> Changes since V2:
>
> - `index_blob_bulk_checkin()` is combined with
>   `deflate_blob_bulk_checkin()` in patch 3 instead of 4.
> - Continue to use `repo_get_object_directory()` instead of open coding.
>
> Changes since V1:
>
> - `index_blob_bulk_checkin()` now assumes that the caller always
>   provides a setup `struct odb_transaction`. Callers are adjusted to
>   ensure this.
> - Functions in bulk-checkin.c now consistently access the repository
>   through the provided `odb_transaction`.
>
> Thanks,
> -Justin
>
> Justin Tobler (4):
>   bulk-checkin: introduce object database transaction structure
>   bulk-checkin: remove global transaction state
>   bulk-checkin: require transaction for index_blob_bulk_checkin()
>   bulk-checkin: use repository variable from transaction
>
>  builtin/add.c            |   5 +-
>  builtin/unpack-objects.c |   5 +-
>  builtin/update-index.c   |   7 +-
>  bulk-checkin.c           | 152 +++++++++++++++++++++------------------
>  bulk-checkin.h           |  25 ++++---
>  cache-tree.c             |   5 +-
>  object-file.c            |  30 +++++---
>  odb.h                    |   8 +++
>  read-cache.c             |   5 +-
>  9 files changed, 141 insertions(+), 101 deletions(-)

Looking good.  Will queue.  Thanks.
