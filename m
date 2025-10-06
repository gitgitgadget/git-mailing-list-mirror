Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2900B2DA75B
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 16:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767685; cv=none; b=pLivLyHRVM3R2wFyGVMV8d8HVrTwUqj43x5TCVu98jRr3dWyS0rPwhzGA03J2SmTingP+Ks5ubom2g8ZjyjBUhgcmBhYyq5m3kVrBs0NdVKerHDEql0gQbnAvCyjVmhcpRbgH/poyVEpR8CTv0a0iDaSejrxn7Acpi52rYFL3Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767685; c=relaxed/simple;
	bh=mhIwUMq194ngc64PLgcmGSc0qjBbg2dO1umFlQip5mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mTZWl9FvOeRFyc7OunXPfe55XLQEVnt5mvklP6BIVW+89PwUlbqzOpA0ZlZ0X+UNIHIENJphnsPN1hIdYzxW1Lr7qBB6P2HHltq+qHo9sktYsXuqSaWizCeGHhl8An80Mbl1IzuTwyOp/+jexVrVoWCdgO8MQgvXYyKKGS3VF/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eVRokEjh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GarH1jMU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eVRokEjh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GarH1jMU"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0B5F37A00E1;
	Mon,  6 Oct 2025 12:21:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 06 Oct 2025 12:21:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759767679; x=1759854079; bh=fkgh3XbPy0
	exdjnwRtHzGt78L5eRYSz76OcWVa7sADk=; b=eVRokEjhQpFbEKx+zYuWDitJnV
	EsxIufTcTPzA9/EhwOMho2rKNyG91P89okWE3uhHvDzGzlbmWx5ZHs59jVCeSBBN
	REKlEu/kTiUcaEGKFBL9+COJjNj7tfmtczfJYuLKcyh7wzpqDvA7lITdG3jpd2n0
	K2PYvOsv8mhhiysXQFQ9fZREw025IlpIgE2mwsjd1/87OYS6GQiBY9Xm1oD7Vnn1
	+8R0cRzt06GeTXMj+nEta5RQfTkHt6kUP/LkeEXG4ddZH/JOhzn61nqrhSTCUyOY
	wQKhSAJ+upNxKcVBciXs6lwDmvID1gHxunxa2h919I7tXCorihPio6oxBr5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759767679; x=1759854079; bh=fkgh3XbPy0exdjnwRtHzGt78L5eRYSz76Oc
	WVa7sADk=; b=GarH1jMUXr0NfIKNaOsFNJS9op5irZ6HQK+FXiNZGtAQDP7/wwX
	N+K5K1bELbXHr42fGjnWYSgHZ1y/7V73NSYbZJJtlMo4WBOrcd32hvBWqqLtaBYo
	Zu5gboZ0JRZycbwa1nbjcXEqF3VqfRtzEB2VUeL7MCiRpjYlRrFc6Y2R0VajbJW5
	tbyMgtNP+Ghnu0u/iifGp5mOGLoGNfVI/atCQGnad7Cgjk231mR7EFugylCcg0I+
	gj2kWwHJxZHs96eyUTkU1TCD0ft9IVKWufvJz+GOESG3NQ/Alk4GCe9NwK7YCKE1
	FIIs0/WqhVQMh8IXNnowKEy5OAbGeboCJYA==
X-ME-Sender: <xms:f-zjaH2dgtPYStIUlqS6qsCBe9DSZ9H7dJlBnlfogCwmAMuSbTwn8Q>
    <xme:f-zjaB7HiLq2Rw0ktRLMBdNmkZD6w1yrGWmPJvy3RtUgyrKiB8DOxvTtcErl_mi_r
    Ep3QzM-pwDUeQmaseGMC50NJsRAaDUPBtpHtTaGdlDYhCA365fcbA>
X-ME-Received: <xmr:f-zjaDT1GqvCxCr-7nDjHGrSNIFq_lE2ajfHJ0EY0CD6MzzVCantJ_NYULfa2y9091hLNxl2WCJ54KtFktzgxzJIyfweI56v11rP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdelkedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtoheprggrrhhonhesshgthhhrrggsrdgtohhmpdhrtghpth
    htohepjhhrnhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:f-zjaGVcZWm5OvQJRrB-eeGwY4Jaec4KGF0x41qT1eNA4IrUwtW4qw>
    <xmx:f-zjaIGr0foMyJQFNaZmXANBAJrDujd1WFoCt3I4uZFSZLCWj2FDHQ>
    <xmx:f-zjaJe9Rk8TRwkF5wuBIWTrT1XBf9f7WI9bsmZDhqF0gz3pp6EHWA>
    <xmx:f-zjaBpxQdKVlHmobl9NAVo3khfWGjiG7M-sjPCsWno_O9PjC-Zl_Q>
    <xmx:f-zjaKQ0tuQHUhfl03FJcN0VkkNv-djC8k_dQSaHE8N1Mg56YvUZzb8D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Oct 2025 12:21:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Emily Shaffer <emilyshaffer@google.com>,  Rodrigo
 Damazio Bovendorp <rdamazio@google.com>,  Jeff King <peff@peff.net>,
  Aaron Schrab <aaron@schrab.com>,  Jonathan Nieder <jrnieder@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon <steadmon@google.com>,
  Ben Knoble <ben.knoble@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 0/5] Encode submodule gitdir names to avoid conflicts
In-Reply-To: <20251006112518.3764240-1-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 6 Oct 2025 14:25:13 +0300")
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
	<20251006112518.3764240-1-adrian.ratiu@collabora.com>
Date: Mon, 06 Oct 2025 09:21:17 -0700
Message-ID: <xmqqo6qkq9vm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> Hello everyone,
>
> v3 is much simplified from v2, starting from the design idea that submodule gitdir
> name encoding is to be put behind an extensions.submoduleEncoding.

This design decision to make it an extension makes a repository with
a new-style submodule incompatible with older Git, which may not matter
all that much unless you use third-party tools that come with their own
version of Git embedded (which by definition can become stale).

If you already have submodules creted under the original scheme,
then add a new submodule that needs this extension, do you enable
this new extension and write the new submodule under encoded name,
and move the existing submodules under their encoded names?

> This allowed removal of the modules vs submodules directories split and simplified
> our logic quite a lot. Tests have been been squashed in the smaller commits as well.

By this statement, I am guessing that the answer is yes?  That
would make it consistent.  The last thing we want here is the code
that needs to guess which ones are encoded and which ones are not.

Thanks.
