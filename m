Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AF72CCC0
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 01:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758589596; cv=none; b=Kym24Y2DLJQlPMc/NJWYjuYXR8kjo6g9yu+QMWxGbrHOUgghiTTLRF83KYG3xn1ZV+rNEUdbnYLHr5LU3uGTPRnM0nfkeelRuTHMosXBxvYqa5E7m4CV61qhQ6I1wF2K/HUYIHkK5mEqApnUx2LvQarq+lIIQs3FHKR+d56hUtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758589596; c=relaxed/simple;
	bh=a268r9LVExdi/XVIOpYLJSq0YsbKJNecCgGh63xg5BE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ew7q+gWTsqUZbjaMmcyZzZTpautzjD6x3eh6FOT85AhWrjWiQl5WudylsYFPqU9Cfg9CYzYc77egfebYAVBx0hbSWmkdDOvSAJNZpuAPt3smHPjSajEq1Jkn5TlxEJ/1ttIH5E+uC/n2zFJs75xCF7m96RZ/FiC6sH/+Xtc6ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gq0XMXIU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TU+ccE+u; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gq0XMXIU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TU+ccE+u"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EB76F1D0020E;
	Mon, 22 Sep 2025 21:06:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 22 Sep 2025 21:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758589592; x=1758675992; bh=cJ5gs5++ki
	elAJlIf2s0JucPDhzIYSaMFJdI3hgMyp4=; b=Gq0XMXIUpbPBt4CfrZI59NRRZz
	9IjQSuHHjEnp6P3j02K8b7HxMGFYFSt6u5T1Cx3usQ46S0m7aJZD4zyMcVfTZOgO
	qm5JGxmm2BKdJx5iwGVJe8Mcy62CXUJSm4swJZCx/eFHiL+Au+Yr94PA7CMQnvyf
	bXcYv9mOe3iH2ok7RMMu2x/wxWqLshRQ1CjgHIVgh/jJmXKbYMZs1okObA6NLtOQ
	d7Q8KW+AGPOuTBNeoK4ZBVNktuz41w1kuhYyHiYfQXll2YU+ReSZLZPdMH4KkZoI
	9uPFUVzW+xa7KydAyxnN3CCY5TTIE5dfBgIwz6TNKTEkpASFhRSrucyMOePA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758589592; x=1758675992; bh=cJ5gs5++kielAJlIf2s0JucPDhzIYSaMFJd
	I3hgMyp4=; b=TU+ccE+uLD466rPfIznP7RO6EFBwD9O/Nxi7HQ0iuQq+EaQjA4v
	Px7KruYbkiv9wDM8hCplDmxk5KhMZ99XWxiOz2ZrGxj4IcPptHgVHiiwjtx12nE8
	l4aNmcNfL9SU/6lTyG6RBavZ2Do4aX/wx7Ss92L0nAREhd2FKizyXcaEBIwhOfrw
	jVpKaf92CbrukX79DDuNj+bNBqiKf0anN+8beSMyAMK11dMvVJLmovHYCHJcqlC5
	Zp9qUgcqfGDAolAYkV30tWJXwrTrlInfeaFjdoKV41yzGCEuzxLUtGV/UmdURBd9
	JjCHoE0XmQCbzVRPmWx2U7tgXLZ628zuLNw==
X-ME-Sender: <xms:mPLRaKXxmJscXplGe0x9NPQVRzty_E2xWh_NBZ5uzNLPQhgmaHW-CQ>
    <xme:mPLRaFocvhGEm38vAxzBHqS0m3a0xWtxk1T45mPatH4_YPNMwZOWW6GweD2ttviuq
    xZEJ2HEeIQTtUMLwLcaDJkyJ4fgyFza0clilPS8z67MWutaOaU9cA>
X-ME-Received: <xmr:mPLRaEms7x3FG95VE2soZHNynR4VNzkSjoz4Irda9JAc0kSx2M5LtAtirZ3yM5vFOGhGOUQ4YNnRZ-xkl7HqsYcO9RI-hAD6vmar>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehleefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mPLRaN0OC6qsGgC7XK7C4Sd_fTMjyHBqj-bUqute_nO6Hz_MQ1W-Jg>
    <xmx:mPLRaJRwCtjur3swwahEyhQvxQU76-KWcI41p28lW33UnEM3JPHHcg>
    <xmx:mPLRaOzkvl5y0qeih-3gPOCvPOfUKerkNrhxq3Cg89GyYZXrpnpjog>
    <xmx:mPLRaBDRRg2sSnzy_nu_bwHLUNpX-6e24aLZK5olWbFTxIQOUFsVFQ>
    <xmx:mPLRaLGpvqlYkPfS--egIm02svZgi612GXNa4Vou9nNmmmBD1Romn4pU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 21:06:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ben Knoble <ben.knoble@gmail.com>,  Jeff
 King <peff@peff.net>
Subject: Re: [PATCH v4 00/12] Cleanup xdfile_t and xrecord_t in xdiff.
In-Reply-To: <CAH=ZcbC5Y04D4bGjfH3rZ8GKabDttFez5qb9i8mXVsfE3LF26w@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 22 Sep 2025 18:13:58 -0600")
References: <pull.2048.v3.git.git.1758294992.gitgitgadget@gmail.com>
	<pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
	<xmqq1pnyru1f.fsf@gitster.g>
	<CAH=ZcbC5Y04D4bGjfH3rZ8GKabDttFez5qb9i8mXVsfE3LF26w@mail.gmail.com>
Date: Mon, 22 Sep 2025 18:06:30 -0700
Message-ID: <xmqqecryq8o9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> How about
>>
>>  - rename rchg[] to changed[], which is a very good move;
>>
>>  - optionally make it unsigned char, not char;
>>
>>  - the user of changed[] that uses only 0 or 1 and is not even aware
>>    of that MAYBE thing use 0 or 1;
>>
>>  - the user of changed[] that has to be aware of that MAYBE state
>>    use its own NO/YES/MAYBE for readability.
>>
>> Hmm?
>
> 'changed' is NEVER EVER!!! assigned anything other than 0 or 1 which
> strictly makes it a bool. It's easy to mistake that because the
> functions in xprepare.c that deal with NO, YES, and MAYBE are within a
> few lines of 'changed'. Please re-read xdl_cleanup_records() and
> xdl_clean_mmatch() very carefully. I will update my commit message to
> make this more clear.

OK, then there is a variable with some type that is _not_ bool that
is used in xprepare.c and the code that deal with MAYBE does
something like

	u8 current_state = MAYBE;

	if (the .changed[line] is NOT valid)
		current_state = MAYBE;
	else if (env->xdf.changed[line])
		current_state = YES;
	else /* false */
		current_state = NO;

and then use current_state as a three-way variable, perhaps like

	switch (current_state) {
	case YES:
		do the yes thing;
		break;
	case NO:
		do the no thing;
		break;
	case MAYBE:
		do the maybe thing;
		break;
	}

?
