Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F871494CF
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366085; cv=none; b=pSSIyPtBFESjxFR5sqdQtlw0R3h4VWZJePdFjkyUVnx3dH0qi3IHmBRYEFSiVSSoskVAU9vgaOUw+XicY9+PO1Hfi27VdFc7jI5Iuh8pgV9xKuuUcCrlZ8fG4c/EoLrDs1aCC+3z2KObrqC0R8Lf8bI6BfdRF1UbC6YGEyZRWjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366085; c=relaxed/simple;
	bh=rwXA8gybGChb4oi2udTloNhehgWo5C23cWG/RNEtoJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aesuq3yDKpZPifdhw0qEzstru0Qq0JuVFdIqFFzPo/cXgzxzbe/Uvfa7nW114NeuDHjy/31WrZVxszOYKkiQNuuDuc7zi32znyhB+JCHvmR//HU9nbeL8p7c6fHKq5xnr6Qsd3/uJEeOHtdK+IPiTphIHzF7A95i6kKclATlwyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pK4rqdd/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rYpJWHai; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pK4rqdd/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rYpJWHai"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5AAE61140098;
	Mon, 16 Dec 2024 11:21:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 16 Dec 2024 11:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734366082; x=1734452482; bh=IL/rQZHOf0
	13G7JMjAYV+pf+v7HWMwUk5+regcTdALs=; b=pK4rqdd/GOcK/YI9XIzgTq+XTn
	I81/4FVHjW9C+KwCguGCt+zGkIOOpN67KGX1KA06C8n6Ie7NuGC0dzSErDpAwX69
	zKAt6polC2ol70tY5Q9ausgtwHxU/wYn+bNzW/pIS0d1xCOPhDKX8dq8YXmvojpF
	TtEKeM4nCOFTUOqMkuhArcoq0AJM/uiLLBDrveoO9ja3LuaWYWinwglIbyDDZnzn
	dIq/FmrF96v5Jks6Pn6ulWsjc1jH9hd6l9rRZkrSHQOccmoCZj8RmyrZMLXtaNvR
	uW3ipWOeoaSUSJaTOE5djFprHCgZrDMCI7QDwIeTNu06X3y6i/s26PyR0FoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734366082; x=1734452482; bh=IL/rQZHOf013G7JMjAYV+pf+v7HWMwUk5+r
	egcTdALs=; b=rYpJWHaiPp6ut3I6i1wtRdxSZMJInkiDv4vIc7GR/xZ4pe4scun
	dqC1EZKkO6azWzaPr1PkaivnBCq4lRS52/IKxj8z8flJHgeo89W0GK3x46GjmMaP
	AokjNNMBoENEUJ0TTJi4MYHMNtyoKbyglO1ZTRFPKQgzOAfUckv/FIhphyxI4Y4E
	9KT59vgmzuO28j9V6uz/sNF+vkr1DUDIumOzSZK/zPAkycLg735MyruYr2cehfNY
	8pUo2LygtNudOBx/QRuDhjOabZPkG1oa+OVgm7mV1hTd9JD8D69+qMYmFScW/3gt
	1n4LwUC/eSgmHb6+rX64pN924GGGo0Xkq7g==
X-ME-Sender: <xms:gVNgZ9u536KABzkkQD96pw9wcibg_9evUZL4oubTdNk9YXALukrQRw>
    <xme:gVNgZ2cAF-Lw5SlKwpFO91JDhHG-ZNAX6i_N4d1Y1SzMpEB6oV-KaXQPL9IFNUlIc
    nMOLNv6JbRl0W-_ww>
