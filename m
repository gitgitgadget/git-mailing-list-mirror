Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9BA155C82
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 21:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745876817; cv=none; b=lwrKf0YHC3wFMb3eFbxzGfcw4kZr8S9GzlVMJTKLXtFzV4zqe3czT51e/13hLvVBf/A9QkLSJ75lIjfhGnJrYWNZ3GyjLwo3e9gKktHsc4KD5SGBxsn+//wPE6QWasI87OKl0F5cW8qVUojOPwcYsoLLB/wbPpC7n0QM5cjmNvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745876817; c=relaxed/simple;
	bh=NlBkQbdjtPc4ss1Eca9VBaS7EBalZWrABEzek7oe3/4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HzI10Hd2yWha/yb2tWg768WNQDvTOaLnPi7fB1D1SDJ3eDTgb/1uNpOAcpGpWzcZS4GtkdBFjdJyEA2PfW/PSub4TYFprnPufn+PphKPepadkKKk2NYjtv7aBqf1CFEr4xm1jOCd1ZSQuWg5U/AaAZMDzX7mFxAgCz89s5MQsOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K+tXbG7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W8Gmv2Ac; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K+tXbG7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W8Gmv2Ac"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 369631140270;
	Mon, 28 Apr 2025 17:46:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 28 Apr 2025 17:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745876814; x=1745963214; bh=mwlzuEKHdH
	6G5n2IgGKtgaBvnC719ojrn02EXYY/K/s=; b=K+tXbG7kIDKllOXux6DogbYGgB
	/vSJtgEQFTWXT0qhb5RxAUryHlyWWSZdaDV4lgnzfZsS821km3v97WU5R76EhOGf
	G8SBPt6RbqObPPO6MpQvC2xmVFwK9uuGmbJ5r4k3PsJuz+5HR3U0fb/2RnAD05m0
	CWRBWWNlsiueVH1QPHv67iBVMIgTzNi2A9dHO+UCvkT+X48rKc35+wNncBKM03tr
	3YFmwUxrioQLSGsTid0t4Z0awiM63Rz9MCdUNGRZTDn66nX/CDS3OnKQqnlNKJRk
	h22PWxkWw+8NicbrXFIgArh4ZxyHoe/DAbKEDnsxEcEm+UGqeO71Hvhex/bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745876814; x=1745963214; bh=mwlzuEKHdH6G5n2IgGKtgaBvnC719ojrn02
	EXYY/K/s=; b=W8Gmv2AcpEq7zsf/ZxFN2mnsOX0kx79NfavUWdYTTZGvqkiZ41X
	owRPLhW1SY9N/aQcsu55b0629cHxre3rVuKgt1ccUrNdD+PwI0X27p8/CWvdbzbk
	wYdcEPebVMtjWsXSq6JzMwztTyQQBCu+59y0UlUnqGzNL+jaNAqI0PX1TO8puU22
	zhzH8PW9BNoJe81CQxloZHqmNVNC1VAbgJLF4Jq1dwD/UKDkZuC1wif0/uW0EHkE
	Oz4Z+U2YkucS/naFPk5S4oob4xIcS7WoVF+picdRK3zO29WDh4apl3WWEFJy/mHY
	+372Lv9eMn1DzVFRhhQaJi1weOMrao1r9lQ==
X-ME-Sender: <xms:TvcPaGNdUjXdHIq7qEoUkNswp-MUTEqM1mR0LlybsmA8D9IpFzQBfA>
    <xme:TvcPaE_RMu0HEn5Nh5HI_4LmWo1QRrDHDQ_tHKCRJF-HxNSwH7ljOHqaRy-abbts_
    rHXotaOZmUYy6XuDA>
X-ME-Received: <xmr:TvcPaNRw5BSDdMusofBHoRwFuWCpQYKmIZ8JYzQdJJ3zTD0ahuq8VB4OKE_Rn_7TXGJMrAjWHlAILajzMr_BOuFLXRiUY6SzKhf4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddviedvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:TvcPaGvu9UIQBh5lyE3xks1vWbcTNFwbgJ4QnlC6SFmnOhQvifRRmg>
    <xmx:TvcPaOdp0kfkMwXG6CcHemI_N3q-ReXohRtOSk2uW9b5B9IPbn6afQ>
    <xmx:TvcPaK09lxMeou9VNAc30m7DdmYuWXyv-Q_3qRzuWw1wqdhU1gtdAQ>
    <xmx:TvcPaC9C6IzXAY3g50zxRsr8zhB7Ib9NBqQHM43SdI517d00ngrLzg>
    <xmx:TvcPaJKiEfBiKS8iaHwMlqlzXVWGpN_IWEwaK7JxOjT3VqicRAp6SQjW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Apr 2025 17:46:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 07/13] builtin/index-pack: don't fetch promised
 objects for collision check
In-Reply-To: <20250425-pks-object-store-cleanups-v2-7-63f1695b7700@pks.im>
	(Patrick Steinhardt's message of "Fri, 25 Apr 2025 09:08:58 +0200")
References: <20250425-pks-object-store-cleanups-v2-0-63f1695b7700@pks.im>
	<20250425-pks-object-store-cleanups-v2-7-63f1695b7700@pks.im>
Date: Mon, 28 Apr 2025 14:46:52 -0700
Message-ID: <xmqq34dsarhv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Any packed objects indexed via git-index-pack(1) are subject to a
> collision check. This collision check has the intent to determine
> whether we already have an object with the same object ID, but different
> contents in the repository.
>
> The check whether the collision check is really needed is only performed
> in case `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)` tells
> us that the object exists. But unless explicitly told otherwise by
> passing `OBJECT_INFO_SKIP_FETCH_OBJECT`, this function will also cause
> us to fetch the object in case it is part of a promisor pack. As such,
> we may end up fetching the object only to check whether the fetched
> object and the object that we're indexing have the same content.
>
> This behaviour is highly dubious and more likely than not unintended.
> Fix it by converting to `has_object()`, which knows to neither reload
> packfiles nor to fetch promisor objects by default.

It is unclear why you thing it is highly dubious from reading the
above paragraph three times, though.

Is it that if we are suspicious of the incoming pack data we are
indexing, we should also not be too trusting of the object that our
promisor remote would be giving us?  To put it in reverse, our
attitude being "we trust the first copy of object we saw", which
translates to "we trust where we explicitly clone and fetch from" in
the traditional world without lazy fetching, if somebody else we are
explicitly fetching from offers us an object that the promisor
remote would give us, we just do not bother if they are the same
because it is not like we trust our promisor more than we trust the
current counterpart we are fetching from?

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/index-pack.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index f49431d626b..805b7aa1e28 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -892,9 +892,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
>  
>  	if (startup_info->have_repository) {
>  		read_lock();
> -		collision_test_needed =
> -			repo_has_object_file_with_flags(the_repository, oid,
> -							OBJECT_INFO_QUICK);
> +		collision_test_needed = has_object(the_repository, oid, 0);
>  		read_unlock();
>  	}
