Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE6A4A07
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 00:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768869104; cv=none; b=lJ9uvkNCtbq3d/JxWzNGGopZ+b2Nb289bItEM9SidG0Mq/9utTxEXwSb7QlwERZIpeKEBa20DquaxghYuPmHCLrBa4M8OhnFW/21Qtzlh/GMpL8aOE99ThMj/XN9SAGXHia47N2ji43liHHO/Sdj0GCzVPjv3WsIak7PjwmDWFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768869104; c=relaxed/simple;
	bh=/jQKlwkaXUAzQByK0vlvhLUT7BaM6i7+e5P5IXhoQ4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AJqL6W0WXzGT0QCYd4oMFZDgfPdDAXNfTzPRqgXGgeZsngJYW6Vzh+I/fhoS92WPAofgbTbARfz16jNgaAPSRRU/uOSQhW92v2J0dHvXkZzunoDsAeZoAfqo0DAH7Dx2Oilg2PxF6HPEE+0nkEqc85xbzaqTkXp1JiwbzY6oTl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TuDtvgXD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sNEGTKTj; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TuDtvgXD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sNEGTKTj"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 7F0F41D0035C;
	Mon, 19 Jan 2026 19:31:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 19 Jan 2026 19:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768869102; x=1768955502; bh=2PVXn1wcHM
	puUkiWExUWlD9GHiUUCIps9e/69gjiByk=; b=TuDtvgXDZOWFYFxN+iqQmz6vfv
	Q9F8CaGFYnRxpmN311mMjX0P48jwbIT3M8/VsTyb6W9Dwk9kD55oHVdsbIM0QL1A
	13FmV1a4QC1lWCulc2ewv2TmkfzLeyx/CmhHk1xDbsLiEQ31TF7n+ujt1NQ3Mcmi
	9dEAtr70uqP5zcUdQ5wU6Cdk4UNTEbVJdyHhbCpSEJXdPIGa+fjfiAznNbxL5d/u
	curpIEo9dXPwnxcZ8yFLcHYeY3U/CMsYi2FJ7JKtd4jmDDZkqy80rN8BiKO8HFNS
	pYxJxRxuFb3Quzre0rk94KOxxe89nb2rcMID3iIR2yY33vE2WREax800NAsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768869102; x=1768955502; bh=2PVXn1wcHMpuUkiWExUWlD9GHiUUCIps9e/
	69gjiByk=; b=sNEGTKTjSnX5pd0yJXH/JYnK7ezpaElqZgZdFUUguidtRu0eROQ
	f91hqOJQ8UYxWBk/5edyEckv+XR8j4vWlih7Un3DC+4aODaQA/GItZjfH16Qtdq9
	Zg0S1BW96RSWsZLkMM6iIKRJ52pgr1/I2gezdz9mxbps9021/NKt3Pg9l9+vFkOE
	vfv1gIZ+Z5Y2TZ+CB0tiwdwEft7A0qK00v/CYAB8gLVpxxnCSdKhn3kW/gr89yOS
	JT3Y7iveC9fhPF+YidNKeIfcLfNOs3D+d2AI92jNaCiQZski4yzP+fU/fCKm/3vk
	N/uzadWGzDQIMRCJ9NA8zkvwHW6qp17WIQQ==
X-ME-Sender: <xms:7sxuabiZINXdvvuKEFCteWjlZaXzzDyZqutRxZ4Qa7eN71A8CKvWBQ>
    <xme:7sxuafCDy7EzHZY1P6iWOp2aJ8-JqlxPd5XWupEsc3q219xRsoZ7Hg3lOExlmKP_b
    Lw39rgce56gt_7RBn16CmahWl0Vsvh1y7XYXOnT68qGCnZVeNBDYw>
X-ME-Received: <xmr:7sxuaQHbWrsBD2bgQlIGeiCYdcidNpQGn5LlEeZYFkm2cV_jhlZqvO5dxrhSpY7CH1clyLI1v200Ustopl5QSsaJ0A-lgpS6q5ALs6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrrhgrlhgunhho
    rhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:7sxuaXIzfgKsvDbUtMDZb9gMDxo3aXIixHok-LwMA9CDqcO9wpF4UQ>
    <xmx:7sxuaUmJTWj1QuTbi1dv_0ZAHxCJGLY2HHp_GEpYaiYTf2N3TOhvlw>
    <xmx:7sxuafRXPT7aOUY1761ns6zfI4idYfJ7BJF_DywW8xwW34ED8VmsHQ>
    <xmx:7sxuaWK-_tGOSvi-YTRM-Uw-YbBXZlYAI2Ge3iW-t5sOQbk1dEp9Pg>
    <xmx:7sxuaaCUJDFrxRTsHXsUJjhOb5mtgbgZo-G-bH_4soZadQ4yUTaPqvFW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Jan 2026 19:31:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH 0/4] memory leaks in remote.c
In-Reply-To: <20260119051858.GA1991308@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 19 Jan 2026 00:18:58 -0500")
References: <20260119051858.GA1991308@coredump.intra.peff.net>
Date: Mon, 19 Jan 2026 16:31:40 -0800
Message-ID: <xmqqecnl3z0z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> This fixes some memory leaks in remote.c. Not urgent, as they are quite
> old, but they are newly triggered in the test suite by Harald's
> hn/status-compare-with-push topic. So I think we'd want to build that
> topic on top of these.
>
> The first two are just preparatory cleanups. Patch 3 fixes the leak that
> Harald's series triggers (and adds its own test, of course). Patch 4 is
> a hypothetical leak that I don't think can be triggered in practice (so
> it's more of a cleanup).
>
>   [1/4]: remote: return non-const pointer from error_buf()
>   [2/4]: remote: drop const return of tracking_for_push_dest()
>   [3/4]: remote: fix leak in branch_get_push_1() with invalid "simple" config
>   [4/4]: remote: always allocate branch.push_tracking_ref
>
>  remote.c                | 24 ++++++++++++++----------
>  remote.h                |  2 +-
>  t/for-each-ref-tests.sh |  9 +++++++++
>  3 files changed, 24 insertions(+), 11 deletions(-)

All look sensible.  Will queue.  Thanks.
