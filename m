Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3968A78F29
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 18:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804101; cv=none; b=LjyKVylXMBN88FW1yt6aJCarp0OJTQrviZ87qxDyp+eRG6fLbQQnQAkFdfkeB7BQwyW1N/VQMCZniGTDWu6j8PCVLAC4vLlZTOREY0KVqrHKMScuVIvMYOVBMTAPApzNy8brl0BH2SZRt7fXKVtCYChSzlW3F9kDHJ1pSdh/H4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804101; c=relaxed/simple;
	bh=nZ+M8kskx3KRcS+HD9jvm52dZK76zqNAvXA+3mH+zW8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S209ONXXiLYXrDRBB4CZnQlzt+goNVPmIVwHHeovAuz6dOYa8IkpmcKA2QTgysLDmP0rIEQsZbHsma+MaHAcT7o7ghU+bGl9BFrFXy2NOJsJHu6QWTY1Hume8JeoBIgGiXJ4CUvEfgwAAtOiVTYku9pDVE32JiPxR/jAmciwKfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZWpTLUBC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pNihCYVZ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZWpTLUBC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pNihCYVZ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 5096E1382DAD;
	Wed, 12 Mar 2025 14:28:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 12 Mar 2025 14:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741804099; x=1741890499; bh=JLlb1kVNSE
	pVVe4xA3a0j1tsLET2N6GKqarba1bUdws=; b=ZWpTLUBCTz1/RsK5cvGHT5F3Ga
	G78lE7am9ciQcK1DmTEru4xUHTKbLpLicsK6uRe5/ihelSenm9RODWd9aCysw0ij
	cYD5wGWza+WRlEOeROlGZ3FQ33wZPSPhu1uFVIgsSrdfggiCv/A3w0gNnsO1wBXo
	sxA1iIDNPqeeXii10w9YnbOAlh4FnF02UgDst7FbI5Xdc9nvEG2KWEX1FufUmmk8
	dduEMcQdOZXlfGlL0HRF7SfnNRDSy043Lr/rIECFleBtwxfDW3Uqr4CqZAteowgd
	zo9ot0KedUqdiOrwDzqYw5PcWm9JKfa2x/PMNcF9hIKu/I8G4ONTTJYLWoPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741804099; x=1741890499; bh=JLlb1kVNSEpVVe4xA3a0j1tsLET2N6GKqar
	ba1bUdws=; b=pNihCYVZU9Rv7+qulD2JGoizJX9YbkBA2hMYAG6ZB0KMD0ixK9H
	LAvpSVSOEZE99uBoSpyuP+3tA7iRdFzyc/f52ujtUSOcZeSM4/+54mcjwXFt67nl
	COh7KZVS5guIzJySkZddfOldR+n+28xDjw38DGlazfHVzGIawvJlSR844gY9MQtq
	z9JBM4OL+n2soQyda3lg5XI0eL8h/uiX6s4QxTCYkpvidt7qe0l7OfWJDCGTQEma
	qxbElOTEQWnCe/D0JRPrXSWEmCKpi02kUU+aNtZvCBj7CMZas2DdNtaf/8M1GyB/
	k7t/72q0aSyyEWhGRWjWcy1SI3ayI9jcZeA==
X-ME-Sender: <xms:QtLRZ6c2zk3K5R7C-OyaDutYIrbH5o6gBfuKjmCJ5v6ip9uhsPm6pQ>
    <xme:QtLRZ0Nr0eEAyhOlbREpvyFrs0MVotF7-FgMble3vfgrjlGHjx5XNbatZXkDPUthz
    k8QdQ_hRCjh6T0QpA>
X-ME-Received: <xmr:QtLRZ7g1rT_BYBslDuAQ11ZA-_RVTLp2tDuY-lVdpCo4AIXEK-GWl9Q3swEeJoiAJYcOPhmDpy4qHvv1oodtl98PJITdXs09HV1R>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhi
    hlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:QtLRZ3-bhhX2T5tXIrphBnRuRIIXfkQIs-ppDU3sHPQ32bUiZ3MEgw>
    <xmx:Q9LRZ2sTXNFfPkhsi_Nvo0N5m1iWoyS1aNf35ghI8Xo3DCEleS58Pw>
    <xmx:Q9LRZ-ECMQ9apu6eRqTdNEXsJI18bv_-88vWWA8jaDpoj4YBFfWZpA>
    <xmx:Q9LRZ1Pxfbhu75POpmFGyeLZz--v0FJ9ZBp_ei8G4QhYv-t0lav7IA>
    <xmx:Q9LRZ6iT4mwdFiSknjSzcgWTyvnFMfWr41AaPHQvynccUCxSI8ttMMeQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 14:28:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 0/6] pack-objects: freshen objects with multi-cruft
 packs
In-Reply-To: <Z9GpQqm4YBvWF7Ff@nand.local> (Taylor Blau's message of "Wed, 12
	Mar 2025 11:33:22 -0400")
References: <cover.1740680964.git.me@ttaylorr.com>
	<cover.1741648467.git.me@ttaylorr.com> <xmqqr0332un3.fsf@gitster.g>
	<Z9GpQqm4YBvWF7Ff@nand.local>
Date: Wed, 12 Mar 2025 11:28:17 -0700
Message-ID: <xmqqfrjixfwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Tue, Mar 11, 2025 at 01:13:20PM -0700, Junio C Hamano wrote:
>> > This series resurrects the first patch from v1 after introducing a
>> > behavior change for 'git pack-objects --cruft --max-pack-size'. When
>> > given with '--cruft', '--max-pack-size' now allows pack-objects to grow
>> > a pack *just* past the given limit by at most one object.
>>
>> And what happens when the last object appended is very large, like
>> 70?  Would we end up with 270 when the threshold says 200?
>>
>> I still am not getting what you are trying to explain in the above
>> two paragraphs, but in general, "give up just before" would be a
>> better choice than "give up just after", exactly because the threshold
>> we are letting the user to give is the maximum.
>
> I think this is similar to the discussion earlier in the thread, but let
> me know if there is something here I'm missing.

I think the only thing you are missing is that max specified is the
ceiling, and "you can bust it, hoping by a little but you do not
know how huge the error is" is unacceptable.

Thanks.

