Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965D519D89E
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 23:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099268; cv=none; b=JFmQuj+eHUxeaPLlwFeJn9KnF0E5nKPyZ3ryAhms8E/sh9rHUtyPnuHYkTymawCVOYlPCyKECxeYzIQrnyaaaJtVxH7ZQ9wDckLU62l24D/k1TlSQMw4d0Lv3qCEVG0J+S8j61Ld0j9Q30E2TyXiNP2hgIvHCiPgWuLzfnpE37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099268; c=relaxed/simple;
	bh=Q9r/UI6VriAMWvEzfw6zQ1dPZ2lqWABwG5IRFnsA18A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Co+iyXZlfUHuzrG59H4h1/1GJnr1ptnXi6a8AD1n6Lq16tKfs65NF7OzQWWsbx/F80ZIkjXPuhhiUJpKsUiWvPo2RwQ3MBBKJm1fKSKMrSeqD4MsiyjF0lu1/RrsVgLFYgU7y8GSd0GklAXOJc6elV5azbrIsDM9R4Gk/krxX3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L4lAFrW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iOKSghHO; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L4lAFrW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iOKSghHO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C751EEC0547;
	Mon,  9 Mar 2026 19:34:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 19:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773099266; x=1773185666; bh=YbA1eYstry
	zLscYtR+xB/HI11aNFkFM1wt+hRRdWMG0=; b=L4lAFrW1ZnJQTuK4vDLJCKpji0
	SgUR165eXHiDKBbsdiL9/cYNUSNXui91SfWWSBa0OX7g36YK92q3WhM75O1V6yno
	wq5Z8HLbHQmopar7HBZWk9PS90OoYY/ovIJfmibbEtUjj8gO/cMdG9I0vP/1uOLL
	sytV4kpHwR1RuwhAdyF8Sp44xmMUpGtMxsxdOFBquSotxH4jN/Gb+ktmOnt93FGc
	CoZ5kNhUNTK0QeOdjIdPhajmC0sV70seIlBH0War9Dxy+RhP+ULPBD3wHEPcGuFw
	//syFpCsGA5tTwnnP3zRzjU51YlpcsXYRbcztvUprOgq2gznDeW4YY1I5rzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773099266; x=1773185666; bh=YbA1eYstryzLscYtR+xB/HI11aNFkFM1wt+
	hRRdWMG0=; b=iOKSghHOu9v7owXkvZcfB5615utq8WkokPPwpqmzI3k9f6J43A5
	NUdKl074KhYuLI+4cSObosxY3jkQxvt/ayNv/QnHe+r4XFWp1QiAE0DNqRdYfWAB
	QmDD2Psy2J7NF983I9z1Ys5hk8YuHZFvKedH/6mkMtyskfs0/yIhmXs2MR0nVtNh
	KpunOVOLSaXKT8Qv2F6HUIQfe0hsA43O+TY9lMmN/8eH/mKu+NuMqbA07FLmlzz7
	yQn6qHSDq4WQQWE7SHfOImaU+5AwABN99xwOOhK9s+rBKHJtrABg86zwlLuqxDxj
	djUkBC2V7dmtkeTTkyzxZHmI2EnkuqAKmMA==
X-ME-Sender: <xms:AlmvaXd8H-78kwVSFvEr1XkrPOTYkqFMbx25ko4xDFqBlEEEwqqeEw>
    <xme:AlmvaQ4qYJT0nQrjvWEF4wPy9_jD9uLoRyjvSOAI3TNT1K-0jhJasEDesa3gJ3-Eb
    4be5G4OevCKnjOYLrStiSNZgGQaMvfP5zAmCk9g-0cQlonnOe35>
X-ME-Received: <xmr:AlmvaaXWZcRKlOnwn1JVJJYBkipkQgm8F6iSypNbKp_3kwN0ODPKXoGY0YmfeFIMN-HUEv5ffLZtyp7DzP4AtUhEiF6xgH-eeQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeelgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnh
    gvthdprhgtphhtthhopehvrghiuggrshdrphhilhhkrghushhkrghssehshhhophhifhih
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Almvaf4RPvjCeHYvpKPEl7ga2GzZWOqdrbW79ovH8J5qkcITps6LtQ>
    <xmx:AlmvaVqsNbd4AO6tYBITVAdf3tj_5zvdC8NuFzjyi-uTyMlp-D2nTg>
    <xmx:AlmvaSld27hQoZhMD5Fnx9pv0s5mNqyC01RqAIKhpGVOqfMntGQpPg>
    <xmx:AlmvaRP37UhGR2aea5ZBspZ3L1dB4w0NbvlPbPLvL9Pb3lXUm9RCfA>
    <xmx:AlmvaWW7RiWgzS0Po23hMQMJJkjFALhjlMiulA4FFyO7fvegcG1BBO1Y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 19:34:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>,
    Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>
Subject: Re: [PATCH v5 0/4] http: add support for HTTP 429 rate limit retries
In-Reply-To: <xmqq5x7nknrd.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	23 Feb 2026 16:07:18 -0800")
References: <pull.2008.v4.git.1771423748.gitgitgadget@gmail.com>
	<pull.2008.v5.git.1771856405.gitgitgadget@gmail.com>
	<xmqq5x7nknrd.fsf@gitster.g>
Date: Mon, 09 Mar 2026 16:34:25 -0700
Message-ID: <xmqq4imo1sse.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "Vaidas Pilkauskas via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> Changes since v4:
>>
>>  * fix only strbuf_attach() calls which don't need reallocation
>>  * remove patch, which enforces strbuf_attach() contract via BUG()
>> ...
>> Vaidas Pilkauskas (4):
>>   strbuf: pass correct alloc to strbuf_attach() in strbuf_reencode()
>>   strbuf_attach: fix call sites to pass correct alloc
>>   remote-curl: introduce show_http_message_fatal() helper
>
> These three patches looked quite reasonable to me.
>
>>   http: add support for HTTP 429 rate limit retries
>
> I'd feel comfortable to see somebody more familiar with the HTTP
> transport code base to take a look at this step before we declare
> victory.

Any volunteers?

Thanks.
