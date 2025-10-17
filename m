Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FF1246783
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760728383; cv=none; b=l95aMiQ5W+dm1XVvYOIHNYIp84zr/C3/oW28hYlTcOeEUPsmW2PjgxKiK7t7fKVo/26wzLL2DVYRgvFE5Y8hQ5u0W4pkFK9Z47YKJSgeFMyF29lyRquVU7VFhgKhoLR420oXaw6FozUUq1MrGRiMpK8i3WmD3X+jIdx49wlYCBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760728383; c=relaxed/simple;
	bh=HkpqVkE7ty2EpMolhtRmSXbN3RWiy+Z3ZUsl/+90yBw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iMLV/wg4awIOzkXmuihllrKZmM612LXi6t0LeYL2ixBqHyPKdMgUXomuJjHO+AvD5sgeQU17S4XPgZ2ca9mWje8r26Hr6ZNy2InJU8Xo4burThaDQ3Mj2BStIR5u3yGJi8yFRPQTNxnfNqBMJ8kVZdQXlYkWwggf/mUFlIQ6q9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h/Ea8Cbe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sp5vI65R; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h/Ea8Cbe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sp5vI65R"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C71F87A0108;
	Fri, 17 Oct 2025 15:12:59 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 17 Oct 2025 15:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760728379;
	 x=1760814779; bh=K6GQTw5GXk6gU6O3mG9eq+3prT12eG5gJsXH3rJfG00=; b=
	h/Ea8CbeJWqS4iY8SZDhsZCaQblma88nPEM1Xbed9wk5W78E7vrRwTNo7VXK4erE
	uHtHhmgDfvQ383TRwhZnAnjCtXaZu6tKKnaf0zVOouGj9VQaKj4+EYJe5Mrv2qea
	LM7LDzkpDvui+Vmed4DVhQBXtRaf3QKpZU3LYU+tarPvtT0mZkgqy+6vTlvHFkWX
	XOcF4cWSybDkCnh/+cNtLIe84hxQ5Ovg8n0epzM49HH+PfVhidG47qQcDlkGx+iU
	pZ1Ud6V45p0oWwsnIaIMoCxjTGWDxZerN5LzHEotV78XfDhXauA7vucrwzKOqsny
	uyV77vtUIQePzzCu3g+jTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760728379; x=
	1760814779; bh=K6GQTw5GXk6gU6O3mG9eq+3prT12eG5gJsXH3rJfG00=; b=S
	p5vI65RKEAMFI8rsKfIrqj+YuBmKnYOAHQ5G9mHUu8c9+AdrL0Y7cFFaLh/cRMTG
	sZiTbd7worAi0h5LW0w9OmjMDurp3c6Ce6AGnGFAswj1BDfdAge7CS0w3W+NxOzN
	OF7Z/pDmxWPlkEXc0yJDYME4PZCaRu6Wrxx+LyrZ/805MuvFhJ+QPuUDiht8/U7K
	EXbwuNeklhfY+jOHv0wl/ES8y85uIbrLa1bSvtjMrFACbLudMJqCze1+o88u09cB
	czzJrxaL8LI2TYDBZKRJnr8PZfyf8E+QnKFuuWvWJWhS3YpenFhQP9MUtkdPRveX
	fbTbn4IhqKMcm2RONLsew==
X-ME-Sender: <xms:O5XyaOibzYXiGr8ODbz-8RKr4Rtu_Kb_iIGZseGo0Cs3VgP6xz1Sbg>
    <xme:O5XyaGCSrP8YfiDFsW-8GijQP8koP7ONkq0flfQ6cVgeIgSK9Y1wuQ2Z5MYYFFBvD
    JScddlP3yuzW5LEpJfM_Hv-hU8XFjJbCnd54xNCbnM4ISSv-6UjXpU>
X-ME-Received: <xmr:O5XyaLGgZobode7SPCO0WzEnXbmbhCuG9_zAb4xfB5fbP_hYGZxLYvwBvIvgVeomLBu7UBkW2icMFlYy7yJxn7n4bqMHoMKU2V4x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvdelleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehokhhhuhhomhhonhgrjhgrhihiheegsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:O5XyaGJ_XehZwMc4jPN2Nph-ciECFeiZGXfJVqOG0Ims5FwTyfVUYg>
    <xmx:O5XyaHl-2gfrs8oFXVV5nC43idq0Oe2kwqISAcaq-vvzthLw7SMCXg>
    <xmx:O5XyaGTdynkv344WOhVVmBuofwNE_Sh9rdwsT8ACFZue-RjnM_az9A>
    <xmx:O5XyaBIvY3ZtGb3nZVhIPRaURNJ1fq8fwXUHJFrnQ11mZKY33IHhPw>
    <xmx:O5XyaCkuBpaDl9xbSN8kWjmLKMPdcDcnbC60_-und5Ei_ojmphR5Msy6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Oct 2025 15:12:59 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] [PATCH v2] gpg-interface.c: trim CR only before LF
In-Reply-To: <CAP8UFD2sdvkv_ZqiLZU9k5zF+tM3UTQ8+mJjziRZGzOra6dMFA@mail.gmail.com>
	(Christian Couder's message of "Fri, 17 Oct 2025 13:55:02 +0200")
References: <20251016200344.43239-1-okhuomonajayi54@gmail.com>
	<CAP8UFD2sdvkv_ZqiLZU9k5zF+tM3UTQ8+mJjziRZGzOra6dMFA@mail.gmail.com>
Date: Fri, 17 Oct 2025 12:12:57 -0700
Message-ID: <xmqqo6q5z6iu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Christian Couder <christian.couder@gmail.com> writes:

> On Thu, Oct 16, 2025 at 10:04 PM Okhuomon Ajayi
> <okhuomonajayi54@gmail.com> wrote:
>>
>> Problem:
>> The function remove_cr_after() stripped CRs blindly. The comment suggested
>> NEEDSWORK: trim only CRs before LF.
>
> We use the present tense to talk about the current situation. In
> "Documentation/SubmittingPatches" there is:
>
> "[[present-tense]]
> The problem statement that describes the status quo is written in the
> present tense.  Write "The code does X when it is given input Y",
> instead of "The code used to do Y when given input X".  You do not
> have to say "Currently"---the status quo in the problem statement is
> about the code _without_ your change, by project convention."
>
> Also you don't need to prefix this part with "Problem:". We should
> understand from the description of the status quo that the situation
> is not good and should be improved.

Thanks for the above two pieces of advice.  The latter follows if
messages of all commits follow a simple convention that we have been
following, which is that the usual way to compose a log message of
this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

Perhaps we should write it somewhere in the introductory text
designed to help applicants of mentoring programs like Outreachy and
GSoC?

Thanks.
