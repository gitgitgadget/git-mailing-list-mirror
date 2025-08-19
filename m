Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006C6246761
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755632760; cv=none; b=i+NW2IUA3yNH6PvNKieaze4FOA1Ajj3YSz8JLTqV7Y2+F1tXa4FlzBjpg8XHnYhbxjjzFD0pW81+X0EJsaXEKh6AxkJlHfwbItX+6kCWXeovPTNsNVgc8fss0l1blU8mUoscsUr1BNONZBrP7MMW+89rzrZ0pIqN3Vi5P9BRXMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755632760; c=relaxed/simple;
	bh=ni8cLZaC+j9ZqUKoF57hFYyZtRlgWzuiWYJXMUL5WvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSBDvdz/saHq9FFXF/kUAl/0RGJ2xTUv9smNrFyj9mHps8hEhgX7vcHfjoIqJaSIO7KjwMSD6bIvQdVqsMxSpaML2RDKq4ObM8mTGf0SCddIL+MOTKFHn/MnCmm4gtJhBR1vAQvqm0vSveFLu/c5koOpUjxw51GFYRMyWX0e6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PwkpA4Lg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MkTd9JmA; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PwkpA4Lg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MkTd9JmA"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1A928140017A;
	Tue, 19 Aug 2025 15:45:57 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 19 Aug 2025 15:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755632757; x=1755719157; bh=PwaROquKQw
	AzRsCsbLRBOQibfIMAe2cDyTu13yMzD5M=; b=PwkpA4LgsFI342HyKTDU7JGxjI
	lYLzq++MZ8ZIadykNZKhgpP30SavpbXTzp9/2jyoHhM5vIdl+ohEAwDK26Rw4V+0
	7iiZGV9k+MkTKb0F3hkyo+8+VBECf12+269UetRN4jrvUXBHpx780+NbmXMe3XNG
	ljM0/Zm+uQem2HpZZfG40F1wk44YJpz/D0AWXgY6KidjsKSACLC53lRC4ogbBfe6
	vp+Av+o2A+f331pgoZWNvQLk+y7Zk7+hQ4YX7q2XobLctXh2eT5lqXzj0jBbq7ur
	JSOJn75wJ0q0kaUhhaa2xg+HlkZ3vNnEm+YVQ7ced5v+owbuae4JX6/uC18g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755632757; x=1755719157; bh=PwaROquKQwAzRsCsbLRBOQibfIMAe2cDyTu
	13yMzD5M=; b=MkTd9JmANbVLghJrL1h3RnRAwp1UEHZYvfGcpSDwpVVUXpcV1uS
	WObyzXQg1xS5vIYXkoxtjw5+pgwPag31JRn8uG7exYCAg8NIDVkche+uUdyhPgKx
	Dty2iLw5BQMalBSADUiZR0zoI/94VpyiakhGqs0zdITyVkwabVw1ECmMXpXSyQ4Z
	XbmTGUpoM+hFMGOPAaDn9UrVQqH4ALr0vZnM2inQeBI6sMa1B5IiiNUWJVJE+l32
	QZKdAg4ICoS9wIU1tN9zm7SiuF+F9ze1Ug+jXMJO3fMrTjZuBfl1wxikf1Oz2Hei
	7/2FVfeEpEUudVBSj7wvZ0AAKYMt+XHxVFA==
X-ME-Sender: <xms:dNSkaBiPOBX5tZKESf6LaKaHl1FOrXwHc7o6oDGPwO57Iu7jik83TA>
    <xme:dNSkaC87USfVpM0UogSO8orfBKbf1VSr_tzzRKr7EWDvd9D_sLpFl5fbhrY-Z7JnH
    PoGE1wzgdtGD_Aw6w>
X-ME-Received: <xmr:dNSkaMuK_34Rbk98Zq5V9LsJXmR6q1jP9X8iv91JZf-h7Ix7IdhqzKaht9ruWpH0x-7_lBRX2yoBXX3hy9gWMPhrnQOUvPF1VR2qXjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheeifeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhulhhirgesjhhvnhhsrdgtrgdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:dNSkaOoI486uPfkq5KxOI7m_G0jeY7SGSHUM7-oTjqgVrpFiL4GWjA>
    <xmx:dNSkaIoFHRUp8h8m2gVPY9EGWHwU2x4drjTyE6poz5hApaC95T1-rQ>
    <xmx:dNSkaFaoUFr3ONHwmi_lw-u7idKb9HV8g8Izs_ElDzmH9F1OFUNTrA>
    <xmx:dNSkaO_QkOFvPxFGOPCnf6Vgzp9U6mXt00S5h7ttjsQkDORoIte7pA>
    <xmx:ddSkaJTERRrWk0m-eTbazoQ1Fu1Zev24zWgNKd3XXwuBFrQXPcU-vcHr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Aug 2025 15:45:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Phillip Wood" <phillip.wood123@gmail.com>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  "Patrick Steinhardt" <ps@pks.im>,  "Karthik
 Nayak" <karthik.188@gmail.com>
Subject: Re: [PATCH v8 4/5] doc: git-rebase: move --onto explanation down
In-Reply-To: <106c4a6c-9239-4c67-8bed-5ec2c0987f21@app.fastmail.com> (Julia
	Evans's message of "Tue, 19 Aug 2025 11:03:36 -0400")
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
	<4686417b28e4ab386983ad68e4d4d4798a467811.1755276751.git.gitgitgadget@gmail.com>
	<xmqqh5y8nvmv.fsf@gitster.g>
	<51468411-8251-4f13-90f2-5cd5184d7c52@gmail.com>
	<xmqq4iu4k18z.fsf@gitster.g>
	<106c4a6c-9239-4c67-8bed-5ec2c0987f21@app.fastmail.com>
Date: Tue, 19 Aug 2025 12:45:55 -0700
Message-ID: <xmqqwm6zccy4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans" <julia@jvns.ca> writes:

>>> The existing
>>> examples are all good reasons why one might want to use "--onto" so
>>> I'm slightly wary of replacing them with a single example in the
>>> description.
>>
>> Then perhaps we should find a better place to put it.  The section
>> on advanced topics notes are mostly about operations using sequencer
>> machinery, except for the onto section.  Perhaps immediately after
>> the apply/merge comparison?
>
> I'm happy to move it anywhere: I couldn't figure out how the sections
> were meant to be organized (I didn't know that "operations about 
> sequencer machinery" was meant to be a theme) so I chose where
> to put it pretty arbitrarily.

I do not think it was meant to be a theme, but the topics there
ended up being around it as they were placed there organically.

If we were moving it, how about somewhere fairly early, like before
we start talking about mode options, where we teach the very basic
concept "rebase is to transplant a range history on top of a commit
that is different from where that history currently builds on"?  The
primary difference with and without "--onto" is if you explicitly
specify where to transplant your history, independent from how you
specify the range of history to be transplanted, or a single
<upstream> implicitly specifies both.

