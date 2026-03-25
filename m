Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600F2397694
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446468; cv=none; b=gqxo6ZCB4cjPxvBkc+M/A/FWrZTiyNfYKrgGS3LlF4ZZxtw84jwV3O1r3O9tpbOYojaGcpkfgag5yfr7sHBFZ3b1gxZkJ7ANfi86jrvZYiJY3+uXTDTyiKsJf8DNX6N8ofc36DAEyqmUB2F8ZC2zVOldD25m4sQ11hPfGYoGvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446468; c=relaxed/simple;
	bh=qfpaIGGeAdks1Owy73/JbopJ2eHVbKTJRDHKDyDLP5M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=C5bMWaTogZ/GOi3Mj7OoGhfeCuDds2txGa0n5Tl623PFuuFaKwXY+j0KukZxiAk5K0zv7zwu4flKZ/6TMJ4WbR6nHgB6XNrQXOpo7KsdXzYGykLq6gZhNCbkoY8EqEaPuLTQy1GxjfstiD2KsAkgxLkxP5AVGDQSBK6vg9ZZT2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dV77IKFO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRn/qGsc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dV77IKFO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRn/qGsc"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 34D85EC025A;
	Wed, 25 Mar 2026 09:47:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 25 Mar 2026 09:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774446461; x=1774532861; bh=MsaTzf34jK
	wjfXR+m5chRUu/coY5QbaMA+/pEYMC4rk=; b=dV77IKFOQnWVzgGjuApQ4r2MRP
	S9CwsEdCXbXCfcSfT0PWXw8Em/7S4+/lcXU4Cvmx0KeXDoWyDp6Jr1KrecWRKQ1u
	NOHtNadPX5FuOrrYSwj0tVKX/FWqJ38d96TD3hwjVxIeeLvuo1LaYVAro2ky1Y+2
	9b3WWJLsmfb7Aqa1PS1Po1NErGHf8zNF2mI9MC4S8ZVcwracEgTKCTPSV84rugY2
	SMWN3ZKzRsfaf3IIYYAGaGARp5FYN/r8AGVtqAF9KumFYaN+6ezdE3O8d0QGNnNf
	z2sN4i/uHte3bA3pkMH7yRI+u5N6tbsnYWIfljPnZnNil4vPkAA4pLFVoBTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774446461; x=1774532861; bh=MsaTzf34jKwjfXR+m5chRUu/coY5QbaMA+/
	pEYMC4rk=; b=pRn/qGsccLCLDanEgrXbuKfHeNdypn9DSoMWQmQMjPkc4gqIqML
	bCqHUpDHgidYDd7v4uhJa4brXq0V5G+wt1xDH1bxrZVhh3XFgKuZNXBX3xszW7kB
	fmSy8AfPqhr4cj4JtC3oss3mECRRgXak4WpZxJucBzf8F7EzJ6WMg+dTwSIxd8ml
	vlz3eHjfDLDsuITISDbezDW6ralbb8proS81qHWUVgM7nhTTOLLqV/PM6fhVyrHC
	cnecu/U+5gIoOw9rS0E2T905hJAOEtAS+99Vi1XSC45GdXQJuU4xLTJrcmIBOPgC
	2naOJOLJvSbQs5YdJHSROAikQYKfW2eC5Pw==
X-ME-Sender: <xms:fOfDaSa4xhh_LlLE6uH6QyxfON4IMhL_kcKb7llQO49pv1hGExvU7Q>
    <xme:fOfDac2D6H4y6imdCR8eckGZTiujvOOmeF5NVVqyacX6QeJk_1Np8n3Dt1kk5c72Z
    Mrp05lmDwux7jaRABMedSiGj9mkt8etYOfoRrPbXFpU4wZFhArh>
X-ME-Received: <xmr:fOfDaaVU5GpFlK6cV2Wn_0Mg0j5a88JzxU67Glxbj6fG-7eHr-phXirVb2s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdegiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufhffjgfkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteevteehgfevhfdthfduhfetgeefjeekhfelleetueevuedttddthfdvieej
    teelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:fOfDaeXLKq4aQ6amZDsToSxsR3HSISjfh_gxqfMMktqreZZUTzWjKA>
    <xmx:fOfDaRcK5pL2-QnzMYk8zRUm6PEZCXEDis28-W-EnB0uEQgVmHT8IA>
    <xmx:fOfDafV2yIKXBs5wfWXeaaDJe94_hGM-lqx9VtEMZxNp9FBfsOOjxQ>
    <xmx:fOfDaSfO6VchxEcAcw1nMy4MOw7gZEQ8tJHNu5juZ4fcjF16TKNpgg>
    <xmx:fefDaU_ceohUFHcTf2Y17sBjWJUBscPfvgY3SQazOqfQRdPoZKCKS-IU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Mar 2026 09:47:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/11] detect misspelt test_expect_success and friends
References: <20260325062114.2067946-1-gitster@pobox.com>
	<acOJ7EHFF11LJRKS@pks.im>
Date: Wed, 25 Mar 2026 06:47:36 -0700
In-Reply-To: <acOJ7EHFF11LJRKS@pks.im> (Patrick Steinhardt's message of "Wed,
	25 Mar 2026 08:08:28 +0100")
Message-ID: <87bjgcja13.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> Note that I let cvs, svn, and p4 tests run only up to the point that
>> they decide to punt due to lack of external tools and language
>> bindings they require, so for those of you who do have the necessary
>> bindings, the scripts may still fail due to construct that are not
>> "set -e" clean after they call "test_done" for me.
>> 
>>  01/11: test-lib: catch misspelt 'test_expect_successo'
>>  02/11: t0008: make test "set -e" clean
>>  03/11: t6002: make test "set -e" clean
>>  04/11: t4032: make test "set -e" clean
>>  05/11: t7450: make test "set -e" clean
>>  06/11: tests: make svn test "set -e" clean
>>  07/11: t7508: make test "set -e" clean
>>  08/11: t9200: make test "set -e" clean
>>  09/11: t940?: make test "set -e" clean
>>  10/11: t5570: make test "set -e" clean
>>  11/11: t9902: make test "set -e" clean
>
> Oh well, you beat me to it :)

I may have posted these before you did, but from what you see on
your comments to these patches, it seems that you did a better job,
perhaps?  I focused on staying as close to the original implemenation
as possible to reduce the chances of silly mistakes that subtly change
the semantics, but for some obvious cases, trivial improvements like
turning "! A || B" into "if A; then B; fi" may be worthwhile clean-up
to be done in the same series (if not in the same patch).

Thanks.
