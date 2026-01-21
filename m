Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6E23793CD
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 18:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020845; cv=none; b=CbPHaFHxPFJpz6dNS6VW5fgpWuiGA18QdA++jJZHXbEZcYO0xTs2O0ySeSiTw3M4Ro0sPoCFnsfeqSkci500x2wGnV/lUE3kkiPMqbJKr2EaVy16asygEo+RWj8pGTLj6RzLVz9uMkZrNhbFuzBKSQR/09NYG6+EXn7xlakqb7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020845; c=relaxed/simple;
	bh=POkpnpTkAWneyvJgtGHB+xXwNndyY/X0MJW+Y4QuTTs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fkYUauJZ1Si3qgQtU1AEN1BrI+3rfY/hfBhhzotRpRxmXihO/vxPJijB82JHRaw1jCPNB9peuaQ3N67ssrELiIEvd8TU08bRxGNug7zyqSySduGYIuSs4u7gHUicmF2Socl+eMB3M00mdHTq4R01Iz0N8EMG1C9j5JKldUWXbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kViklXNm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q2AQ+T4l; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kViklXNm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q2AQ+T4l"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A63F7A00D4;
	Wed, 21 Jan 2026 13:40:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 21 Jan 2026 13:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769020842; x=1769107242; bh=V4RupDsZfp
	y9o87qhZ/XQzXCsGXDQ9Hjy8h8LuTQxeI=; b=kViklXNmesZ0PpGLD5PnBqee06
	u2NonRPhWKNiRGZSSjIJEYRPFwc9o83u3RDaR3NckqCoC/iqloqlkVHMeaeHtKal
	MaGTDOrhn1nk5t0jDSWY2wDiU3+3hZfeg5U8/jvoTz33Q+iholvqfPK0GLTw1J82
	vf8Cjp30+cirqpQf3ijl39YMUwsWKSVdFwIEUJVBSOLubiN0Q5chM2P6IYs7+00l
	XS7Djty9qtVFDsGdCT/+zX7HZYEabjXq1kIv0XMHyhyVUxKBOPdfy+FhKoAx16Ou
	7/1M5TYBKox2Z2VLOaYrkvB2FIvyGWbPAvSeE46dKCWh+pv/ke25zGcIIWcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769020842; x=1769107242; bh=V4RupDsZfpy9o87qhZ/XQzXCsGXDQ9Hjy8h
	8LuTQxeI=; b=q2AQ+T4lAQxGV070ZS//+SaEFvZgRs5jCLR+Agefney1GFqK+0n
	V5rGicOJtHOpDCqce1lONTXHfsCZ7seXlDUs5pScl0B0j9AcNEfYWOWZ87/kOq3W
	cpaajwg3Ud77H/9JOSCMb9Wih5LoM5n1wj2UKKYzwwgau+fIrb7gnZI8IpaI+c5g
	djIoE8aUgpzEbJP80hx2oGmvokV8RBJCoo3zt2upN2JHCWk/XdFP61rX2J/j7sms
	2ulDXsYnjz1w4ALkXGYaPyMJoFSr6fEgqy8FWJEgYp72mzFemKQsv8gtOEUw1pBW
	emm4yhCEJ/tb9T9/u05y1GEfqG3Mi1SCCOQ==
X-ME-Sender: <xms:qR1xaXhGJ3LMlTiYMH3MsX9enO71AFJjLxEdGfinrmdYppe_l8h7Xg>
    <xme:qR1xabCR102OlHajcsGrAZeJzZb__uk_CLZ9hwDu3ji-GPeaexDgX09wrWZujL4Fs
    5jpQou-sK1gY0wEs3oLirxznxw_NLg7aoA8KeBnmdsVzo2_tDlTJA>
X-ME-Received: <xmr:qR1xacE11y2sIJFEEUuo2rWzFZMr8ERaaQX-SOSX0P5JJKKdvMHy6o4AJLN8Ykof7yAUrdowKNjUcTA76yvu_FWZMO_qCMUDLWhNoZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugeegtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdevleejtdduueeljeeugfeitefhteeltdefgeelheelleelhefgfeetkeeu
    ueejnecuffhomhgrihhnpehmshhgihgurdhlihhnkhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhushhtvggusegtohguvggsvghrghdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:qR1xaTJX-aMXYgxnsiPMLHhEJyW8mKPL5Pg3Z4AE9jBqXBxj3XHf8A>
    <xmx:qR1xaQlC2kDPhaYfd6DE4WNKOva0V9WR5qypvMpONBvRtg8nqaOLqQ>
    <xmx:qR1xabSBJLGkg4Njg7ZqNLYp7_v-j0sr14LCCAY9ZCU8VkuTFQtD3w>
    <xmx:qR1xaSIF7moZaALiqzHxJmKyiVda5Z4Pf38Fma04WbYSZK7lyXeBiA>
    <xmx:qh1xaY3wGPBZ2XDnez0O8k1EkaA_nZaBPCn8D4eG-Y6oOCWWaGkCFjL->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 13:40:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org,  Gusted <gusted@codeberg.org>
Subject: Re: [PATCH v3 0/4] Change git-last-modified(1) default behavior and
 add documentation
In-Reply-To: <20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
	(Toon Claes's message of "Tue, 20 Jan 2026 22:47:07 +0100")
References: <20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com>
	<20260120-toon-last-modified-zzzz-v3-0-9bffd4968b0e@iotcl.com>
Date: Wed, 21 Jan 2026 10:40:39 -0800
Message-ID: <xmqqpl72u7vc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> Changes in v3:
> - Rejoined the two commits about `-z and the two about `--max-depth`
> - In the end, drop `struct last_modified::recursive`. This ensures
>   the effect of `--recursive` or `--max-depth` depends on whatever comes
>   last.
> - Added a commit to rename `<path>` to `<pathspec>` in the docs.
> - Link to v2: https://patch.msgid.link/20260116-toon-last-modified-zzzz-v2-0-79e44f2806fe@iotcl.com

This round looked reasonable to me.  Shall we mark it for 'next'?

Thanks.
