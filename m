Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373BC3E92AD
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173803; cv=none; b=TB23p8TUFXRgWZJrhMiW5cOfq7thZUnsIVXGnLm7szliyWxseR2zKKSxv5nVjuXizRh0x151P8RF1TI2oh01K3+3mc74e0NkK9favaAfG5Wlv37kwyDBTTAJvS7cfZpp6ZrBLkjlKFgz4yRxHRhtck82fSG4kf4iuwWl7/FwV/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173803; c=relaxed/simple;
	bh=uMFVQKnHY+PoPfzC6nSGh2U0mcKcVXVAoqPE+37bqoM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=atNe2d7CgUg///UP62SEE94/5MOPdyaY3CleVz1YtCu1+RlFiXo7KLvLT4DOTcIocDnfLuGkBu6PP5dsZ69kLDrrx4eN3LDT6mYSzpKp2kLoiytrQ4nl8amvoy5k84bEw8UooonFB2VOYOlf0XOQcfs4R0Y59hr+VAuYkCM4h/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hTcMXQa9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZi1LAOE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hTcMXQa9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZi1LAOE"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6383D140016A;
	Tue, 10 Mar 2026 16:16:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 10 Mar 2026 16:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773173801; x=1773260201; bh=4DpL4JinYA
	hHOSmUnFaFiiqa10XbCc1Me219EWvp/Jw=; b=hTcMXQa9+UcuCuE8K63qlLdTZC
	QM79FUi6gLCp0JekViIItXMO1rhQh1aY89YX0lVMnYSVtF7XKQ6pBeMFgp/mAcOx
	KF6jkt6K7ojg5VzwmIzsruopI9xi8xD5nMc3kjQH1ykFRmo33TjwEEyYtbUUJpVN
	74G1aJZaXrVpp2kMp/LbYbZJ8AY+tagwfTHZ9u3pxoTvEAdvR9xryCBp0QKWXGP0
	LjD588n2N1omYwvwGqtR3Ugmtlx75Nu+9+/QK+bai7HaKw1l3SSGiJtAS3EZjao3
	vwjVGeWMo8x5Vx5z5NSBNH/yl2qsL5kSKMnGFzc358Camv4Zk0wo95RzmixA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773173801; x=1773260201; bh=4DpL4JinYAhHOSmUnFaFiiqa10XbCc1Me21
	9EWvp/Jw=; b=VZi1LAOE4kQixjBY0ZtmH6mTFJQQJwNBjPld/my1eAlbpOzkD9R
	1uF35FehLa6BrxTmJRIe1F+ZRoO/A3mu0bSSqt3wh8OlxfLZzjJ/ZzuCo5X2XoBT
	35dM0twoyVYwaO7HzodAQOFmTIQ3i+p4Vv7wE5IukpqGoHElzvJTmPaClx+fdIdo
	vr1S6Ql8QlW/gyGcfa87M7Ov7FGm4vbND1AM1Rje3C/PjR0sIMDZHq3lbW1QC2uC
	ThAoNXPZJzXIX50dUPxLuzc8546rgUIiEwZ84Y2aG94cqluqqiOFAxLDrL4GO0RH
	ZhJCZe5HSOYAQ7KMh+lR1GnSVurZhA+hlYw==
X-ME-Sender: <xms:KXywacaNj2FtkVExVtlxmvGtOs7ZovBAgX0dhI3B1hfu03Gfd43t_Q>
    <xme:KXywae042ZtBMoYZNh7cdt7TnKPSVUDDHaNi6nrmCTwZGOXVYJenpYnpknpNK3BBM
    FyJFwGGgePahzCvRM7Lb6wtwxEzk3IvaRjzwL0XTQJjbr-kUNfuJA>
X-ME-Received: <xmr:KXywaUUznLlaXVxHyGllbgoBHnWIj5MT1lAAnUUd0gQ2u6Os2oX7zJcRDlTzYR9b8iX4WUc49XubAQ0ELZnax5A1ltuTGeGwiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeefleessggr
    rhhrohhithdrshhhpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:KXywaQVW-F9OcEp4QTvjmmBkqwvyKSGQxaN80f9KG232gc7Ms40i6w>
    <xmx:KXywabeZAgepWR-cjE-WZL8BON6pfR-iyr8yDQJbv_wCMKGQkL5lWQ>
    <xmx:KXywaRVee8NvXNtgFi7QBlsTiV_EcStYTGGmojyEpqu1eQBFMOEnCw>
    <xmx:KXywacf2PHGOmbH64L4S1dHGVyMtHnFHOjbhGreIF4yOqZZnXPAXsA>
    <xmx:KXywaTy4T7qywGY_HcGAPVHAxtU_mjG_VCpWAIks7wvXX_7uhM4jQxV6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 16:16:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jiamu Sun <39@barroit.sh>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 6/8] parseopt: autocorrect mistyped subcommands
In-Reply-To: <SY0P300MB08011B31B360FC14F05418C1CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	(Jiamu Sun's message of "Tue, 10 Mar 2026 20:41:05 +0900")
References: <SY0P300MB08013E35DCA8FC31B0662125CE78A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB0801C6F21C2D8F49892DF8E7CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
	<SY0P300MB08011B31B360FC14F05418C1CE46A@SY0P300MB0801.AUSP300.PROD.OUTLOOK.COM>
Date: Tue, 10 Mar 2026 13:16:39 -0700
Message-ID: <xmqq7brjtp7c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiamu Sun <39@barroit.sh> writes:

> +static int similar_enough(const char *cmd, unsigned int dist)
> +{
> +	size_t len = strlen(cmd);
> +	unsigned int threshold = len < 3 ? 1 : len < 6 ? 3 : 6;
> +
> +	return dist < threshold;
> +}

There should be some explanation on the reason why this is very
different from SIMILAR_ENOUGH used in help.c for main commands,
especially given that the levenshtein() call here uses identical
weight parameters (0,2,1,3) as used by the call there.

> +static const char *autocorrect_subcommand(const char *cmd,
> + ...
> +	for_each_string_list_item(cand, cmds) {
> +		unsigned int dist = levenshtein(cmd, cand->string, 0, 2, 1, 3);
> +
> +		if (dist < min) {
> +			min = dist;
> +			best = cand;
> +			ties = 0;
> +		} else if (dist == min) {
> +			ties++;
> +		}
> +	}
> +
> +	if (!ties && similar_enough(cmd, min)) {
