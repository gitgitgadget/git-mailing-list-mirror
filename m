Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054539460
	for <git@vger.kernel.org>; Thu,  2 Oct 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759419973; cv=none; b=cgP81VPdybsiX4TGbzcb7ZUOaok7Y7wVWxUIZ0f1qqzUt/sMp4NM3/iHvupwGR1F7uTuOfBZJiytcglXzbY1ztt5sWVbJY2ZVgUy7/NRsUKJovNf5bykaOBP1KG4CjoTn63wZNTMgnHhyUOTfTdHoN3YbC2Q6AZSG7U4Vf264Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759419973; c=relaxed/simple;
	bh=pCyxJWoMJbB2C2d6+JvuExfqu8gcmyg2kPDGSBPBWc8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lTQ46t6eOgJ/ASLhhe2B7nYoD1PePNX0KDGCtFnnlXiwITW0dsv50fM6Dpcb3CURCSFAF0Q66oVwbyZolOAk7GDmXJsE77uhWwoCNcl6+oJbYrNnmEzoVlRgMItTTuxPU9ytnqd13pnwGHnD+lp+wUFO42Rs1taev9LcbpiW8BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OiPy8nxg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JQ1JxXrP; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OiPy8nxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JQ1JxXrP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B8361D00069;
	Thu,  2 Oct 2025 11:46:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 02 Oct 2025 11:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759419969; x=1759506369; bh=NEUnLvCQoZ
	UaIDnFs8kb5+W6Vxh8bcSsqZD6bIYN01U=; b=OiPy8nxga5yih2kOAWf/etshmC
	85ZlIf4MA7ULvfzlU1En/EKVowDNga3f2BBD2QjCOJjUIt7QmG+TapliOf/960OY
	aPts3f7RshtaYBsq9v9uOrz3aOcTUxMAETtGbLz8+SGzYA9a2A31CH/xEAw6vCIt
	zdpXHwJO52/fhkulmvLOZdWHCp+9OmlHmpKwXSuiQkmT+JXOjqm4u+ZqMdXgCGI9
	WLIvE2JizKOUD+a5/wgTz+VKL56xEtZOsu5BdEilXMiT9vC0MZH/VFqLdnKDh7x5
	RF6CZVUDfjgwBb3wV4yXNwkeG52Sv/QYhfozgsb2oaEHuV+dVtfYeulT4tGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759419969; x=1759506369; bh=NEUnLvCQoZUaIDnFs8kb5+W6Vxh8bcSsqZD
	6bIYN01U=; b=JQ1JxXrPJSQhaPi2G+WC8+EZHGEQLSsgftLeHF+yyqkuK2HVzby
	lCDGlFjCQfWPnC1RsJF45uNjtVT5q3XXitU4uAKpCdRv7d4pQvCXi9CT+Bei3Szb
	lHisNnRR4WF8ujZ4zyQHwU0q0uG/JBPlrPbll7n5iVca0HACv6QO0bnWLe91XJix
	4MrtguTQRzBM8q4eW4W2gn0Nh71giSjdbEyHYqlqrT0es7ueXwfWXQE1KOFoDuS6
	Ze64qvNy6pxDkzCZsmOnTsrWoiT/jJtq+ezTgp2WMXeeT0jpQTFnkz8ef7jc7rfz
	50SRbvqTm2L+s+NaQD568iIKr7rvCCkz93A==
X-ME-Sender: <xms:QZ7eaIpTl9tKR0M42TxV8US-ARWnZt0ALhK9abmY9sOwgq3S1O3CjQ>
    <xme:QZ7eaNuIHbLDBNfp1D4bnB5Y6doFpmn3tgp5I_HhBvndF2cK3mTCzFM9CUdV4dCpA
    380N1-UYcCpdMaeu_FAkjbkuk6flLBmSnfXC1HgOZcKfEzBRjVA>
X-ME-Received: <xmr:QZ7eaDbF-AaehyUb1xJ70VmnqThHGUXQqRl6rKI0VCz_uwAcSdWns7GK-wjUdApOx8GTPg4IBUw5ddNXF16FJJ6cVKHNQ5VMopVD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekieegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprggurhhirg
    hnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhhrghffhgvrhesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtgho
    mhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:QZ7eaMaZy49PwozBypbrQYIz9L7vMqWqlTqbq2dRs3QrOKkn7EpYMg>
    <xmx:QZ7eaMnrnsR0bW8wKKzEfyNoPmgX72q5e5S0ME26z4PADitUJFcb0g>
    <xmx:QZ7eaH34hAtK0wQIfE9ngAwulGNw4-25vPm0t318bSfFqwJDfSSb5A>
    <xmx:QZ7eaM1r3Vo8iIhldE0sM02nhOfgQgoy5NlQ5C18wQ-tnoYHAbwIkw>
    <xmx:QZ7eaO2HLlWpfGyFgwFO0oE7VDwRM7a2YJ8SS_QuUGDs-yN3SJpKOUnd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Oct 2025 11:46:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,  git@vger.kernel.org,  Emily
 Shaffer <emilyshaffer@google.com>,  Rodrigo Damazio Bovendorp
 <rdamazio@google.com>,  Josh Steadmon <steadmon@google.com>,
  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 01/10] run-command: add stdin callback for parallelization
In-Reply-To: <aN4c6l7gRi4auss1@pks.im> (Patrick Steinhardt's message of "Thu,
	2 Oct 2025 08:34:18 +0200")
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
	<20250925125352.1728840-2-adrian.ratiu@collabora.com>
	<aN4c6l7gRi4auss1@pks.im>
Date: Thu, 02 Oct 2025 08:46:08 -0700
Message-ID: <xmqqbjmpxq67.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +	/* Buffer stdin for each pipe. */
>> +	for (int i = 0; i < opts->processes; i++) {
>
> `opts->processes` is of type `size_t`, so let's use the same type as
> iterator.

Good eyes.

>> +		/**
>
> Nit: multi-line comments should start with "/*", not "/**". This is also
> present in multiple other 

True.

Especially for a comment about a specific piece of code and not
about an interface---even in a future where we use some tool to
extract them, we would not place them in documentation.

>> +		 * child input is provided via path_to_stdin when the feed_pipe cb is
>> +		 * missing, so we just signal an EOF.
>> +		 */
>> +		if (!opts->feed_pipe) {
>> +			close(proc->in);
>> +			proc->in = 0;
>
> Hm. It's curious that we use a valid file descriptor here. Shouldn't we
> rather use `-1`? Otherwise I could see that we might try to close this
> seemingly valid file descriptor at a later point in time.

Good eyes.  Does -1 also have special meaning or we have no risk
mistaking this proc->in that was once used with a request to open a
pipe?  Regardless, I agree 0 would be a bad choice here.

>> +		/**
>> +		 * Feed the pipe:
>> +		 *   ret < 0 means error
>> +		 *   ret == 0 means there is more data to be fed
>> +		 *   ret > 0 means feeding finished
>> +		 */
>> +		ret = opts->feed_pipe(proc->in, opts->data, pp->children[i].data);
>> +		if (ret < 0)
>> +			die_errno("feed_pipe");
>> +
>> +		if (ret == 1) {
>
> This condition mismatches the comment: you explicitly check for 1, but
> the comment above says `ret > 0` indicates that feeding has finished.

True.  We already handled negative, so we can just do "if (ret)"
here, but "if (0 < ret)" is also fine.

Thanks.
