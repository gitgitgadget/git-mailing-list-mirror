Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0235165F1A
	for <git@vger.kernel.org>; Mon, 11 May 2026 02:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778467100; cv=none; b=cwtuZnCAXrs+LmBu6nDg1wVxQk8AYOJXkQpI3MXUkmPcOgaNfx0y/wH0sS8Y1j+U6KRvYbb4ryTIPRtHHKzdNU50dnYxGoh6cAlFGK6URaMgejJTxPa5x3xRxSbNYtDU89xdYx+HrLwDfby+Ly0l0UfL0LlZImIHj/Q8/Pr0u6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778467100; c=relaxed/simple;
	bh=33yFI/zUvicTGMZNrsZOtLs/S1grVfcILTPBjnCXJ/M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RwVlTwMcIEnniG4yX1dFqDDdunJb2PCT12WTQcbbzqerku+DND2AJ7pgxXg9DrTaqTcX08SVUq5DQKtNskVuERjCRbbbWiOfxo3A74k4xq/hUjOmyf1GJYaH56QxWgg0GTv3+t5iIUEUiGaKYM4Wa/J5VP+JsW5oUdoMx+nsp7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rdL4OO08; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QfklHEax; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rdL4OO08";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QfklHEax"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A1E337A00A3;
	Sun, 10 May 2026 22:38:17 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sun, 10 May 2026 22:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1778467097; x=1778553497; bh=gKcNRDGKiq
	nz5Vex+CJdC2kyGHwhe84wTbRyrmKdg8o=; b=rdL4OO08bXIR7VISho+wFID7hH
	Ss2JcsZK1ThQALbuER5jX593l9KIk5kKW1sbYI1IcbrOMAA+VGBczr7TMRNk49NC
	8YcXAeCQE52KMNGB61lKb8aa5Th2SjRORlJedn7R4npDFDXViID8V7gvTivtbzWL
	O6FPZcYgASYZTmOhjD8KUXY9UeD+v2tZxgMmlzoFDJt7is4WcSA51oUpWk6GhyKS
	Gk0e7WKuuHiFLi8ZhYdEeyFFd+bU6j6+PAw7wpSZvZXQ63iCCpQqTiICCgYAwLxo
	dy2fsSvbyEBB1wBA8CW7CpD69wcze/9v9BxsZQ6SO3WSrz4sjDA1s/HNuQ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778467097; x=1778553497; bh=gKcNRDGKiqnz5Vex+CJdC2kyGHwhe84wTbR
	yrmKdg8o=; b=QfklHEaxDVhABzKaC61mp5jH5p1Ss33oXWIeNJJZ2x/EzzYrw2+
	ygWVpN3hcaq3aplhAKw/bsuPj1vj77HIL2dRl/z7Z+YFV242mZ0T5X03nr2+QP9E
	TPgtLjDr1qseK672CgCk48xCURu+Q0NZLsaqTuPZP0m7MWBk8OLceulyytoOKTkc
	2IwiR4etknl5gTFvDo0AxJJZpDFONCyFRSR7F76e4blKfWxIPaaJ69sJeRZULuQz
	JZ0c4cKoFVyX0k5Nr878xjR6+O86caYqrP98ODcMjxf1AKwQeX4HpS948k+pAY5z
	vptbiV9jUI+dn0W+HRUwujVclWfgu/QlWEQ==
X-ME-Sender: <xms:GUEBalPYrbUpEs-6gbJLupIHrgpbkf5wWGZ-kgYHbLVaE9dAQMtJIQ>
    <xme:GUEBajrmiWXVun6yTP88sCKBvnnkr8VlIoK9gOSZzZlrYNGOqthG5oL3F6UEX4dGv
    OEiDCOVNj_5KEQkYEOZGPY8xXibSJ6nGOMNpBBNeXtEVZx2gGIA00s>
X-ME-Received: <xmr:GUEBagskfNpwvtAdHHIevRYY7SnL026MojfyWxCAl_XL01jXbOFuec1aDuN1D7DCOe-SnrKWfhPhNiqkrB1qKOjq-gGstERKww>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudejkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhhtrghnmhihsehgohho
    ghhlvgdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhu
    shhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopegrlhgrnhessghrrghith
    hhfigrihhtvgdruggvvh
X-ME-Proxy: <xmx:GUEBaq0Sf69ouHawHKrKBn1mStNP-ANbnrzNOu7IGI8AvqG22JEbOg>
    <xmx:GUEBajHZYPpLSQpzTeAowgWhcBcYZ73Go_U2NYj7pbsKcPBZzWohyw>
    <xmx:GUEBatvoSum6n_zXIbyxH6P1ifciLbDc4zKjXZifb8cyR1kegISVcQ>
    <xmx:GUEBaur3b_hI0UUmhJoK2DyKTPWWInB2xbk2AMxmWAoUodwrZfbkrA>
    <xmx:GUEBahnbSlEWAmwpvW8DJLuvLOOV7PERS5mV1lRMsWorld8iA4b0KmUX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 10 May 2026 22:38:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Alan Braithwaite via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  christian.couder@gmail.com,
  jonathantanmy@google.com,  me@ttaylorr.com,  Jeff King <peff@peff.net>,
  "brian m. carlson" <sandals@crustytoothpaste.net>,  Alan Braithwaite
 <alan@braithwaite.dev>
Subject: Re: [PATCH v6] clone: add clone.<url>.defaultObjectFilter config
In-Reply-To: <abe1l8ONmFIhzaxi@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Mar 2026 08:47:35 +0100")
References: <pull.2058.v5.git.1772847236966.gitgitgadget@gmail.com>
	<pull.2058.v6.git.1773553022381.gitgitgadget@gmail.com>
	<abe1l8ONmFIhzaxi@pks.im>
Date: Mon, 11 May 2026 11:38:15 +0900
Message-ID: <xmqq8q9qvffs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sun, Mar 15, 2026 at 05:37:02AM +0000, Alan Braithwaite via GitGitGadget wrote:
>>  1:  fa1ea69bdb ! 1:  480453b2e7 clone: add clone.<url>.defaultObjectFilter config
>>      @@ t/t5616-partial-clone.sh: test_expect_success 'after fetching descendants of non
>>       +test_expect_success 'setup for clone.defaultObjectFilter tests' '
>>       +	git init default-filter-src &&
>>       +	echo "small" >default-filter-src/small.txt &&
>>      -+	dd if=/dev/zero of=default-filter-src/large.bin bs=1024 count=100 2>/dev/null &&
>>       +	git -C default-filter-src add . &&
>>       +	git -C default-filter-src commit -m "initial" &&
>>       +
>
> As Junio already pointed out, this change here is a bit puzzling. Not
> that I think it's a problem, but one wonders why this existed in the
> first place if it seemed to not be necessary.
>> ...
>> +	normalized_url = url_normalize(url, &config.url);
>> +	if (!normalized_url) {
>> +		urlmatch_config_release(&config);
>> +		return NULL;
>> +	}
>
> We haven't allocated anything, right? So in theory, we should be able to
> return early without calling `urlmatch_config_release()`. This could be
> stressed further by moving the error path earlier, so that it's the
> first thing we do in the function.


We haven't heard any response to these points raised in the message
I am responding to.  Should I still keep the patch in my tree,
hoping that a responses may come some day?  I am tempted to discard
the topic as it has been quite a while since we last looked at it.

Thanks.
