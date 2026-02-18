Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5500346774
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 18:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440212; cv=none; b=HDLutF3AlzPUSE4RS59yMLh2l3qYwsZQl/wVcAhm9KfNuj2YxPKhCM0LT95EIUM3tiv/J8ygzsDubOhr8rwIxV/aOuqikptxaQS+ia2tIGbK8D45nmQZhHZDLYXjiK8MO9YFh4ni/5mzxgqFqbwJolRqA8LRrrMUfcTY/HuoTYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440212; c=relaxed/simple;
	bh=ekmLES9mQLhqa3lUhu/BcIcCOqAiSkfrxHbsHfl4Pdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M0ACaMIwoQmpPlhfshtMbzyC8lp3xItxPfvSib9uECBHR7VNwiM/yF8jnE7sb1ixdfSgRlvAtupegOMoqSs3MO4CmXgdr+iXI0XzAYtHD+NntJrI/yepdQjZfpGE1NF1qpxKfO1TYiH8a8ehzf2GMCnq97Z0x6Py/1uixwpNeFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pDO3W+aO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jAFAuqtJ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pDO3W+aO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jAFAuqtJ"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0737B7A00F6;
	Wed, 18 Feb 2026 13:43:30 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 18 Feb 2026 13:43:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771440209; x=1771526609; bh=Hn3PZmuG9k
	btEiKbTFX1alhU8ZJwsXsvmI8jkPbJJyw=; b=pDO3W+aOJr3J6hAnp/TLJABcjm
	Bw4+ItYYHNNDcon4tVQpj3GG5okmY7RQ+XmrViFL3VpzYB/0MnAhw2vvEgqlwgsE
	AAI4aARjgp7O7eKytegjXHGEApQQBnCaej6d/dtKXCWfNUu5o6NVv8rZyvqBTBhB
	yImf4fWd6AruWzvevhHDQg9sKcBWpR4F/3YF+5I3wHPih59BbjGTAxv3hX3GOUze
	6+nuzqcjmfMErP1m/ibVU44mBOk7ohdq/T3WJ6Ue38usYE196LwrEnC1VE7/7DZe
	ObbHMBOlZNFI7AbtvETqhZjUp77f/X96THTIE9ZeFY/Jd/C96dbwcD/Ym/xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771440209; x=1771526609; bh=Hn3PZmuG9kbtEiKbTFX1alhU8ZJwsXsvmI8
	jkPbJJyw=; b=jAFAuqtJ6P72r1LWsjbZJka3BlGZce2lYQi4/T8nTwqqxpIu/4H
	Ibk47T6Gbx2im4wgMqCnW2jcxCLZncQiugzLKyKrDVlxjmYZrBjIwekgp2pBFSYm
	WFRpqIEladdbMo4hyNZJRsXp7lv52CO6AcllFtEijxc80HIkPb5tqp4IvVs3Bjrg
	vX94ionsfJai8KvsRa4ZR95KJEjyJgQ9KakxTkMj/6st7cKynUqhGSPfgwWjfdqM
	AenObEsEPnx+MM+IxrZXId3HyVUgjC43nq1ijWtscNcU8QR19wLbonUO/ogOb+Je
	roLJbU4vBqWkuv6nDNO6qjiVUdoing5gSLA==
X-ME-Sender: <xms:UQiWaX-P2tzmRMWXQF69YJOdtgUqKHNfihlJ9NXik5lrCJM1wPm4lg>
    <xme:UQiWaavzPTRVXBnlM1inwHUlYefM2mQChInZXiXTfq07K_VgxKFlrVCfjhwOfPdhN
    zpF6aYe93zRMl4Y8TI1eVuTmFrCqk-prJmSkLxtVopF0vTj4z-uVl4>
X-ME-Received: <xmr:UQiWaaBv2kCgb7GC7cQqKqjzllp3VxEAwqke3vzPSYWfnmG5XkV_1fZ4HTMYPb00Cuo-l-7M8StmWXI5iMij70K4gPvxSkh1AQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeffeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrfedvtdeh
    udehfeegudeisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:UQiWaSVV611TWMOprxYwl7OhCowQS9Q6NnhG4C2ABwDgsCVC-Km7Cg>
    <xmx:UQiWaYC0D61ozXQ5oatTaOPJawVZNkLHVriiprQezgijucG_lDZ2jw>
    <xmx:UQiWaV8ocYDxDn1HsW8WBJACkr4lz5nap3U3PHQ9aQgfWo6A0hNj1g>
    <xmx:UQiWafGd8nvJSh1I2ZKUEShXlFBB1I52jzu2lYAgrWB_fwMdXEH41g>
    <xmx:UQiWadhdadc9Xn4JoTa0qz59ytvu-SlSGiUBWeMnv8E4OiKkGpOPoE66>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 13:43:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org,  karthik.188@gmail.com
Subject: Re: [PATCH v5 1/2] setup: distingush ENOENT from other stat errors
In-Reply-To: <xmqqy0kp7wai.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	18 Feb 2026 10:15:33 -0800")
References: <20260217084124.150366-1-a3205153416@gmail.com>
	<20260218051850.164972-1-a3205153416@gmail.com>
	<20260218051850.164972-2-a3205153416@gmail.com>
	<xmqqy0kp7wai.fsf@gitster.g>
Date: Wed, 18 Feb 2026 10:43:28 -0800
Message-ID: <xmqqpl617uzz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Tian Yuchen <a3205153416@gmail.com> writes:
>
>> Currently, 'read_gitfile_gently()' treats all 'stat()' failures as
>> generic errors. This prevents distinguishing between a missing file and
>> real errors like permission denied (fatal).
>
> The above plan makes sense---you would split stat() error into two
> different classes, start returning ERR_STAT_NOENT in addition to
> ERR_STAT_FAILED, have the caller act on the new ERR_STAT_NOENT and
> adjust the way it acts on ERR_STAT_FAILED, and if possible add tests
> to make sure we react to failures from stat in an appropriate way
> (but how? --- it is where my "if possible" comes from).  So I would
> expect that the other patch would be to split ERR_NOT_A_FILE and add
> ERR_IS_A_DIR, have the caller act on the new ERR_IS_A_DIR and adjust
> the way it acts on ERR_NOT_A_FILE.

I forgot to say one thing.

When changing the external interface for these service functions
like read_gitfile_gently() and read_gitfile_error_die(), we need to
make sure the change will not break _other_ callers of them, outside
our main focus area.  The latter, for example, has a caller in
submodule.c and we need to make sure that the existing code is
reacting to the updated definition of what ERR_STAT_FAILED and
ERR_NOT_A_FILE mean (and if not, adjust it).  read_gitfile_gently()
is used more widely outside setup.c and we need to audit these
callers, too.

