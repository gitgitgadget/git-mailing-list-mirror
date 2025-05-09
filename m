Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCD325C82E
	for <git@vger.kernel.org>; Fri,  9 May 2025 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746826997; cv=none; b=q8OrYsDcQRf7AkvUktnL3xEvjF2pJL4TK1ht5yN5OuClobufJAUemX5ZrwBUIsPyny528solJmzdLF8vYM7FHBPYZJCjrawaPe0tPbms7oOET66vJs8pQbq295wIeE+/ztLmmD2HBzAjpThIFfTr3uLPm0MuOjxAVA6m2oMzMfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746826997; c=relaxed/simple;
	bh=hk9VJuF1CDb+XwkqGxK3Fft/rCdviseNFMHRU5/NNvg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aZK1B7KmQaEiaU+JlUb8xOYxNuvdRUWGfzn8m0nAcHagdA3zvpsFLh2W6FL+8mHaNC4/NlYCfOy7lXRibiFODB6WUIg5mSR/2CKr/hixS7MKmVoEWoLzCg5xji5Krg5ECxpYjfuVmVCkAZO9WVgdetLTYlP8+XSa4/bNlWZZ4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dhtH20A4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tu4id10d; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dhtH20A4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tu4id10d"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 41666114008F;
	Fri,  9 May 2025 17:43:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 09 May 2025 17:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746826993; x=1746913393; bh=ml06/fxa68
	GI6mDVUj912jFV9efU6U/VUCavm5DEs40=; b=dhtH20A4RkEVFF+4hLAktXychJ
	fCWggBG0LcWfh4kWKRT/EPkbKy2R5O/WtVmvnMzhrpfy4AdZTrNW2Sa/UlkiTeq6
	yVaKtGwDhc1uq+mWHCnyYW3POlmHP6qkbOFdFR1PkkRlpfRtSieZC1mfDGi5dirN
	jFOInDFFwfETI3hzzfa8ohc/Bw6oUNAGb/sivw9DXifLambJJsodGrf7zn5VGdNE
	7McqEOVoHKF+gRm2mZ0HxCGDUjM02NzHtR8YX52WmLs9/0M/tDjiel5YO/6BV9F4
	SEot2Uhn+psWt5Eptcb5l+XCziKU5LhA96EkbxoXL9eJwtHMJJn4fmaF+JVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746826993; x=1746913393; bh=ml06/fxa68GI6mDVUj912jFV9efU6U/VUCa
	vm5DEs40=; b=Tu4id10dmmmOcFc9rbGkjldPgT4dpJwq0VhX/0TaIQQUSo0WjpS
	ten/Zy/2LwaEpU+26yPxSxvdUlPywRPbRf0Ysf8scXCjx6QmKnVMs1qCkDr+e36L
	zXwCjpQ6sTuaEDRzpNiPbCKA/I+/RuL2cTj1vTQbxrGIi49i1GR+Ch2tjBIMfZXs
	1E9WVCSvdpbIxhRODm5QJ68T9pMzyi1X5W/CCxfibM0O5Aa0voI17BRCMO73ONeN
	LvNoqhWTo+/26gzW5amzmjXg+MIwi+gm/sb+j2JNxz4ibE1ety8Bee/wRACxqigw
	RdJrK9mdYUk//pUcg9tHWAc/3F5li1d6GEA==
X-ME-Sender: <xms:8HYeaFq-Xw0qAfa7aH-AzbBZL11_AjBbeL66H9GGuQdO2CJOKQPtHw>
    <xme:8HYeaHoEt4WdhohBYy6KXR8vRq3cq79bIsaJTWWCvuiOXrIYB7MVdvYgH-i2kbwTH
    eWe0dojahhWm4idbw>
X-ME-Received: <xmr:8HYeaCPcykDOf5xo146rupEnJuQg8iMUNgpxA1BvYIc8e8hZeTblM-pxR2Rm1u2RBu21h5yjSXHN3bs1ajDqb68NDrQobHmSTfoz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:8HYeaA6ZTmcyJBOxpRq2H48fLpPI78BFzz_QeT6vMOmard-xUIo41g>
    <xmx:8HYeaE6DJRPrhBEClA6wq1v78JU3TQ1Td7RN-uq2ogGFzX9ryHaJqw>
    <xmx:8HYeaIiYvwuWdjwxVoxPZJGTtVQtm3_MMOkzDR3QWMqCbtbrwYxHfg>
    <xmx:8HYeaG6zmyNrFwfXHPO93iDjvaWvk-TK0Nw4B7I6x0lbc7-7zR-HvQ>
    <xmx:8XYeaKGmQtngUO6ErXVbllx81ofJt2pJ7Ez7MWwexP2qVuzV8HdkfZDY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 17:43:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 00/17] object-store: carve out the object database
 subsystem
In-Reply-To: <20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
	(Patrick Steinhardt's message of "Fri, 09 May 2025 16:12:00 +0200")
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
	<20250509-pks-object-store-wo-the-repository-v2-0-103f59bf8e28@pks.im>
Date: Fri, 09 May 2025 14:43:11 -0700
Message-ID: <xmqq8qn5zci8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Changes in v2:
>   - Fix for a copy-and-pasted commit message.
>   - Rename `struct odb_backend` to `struct odb_alternate`. I'm happy to
>     revert to the previous name if we ultimately think it's the better
>     suited one.

Diff between the previous iteration is quite noisy due to this; I do
not have strong opinion for or against either name myself.

>   - A couple of fixes to move changes into the correct commit. `git
>     rebase -x 'meson compile -C build'` is now clean.

Good to see that we care about bisectability.

>   - I _didn't_ back out the rename to "odb.{c,h}". Junio has already
>     fixed the fallout, so it's probably more work for him to kick it out
>     again than to just leave it in.

You do not have to make me an excuse, if popular demand is not to
rename; I can cope with either one fine.

Will replace, thanks.
