Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CA92EAB8A
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947914; cv=none; b=KEwDF8926+ntQYx+PJNBqxdwu+eJJexOKgifUegmorXcw1/4BkYaAEgBKnmvsnGPhj/uSUBkLUQwlyeAYLC2A1hj1972hMb80+K/eIUCjgrnCISlyxnOrqBAFe2BAppymSD3oEeQxlcA/hDAqsE3tAe3W9ZXaO1Y2JzZ9rQPeRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947914; c=relaxed/simple;
	bh=Ued8FNdkdTQkKazlhOOnhKo61tA+ow9UBd7m+fIqfJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e1q7mxDQXejyeLAerVw+OvUANdkw/fACPXvmxsdv5PQ/AEMwHsjqiQ+lKLwe33viBdlu6Q+mIm6EIaF4rLn/0ZJlaSJMgpKTd2PSLnQQumX64tNdTY6QisWiXF9p5e/p/7NVhQPGZYdxK9kHAmYOTCl56b2+PwnDLBXjjTcpR6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iiRQcQZD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOaNpyty; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iiRQcQZD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOaNpyty"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4520B1400065;
	Thu, 26 Jun 2025 10:25:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 26 Jun 2025 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750947911; x=1751034311; bh=77SV3d5GgF
	uZ45htrZT28EKxJW1ZCu0CdOTUvc6qeUs=; b=iiRQcQZDup+YhL817g2fn7xLic
	93Fbp4AwNuLJvBiTiSSamXcyMGgkbaq8ce0VlqpOB1H1wlDVnSruv4KTU1C/dkQp
	6BUqklKIjrsyPuc/r1ta6a7f/X1hqyqKU2Zk1bWScUwLdyP6GGFifMS4NONMcGdl
	scuoqmR4T34UwJNbpGvR1DlA1q0Tqz2hUn3J/cDFyWPvdYjOEirEKHM6o7ctAl5F
	GwyBFTOmNYh6l5Bjp4yBvU2INBY4/iW5d56wOMDJ6gM7gC4IhxuCvYteSOCU5P4m
	zfwwZQSqLObwHONQjf5f6SpqXAbi4Pc/3Jmk/hEw90motXOhYYjAaIQXTpRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750947911; x=1751034311; bh=77SV3d5GgFuZ45htrZT28EKxJW1ZCu0CdOT
	Uvc6qeUs=; b=NOaNpytyak2eoAxfPp45FU858/Gqc5yDvWymbDxFwqnt1UbZonz
	jUBcOWeHwulLmvYTDrvsu+eSJv1zm1TbNvnZRRvawgoAVuVjB8e4FcT4tp6OmqB+
	Ws/Fw697JW9Bd3/YfFzNCiLeBHMbrsU0zhxm8NfodflXRQLuz1jhc2zMJmgg0pp8
	v6XtfGIcWN3+pxanNARlG8DTWvdckYuj6gsizlrcesv2IN/f2UXtjb0wEdinojO5
	phtXMVL+9AUOqI7sbFKUY+PldM9UpWAxbWFfhiqWY8tcYADQu6ONBdmrv73NoTUZ
	z1Hp788UJnkeCj6wBSQXDGeRpQsyz09ynEA==
X-ME-Sender: <xms:RlhdaPWjvuvpBc6yp1nCBet-3EXMWK5cBVqjqS7VNhHPA9h0lTZ7gg>
    <xme:RlhdaHkJTIsZ4XKxSpUZTBSfNKjbNyx3yC0wSymG2kK_nA5GpCNoyxPZFsOjak4l9
    e6qgQIqoArNSNab1Q>
X-ME-Received: <xmr:RlhdaLYWz0AAKUhejtHJ0Gx-UE8BYyc5AoYsUMLRJU-39IQ3_C116OIbbZLBAdr2D8Z0iSRNNO1GMpTKoZL4bxp-tE2QY5Hah7ROLzk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:R1hdaKWbP68JpgBkIcTbVPo_EPl7ZMZ0yr_VrTCKOAi1_okBdhmbnw>
    <xmx:R1hdaJlHS5IDpn5f9ISyn8tELavgU778hkKX0e1g6nQo-W3KJiNPSQ>
    <xmx:R1hdaHeOUxz22TScK7j59Qb6Gxl2_1MXH06mAAGJhS0zgZy-hRknIA>
    <xmx:R1hdaDEk5Bv3_vF8hvDBID36za18eNPJe56kLRdCrV9LgoaxtLWPaw>
    <xmx:R1hdaCJhTxl_aIi5xJmvjH7tUXs_yaDBa0nyC9V7kVJCdzyupTmZsekj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 10:25:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] editorconfig: set maximum line length to 120
 characters
In-Reply-To: <CAOLa=ZRu-fBsNpoSzb8z2xUfM7WUUcdR1XRd8zr1U+P61QRccA@mail.gmail.com>
	(Karthik Nayak's message of "Thu, 26 Jun 2025 08:27:59 +0000")
References: <20250625-525-make-clang-format-more-robust-v1-0-67a49ecc2fd5@gmail.com>
	<20250625-525-make-clang-format-more-robust-v1-1-67a49ecc2fd5@gmail.com>
	<xmqqo6ubu0ic.fsf@gitster.g>
	<CAOLa=ZRu-fBsNpoSzb8z2xUfM7WUUcdR1XRd8zr1U+P61QRccA@mail.gmail.com>
Date: Thu, 26 Jun 2025 07:25:09 -0700
Message-ID: <xmqqbjqar35m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> So my intent was to instead was to allow the user to be in charge of
> line-wrapping, but for no reason should that go beyond 120 columns.
>
> I'm happy to change that to 80 columns, this does mean that supported
> editors will start wrapping at 80 columns. Users will have to override
> as necessary.

OK.  So stepping back a bit

 1. We advise people to avoid exceeding 80 columns

 2. A line can be easier to read without wrapping strictly at 80
    columns but left as a single line, slightly going above the
    limit..

 3. Even with the second observation above, a line that is way
    longer than 80 columns is not acceptably long.

Now, what is the line between the #2 and #3?  If we set these "hard
limit" to that number, as long as the tool does not pack multiple
shorter lines into one line using that number as a limit, we'd be at
a happy place, I would imagine?

Thanks.
