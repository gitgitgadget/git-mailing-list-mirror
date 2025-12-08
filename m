Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA4A2EBBAF
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765197691; cv=none; b=QJ4g6iWoLhYf36ErPRO/kfyP4QXuvv0fqXj5ZpOtoyz/ovz3ZLAZSXczDXUzQ1YvrJX9DPQuRGCuMOLYHmDA/UAsWalxJicodMYXNnVgEwI5bIzcrKQurv+dyMtWTxJx7TRLBa0Sqmokq0pSFM+TpBrUzjvYfUVUZRR3PCrwMac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765197691; c=relaxed/simple;
	bh=SI7UUJ8WtWl4PPhmbgSvv9iQdVKHscacjFG6IhK/iho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0Z7QQ8PTow7l6AMWaluz054Z+gjI7mfKVwrRBbTThR1n+7D61804iBvNtz3jg7w+0CFqaCV8vZd/pK8cwwviHCOPguxjtlrB46cqDNenbvan7JizKiVgl44VwPWuKJmknddIOcNf2AHCWoEuqSp/mxF5KM3NtLQa27MrXmRo+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hCRb2aTa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JRPQn567; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hCRb2aTa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JRPQn567"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 305CD7A0113;
	Mon,  8 Dec 2025 07:41:25 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 08 Dec 2025 07:41:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1765197685; x=1765284085; bh=vOpNuLLXP8
	MAiIWJ52JGI5GSyfkYj7OrmSI+dcTlR6k=; b=hCRb2aTawwV/maXTTwEqOZSAAL
	QVKzXkc0q793CDZJDs4VuX+hdlnq8iE10U4gIZrU/s4JF9D1PjZ/AWgsFhVcKEAK
	RRf6pkpgq2wpDbMgsdSKHfRSX6O70CGfVkIdOnh0DDIKYfmx7j7Kw8SCNYvbjXiM
	HCP/vekSlyylXhmIF7A7gryaOpx/auQErBZh/uLcvnsMdSNnL9Uf4V99N+1rUIok
	zjCVdhLPirVxaIZo7nUV0gQfD5CEOJ0G7esJUEkSDZ1fJmNO3EXpZeH2ZqBtG1A+
	PcOoNrj7CO2p19bnddsiJYvPq9pGHu3WreI+4XKhtEODfbW3s6azDHRWOkfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765197685; x=1765284085; bh=vOpNuLLXP8MAiIWJ52JGI5GSyfkYj7OrmSI
	+dcTlR6k=; b=JRPQn567SXQptkHu4oMyRlg63K8k97A1i0V/85uyS+eKVn2Zl1I
	FF8QTzZRAYoS4Izddr350fIDjb5g4x66al1C9trtf+AkTlWZoYCA46tOLCpeX662
	fbDDPgTws9TB9kwLnDhkQvdWiw3XxHDRG1ljc2oKXAVtMZGj4LR1u5X3WZy5rmFX
	cZKnM+IY3ybowC5DNxXgNaUaNU2Ma4gFLHl+DUvW1bhqONHxSPDTy7r9rKNtCica
	K6s+P1tNe6Af3Fm5SN12QWuMHhaNBCOyiWhjecW5AP6Ob9pGVwQDrxFgpvMN2th2
	T8L/uH6FnBTg7G0k9HAcfzA1D7rIqFLrrtw==
X-ME-Sender: <xms:dMc2aeECWkOjQ6jN0WbAQTk0xVSfbhhV6z68SQ12Mb3cBfYZkD_z-A>
    <xme:dMc2aRlkI1DKPic3UtGR34TyBAAg7dUq_G6SVEWXpMYMziejdnIogA16sHJpioKJK
    vm0JPxRuWcXMtVJ1psse9cfuo1BdsG_JlQ_wXgADBwYBSDng3ZW9A>
X-ME-Received: <xmr:dMc2aabwT8sbb5f8P9tV81GaVwr9wSF0Tlh_lSkII5YKhNBNpLSQ0PQny8YN-gC4BPbIuNi7L3VzZYB71LFK1Rwgkd5c5f6aDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhiugguhhgrrhhthh
    grshhthhgrnhgrfedusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:dMc2aeEI9r5QfGoyhNxPHStqZTTnGr3TybCw7KV2Vtuai-foBVzjhw>
    <xmx:dMc2aTLC3O_Ec53vFSqAKRmr1QUtHu6m68ZYm9cSAS4mEaR8WZvJ7A>
    <xmx:dMc2aRP73CuetongszrKNUIyD1rbYpoNeIcEtkdGV6UhQTlwETSPJg>
    <xmx:dMc2ablUCJp7vLecwiVDheVlnhBtFhGSPx4PfVHKxjOqVySjQQ_EcA>
    <xmx:dcc2aRYlFrNnSGj2LIJBoxE0omnTWKKVtsvs82vJP3jssMX5-H9Rx8mw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Dec 2025 07:41:24 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org,  "Kristoffer Haugsbakk" <code@khaugsbakk.name>,
  "Christian Couder" <christian.couder@gmail.com>,  "Elijah Newren"
 <newren@gmail.com>,  "Siddharth Asthana" <siddharthasthana31@gmail.com>
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output
 on conflicts"
In-Reply-To: <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 08 Dec 2025 08:28:52 +0100")
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
	<d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
Date: Mon, 08 Dec 2025 21:41:23 +0900
Message-ID: <xmqqms3tkux8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sun, Dec 7, 2025, at 22:58, Junio C Hamano wrote:
>> kristofferhaugsbakk@fastmail.com writes:
>>>[snip]
>>> base-commit: bdc5341ff65278a3cc80b2e8a02a2f02aa1fac06
>>
>> All looked sensible.
>>
>> The second one looked a bit sketchy, but that was the phrase used by
>> the log message for c4611130 (replay: add --contained to rebase
>> contained branches, 2023-11-24).
>
> How should `--contained` be documented?

The text you added uses exactly the phrase used by the log message,
so the author of the feature apparently felt it is good enough ;-).

It just felt that "contained in <revision-range>" is understandable
enough.  For example, I am unsure if somebody who read the document
can accurately answer the following question:

    If you forked 7-commit series from v1.0, merged the early 3
    commits to the 'master' branch, and merged the rest to the
    'next' branch, is that branch contained in 'master..next'?  Or
    it is not because the bottommost 3 commits are not part of
    master..next?  If it is the former, is it because the topmost
    commit (i.e., the commit pointed at by the branch reference) is
    the only thing that counts, and it indeed is master..next?

