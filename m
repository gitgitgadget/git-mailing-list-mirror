Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB4427FB21
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 22:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770935210; cv=none; b=FcuTbGDvM+YsCHyq6p+wNAlkHA0+jdvAY2Wl+W6zfme9DsxFMEFzNSOYLO4Yx7TdwLTbw8kWeVC2MU4ckSjdZPsxhHXy7GBntmyiv3nCQONEeyOEvRnA7PDOrA4eHh6H6SKzTHlFm9dS9cizNhbMADStoYOS5/eSpXfxxNhES5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770935210; c=relaxed/simple;
	bh=Od0bNW9SZWP1Z6mq5sZIcKJflwNABQIJCR+yO9Let8Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFtsrhWbzeusK6SxWXakWzgyhDnFrckNStDUk6EsCVlLsUM4lY9rJlT9Q++vd+3vdRww+1It1jx+nwTLP2t8Mp0ts7So38SKfZQaY1tS1Z8630rS0RwCFvCZqW+r++rSZoPSVn5jQ2JzvaXNKEvoJgZMzOzRtMsC/nt9xE+0KiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UcKx1HWY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=otv0L+wB; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UcKx1HWY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="otv0L+wB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 355A37A016A;
	Thu, 12 Feb 2026 17:26:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 12 Feb 2026 17:26:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770935208;
	 x=1771021608; bh=rotbUlXoAJ30W7Cu4Y/DEGvDj54Us2hYLsTt3yOlt4A=; b=
	UcKx1HWYPPYtJX6WSE+RGMwhO1qvVCGtIP2Agi0+9vQW3taWPghVCnXu4xkbEizy
	Rvf7/CzjWxBIW81O4alG83pSES2ny0m8YNus9H21PkmrM0Z9ImciYBsfyfjUc1EW
	5oAJoj7wv8mVOmYO1WTJ0Jl6Sd7LiIsyw4ozpHkQ17kWxEJqO76Vhiyi23bkS+vS
	WTsBmRpgp+AJBpLXXaG353gw0U1KE67cst84M6Ge58lfyT/Vekw02I1ufQ4IGjdS
	wfC3ltDmFtIwCpwRf8z4jn70U4wCuVeRI03IBfV1oF0R3EsfEmkCUPcz3n+UH3Nn
	tpzcOl9R8bbMK9iVyNPiTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770935208; x=
	1771021608; bh=rotbUlXoAJ30W7Cu4Y/DEGvDj54Us2hYLsTt3yOlt4A=; b=o
	tv0L+wB38qrUsf7WPpToAyNNKBEeJQPDFlu96hR13W6qVuy6DDN86DzoZeK4Im7G
	0xzGPcI+AijeWcboU97zQtbsvkBRRXVXBHM8pv/5wmiuboTcSOL25gAK8d5y3cSl
	lh2TNlKCU9Kp+jPS9snEz43qFtfxXEvBV6ac7B+wB7wKkbXU8riR8qiuksMP9FLX
	VHyJ+/h33f0SdOo3hAb62UPmSuGnTvWGJJdXiRYGqErJzI704bXMvetEdAS5qu83
	45FvjbYjUEJhycgFV8UHARYGXLD6DkYMUi8JsDZho+Gjo21IfD7KKiwqLOsFOGSD
	3dA3L88eJWCHnRlBbk0NQ==
X-ME-Sender: <xms:p1OOaRC5aO1Bwdfhz7b_Mza_L6bBxNF4Uc0CuMhzlDalVKYi57hfeg>
    <xme:p1OOaWjsyQmiNZcnKu4hxeFhdzl-60MDWoMqjbTG3TfJkER4khbrkV_iHSuupeRiT
    0w__5XSyUyhvYGiBrkzBtnq1GKzQawi5r2F9TlZwCNHFfTAg7iJOQ>
X-ME-Received: <xmr:p1OOaRkmKSMVWBRzIMjI2KeIxkA_wuNc2acX99IJ_xf5q4UOChSSTiDnOSnuwF2jB_gRGGb_x2BmZ42Sw-BaPG1ResKewlE-Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdeiheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:p1OOaaq865ZcyPr4xKTXtKpugDceoyLtgj_cWSGrY5I54FgKrFwRSQ>
    <xmx:p1OOaSFG2RMjieDAXKsMCU-1QvMVvd9fdLvxkB3mQo6pJUgMRWG4_Q>
    <xmx:p1OOaezPhjtl6trWLTpkOMVybrCrsqRHcZa4Qb13H1_JVYhdPnKJGw>
    <xmx:p1OOafqir1QyMqP0ZfU3JKtxj6C7Oil6SZd8rn070BE8cLmlfrYKPw>
    <xmx:qFOOaZGFthafRzTAGgE5XYWB9-dfPDJwQfhdr-lem9ZxeJSxbmMlZbsC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 17:26:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 2/4] builtin/history: check for merges before asking for
 user input
In-Reply-To: <CALnO6CCciWF_GOd3WqOVwUDLoPRABNgDWbSu7FTgP8KLWQKvgQ@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 12 Feb 2026 17:20:08 -0500")
References: <20260212-b4-pks-history-dry-run-v1-0-1ce03d631c1b@pks.im>
	<20260212-b4-pks-history-dry-run-v1-2-1ce03d631c1b@pks.im>
	<CALnO6CCciWF_GOd3WqOVwUDLoPRABNgDWbSu7FTgP8KLWQKvgQ@mail.gmail.com>
Date: Thu, 12 Feb 2026 14:26:46 -0800
Message-ID: <xmqq7bshmwd5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Thu, Feb 12, 2026 at 7:45 AM Patrick Steinhardt <ps@pks.im> wrote:
>>
>> The replay infrastructure is not yet capable of replaying merge commits.
>> Unfortunately, we only notice that we're about to replay merges after we
>> have already asked the user for input, so any commit message that the
>> user may have written will be discarded in that case.
>>
>> Fix this by checking whether the revwalk contains merge commits before
>> we ask for user input.
>
> Indeed, that would be irritating :)
>
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>>  builtin/history.c         | 40 ++++++++++++++++++++++++++++++++++++++++
>>  t/t3451-history-reword.sh |  2 +-
>>  2 files changed, 41 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/history.c b/builtin/history.c
>> index 1de51372ea..ca0cdb6a58 100644
>> --- a/builtin/history.c
>> +++ b/builtin/history.c
>> @@ -177,6 +177,42 @@ static int parse_ref_action(const struct option *opt, const char *value, int uns
>>         return 0;
>>  }
>>
>> +static int revwalk_contains_merges(struct repository *repo,
>> +                                  const struct strvec *revwalk_args)
>> +{
>> +       struct strvec args = STRVEC_INIT;
>> +       struct rev_info revs;
>> +       int ret;
>> +
>> +       for (size_t i = 0; i < revwalk_args->nr; i++)
>> +               strvec_push(&args, revwalk_args->v[i]);
>
> I'm surprised we don't have anything like Rust's Vec::append or
> Vec::extend_from_slice

strvec_pushv() is what you are looking for.
