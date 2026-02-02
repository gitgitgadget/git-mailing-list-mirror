Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102E3387563
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054992; cv=none; b=dm32wKL6YG6wkCEs0sf/gj6zC5PHMgCiY0AKxcJP5oYDHoXqyiwXo7ysOt6Lsp2clQyPprF+AjrF6OAnMpqT18B8RKErRaUSsWiFfAmCcRRTNKBO5X+Wbh2Muf1/ps391gRo5r/t3j1/BCzxSxjeHSSyRSGqrtNmJbYS9R2re2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054992; c=relaxed/simple;
	bh=ElDRDkdetT85AK3I2CJ2VkUQsm6n4XZhPnGbd6fwWgM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ik3QqI43dZjQxbNjZyosgmyp3evgqLJVU6AkG7Z49G2UE1YsEXxmPSnqiwvlPYR1+Vrsluha0PqaxLV9zWJBZb8/MhHP0GL4UY1MhI0tWEnM3c1cFuUH6tFtimqxtnsbxNej+zNoRW952VlX2dVAKZUyCA6pcB8xhvedRjSsSxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Qbr3Baqq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QpiqzVw/; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qbr3Baqq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QpiqzVw/"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 327F71D000AB;
	Mon,  2 Feb 2026 12:56:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Feb 2026 12:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770054989;
	 x=1770141389; bh=+ttrtjMLyynu9Jga4lG80l3q8VcLiaKu59BR9R2QZRc=; b=
	Qbr3Baqq6W5wDCsZpm/Ltz6WH9HEVvvU84jkD7sXnENdlS1GZnCRH7MYOnv2WRCO
	Rg/H9f+mZAIGcsEZ83gohQukAEzDtYPUVv6Im29+0UzrURNMd01KnXHMICyXF7NZ
	xBeybrmeuq6psvavBlSa2Mt4QHHhRIiU9rZNzgXqV6uOiD3Vi9hymVyii0YwPvWU
	ac5k7BfvQxOwmcTUpqMTA0Hk94ci87XYfdSSsBlYR7JRmlk9xb30LQdn9eE25NYy
	eEt8d8CNe+S4m3TQY33fwsolVADB+7J8DXqezbzVCNSlocNlFJ+14mrLSFj46BJf
	uUkKymu0OBatcNaJ6UAjXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770054989; x=
	1770141389; bh=+ttrtjMLyynu9Jga4lG80l3q8VcLiaKu59BR9R2QZRc=; b=Q
	piqzVw/knV3UfZPKteSh+Ph2QhRRFVcAPx3I7YlWgiS2FLJxk4p83IjEotyK8n4Q
	0IMl0u2NjnFQcQgvIcoBFIJK1VSn5JaGERofvRiZhJ/LlMN+yFqi6Pj45gJo+EIJ
	QxUAGRZqnhM+bWFJHZwoDQKexUSpGYC9Xl/nM0vUUfsv+b5liNMoSFxp5h3WjTUn
	7I3/3uqWNRkH9LtA9Z7dNU7ur1x6reHu+bSIblnAVLhXyC4NRjjurBT1KEcI2cx0
	LgZumGvsKuiDT+N9T8gikjeQJMHZHGaePGjOropKimJcefJDLqzl3aVnCMxDBjwh
	OqBzQjb3FRpUCLjmCL3OQ==
X-ME-Sender: <xms:TeWAaTLaeYIRybXcT4J_Xv3gcRJaeJk_tgedpnhwhppi58XfIzN4JA>
    <xme:TeWAaeKTMe2O6eKmrQ3akwqb0g_eEhNG-ZK5NbNABYTtpv8myYw7jDUVNlyXfYLwn
    4vwuZ08Z9QNMVpRZGN5M8_VTl0u_AnJDj4YjE9F866qz2Jixsn8i4Q>
X-ME-Received: <xmr:TeWAaQsRO0ejJxXyVtukCut_fp5F1G4b0telc0sv1nwKc5WTxuLL3J6k5h0W11AXkmf1nZKASxrlLvp88pvKw5Mup4t4lBu8JQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekre
    dttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhes
    phhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuve
    elgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnh
    gspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepshgvthhhmhgtmhgrihhlsehpmhdrmhgvpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TeWAabQxun4zz94t7nyvYl99uL_wGHIdgYNKiZEBFItBZW5RXHXPrw>
    <xmx:TeWAaWMXINUWf6w2CTZjJ7qHu77YLF4GN8ZZ6urFrxufU2E7EF8UVQ>
    <xmx:TeWAaQY1h0tn42nT82T8vbKYjbI9XdODZf7o7xHEEqxJV7YIcnhxNg>
    <xmx:TeWAaQwLqD-RhOJsKRTdD7ghgj9zuNC9jgRAnhvu5tPjjdB8RjI0Lg>
    <xmx:TeWAaU73TDGkhcXVQ3fr9zFxje3AMVMRAIiRbqnFxx_K0LuVk8hQQ2rl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 12:56:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Seth McDonald <sethmcmail@pm.me>,  git@vger.kernel.org
Subject: Re: [PATCH] blame: fix coloring for repeated suspects
In-Reply-To: <62e3ab10-bfa4-4ec7-9838-0bad89d04edd@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Mon, 2 Feb 2026 17:24:45 +0100")
References: <aX8BjoOGPIytGXjD@McDaDebianPC>
	<28ac1ee6-f3e9-4789-92b7-903788430697@web.de>
	<xmqqfr7j2u6q.fsf@gitster.g>
	<62e3ab10-bfa4-4ec7-9838-0bad89d04edd@web.de>
Date: Mon, 02 Feb 2026 09:56:28 -0800
Message-ID: <xmqqqzr3yqpf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

>> While this should work, I am kind of surprised that this has to done
>> as a sepecial case.  It often happens that two adjacent blocks may
>> be originally pass their blames to different parents of a merge, but
>> then the blame passes down through both branches down to the same
>> ancestor, at which point these two blocks need to be merged back
>> into the same source again, and I was hoping that a helper function
>> for it would be called to take care of this case as well.
>
> Do you mean blame_coalesce()?  It is called, but won't merge entries
> that are not ignored with those that are.  And we do need to keep them
> separate for blame.markignoredlines to work.

Yes, and sigh.  I know "ignore these commits" came much later than
the main part of blame, and I am not surprised if the way it was
bolted on was not designed to mesh well with existing framework like
the blame_coalesce() helper and what it tried to achieve.

Anyway, thanks for a fix.  Will queue.
