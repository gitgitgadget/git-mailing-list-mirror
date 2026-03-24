Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491B2F0C48
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379008; cv=none; b=IZSMv0Xm/24PuunagMVYnl81QZz2vj5Qq82RsOdDUOExPd2uJeUKySTssHlM7UBTW1jncYpfcI9kSILqdshjeJ5+89XvqPvNik41XusmaCtostLZHBXvdLAsCExP6pPb+TARJQptd5lJXfRn7YUyjbon9votJL4wfv4YC0kR9Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379008; c=relaxed/simple;
	bh=60PJMgjCvj1RS+9c1kwta2+aeANG4QJ0CxHmPziGGlE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2jJHwbnWZkFZ9xmkKBzA7fP3dm1KLkP06nh6VEcD8Wbg1+FQUywVztPKCdjdOeLqA4b2oYdQUVftO8UkZgDeY479oxgOEwoXHzA3BEnZ79qhO9cksH4v2Hujm4IrWHmg7uDRRaTVMh+eSKFDI88DJ/wSNgd7gouE7AjVkRUE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LoP/HmkA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GcEFy8HG; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LoP/HmkA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GcEFy8HG"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 80CAAEC01CA;
	Tue, 24 Mar 2026 15:03:26 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 15:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774379006;
	 x=1774465406; bh=BEG6EtF60463sE+QnuoJZitOPTTvQNh9TTxTN4vu+50=; b=
	LoP/HmkAgeILT7wMu0xYBz9yGsTrU+7BAVm+8me9UhxMDplfCYRcwup+WBQqS1um
	ZUh/DMy+hYXNvRMCEgLh3DdpzUdoT1uSl7/osU4GeQ8NOhQEOURp96dn+m+CQyg5
	Cq5hZmGj+lR3c4Gp/Vhzt76SRLChd71BTE5Q1F/TR39epKscV903InlDqhBZ9Q6D
	SFiJuV2XXjk2UCwbU9Bg+zCbBdXCbi9MKRG4FRmizez3qn91TomWXmxZCNaxOXuw
	cQVaQZlHhER3A4SPlcNrBu4z+zusymKwxobgSky1B8YOsCyqIdxzNI6BvIlMQAdb
	zxOnJQ1OTQyT3liNf7/Ppw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774379006; x=
	1774465406; bh=BEG6EtF60463sE+QnuoJZitOPTTvQNh9TTxTN4vu+50=; b=G
	cEFy8HG21uSYQrOLLiwxTL0kxMsGOUuCquE7fot2l2xhQqv5WNb21oCwlSTWPNBh
	sbyv896ZQn9g9hcVE+tOYSbGkg09NvqWgxFTvtHdCeRk0yijmNbesQP+9RhEoMRl
	t9Gxb3RD1bW5QQ90hriI8fYZJh4IvQAL4NdBGDjqiJxF8q4qiIpMenQ9UTIvlvry
	TFJCwEId+8pveUdkZP5eFwi12bxD3Q9djn8BxLX2qCmppObs8HTZFkbzeU+y0oj7
	q+dMEqP+tPLX681nJJRnWvPUSg3XAqoKpxRH+0KwOVP8v8hsECQWpqQ48azLj4eP
	JkQE9bh9mo8odjJf58X2A==
X-ME-Sender: <xms:_t_CaS_uZaAIBpz9gllSu7JF9TN1Ld59cb9RsqjbKdUWRaqcmosDIQ>
    <xme:_t_CaaKbiuYtC3_cqtrmhVAMOrFGNX8GKg7ADMhm9b7GYr5PMrT2BiwaKTzobyI5y
    OhpNK95cdLRxzs_Y9uU56lOoLUkWFHHUqX3PLzSBU8r4Dm59K3ubDE>
X-ME-Received: <xmr:_t_CaVbYrdr7zqKzYGS9dN1bu-ucVANSFsCcEhSZVl64m7QDIVM2oi_8TMIz1FYZB3Lc9ittflTntKgYbOxaJqb4NPlIU1Fhaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghord
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:_t_CaULkdDhu9qI8ZMIlMUQ0eTFK2dwbHokafDIY3Bcf600YsaYV8w>
    <xmx:_t_CabD3ESIXpZ80kuhR12Ku9WZ65g8UBazGN71OW1yQe6Mg13N-2g>
    <xmx:_t_CaRoXAKd5AcEDsAqSsTf5xrYHI5sep0Daq_MJ3AFxysTBhe0PYg>
    <xmx:_t_Caeg7lnVIpMSamwpYfnz4u_-ay-dtn8LkrXhXTkSAXVYrUM1ClQ>
    <xmx:_t_CaU0Pk5bHgyyjWChghaL3dSE9b0f4IQdLf0OLQ8BQoz0ngUVFPn8R>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 15:03:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t7450: make test "set -e" clean
In-Reply-To: <CAPig+cQPD3vAxbRAJsqyd5=x2xCkTHj0Z6Gt2t+GiGjXDYei0Q@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 24 Mar 2026 14:38:35 -0400")
References: <20260324-b4-pks-t4014-fix-test-execution-v1-1-ac83c1bcc828@pks.im>
	<acKqvI0EhaORjoD7@exploit> <xmqq5x6l2q5y.fsf@gitster.g>
	<acKx6yBi-BWUVJcv@exploit> <xmqqo6kd18sr.fsf@gitster.g>
	<xmqqcy0t178a.fsf_-_@gitster.g> <xmqqbjgdyt6l.fsf_-_@gitster.g>
	<CAPig+cQPD3vAxbRAJsqyd5=x2xCkTHj0Z6Gt2t+GiGjXDYei0Q@mail.gmail.com>
Date: Tue, 24 Mar 2026 12:03:24 -0700
Message-ID: <xmqq7br1yrr7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Mar 24, 2026 at 2:32 PM Junio C Hamano <gitster@pobox.com> wrote:
>> In order to catch mistakes like misspelling "test_expect_success",
>> we would like to eventually be able to run our test suite with the
>> "-e" option on.
>>
>> Often we write "A && test_expect_success ..." and want it to mean
>> "If and only if A holds true, this needs to be tested", but under
>> "set -e", this will cause failure when A does not hold true.  We
>> need to write "!A || test_expect_success ..." if we want to run the
>> test conditionally.
>>
>> Or write it properly with if/then/fi, perhaps like:
>>
>>         if ! A
>>         then
>>                 test_expect_success ...
>>         fi
>>
>> Make sure we do not fail unnecessarily under "set -e".
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> diff --git i/t/t7450-bad-git-dotfiles.sh w/t/t7450-bad-git-dotfiles.sh
>> @@ -220,7 +220,7 @@ check_dotx_symlink () {
>> -       test -n "$refuse_index" &&
>> +       test -z "$refuse_index" ||
>>         test_expect_success "refuse to load symlinked $name into index ($type)" '
>>                 test_must_fail \
>>                         git -C $dir \
>
> I suppose this is the absolute minimum change to make this work, but
> typically we would handle this sort of case by defining a PREREQ,
> wouldn't we? Using a PREREQ would also set a better example for those
> new to the codebase.

In some situations, maybe, but I do not think this one is a good fit
for a prerequisite, whose typical pattern is "let's see what we have
in the executing platform environment just once, and act accordingly".

This is a "the outside helper function is repeatedly called, and the
caller may or may not call it with an option, depending on which
this extra test may or may not make sense to run, so run this one
conditionally".



