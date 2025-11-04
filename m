Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0275E33B962
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 17:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762277664; cv=none; b=HZw1PlFkNYkHQVks2xajr16yyErJYsKAw1zipqCablD/6RAs5JqiayFtKo2wDQQIOiIL59L+3ljBp/Qg1/Vfg1ipM9ksYjEHE/+5TrNHWY44CfWsIOLg+ZKoZpjoJX7hYh59iD88kznY3YCvuOPA6wynXDcsUgb11oRaAQ4qbOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762277664; c=relaxed/simple;
	bh=U6KW4ltmwRW+W4Olr175OyjpP5AE/+UrkcI4pkGwB0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rLi8UTerI2hLq5RSj3Wy5B7Nxcdh4rSuYvepL41jBH+lb5dRUy73pTemycomLGNja+wPHPjGMzHq7KqgdywQ3QL+f3DjZObTKE/GPU1VF8sbvY5ljoY83/YEZ6h8xYQ74Uf/Xvn3aevpJxbPmq/ZVw2JMsErwUk1orz2tIBw0Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L5n1705l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lYZ2JpLA; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L5n1705l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lYZ2JpLA"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 300CAEC04D8;
	Tue,  4 Nov 2025 12:34:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 04 Nov 2025 12:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1762277662; x=1762364062; bh=dL3QiHicGr
	dBddmR0hxyM9ZUZjatYAdFw0Ytg7lsxwo=; b=L5n1705lznQrfSkEOtPKPg0uDA
	svWjcupZZQ3fecV6aDeGhu8nyzxCEHlD1TgP75Lgd+7mAyor5TaK7jO+1MM8Ac7N
	e471qcnjCaf1uDF2UNi2fPZHjLdSqeHrpYLJ8DBDAQSjY5ldp2Sf6QBshwuSI0W8
	V7FOXq3RUYOkb9fZX8ZKgcyqdNDeTl/9rgmchLlFbZrKZ4FhIfaEsy3zjwOwThq+
	3grWOS9xgJXW8u0UduRJiLY3XDTFJcbs3uZEChpsbwbaONkOM2ZPJiEkXLtRAhni
	YRkl/pGyf9WrctJa19bAbcytUC5TOvPhaEKUdCzpbf+Maj+JV2h3L9zNHsMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1762277662; x=1762364062; bh=dL3QiHicGrdBddmR0hxyM9ZUZjatYAdFw0Y
	tg7lsxwo=; b=lYZ2JpLAuVymAAAam4q7woCiMtM1tJR/He6AIDDlTPdTGIQukQr
	q6olTcsaM34TFX4dSD53B+1FhnkBia40zqlc01ITjLP7DhhvOmIxxrknqyWHxx1r
	4aF6OGAZFUnj1thrPYyRHObQims5Z9X69wsN54+en5PNNWVobLaLSTMRjQo4vwf7
	kMA+ITCepPcaJQtnVwZBb+t4uGvt1jtEDfhK2c2GJSQnK498f0VzeXadReC/Cbvn
	WvdRo1LJWxngFjWxDsTbAZJcm2jCI2co/9PSUcFoKqPH8v0bWJg3QeFEa3LEjTaX
	030YBgLpwUKsVqKp4Am4qKodUBIvoCY2n2w==
X-ME-Sender: <xms:HTkKaQubXeJ-jzlX7DguUr3i-VJhhDXNqmBwAwUzZllVAgB-TjnObw>
    <xme:HTkKaWxVONc8XlVYSToCVDDry0J_By0kYzBfsR6RHdSRtvRkh9PCbiqrNgjwapZfB
    rKMDenjUBKdB4FPfx7SNU-sAU1TEVP5j0d39Zm3Pq9GhpfxW7UX>
X-ME-Received: <xmr:HTkKaTA2wQ2-ip-O_7ggUuLZN0Ad-UOpzVIbVRVUl9KglsGoCpOL_RvknUdOwYkWt012KpMDkBt5rzq0bQVHm0dj19k67bD5YX7I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:HTkKaUdRY5WDyQ4JZD8ii0ZVDpeqFDZCOuG_MHzWJ2SvNpI4dm2eyw>
    <xmx:HTkKadnby2N38dw8VejHKy9j_BNRKJbhVbPFS0y2ax9kNP0JmRKqLA>
    <xmx:HTkKabGVK346oBaSBPgPv_qQkMcs5zwXWMzIkbv8BwxrXJAcmvhnKQ>
    <xmx:HTkKaV6ee0kvSJy30O9x7Ozz7N8u5AieQvmQLecCevfTXAJJtxGstQ>
    <xmx:HjkKaTqbZP1JeqCh_nvX0y3MmzXABCB1hb-OtanXLO_fTF0IpIEEScZe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Nov 2025 12:34:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,  git@vger.kernel.org,
  Phillip Wood <phillip.wood@dunelm.org.uk>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/5] parseopt: fix :(optional) at command line to only
 ignore missing files
In-Reply-To: <xmqq1pmdr9qu.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	04 Nov 2025 09:24:57 -0800")
References: <cover.1762100242.git.ben.knoble+github@gmail.com>
	<9ec696eaac647aa01466b101129da2b12ef5dbd5.1762100242.git.ben.knoble+github@gmail.com>
	<ec8d1764-649d-4edf-b0ae-a19ead5f6f9a@gmail.com>
	<xmqq1pmdr9qu.fsf@gitster.g>
Date: Tue, 04 Nov 2025 09:34:20 -0800
Message-ID: <xmqqwm45puqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> Hi Ben
>>
>> These all look good to me though I agree with Junio's comments on patch 
>> 3. It would be nice to get at least the fist patch merged in time for 
>> 2.52.0.
>
> Yup, let me do exactly that ;-)
>
> Thanks, both.

Let me have this on top of Ben's 5-patch series.

----- >8 -----
Subject: [PATCH] parseopt: remove unreachable code

At this point in the code after running skip_prefix() on the
variable and receiving the result in the same variable, the contents
of the variable can never be NULL.  The function either (1) updates
the variable to point at a later part of the string it originally
pointed at, or (2) leaves it intact if the string does not have the
prefix.  (1) will never make the variable NULL, and (2) cannot be
the source of NULL, because the variable cannot be NULL before
calling skip_prefix(), which would die immediately by dereferencing
the NULL pointer in that case.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 parse-options.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 27c1e75d53..97a55300e8 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -223,8 +223,6 @@ static enum parse_opt_result do_get_value(struct parse_opt_ctx_t *p,
 			return 0;
 
 		is_optional = skip_prefix(value, ":(optional)", &value);
-		if (!value)
-			is_optional = false;
 		value = fix_filename(p->prefix, value);
 		if (is_optional && is_missing_file(value)) {
 			free((char *)value);
-- 
2.52.0-rc0-28-g4cf919bd7b

