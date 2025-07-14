Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE6D267B01
	for <git@vger.kernel.org>; Mon, 14 Jul 2025 16:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752511359; cv=none; b=gmjDvjTqpNyzVzd1d7Wx5fEkTsr+Wzp7zndp1X8T8OH/pszBJlGM4yrpJ3Wx+L4dnq8f9lrclP7bYwWZA+ksmt0fUa7r8j1T9TbHlu7qrj/ti0WrOMKIhgEOCymxxe6jSt42MnxfO3eazn3E7MgP7dsCm5w2hLvXqLfxXkQ20dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752511359; c=relaxed/simple;
	bh=0f+bWV8WVa8aquJyiPmMTyOfmnyrXGu/u+KGpYmszT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l0EsdHxTBABdrAAG9hrXh66wUUw0cqLmT6cpHG8izkiVxjYSkc6qTmVGFBirHaa1baXODjo34pKJjdcfZgwQTiRPWdvCR40mMyBCWoycVr8wx8XGWT2iPD4fVR7Y0r632CnMq9q3MDacbwHnnNmuAB01njXuzF0IB8dfSVBzx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HAyMtj3I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ixAXaaRg; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HAyMtj3I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ixAXaaRg"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 68E55EC0486;
	Mon, 14 Jul 2025 12:42:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 14 Jul 2025 12:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752511355; x=1752597755; bh=o9tbOp6eA8
	h/dfIfLb/JKmvisWq7RE7nWs9IxgbdR8U=; b=HAyMtj3I9+6K1IxPFz6LX0QFj+
	XTy1cSo1mL1atEDMZH6BHlpAwzWp2ks7RWjznxjr4AK6XxzRCaHN8ybNgNrG3fvb
	/cWgkuiwUL/ON9Z9WS1IUQqocLEob30kvOIBj5rDL2C9zW9Z2Uxtawqg9YUMNWs0
	oNwOECQ9euj/e2zCKwO1squFI9yI+r2ciO7+c9D2Bj1J7U5WMMqw6uuEl4q+RiRn
	2tPaQzgxtV0MqOYB9AFatYqkDcxgoxx5hIHOlJvy5nr0U4B+d5wdxSY6rtHH3lnO
	VSJgojTVD5X5IW/Rkve8ElRLMCX2PUcSN22KAyEXxC6BXaQDCgZXXTORDfhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752511355; x=1752597755; bh=o9tbOp6eA8h/dfIfLb/JKmvisWq7RE7nWs9
	IxgbdR8U=; b=ixAXaaRgi4MvEGhhHN8tUmJ3IsoVtyEtZlHhK5dhS43eJJwB0k2
	L+1q+cY0uOGFmJ8BDQ+OBzmQ49wr53HzVZtlqhh4hJixC5pZET7UvAc1OXXVgNYE
	OHkU4NSdjydqXAO1fICrt8la253pBmEVblpnue400sm5bK7NXERUMVagonQYUG1a
	FhtfsfkkqPzNWWcQ/MXzcFntZpAZMsRhzwl6vU2J8YrlGrQgjmQr2PzsftKDJv2J
	jTCXFk86XQXm/3TXyIbdoa6UmH4Wt0Kq9n2fe+FuysUbOiq4t9QIZE6OpaREOXkP
	qcwPLJcFuav1OgeLXlSyK79Ojq2jrfbUFxQ==
X-ME-Sender: <xms:ezN1aLUakOADCMYqk7U0xHXcjW_pkcpgADQprJR6QT8Y6CvueKDhNQ>
    <xme:ezN1aBLZeZXHj5-Lzyi0p4PQckJjzZN7jSUTqkNTt9Fj6JZWgC77a748sOjdhnalI
    oz5TeRx0PmJJC8DTw>
X-ME-Received: <xmr:ezN1aN0GL2UMcuxWxkCw0JzecsPWsXt_hBtexeDJsMs4gsuXTzYH7-6HdcIMpnWQ2woom0GNOEoiWQ8hS6PNQEujj9lqsZqyRcuYXe8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehvdegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkhdrohhr
    ghdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ezN1aH5OoZbe3wwOanjkG69r1tRTRUic93t3tenP6qapi7O7m-m6CQ>
    <xmx:ezN1aG__qAH_e8p0n1ufPkeYGJlZCatCAyf1yvnmRHM3zXnTbFRUZw>
    <xmx:ezN1aOXXoLrf--sCfDBK1VuCM8LKh-gXWHd5TORRTbXd26EWa6BYxA>
    <xmx:ezN1aJql-CPAmlzUbGl2ddLJffq7vhN7gsLAmnfrxMwxhhapt67Tnw>
    <xmx:ezN1aFMSNFcUfcdWWc4EReROAViUnsguveR7OuDSry9x7ExgYN8bE5UA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Jul 2025 12:42:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  schwab@linux-m68k.org,  phillip.wood123@gmail.com
Subject: Re: [PATCH v4 4/4] for-each-ref: introduce a '--start-after' option
In-Reply-To: <CAP8UFD1wRxZDCRC76VuuA8_rpNn__TQnL9RnNumCE33wAjSrMQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 14 Jul 2025 18:04:21 +0200")
References: <20250711-306-git-for-each-ref-pagination-v4-0-ed3303ad5b89@gmail.com>
	<20250711-306-git-for-each-ref-pagination-v4-4-ed3303ad5b89@gmail.com>
	<CAP8UFD1wRxZDCRC76VuuA8_rpNn__TQnL9RnNumCE33wAjSrMQ@mail.gmail.com>
Date: Mon, 14 Jul 2025 09:42:33 -0700
Message-ID: <xmqqqzyiu3k6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>>         /*  Simple per-ref filtering */
>> -       if (!filter->kind)
>> +       if (!filter->kind) {
>>                 die("filter_refs: invalid type");
>> -       else {
>> +       } else {
>
> Nit: the `else` could be removed altogether here, but maybe that
> should be done in a preparatory patch.

Good eyes.  Thanks for carefully reading it over.
