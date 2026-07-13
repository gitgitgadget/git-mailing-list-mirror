Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AF53290D0
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960225; cv=none; b=Tx1Tbl1cCv9IT1wUdmU1eKZJu8T1SFieQ2JRi0tXUNWwEN5HrWxVTb4TRwWS6BtEEvsolGxrfm1Z/v2+Cvt8BKwfxmwQmzDms/GH/ydKUgtcmT/oYMSsOMPBxh0a/f3bzRznB4jSAC5Y/BbVZoaCHhjP8CUrQd5SuquoVvw8fLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960225; c=relaxed/simple;
	bh=GAaW9aVaIn6iKBb+5EC17adC27/uKxg5S5D5SPHLpw0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7dDtHI3LOOGzBh4TQJEzE35upqlJ6ZomLQhJtuFHx6CQbqW0pIbaBkCcsTjoTbhNTZeIZZjNsfKnOizBpPZF45sEmhTs+eM5w4/zWqYDrNH8BcMExQBU9wySX6gK8N7DYu6ysvnl6NkpXMOOeUVBHKcg9r9fLmV3lGHnJiNKBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PUacfmJo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xez6GKm7; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PUacfmJo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xez6GKm7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3C38D1400155;
	Mon, 13 Jul 2026 12:30:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 13 Jul 2026 12:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783960223; x=1784046623; bh=3ScYj7hEsf
	vvEPZPEO6s3WIHR4oMO2s5UWdh3l+gKyM=; b=PUacfmJofyCxU8NxA4qYQgLVQK
	Ay8NMyL+H891IrQqaEvoHjtPUTtQ1d7ae0mHfukPlLctc8Ip023BApzlcMf1ST/4
	9qHfLzGBryVbKp6axneE1WJjoaf9D1N9EjcGUl2Q2zeXNx6OR/jIC0icuZdAgOJ6
	wwnnTRsQ/fxu+FivI1tyguX01FPbpQ1G44y/zMffO2Ah4Lqdj5Bge5V2Ed6Q/2XE
	jemGY19S3aRiT8AFOjeEDmFXqb465auqD5fiZhY0Q58UT0Gf1Y9WUz2tloCF4h5c
	1wcopwMKjecZiJ+yu3ZoHkL7RizHqQG2rf9XLl7F0KFVoP41v/tbXs9rSEng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783960223; x=1784046623; bh=3ScYj7hEsfvvEPZPEO6s3WIHR4oMO2s5UWd
	h3l+gKyM=; b=Xez6GKm7qNeP//9ZAWhtQum93IxndhSw/+EsQYhDTZhjdL3fZik
	hE3VZ+NL/tKHxwLm5x/t/JA3wac6iEQq6yOmnF8YtQyGkhQcbVzOU+DGgIqqM024
	kpGjt6Jz4hqbOD7OmUSTKGchiOt7ftpp6fBhuQpGvZ9hDKyTR3Xr4PsTlE5nyMm5
	EGLE8ujq0e5bb162iol14j9OfwC/OGIq1C3vD1XSCk6yFRwHMgd3OLz7KeX1RH0Q
	buQ8c/3x3GFYv4gjhRDnC/onS6xb4pVGD5gG7TXrYDPKTrsVIi5/STgDkcEvaQ+i
	V2swQAC+6lpjZdCgEkpFJfvp8F7B5cSALfg==
X-ME-Sender: <xms:nxJValSwtIGeGSQU878vCDulK2aNfRpyQnaDTXKCToMGskdNLTxSbg>
    <xme:nxJVamODnKeBDNZP8pYvhoEVCBxeHod0p-yamXc8ibunP634poTTN9yHbgOre8sx3
    fystWU_E826Zv2Bxi7TSZrpjkep_xG2R0WdNAZoZjpKAsijkbW1pA>
X-ME-Received: <xmr:nxJVaoPrcClU60giSJCF5u5ATCNXO3m5uUwCH0CD6TGmmnejqiRxjOmGuI52dvrYEx3MX1O0Fcmw_EVO8kuB4TT9ZNvMjzbSY5l_BNk>
X-ME-Proxy-Cause: dmFkZTEsLG7eN+0eLA6y+b8/KlKZxBUwS5f23sBf8kcLrQguH058U/YNmibI5NPNVqVNKK
    GE2f6YXulFwQr1aYEMlVrINBuPS170fnGim0viamx9HtHo005NLZ1B33SuDm+L2tMIiOFx
    EXcwbBcKeUAzR6kPakZ9a+6qOlnxIH7GsSDZcQTHj61IH/9SeUExvuqssNsoYUWtvW+GcF
    XC2z1nPRzKCq6VpVkvrqoix9beXODBgmUVsAgbzsE2+se/3Y0wekPlL4xEZpVASRWFTY8I
    KQHYTbLWL+jwM1eb+CqwNJUYzKqE5D+A5dsVHmwWppzFJ2L35aHeK9Qs+aS0HZKyV7HpS/
    2aIAqJCyp4LIEZyq6OAszI/pJg2hxv95rxGLD9Q+nfaGIkGQ+Tx4HIgB4fMq7+7W+Ymba+
    swzf28/D3DXPXGZGtHR5a/ZYdbiMK753fy7vkoMT2/8CGNFtGq0i3OaWEfmHgMmXhRqzQ0
    kn2/KCmp5T2VN6njpwQ3hw/jo1iu4eP9juq9j4ef0zed5rkAstxM9yZcSeI/cFa9b8t9RN
    JZmd2Rt+zjkgatRaczLxVCOx/b2Qiaxv/UcsRe33DUH61C9V4QfhQcVS0F8/vFzY5qwn8M
    waauEwa9lsnJuygD5KHvGMw36jBe6POgbE1d1qLZQ+b76Z5liN868IK4LDDQ
X-ME-Proxy: <xmx:nxJVamt8Oriaiqy9tbTtrRNqnmoIjFwm7GdzHomsBDq2NwOtTRL2Fw>
    <xmx:nxJVaiWXtONv6M5JbYXHdTkYAFMa5aU7Fh0W5SQfZgIPuqrsWgKJBg>
    <xmx:nxJVausZXaorPLjDH5FgZW3gt4uhLOTRBIXZkijINTgpDqmn-5nUCw>
    <xmx:nxJVauU0ZEtEy_wZic7eIhEPSZKdJmGyGjPkYgA4YP8hDqvley37xQ>
    <xmx:nxJVas3BytR39nKZwCght4JWvaPaRaL2KxJ47siu1V6phSW8hZCVmrTi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 12:30:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] t1100: modernize test style
In-Reply-To: <20260713140142.27898-2-diy2903@gmail.com> (Shlok Kulshreshtha's
	message of "Mon, 13 Jul 2026 19:31:40 +0530")
References: <20260713140142.27898-1-diy2903@gmail.com>
	<20260713140142.27898-2-diy2903@gmail.com>
Date: Mon, 13 Jul 2026 09:30:21 -0700
Message-ID: <xmqqpl0qyhr6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shlok Kulshreshtha <diy2903@gmail.com> writes:

> The tests in this script use the old style in which the test title and
> body are passed as separate backslash-continued arguments, with bodies
> indented using spaces:
>
>     test_expect_success \
>         'title' \
>         'body'
>
> Convert them to the modern style in which the body is a single-quoted
> block on its own lines, indented with a tab:
>
>     test_expect_success 'title' '
>         body
>     '
>
> This is a style-only change; no test logic is modified.

Cleanly done.  Running "git show -w" on this patch clearly
demonstrates that no code has changed.

Thanks.
