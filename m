Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8579623BF91
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757086084; cv=none; b=nuHdL/HScEnjmxDeA0OEwvcGwuJzZuS6pYkPk2O0gm+LhiRug+dU9amFYk+g3JBZSf6HSKuNmhOlM3AvVkps5xzHcyFPFPy/tKgM8uiKYGFTeWAYK89ochxbUTINPsaaU32Hoy4X9P3FNUHIiLJi435C//DDTP89EgLMqWKLaYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757086084; c=relaxed/simple;
	bh=5myDitpVOHsQ56mAK1FqIR8QV/XFDTBZmo6QSFaxItQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I16lyZPCr83+EV6whFsP6i5tu573Jst5EpfTEfTLTzNmH0Aso9OY2WHJaOINF4/3rPiKyAtel++ggi0IX0eqq7cFxcS7cwnXRdczivg4aFZo6etsthaJ2pR+pFBmrwc8b23wITN59AG5OrtLko0vsXaBrJeDjgx7VlJQdgVQw7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=afkneff5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XqHsWkB2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="afkneff5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XqHsWkB2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8F30814002CF;
	Fri,  5 Sep 2025 11:28:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 05 Sep 2025 11:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1757086081; x=1757172481; bh=p7wHFhIiQi
	RUVOeEdQlCDrvFId8tyxWC3f4jDHBxdz4=; b=afkneff5QzFo+uXoJIdoPWWMVd
	qZd5ygiMpCBMHby456nXTGzq6Q+nYLv8IU5fyooio+UqxxLZyqkplwGE5qNcowVE
	uYVfXuNhl66HmvrlVN3K5WjLzV5Nc9BxnEAH/ohPag6bR0VCu7SbFq1DxeB2Gww7
	PC9ye8xWTErk3WFWnb3+RLTkeknlDr6QdRYgM6GoXaaHJdg7k7/A8VTWoaaqlFRv
	2uLTV1+1Ic2Xn/ToDTAbQSDPkZ4JS8oldORl4RIxKxfEnx8VqXS/+6ufN563o9+8
	DPwvd/sXKlg7ctHWKsgpbUvusCGVB9mSejxo5r7TUJ3WhcpzSNEnaDEEPpYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757086081; x=1757172481; bh=p7wHFhIiQiRUVOeEdQlCDrvFId8tyxWC3f4
	jDHBxdz4=; b=XqHsWkB2Ra9hm70I9/fiS3KLKMZPI+V31ZwR9cmYn6zG0YvNvni
	tyNrbLhohIYqlCd0rn3Sylez0aycCpxPFrxKaZFc7vKv5B1fVE7eqDIPfRz/vAPC
	nDDsCqjRdPvYf+86rQ+L3vp7YOaBvKk7jVFwX9vaKtOGBDBlU8gvQBxCxTKR3mtT
	ZlM9EEN0R7YdiFiNcHg/W4dlwqYFY5rI7UkeOt6V8JVz8mnwlgVWy+tSZTXOwsC8
	KwHZUXVlOTjzK5dC93XPmNrLOOdkMt8PoAbqix/ZawGAFv0a6WwcbxY9q6LUIyxM
	dkv/AllrKnko+dc7+0VpK4vVVAX9YKSaFCg==
X-ME-Sender: <xms:gAG7aJ01spxDB_mqkVF1pOr3MhSVmIMUWgGT0m4wV-JvTD92exO_Lw>
    <xme:gAG7aLl02glc91Es5AYEBG2mTMAof7yq4ic3fm78t2jLpiF0N8gKSCzVjGescf7PW
    YM22FSC--faE1j-yg>
X-ME-Received: <xmr:gAG7aAUTDwVpym_sI-mxLpxsALxpR_h_RrbLKNzedVYRxWfe3mmDm86eYTDeSXyGGZ3Yh2HjcEw2WlxSJWydj9KH2sm5R5xod1wbs1E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:gAG7aBtUM8ZIeBA0oL6ovFai_rVVKvawzJS8HJACKG6E0CL8UNNBgA>
    <xmx:gAG7aDZrS3gFLWS1LGeuIVgAT9b1NX9aD8zIra8R2kmEZwkFNVKWyw>
    <xmx:gAG7aAVycPopkSHgB1PSu7j7tUyhQj5kg2uzCmvRVYUKaLOCxkfyuA>
    <xmx:gAG7aIRLXhJ_vss8qUMYpt7B3YJNn-Ey95PqlBqFNflyMwKT0ZECog>
    <xmx:gQG7aAztt4h-eZBnP6py6IyM4JtQrWg9IPoHhazIQ2lMI0Yd_gOwaKLH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 11:27:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] combine-diff: don't override recursive flag in
 diff_tree_combined()
In-Reply-To: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
	(Toon Claes's message of "Fri, 05 Sep 2025 15:06:31 +0200")
References: <20250905-toon-fix-last-modified-v2-1-d859eeed408e@iotcl.com>
Date: Fri, 05 Sep 2025 08:27:58 -0700
Message-ID: <xmqq5xdw537l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> This patch is based on 'next' at 1ba7204a04 (Merge branch
> 'kh/doc-markup-fixes' into next, 2025-09-03).

Can't you be a bit more specific?  We usually say "do not build on
'next'", but what we really mean by that statement are

 * Your topic may interact with some topics already in 'next', but
   it is unlikely that you depend on _all_ of them.  If you are
   willing to depend on a few selected topics (meaning: you accept
   that you have to adjust your topic when they get updated, and you
   accept that you cannot graduate before all of them graduate),
   identify them and build on the result of a merge of these topics
   into 'master'.  State how you constructed your base in your cover
   letter.

 * If you are truly depending on _everything_ in 'next', then stop.
   Wait until all of them graduates, and then submit your topic
   after that.

Thanks.
