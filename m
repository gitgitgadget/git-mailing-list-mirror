Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85981347BC9
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771972329; cv=none; b=HgH80/40o0RCH+pPJbmrytbZHt3dbo5GG3648/+j0k1Bj0IL/aaRiXO0tailo9sf42Rt023ELPREnzLDXZRb39bqR+QZI+r1l/Z+Cn7G1s/UFSWqYfZeZHaWo23ueJ41cCOpXIQyBWjdzQVW05MUWk86uC5HTPy742WG+VM+bx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771972329; c=relaxed/simple;
	bh=fTfkAyKQJB0t2hnyoo5Q6Wc9kVbDU8kaOBNrOnTpLMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UyUrngN+nmWhfe26qTcvsSnasCKY7dUI7HPbBzhd56p6TPTNHde5BoXbW8KeyGqP+Sl0aC1v3jRYdvWVQvRxSfCIpOljOt4QN719P3jCFrKFCQc0VgmFukBKCNJwktx4kZMn0XEBXsI31qp4eRJEbOSi6B4wx416xdN08OvoE7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YOR/g9Qf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hQfRa+n5; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YOR/g9Qf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hQfRa+n5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 69E8C1D00077;
	Tue, 24 Feb 2026 17:32:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 24 Feb 2026 17:32:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771972327; x=1772058727; bh=b20/4ka2f3
	0fyVRCDUQAC4y4lEGgXh4XE9uPiJlDEFg=; b=YOR/g9Qf0xIEV8ny+Bm78ohrBs
	Wu18YGBMs2MFDgZkgv2o7twyP4H9diScIkJXL88eNm0InQf1GsfaLDVvV39GSHED
	3MQOLKS+R7uIN00LQv/q9Y9SGGeSHxuz6TBNdxXc/tiO2BWmzPleKahRu4HQ9jQ6
	b9w+nanov9Cre/Ogdm1X94nu8IVYG1ESCy7EjpiU7MEMnC3QykOP4f9wh3BXKyfq
	QEM/AiVFhj37Rxnd74a5FxdJO8NUGtFfNdpNrLYrk6HYdSLEieI9Mg0aneKDQwkt
	KR6iVJqEjdzcajobDdme832YkgakAFvrTfrrodlZzGQUkIikZouKLm2xEA1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771972327; x=1772058727; bh=b20/4ka2f30fyVRCDUQAC4y4lEGgXh4XE9u
	PiJlDEFg=; b=hQfRa+n5qK8RTgSNVB3+BwL/Ft8CPFPdZQRReZrYLemLjyd0SEk
	6LcQSYIMLJIgTb8nlRF3HpPly5PAD8GePD37p4CMS2coTe38PqUjH2KGWGyMQhfV
	oEfcgXJvhEoo/14OLdGGCqmeqk4uRq/+ey5wckr0OUCCurSIWgRh+wXRy5+My5N4
	OM+rMWzsoP7+TAUi2/WEaBe5XLhrOoJEICLtHoMqiWRjuAozYactRO8SwD+u11WO
	FSmlx9uvrvpBvtxrbPvLnW9jdg1SuNYWghr81gkOiNUtq7V7WiYeKmg2b57uREUf
	2oemqNwGZ++tXyonkFkEqoW4ViPaWqpZXLQ==
X-ME-Sender: <xms:5iaeadWbQaQcG_lQYl7UgtCUExr8Pe8xqlqC3339HeVDVvcPsi06nQ>
    <xme:5iaeaUl4e6MvK4KAeXsaZKlpwfz6AoseEohm1zuR4UCZn3vHqd3uVxUuU3yS5AX17
    bvmOJfKf9POgYyBrQIyYhlV9dBwMyS-tdD3SkOyslnXqI80Y2NOug>
X-ME-Received: <xmr:5iaeaeba2Sj_8oZ4_9r1ACXB07e5wqN75vBsX-To4mFJlgmiBOSFMPi2fh3sZnsOGv-qRzOapuSAWkXPgsXzzThfT9AZ0yK5Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedugedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:5iaeafPllDi3OMdIL20YzZMj_P8q_RdXWkzcWgu6Jm9D2q3DN31PYw>
    <xmx:5iaeaTZwQ0GKWnA6AYgrWx5XVi319gPq1W_jAQqhg-nt-SgaE4ceGw>
    <xmx:5iaead2Y5fSU-OsnXMHKY_jJt71P9yNQVf8d9ChVx2AyyOCm7BNg4A>
    <xmx:5iaeaZe3v6a4s3XiRpdDvNLh-7ioX8YRlwd0xXvWFbro_TNRXUYLdw>
    <xmx:5yaeabdQmcpZp2uey2cSppp26t4xBtnoXt0TxLlyyN9dnkEmTdsi4Rif>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:32:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] fsck: do not loop infinitely when processing packs
In-Reply-To: <aZ4k5C_i_rK_yq68@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Tue, 24 Feb 2026 22:23:32 +0000")
References: <20260222183710.2963424-1-sandals@crustytoothpaste.net>
	<aZwTPfmyrFp-QAPq@pks.im>
	<aZ4k5C_i_rK_yq68@fruit.crustytoothpaste.net>
Date: Tue, 24 Feb 2026 14:32:05 -0800
Message-ID: <xmqq5x7lepsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2026-02-23 at 08:43:41, Patrick Steinhardt wrote:
>> Typically, we don't execute `find_pack_entry()` at all when verifying
>> packfiles as we iterate through objects in packfile order. We thus don't
>> have to look up objects via their object ID, but instead we do so by
>> using their packfile offset. And this mechanism will not end up in
>> `find_pack_entry()`, and thus we wouldn't update the MRU.
>
> If you're thinking about `nth_packed_object_id`, that is index (object
> ID) order, not packfile order.  I actually made this mistake when
> writing the interop code and having that function operate in pack order
> breaks a surprising number of things in very subtle ways, notably
> generating multi-pack indexes.
>
> I will be sending a patch in the future documenting that requirement
> clearly.
>
>> I've got a couple patches in the making that'll fix this.
>
> I'm happy to drop this patch in favour of yours.  Thanks for a quick
> response.

OK, so I'll retire your fef2a726 (fsck: do not loop infinitely when
processing packs, 2026-02-22) and replace it with the four-patch
series:

26fc7b59cd t/helper: improve "genrandom" test helper
10a6762719 object-file: adapt `stream_object_signature()` to take a stream
41b42e3527 packfile: expose function to read object stream for an offset
13eb65d366 pack-check: fix verification of large objects

Thanks.
