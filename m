Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBBE18E1F
	for <git@vger.kernel.org>; Thu, 26 Dec 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248862; cv=none; b=mvvLXi8ShjsrBe7B3OHPQ3GvvPmJVldKQ1YVHb4kOldeItIY0LUdIWOrgN9PBcV4u47TVMk5C74IBQ7OlEQb92DOuEdVU+S18KmMZQQrS1pcIMgpc6FL73YUeu93kj5S1iTo5dh2TDx3zRrZfUhjhB+rhqpio0M1L/ic/Ri1iMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248862; c=relaxed/simple;
	bh=VaIyG4ZSjB6hq1K2pGcQyT4z2ctFl2WdQpGmynltcnY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kko8VhhR9uMNNgDgNCTjm787Xg0AMW0RzELz2OCyMBu2qOj4a9HRUZud8HgxCTlSywVPG8wQtO2VuqxRbiH1DVFsUVw9X1VT6inJ6N4i7bbMKZaYVsjcFgFQFbgEloM9IucTSxdLJRDw6Jg73/M4Kz3Gv4cSV/L6KGBPw2/6vHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PXbOTiou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YXPbAYK4; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PXbOTiou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YXPbAYK4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 70591114017A;
	Thu, 26 Dec 2024 16:34:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 26 Dec 2024 16:34:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735248859;
	 x=1735335259; bh=hryfLGMAa306iP8fVioKJAzvUWU0dm0Zu03hbuPiLHw=; b=
	PXbOTiouZ9mqg5FxKnD9lnGNBOrKcOjhLDdv4EJvRcw4jB/ql5CFE9NiLmanf5jR
	ll+wkoJ0i5rTSNE0ZCyIC+YKm/5J89KBiQwnx7qyLW9y1PBc1pp+toXI5p9yEkW6
	v1ee1vWbtdrM1p5+fn9ia9YX3gAOcEm9GzWlcsoHXl9GmOyOi6RpVq/iE6AntMJa
	ExQyndzv0lZJ/AJhJmn/tIRVsdYgdFsYKqb8qfOMn81EbNVuw57j64DhCbxs40a5
	AfsLQpDl4TRd4UmYOsRewtgjbA+Un5sm6LmhLbvSwzj70Vr4B2iiL23FSaGE0qOs
	jgEENtKl6h9j/7n73Z5aXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735248859; x=
	1735335259; bh=hryfLGMAa306iP8fVioKJAzvUWU0dm0Zu03hbuPiLHw=; b=Y
	XPbAYK4dLOQyrR/Q/2Kb0w0dFB/dV+hj2cEsse4R68X/lG2Y7dNqGbIEpGDp9eX9
	/mwm1vk3g6JVdmyRTqgfaJ0ACBNtvM4OiMaGQPoBWw5JXvTPexDQVOWc7GbCoNJ0
	cn8llQ+1DVsujHApl1wOFhJcy4t1YzjxVIpm1povicoSOJEurt9x0AObxKm0qw0f
	6RqMwX2J3JGu9PdH8pWnLrJ6Y2qinx8gHNZBz6Ray6PpcDbtXU9+5wHIr1Z+IqKg
	xrG5Qh5O/2V+cpquKQkQ0o5Q3CQov8ulxAT2HiItIkiLSjB3GvLTx5tDm7gOK8Bm
	Cw78NbtQhUrHIkBw6Tnyg==
X-ME-Sender: <xms:2sttZ3yzFQyfZPK0JCPdZbhlKy5Wykk4mIoKhs-phuwIs0Y-rrq03A>
    <xme:2sttZ_TvxOpAqeSmlyMuRvOlkI_vpiVCofiBc3jds4UXNaw4zvcIQXQLVb4RxzJOH
    rFhQWbHGyyK1KjnXw>
X-ME-Received: <xmr:2sttZxW7v6nzDm00hUjiuga0AW4LiXE6GPL0z6tq6NYN4PgKiT_1eF461UUQViRxyN2dl1iE7aNtNSevoyfirM9N3CdO4VPwBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    dtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveevfedtheenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvghtrdguvgdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:2sttZxjy9npu7Azl6XbgvkIPdQVeWRQs6yXIApwCaLvqRNidIF4hzw>
    <xmx:2sttZ5BoCnNchME6N_5d96BBMuZp1XMRlZzaIDVYT7RvEpprMeBrVw>
    <xmx:2sttZ6KBBhu46M06FlX-FfpCFW0WZuVy9ISkykessZ3g4lihpLGTEQ>
    <xmx:2sttZ4BPMsrydtVciZeeeFTbhkMB0oPnM0xN7nOw9QX-7SxVnLARHA>
    <xmx:28ttZ4O5bMY5vdp7YGPpfvbPoJEFWJhvsLlyiSds4In6TakSTVDxnuYb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 16:34:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/4] date.c: Fix type missmatch warings from msvc
In-Reply-To: <20241223110407.3308-3-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Mon, 23 Dec 2024 12:04:05 +0100")
References: <20241223110407.3308-1-soekkle@freenet.de>
	<20241223110407.3308-3-soekkle@freenet.de>
Date: Thu, 26 Dec 2024 13:34:17 -0800
Message-ID: <xmqqy102w2li.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Sören Krecker <soekkle@freenet.de> writes:

> Fix compiler warings from msvc in date.c for value truncation from 64
> bit to 32 bit integers.
>
> Also switch from int to size_t for all variables with result of strlen()
> which cannot become negative.
>
> Signed-off-by: Sören Krecker <soekkle@freenet.de>
> ---
>  date.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/date.c b/date.c
> index bee9fe8f10..8ae19f9ecc 100644
> --- a/date.c
> +++ b/date.c
> @@ -1242,7 +1242,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>  	}
>  
>  	for (s = special; s->name; s++) {
> -		int len = strlen(s->name);
> +		size_t len = strlen(s->name);
>  		if (match_string(date, s->name) == len) {
>  			s->fn(tm, now, num);
>  			*touched = 1;
> @@ -1252,7 +1252,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>  
>  	if (!*num) {
>  		for (i = 1; i < 11; i++) {
> -			int len = strlen(number_name[i]);
> +			size_t len = strlen(number_name[i]);
>  			if (match_string(date, number_name[i]) == len) {
>  				*num = i;
>  				*touched = 1;
> @@ -1268,7 +1268,7 @@ static const char *approxidate_alpha(const char *date, struct tm *tm, struct tm
>  
>  	tl = typelen;
>  	while (tl->type) {
> -		int len = strlen(tl->type);
> +		size_t len = strlen(tl->type);
>  		if (match_string(date, tl->type) >= len-1) {
>  			update_tm(tm, now, tl->length * *num);
>  			*num = 0;

These are all good changes, unquestionably.  strlen() counts in
bytes and returns size_t; we should recieve the returned value in a
variable of type size_t.

Will queue.  Thanks.
