Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2D3644CA
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773249227; cv=none; b=JDhmfbs53n9GeD1M8Net93ISzY24dRekVgfmrmMVSgu56BYECto0J1cl/pbcVFWh47FRL3/3wJfrmT1es/yTYIZGRQ4SKDrKrf4MRU9XzNTKHQ5kKcDbcIx0TYZLdP7pfwvc1PNzmJvluDMnHqTcKNuk9EONhJESDQxLIsgBfoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773249227; c=relaxed/simple;
	bh=KTokZpcF0Jz/I3+yi00/WRzd4zKK0XLFGSrBLSxtQpI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bHSJJYQG1M5D+gmmmWcz6XfTVVzoWburxLvnLjzyHj6Xbpt2EaDEZrY/D9qlHiwDDtjSwJYAAXGwIIwfoXCWsY5wf7zLbj+q74WcMfOZLPUc4nj3e5uG+Zx8fHnwwUTLc9nq4iwKrjpTBfn8SpZJJEWf2l1RCf11oyxxrkRnSOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=feuVlxnQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2IQQAIz; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="feuVlxnQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2IQQAIz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07A8D14000F7;
	Wed, 11 Mar 2026 13:13:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 13:13:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773249226; x=1773335626; bh=+OeAAkeevG
	dNKTKqBfn7+dT8Y6u78SMm8jvK+AIehZc=; b=feuVlxnQwfqJwUAJVIp261RwMf
	VZZ2qv2SgrBUdrJ1HbZxz4qbXJ50SgiF3wU8p/OptuhcYXJEpcqy4pmu4O7eMrLI
	E9aAcLkRWRd0BFiuyAecbRoF+iXoubpp2dJbXyLgQdkGLxuQAoML4uq31RS0X+EK
	+//WlHqbcr78nWaRZ+mG7GO3HW84Xql3Ezz7wCbxVfAGg7eAyJ5Sv8MCpsaFE7AG
	tFTutSeftANKknrbvUntDgyIcD7Tw2x9KPTH3138G9lQm0zRNQYESmifMgQLmcGY
	zLbN6PunWW7SCHu4WYUYnxS+2plMxYE4kEMjc9gyq9183VxCCYtkfhERdjhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773249226; x=1773335626; bh=+OeAAkeevGdNKTKqBfn7+dT8Y6u78SMm8jv
	K+AIehZc=; b=I2IQQAIzsdwO+HQErWOMxdjyT8LU/qvgjiBRTLq/PO5ZSKzHZDy
	UAX58Im4009OSxD2Sg3aDXy+q5hE76LTyudOkFN94uxjZStnJ0VLwrRI6EN0lbgf
	IaGmJinqB7XXHtRk+BOggVBpwy9xhlCtjFn0JxPEKmFTpJY6VVSSk10HCjMzWSLa
	W8D6oGxrLRVotyYs42L4SeeqUqJQ6Jr3apKdbHp5NPPxTCyGCpFCNP3YLNEqG33F
	/Dbr2JCQCX653wzJiVv143M64YjN2MG/70aq+468M2GvqLHj/jp6xkoajuem3hzZ
	h3NsKEiAo5pNf32SqNwQNnrQxYmFQnUAsTw==
X-ME-Sender: <xms:yaKxaaUVPN4OG60qB2OGdBpo86ePLGlbA9eCqCiomEQa2_ktg2cMgQ>
    <xme:yaKxaddbUMBuyXvx3C0g-jB_fgS42mVPGRbH4_e3P1SKolr_YC1OGNaMQ7lZZKcPc
    dumCNfkP8YOMxPP1ZbDRX_lIPSuDa3IlD8X81nbIdS8zwq5eBx7>
X-ME-Received: <xmr:yaKxaWvXANSuYP_mKNuhCzn0aLE55SQNhIYfBv-KVQmLZFUE6IK01t_jiNlCzu0rQpvvjIMzvWvj1tsNGWap1JX6oYcDuCULWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeeggeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehmrhhoihhkseguvghlrgihvggurdhsphgrtggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:yaKxac8EK-z--_61mRyVcZIewnmx3cUK7ULSpDKSB1KYt-u637HLlw>
    <xmx:yaKxaR3DjFpxLzHnhy2IblLB2sjL7Vm6UEaPuWyt9rEoauXyTwG1XQ>
    <xmx:yaKxaRB78w1i2I6P39oCgRLjJXTJSNZr0K63pzV-m4CVKM4liCJqjQ>
    <xmx:yaKxadcNNVr4YaNclTiwcFw0g9shJ7ow4MUfmJWmjRPDgD51JggKiA>
    <xmx:yqKxaWB6tK8Q_1itfBhEtGLxTxbXSPQgI2uv77mdAYKlq1iyrZHNbhtA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 13:13:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Mirko Faina <mroik@delayed.space>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v7 4/5] format-patch: add commitListFormat config
In-Reply-To: <3191559b-d79a-4d50-8364-50581df24ebc@gmail.com> (Phillip Wood's
	message of "Wed, 11 Mar 2026 10:38:09 +0000")
References: <cover.1772837832.git.mroik@delayed.space>
	<cover.1772839973.git.mroik@delayed.space>
	<c522f47e5b574c0c889c40284c71c36158b6bb6e.1772839973.git.mroik@delayed.space>
	<6b160915-1cdf-48b5-abe4-3efd0771598e@gmail.com>
	<xmqqikb3ws3e.fsf@gitster.g> <abCLFS3QP7rJHueq@exploit>
	<3191559b-d79a-4d50-8364-50581df24ebc@gmail.com>
Date: Wed, 11 Mar 2026 10:13:43 -0700
Message-ID: <xmqqeclqqofs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> Perhaps "format.commitlistformat = false" should disable the modern
>>> format and fall back to "shortlog", setting it to true (including
>>> the use of "valueless true" syntax) should enable it and use the
>>> modern default "log:[%c/%t] %s" format, and non-bool text should be
>>> used as a custom specification ("shortlog", or "log:<format>")?
>>>
>>> I.e.
>>>
>>> 	switch (git_parse_maybe_bool_text(value)) {
>>>          case 0: /* false */
>>> 		fmt_cover_letter_commit_list = "shortlog";
>>> 		break;
>>> 	case 1: /* true - use the modern default format */
>>> 		fmt_cover_letter_commit_list = "log:[%c/%t] %s";
>>> 		break;		
>>> 	default:
>>> 		fmt_cover_letter_commit_list = value;
>>> 		break;
>>> 	}
>>>
>>> Hmm?
>> 
>> Mmh, what if instead we defined a prefix format just like shortlog?
>> Maybe call it something like "numbered" or something similar (not too
>> good with coming up with names).
>> 
>> I dislike the idea of having an option be multiple types. Should bool or
>> string, not both.
>
> I don't mind either way if we can come up with some sensible names 
> instead of "true" and "false".

I do not mind a pair of synonym if you insist, but I disagree with
your assessment on true and false being not sensible.  When you view
the feature as "use the modern commit list format" (specified either
with a command line option, or a configuration variable), "yes, I do
want to use that modern one, not the historical shortlog format" and
"no, don't bother. I like the old one just fine" are both natural
answers to the question "do you want to use the modern one?".  Of
course, "let's use the modern one, and as it lets me give a custom
format string, please use this one" would be how the user feeds a
value that is not boolean to the feature.

So in short, I view this very similar to other "extended bool" (or
"bool or even more customization") option/configuration, and "true"
and "false", while they may not be so descriptive, are also sensible
choices in that context.

