Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A5B139D
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759183979; cv=none; b=fUt6QoxIUdY2Y6vUt8wXWbzwXruS1pt53Wcfjik9Ioxr6CWmjm3N9dwqRFkuFgpMWuVNiUl3GB/potwOxs16iSDDYE3HyYilGvib8ZEF8OpKeOnneRy6/SoPvjL7lTvzrGWKg7YqakxvlTYm6QwodsLXPrFElfTPQKRF44pMuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759183979; c=relaxed/simple;
	bh=CcaC7DIhIPNm2hdy0h/G2WGqXlvkozLuZtNoZdbRfuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OEA4OK2wFZA8j32FXz/S5As7qA3HOQ0wSZC5zBbvsEQt/erTfnLesEKfi4IMPCf2aPstMCiDm9+t41pQtG6OcLSkSjRuo+Y/YapqgRcacaiR9nmhT2zGqjoMN+t67Lv1pqlxP/4V0RdMnS2tAtL45SnOTGWYqPyjjQEG2QH/FOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZCseO4or; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MW3iwWq5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZCseO4or";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MW3iwWq5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B1A831400123;
	Mon, 29 Sep 2025 18:12:54 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 29 Sep 2025 18:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759183974; x=1759270374; bh=ugjbbG5y/S
	D6H+EO2xo4S7IElj1POoeqalwbGqvAv9w=; b=ZCseO4ornivTsxeBGPAsPSc4SD
	6I8xoDc9UxzDd5i42GvdZjLViaWYbiEXn0jxs7BQZf3Jt9mCnoR07FpQk6Rc57AD
	HSCrzXXDn48JKeepHxD3ck+mtncKYtRRMQKQz8d7S871XXexz9V5qlUUlAefzCvM
	kSh0l8gb4FZ0xzKOSnFvWAGtuPq8QXVxhwFZDJKYlrmaOv/g5AobMvQOR7/DDqxB
	/aiXU/TQ932lEQ/lus5WP5MtVmaiU7SFjghtCv3fLdjZwa9Enmjtob77lZWFlUXx
	YexXLjb/P1cIKd1k09rwtXdTG6iXYHIwcoG5RNI101SCR+huzAU2sLOPkhJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759183974; x=1759270374; bh=ugjbbG5y/SD6H+EO2xo4S7IElj1POoeqalw
	bGqvAv9w=; b=MW3iwWq5tWMuH8NaEwi8FwJbX5Q0Nt7xkW7ELLq+mzd01bSkJRG
	sI4Jt8L6JJlojmVvblpsmvnA8mR0G/Wt8BSabQh6/wk7S//8e0ocEF2uu+uQI3Nb
	J92K7dp1gwfePAVpxxbriZx3L8pKiReuzO3uzzJdYXh9XRbCUWIYrDZTk3owlK23
	MWsULRW8SXByqkeNS1A7DES7CAv+RWCbwdgnO5kBFOLEvzG6oRQpu3TxtYv4Ynut
	xZLsE/KxsuvMMfJkMpudAQ84OOrOyc8ppAdySC50T2sb2kvq/8v2V2meCnDBdetk
	YhuBHU8vclJ0g1NNJzZaThHW9x9d6sc6s7A==
X-ME-Sender: <xms:ZgTbaG0wCIoOP5x2RGFvEQp80CWm7mUxyIoVPiyWnPtIFXXPHBy6XQ>
    <xme:ZgTbaAiETP23chOwLCHdCtImHCC610slQAZgCotsa7pVEgMaJiSsHnkKniC0ceKFU
    fitCJlcfT9aNsVTXygbCODe29W9lOeOY1dFapJS2sSuqf7rPIHZSw>
X-ME-Received: <xmr:ZgTbaMRvEXRn4-3xjtSl03e0_Q-sSf55bOHmwrg7jOJvqcVnYDbc0nxEmEoNXEPnPjbTaaNPZJVZYnlyj0-jeIS-xGVJuPDUu1va>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejledujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ZgTbaBgyUf-oExJr9FfyTXLBbJ5EDQkhcDOS7cdaPNpOVoKqb4dXVQ>
    <xmx:ZgTbaM5fFRHdw_GgXScdpQ0UrAzblKnM57jVC9_2rZXQPAxOhTJpbA>
    <xmx:ZgTbaOBfpnoOvrx8Zk9XtnPablaF28UkszE2yXJsz2F9xuhrAE2ddA>
    <xmx:ZgTbaDYcTcOLoYNCCbkkBjLqxqrbtaUr-lRhF1kkNI5Nx4E2anNrYQ>
    <xmx:ZgTbaAqWgs1QiVPhqzfObtucz4xJieA82gSFM-RK5GAryKoEsP47yST6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Sep 2025 18:12:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
In-Reply-To: <87792693-58d9-4047-beae-38aa4c59ed41@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Mon, 29 Sep 2025 22:04:49 +0200")
References: <xmqqldm0am4b.fsf@gitster.g>
	<87792693-58d9-4047-beae-38aa4c59ed41@app.fastmail.com>
Date: Mon, 29 Sep 2025 15:12:52 -0700
Message-ID: <xmqq4isk7vrv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> The time taken during 7. is pretty much fixed and unless we are
>> willing to sacrifice the quality of the end result, cannot
>> reasonably be shortened (note that this is based on the assumption
>> that "find any remaining bugs while it is in 'next' before it hits
>> 'master'" philosophy is working, but we have never run experiments
>> to shorten this to say 3 days to see if we see more bugs on 'master'
>> yet).
>
> Maybe pure documentation changes could cook for less than seven days.

Yup, that kind of adjustment at the maintainer's discretion has
already been applied, depending on the nature of a topic.  Some
truly trivial typofixes may not even go through 'next' but get
applied to 'master' directly.

Thanks.



