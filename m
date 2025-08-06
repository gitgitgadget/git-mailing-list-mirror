Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569CA293C45
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754494897; cv=none; b=l9ijBQTuVdkzz1XfJPYttoyywc2kEYlu77f6boMsE/JnadfMBKVSfUZuyRq64MhZxLHjJAf5JWvdI0eJ+e89fAxXWjLG82o7ZDd/hFRstwggkaOzpBGaCckBaYC1KnfHte8hE+x7GANhonktwKDG+yIBaPY5f0EHPNrqec0oGFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754494897; c=relaxed/simple;
	bh=97mfJFN07JJVVhSu+FD+ilohFr6kIZilihqbjNfHwIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/8khrvW1I8DQudajc95Ba65xgWQezmBtoGYLLEWbgwnD2H13KwRdAOnDsB6mOdNyAFcrw3sGpZX4X1q5LGRiYA47Psfxtvr1V//VPm65otMai1A3zSJ3IL5gt6kRjalQA6AJkRhBknm+IJug+7UgH72qd1OpYuqHlkbDqdHIIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JFRVW6cY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JbEs1LOg; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFRVW6cY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JbEs1LOg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 646E81D00169;
	Wed,  6 Aug 2025 11:41:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 06 Aug 2025 11:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754494894; x=1754581294; bh=vY4iHTErkR
	e9ltBy3YUHsCtHWFeEXLLJzGjRrgRR/xU=; b=JFRVW6cYevKoDgiJUJCC4OPxQ8
	6fHBB8vccY9fuKgWjo0fIOiFQMumifouvrZezYtJ3SmdtGifXyRl7BvzL0f6uTZA
	k1l0DlFr9sG4DQ8upgIVf8Ln1Z+3mOc7hq9aj0GFnWThJyMeStBE+Ne+vZmWcB2T
	w7PS0fXs08FxtT+TDfKaEmabPdivm23FvV0X1f2Lf2F5wem0FMzq/A7GQQss4xRZ
	9wc60LF2toMJe8gLdIO0HaQ1uudu7noFI2sXyQvNG7hUWPxq5rQtJvUO355i57XF
	ubpmpYeiV16mf6MFqKFF6w5kp+FciuKQnvZ2Qjxdp1NncpPp6ZUGyPHxA4Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754494894; x=1754581294; bh=vY4iHTErkRe9ltBy3YUHsCtHWFeEXLLJzGj
	RrgRR/xU=; b=JbEs1LOgaCo/Zp22aiJafGUHHBaslc7Dqu5EHCJFNdYZiL/d7T+
	IfDs2XwXyYYWy3HP/UodZM8Os6JttTXasz9BXbluzZX1FDziEScLuGx6n4YsqUaI
	I2BJvMz1KC13Y2RyHlML9POZ9jn81PA6BvSipr8yDLIc/Hpnk5iB1Pj5hrURcnJ+
	bjD6rxoh/qmDjdr6a7CaxFRrWp1F4l9vvLrLSH7qjWwi1HhSuix5O4PMnG6WCknm
	7uSYOTibeJhfMHiE/s06eFKTx95l+B3CF3n7e7NbmT2gnPCLYsFRuSypQR0NFfL6
	j96jPmNMoxcjmBTfIzH7BD9NGqeNF9c6UfQ==
X-ME-Sender: <xms:rXeTaFfWJcDLf7_TAfAbvAyJB__ghxnxIJhGSQN0BdsNHYzrlXs2mA>
    <xme:rXeTaOv_9HsaL9BEJul6R1XwGMe6PYa_20VainxrmKDrw0y-nj_f2GslTh9RB3iSE
    Cmmrl3r7LaDk9LjPg>
X-ME-Received: <xmr:rXeTaE9DgyHpsrkleUnU2xfTDMzsWeK2RL2dIdS0WAG1YaMvF7vj-LnECgkAFwUWL9LQHVA4cFKJOHRrUf_YJdNP2uu8-smM8JYHTMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehmvgesth
    htrgihlhhorhhrrdgtohhmpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghg
    vghnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rneTaJ1fRvdKAKnb0v8N1P-avIdBFirff2Xzem06dZX4dHJEfisR0w>
    <xmx:rneTaJAdltHgyIhyLEcl4xzR9-Tukn7uioeGZokFtC51THFhkEa4_Q>
    <xmx:rneTaFc-c5KIFLHo_vvf11bTda_LsqyIhKtNHM-cEHW--vczElyYVg>
    <xmx:rneTaG72uMZW8R94lujRyO1f5LAtTh0wjzVPyirLm3FMfyfui6M2fg>
    <xmx:rneTaGptrx61hvIb3JsbHWajEUC7GwNkFwjk8l0bJWmRYA4xSXykHp3y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 11:41:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>,  git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
In-Reply-To: <aJL06Nlee6CR-KK0@pks.im> (Patrick Steinhardt's message of "Wed,
	6 Aug 2025 08:23:36 +0200")
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
	<20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
	<aJB5uKFdGybf-IbN@ugly> <aJCW7aYqJB20LDNg@pks.im>
	<xmqq5xf35429.fsf@gitster.g> <aJEppnTkY+66IEza@nand.local>
	<aJL06Nlee6CR-KK0@pks.im>
Date: Wed, 06 Aug 2025 08:41:32 -0700
Message-ID: <xmqq4iukwj83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> I wrote these counters in 312cff5207 (bloom: split 'get_bloom_filter()'
>> in two, 2020-09-16) and 59f0d5073f (bloom: encode out-of-bounds filters
>> as non-empty, 2020-09-17), and I don't see a compelling reason that
>> these should be unsigned.
>
> I think that is going backwards though: the question to ask is why
> should these be signed if they cannot ever be negative?

Earlier I gave an example of allowing for a "not yet counted"
sentinel value for a variable or a structure member.  Another
example may be for a function that counts that also needs to signal
an error, and as usual in any C programs, the natural way to do so
for any function whose "normal" return values are non-negative
integers is to signal errors with a negative value.

Note that a structure member or a variable that does not need such a
"not yet counted" sentinel value (e.g., it may have a separate
"counted already" member associated with it, or the nature of the
thing it counts does not have such "not yet counted" state), and it
is possible for such a variable to live happily with a function that
can signal an error.

It means the variable that receives the counted result from such a
function may be able to use only half a range of values as its type
implies, if that helper function is the only source of information
that is assigned to it, though.

If the counter in question never needs to store such a sentinel
value itself, then I am OK for it to be unsigned, and that is
exactly why I said "not always a valid excuse".  But if the counter
variable or structure member has to work with functions that need to
return sentinel values (like platform natural int that can use the
usual "negative is an error, non-negative is a normal result"), it
may have less chance to trigger the -Wsign-compare irritation, if
you made it also signed.