X-ME-Received: <xmr:gVNgZwwOfJau7fbHS9ssKH2TopiYFnd53bTXyL3EFktX-JieCK3ba9bOMNj5kQvOy5fc_6OKc-4WigxvLQfhLKInDhmEx6xrpPh54Jo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleefgdekiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtoheprggshhhijhgvvghtrdhnkhhtsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrg
    ihlhhorhhrrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohht
    hhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gVNgZ0MvZCeq34-VS3tnRMDxI9b-NKS2Q4fCnj7GV9H5iaqHKmP7dw>
    <xmx:gVNgZ98VJrAjj1LzXMuZhlAsGq-2sFT0dy9uiNjAoi_CNiu1Zv2IwQ>
    <xmx:gVNgZ0VGWETak2Vkg7CGNvqtBOT0kgNn00wWSfaKpiest0MCNOCMzg>
    <xmx:gVNgZ-d68Xg5sx91mNiynBnVYJek_J0lwBp3kgt0gPbZ81MnqWokJg>
    <xmx:glNgZ9xL6xyKmjIbzw32BveYM5Wtnm7oSuZCl46udidWSldikOeDgcKg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Dec 2024 11:21:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,  git@vger.kernel.org,
  me@ttaylorr.com,  sandals@crustytoothpaste.net
Subject: Re: [PATCH v6 0/2] show-index: fix uninitialized hash function
In-Reply-To: <Z1_gnA2kwRSyCF02@pks.im> (Patrick Steinhardt's message of "Mon,
	16 Dec 2024 09:11:08 +0100")
References: <xmqq4j4mv5o6.fsf@gitster.g>
	<20241109092739.14276-1-abhijeet.nkt@gmail.com>
	<Z1_gnA2kwRSyCF02@pks.im>
Date: Mon, 16 Dec 2024 08:21:20 -0800
Message-ID: <xmqqjzbz7g5b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Sat, Nov 09, 2024 at 02:57:37PM +0530, Abhijeet Sonar wrote:
>> That makes sense, applied.
>> 
>> Abhijeet Sonar (2):
>>   show-index: fix uninitialized hash function
>>   t5300: add test for 'show-index --object-format'
>> 
>>  builtin/show-index.c   |  9 +++++++++
>>  t/t5300-pack-object.sh | 18 ++++++++++++++++++
>>  2 files changed, 27 insertions(+)
>> 
>> Range-diff against v5:
>> 1:  05ee1e2ea5 = 1:  05ee1e2ea5 show-index: fix uninitialized hash function
>> 2:  c8a28aae55 ! 2:  778f3ca18e t5300: add test for 'show-index --object-format'
>>     @@ t/t5300-pack-object.sh: test_expect_success SHA1 'show-index works OK outside a
>>       
>>      +for hash in sha1 sha256
>>      +do
>>     -+	test_expect_success 'setup: show-index works OK outside a repository with hash algo passed in via --object-format' '
>>     -+		git init explicit-hash-$hash --object-format=$hash &&
>>     -+		test_commit -C explicit-hash-$hash one &&
>>     -+
>>     -+		cat >in <<-EOF &&
>>     -+		$(git -C explicit-hash-$hash rev-parse one)
>>     -+		EOF
>>     -+
>>     -+		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in
>>     -+	'
>>     -+
>>      +	test_expect_success 'show-index works OK outside a repository with hash algo passed in via --object-format' '
>>     ++		test_when_finished "rm -rf explicit-hash-$hash" &&
>>     ++		git init --object-format=$hash explicit-hash-$hash &&
>>     ++		test_commit -C explicit-hash-$hash one &&
>>     ++		git -C explicit-hash-$hash rev-parse one >in &&
>>     ++		git -C explicit-hash-$hash pack-objects explicit-hash-$hash <in &&
>>      +		idx=$(echo explicit-hash-$hash/explicit-hash-$hash*.idx) &&
>>      +		nongit git show-index --object-format=$hash <"$idx" >actual &&
>>     -+		test_line_count = 1 actual &&
>>     -+
>>     -+		rm -rf explicit-hash-$hash
>>     ++		test_line_count = 1 actual
>>      +	'
>>      +done
>>      +
>
> Thanks, this version looks good to me.

Thanks, both.  Let me mark it for 'next', then.
