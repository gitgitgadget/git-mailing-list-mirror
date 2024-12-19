Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952091DC98A
	for <git@vger.kernel.org>; Thu, 19 Dec 2024 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734645607; cv=none; b=WXeuFdQ226zDM21KYPUaSABhdhvm5QeQ3uhUB0yDzsLkUd7W1Lf8lYlaHOzzJfGGQQewqiyDxAgD5fbM30kjhA/7/AKErqans1GXY1k70mtj7mmpRfpXY8UY5v9asIHmkQFZKxpaZZIvNyEYXEDk01UjmiK6YQSwVTVvM1w7HRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734645607; c=relaxed/simple;
	bh=tmb3wFvwt+5uQfDs5YtjRzwtd4DiUAuVO1ql12sBPn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U9J3ATQYspwx+8Ta+H+C+igUsTdSZeQB23WF31MyYzEXmFYbCBTVXq2baXcpm9me+/5RS5AIXxm/Nd3S4qHeke8g2GD5tf+LciYVqMdaFHq5Y1FMnHuLbJnmIbFZiNYAm2uH0i54hoT+5xnYJk4m5DGDSHZy0n+7eaqpNENWH/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a5RrDMa8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dRaxz/Kw; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a5RrDMa8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dRaxz/Kw"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F7C4254018C;
	Thu, 19 Dec 2024 17:00:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 19 Dec 2024 17:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1734645603;
	 x=1734732003; bh=BbyS+pfw2xzozMjoL5Qh+HDXoqtMJn3y+XGLFFXwiT8=; b=
	a5RrDMa87Cfn9ksZm1l4Va2DeeHLA6fJhhqVGp/vqzwZMRxQSAN45tQ0blGyDFxY
	FMNyx5LFYUkAp971dzIJYOnxqUfohv37EuBvvvE311t3bRPiqmSYN51CJ3/D2rN0
	DXc+NHB3IIlJddDBlOJ1qN+8K6gHy0b16er8b/ItzcMQe3dCVzz1c13C8TZ8D+16
	hcmsTGSeHBrsGfVrd4IUp7s/mdDHv+hIP9j3RhFkz6M8FWkb3hEKOh6kLj3+6/OO
	wJKo34fZq8RMB11d+1yFb0dtwZsqk5ZAbLsn8EgiOacm+R0lCNCmYKXvSJd8ABGJ
	bo9+fxe2MYryWoR8fUH1aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734645603; x=
	1734732003; bh=BbyS+pfw2xzozMjoL5Qh+HDXoqtMJn3y+XGLFFXwiT8=; b=d
	Raxz/KwYU6/kFOj3U31mDonUhhvPWufaFGtJszoQ2jRaDohu+c9MqdFAl2wAWbKE
	C9jZG/PMPmI/kb2I20Qk8TUPDfxyfI9S7ySecLZajOLAfcvFoW3W1lBuDLmHxEmA
	NNGGqw92SMEYavuOA/+0ni7rUuyoQRr2E0DxIOH695PGwsM6H/LP2+EOnqXxltdG
	91W8h40/HsiKB+rymUeOue6MFsWFH6Nlgq2m76rLq3LckitnhHtyIjr4QQw7Wl05
	wnzS9PHhXp1caY6XCqdinxcik0XMjq8FczjJQu9Zk0qRFComFlzdm/kiyHJVOI6R
	P0aZiHm3nsQV5BotxCh5w==
X-ME-Sender: <xms:Y5dkZ9gF3qwJoWf-QAi3WzDihKPWC_4wD-moheEtTRelq9z5J4ns7A>
    <xme:Y5dkZyCp3g6Job1LCY5liNAIHKQl0IuX7n4EujWP0CeyDliqQ2-dNZFhuJq9Ue6eO
    L92MWoYun5sWZ22fw>
X-ME-Received: <xmr:Y5dkZ9EaoQE6JNiDQwIQ_iw95ULUKEpvVgxX4HTfdS09dy0cHwOPAi7Trfm0b5jK3b2ublcBjgfECT3v6pTM1g7VEN4P0eZAVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddttddgudehgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdej
    hffgkefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhpvggtthhrrg
    hlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesph
    gvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Y5dkZySdP6sYgLs1YHWnzmiePJ1WUqbbNiKqcpBI39XErkFg-OrX2Q>
    <xmx:Y5dkZ6wEuGKTUOtkDXue1LzVKyu3cQpajEkTY4YHbBbdapMKpyql6Q>
    <xmx:Y5dkZ44hA1QA42uO31zQ8IKIQ7ia_fOhDHZNnVSYglDzaHjDtruE2g>
    <xmx:Y5dkZ_xuABtqOCniFZGEEg0BLpTS5xCPZNu6JkdgGy8Pr1fk4OnhKQ>
    <xmx:Y5dkZxrFUbCuTrrOZjZ5V3s4yb7Oa4X1EaTMGjgstX8vjglGnNUr_dmf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Dec 2024 17:00:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH 2/2] GIT-VERSION-GEN: fix overriding
 GIT_BUILT_FROM_COMMIT and GIT_DATE
In-Reply-To: <CAO_smVhcai9reesTRSrd=hHz2Sa2T7Bs-U1NZ9KcCN5PNv6T5Q@mail.gmail.com>
	(Kyle Lippincott's message of "Thu, 19 Dec 2024 13:19:12 -0800")
References: <20241219-b4-pks-git-version-via-environment-v1-0-9393af058240@pks.im>
	<20241219-b4-pks-git-version-via-environment-v1-2-9393af058240@pks.im>
	<CAO_smVhcai9reesTRSrd=hHz2Sa2T7Bs-U1NZ9KcCN5PNv6T5Q@mail.gmail.com>
Date: Thu, 19 Dec 2024 13:59:59 -0800
Message-ID: <xmqqzfkrgwps.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Kyle Lippincott <spectral@google.com> writes:

> On Thu, Dec 19, 2024 at 7:55 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> Same as with the preceding commit, neither GIT_BUILT_FROM_COMMIT nor
>> GIT_DATE can be overridden via the environment. Especially the latter is
>> of importance given that we set it in our own "Documentation/doc-diff"
>> script.
>>
>> Make the values of both variables overridable.
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  GIT-VERSION-GEN | 14 +++++++++++---
>>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> Looks good, thanks for fixing this and for all the work done on the
> cleanups for the build system changes.

Thanks, all.
