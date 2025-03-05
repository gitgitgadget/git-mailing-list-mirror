Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531A91547DE
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 21:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741211807; cv=none; b=WjW1u+ieTtYfj4f9fVBMNl1wv5KM7Nx2l8uG7GdXaa8B6sJJ9vQ1iyxdP6emh70Hv+tiHoISeypkMLctp+zrMzpFHKik2+EDYFC+CZPmQZTgvJC3QC431z5Rcn4ksZunq+/coEPifdSZ79+QUCuTb9V6t4xKoFw3vTiFB6AqAhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741211807; c=relaxed/simple;
	bh=nkg6+YFo4vwCKnJzr7HcnSMbgUzb4fbu1LzkFUPHFUY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EcnWh/v0MzU8wFtSRd4NangJkxJP1BnZqhqnHtQdKYmcxxwRZw9X9g5J9V0GpSv+srtLtfuYrBWKFh4OzZVf3hn1aezsr/DRYcyyePAVgVcd9BZYYhGjaqaI3Kr0RLZOL2jcsnk/jnRIc9QJZRvwFFBokD9Uok1TzPmmalhdvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=L2xtz6pG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yRicItKm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="L2xtz6pG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yRicItKm"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 68B131140189;
	Wed,  5 Mar 2025 16:56:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Wed, 05 Mar 2025 16:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741211803; x=1741298203; bh=Veq+QgIS6x
	2pJYw22wZwpIi8ylu5IXBrK0IwQ8BkH1o=; b=L2xtz6pGeEojotv9Sbt87lXPeR
	KBL0jFK6qX9Rq9wJvkUiO6XdknXWwJwpHb1qtZb9vkOaGG/4UAn9xqXzgZWMZNiV
	B/k91mMOoyBK9XGAcJ+TLaJwLWOnh5pLXdXvJkRzPmoSg8qje+4u4CSaneZY49tT
	rYyAksnHQ/hPVTppm/KxfFeZQqlqgIWek9pKvmZ+LRax+/y6RtpxDaY7pkhLHBCU
	PtRMjZ38t1DFVrxlWyHL8YyNHFWqh5VDj5CbdvREDc7S+AaoexQlVDfCtlKPZrVg
	TfoGhTj1LqCH31REYqgeA6GTd54TVQSQQ+BFjD2PL8Za+uxCMyolT4MHpBkg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741211803; x=1741298203; bh=Veq+QgIS6x2pJYw22wZwpIi8ylu5IXBrK0I
	wQ8BkH1o=; b=yRicItKmZCPQxjFiNPHfEmt6QzjR1WbcFHPL1Eiw75XmHdyMva4
	6NLfgF77J0D07jcPCMhORgZC//eYM/C/wh3DxpDhSRqBQmLCmWoOr0dToT1dehnz
	zihDtI1voBHEEEiwNV71L6lB1xKf2sFNiaCGc06Lb321gPDtIumTGf6YmtMbNCIz
	z98eGX2qUJdZJfVOfrJ7kUJ4cDPh7y2pBsXjAb53o8liSTMfLMovV1oVeidtG00x
	luswIvilfuzZeM0vwZ0gO/2IUwnvnwZsDSCpireUYZ1DqqLlMLoFKOp+AD+buu7q
	FJxuGNL4fx+pjIaFT2oXArWyGjULV+aPUIQ==
X-ME-Sender: <xms:m8jIZ_DxTorvsobXR5QNKlK0Rxd8LmKhNWjqNX9PBuUnCOOpCejL0A>
    <xme:m8jIZ1i_MEJWhRWzpnPFObSXHWnZXO9C3BmX2BrMOnMb5u098QRYazRPixZS4puup
    3NLkIlSiVtps7YetQ>
X-ME-Received: <xmr:m8jIZ6ngKqcaljGhuyGEt47BmD5NtpJMbrNefku8JdRi6NsxqEZ0owiL-La4XWbW9KaLxidRtZkpavQOcloBbbccOCTTPqJbWb7S>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdehleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehjlhhtoh
    gslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougdu
    vdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:m8jIZxzqyKFsgJg8d2Qw3_rBjjOXWkmKDt0F6PwUOpA_o7Ifgw9YGg>
    <xmx:m8jIZ0Sa9LqilX2C7cQnYzkWMSKVmhIRLpALtcvRkvWwgz4lB9S94Q>
    <xmx:m8jIZ0ZjVQyJgmIpfn6mz1i4Zk9d9Sd6pWaaQd_zYzEh4kB1f7d4Dg>
    <xmx:m8jIZ1S6saIdwjV2UeKlUMisM-BuALCtyhLoyMkriPuZjmHOizTFtw>
    <xmx:m8jIZzGzHAjT2viNcpTmRuwtl3Bs5RNTEdruuaVG_lR-vf0_qCW5s6aF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Mar 2025 16:56:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 2/8] refs: move duplicate refname update check to
 generic layer
In-Reply-To: <20250305-245-partially-atomic-ref-updates-v3-2-0c64e3052354@gmail.com>
	(Karthik Nayak's message of "Wed, 05 Mar 2025 18:38:57 +0100")
References: <20250305-245-partially-atomic-ref-updates-v3-0-0c64e3052354@gmail.com>
	<20250305-245-partially-atomic-ref-updates-v3-2-0c64e3052354@gmail.com>
Date: Wed, 05 Mar 2025 13:56:41 -0800
Message-ID: <xmqq5xknkup2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Move the tracking of refnames in `affected_refnames` from individual
> backends into the generic layer in 'refs.c'. This centralizes the
> duplicate refname detection that was previously handled separately by
> each backend.
>
> Make some changes to accommodate this move:
>
>   - Add a `string_list` field `refnames` to `ref_transaction` to contain
>     all the references in a transaction. This field is updated whenever
>     a new update is added via `ref_transaction_add_update`, so manual
>     additions in reference backends are dropped.

The transaction object is the most logical place to keep track of
what is involved in the transaction.  Nice.

>   - Modify the backends to use this field internally as needed. The
>     backends need to check if an update for refname already exists when
>     splitting symrefs or adding an update for 'HEAD'.

The above reads to me as if you are saying that the files backend
needs to notice that it is updating "HEAD", notice that it is a
symbolic ref that points at "refs/heads/main", notice that "HEAD"
and "refs/heads/main" are the two things involved in the
transaction, and must check if an update is already queued.

But when an update changes a symbolic ref in the sense that the
underlying ref gets updated through it, the need to update both the
underlying ref and the symbolic ref is common across backends, isn't
it?  IOW, shouldn't "splitting symrefs" (which I take to mean "ah,
we are updating HEAD so we need to update it and at the same time
update the underlying refs/heads/main, two updates in total") be
done also at the generic layer?

And if that happens at the generic layer, should .refname member
even be visible to backends?

>   - In the reftable backend, within `reftable_be_transaction_prepare()`,
>     move the `string_list_has_string()` check above
>     `ref_transaction_add_update()`. Since `ref_transaction_add_update()`
>     automatically adds the refname to `transaction->refnames`,
>     performing the check after will always return true, so we perform
>     the check before adding the update.

This change makes perfect tense.  It is the most natural to check
and modify at the transaction layer the .refnames member, as it
belongs at the transaction layer after all.

> This helps reduce duplication of functionality between the backends and
> makes it easier to make changes in a more centralized manner.

Nice.
