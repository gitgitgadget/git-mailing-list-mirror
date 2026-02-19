Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD79E324B09
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 20:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771533045; cv=none; b=nJdv8O2Dd7MuTPq11ncJceb3DaUvQAfkpbpvZ8rA8qOF9YPi3J53BHtrzQK7Ag4KXK23mM5AP527axuTG96GUFjLhD5PPfbXOU0QRdBEOD7lcia7JLFVpgZOTA3jA937biLT+PZthMMtejjKjV7BB7UkMlM5maKE2u4iZCb3b5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771533045; c=relaxed/simple;
	bh=TQZEKUsoVjtyB+NBUYLLq3OcSeqdJYfMeb/QpuQzOZY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o0rJMRgiihflMYTkkH5W66m8AL+IrO+KYJjbQhGps58rmHk0pG9FnS8oawLZkcVelgZcVjxMcbSKE8DtxN2/zvwrMRjLKxisCtLyBoGWd59Hf7k8/PsUQu93T/+WwFx+4SyxlcoESha1KbORExbpzBjbYnftQ+Pdd4gU7xgdXME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ir72VWOG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+/Dw6XA; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ir72VWOG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+/Dw6XA"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 04BB0140013E;
	Thu, 19 Feb 2026 15:30:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 19 Feb 2026 15:30:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771533043; x=1771619443; bh=RYG92zmUje
	QaIe4ERp7FPXlxkNJ647z4iinmkV5+ZyU=; b=Ir72VWOGMlXjZievwgyeet8Zeq
	9LEL7JM2/X1FF3DN7Vsy8knqDLm78L1nwctwAps47cW+erxYEQsGR5xxj+0LaR6t
	CQZRzDY1/9YsT035WyTnck6khkjvEabC5OjuwlKNaGVLqf9NsiL70/HNNz87agpC
	vr8ZzAynH4i5U+zLbR7yxe9gCQFl4PNkGd2OL+iiGmHKDedjy2YnG921R16B2cE1
	qYrEPjP4WcDg+ErpUfOl5NtvcpkCpYHuL/LJdR7r9GHLv3hFfKCUKDItuQUE94s1
	UGhNYSXH6ADSNw2vB7LIhwvNSVirekcmEw23FVHLzVdiuvSqy41x9nwEctIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771533043; x=1771619443; bh=RYG92zmUjeQaIe4ERp7FPXlxkNJ647z4iin
	mkV5+ZyU=; b=b+/Dw6XATdaICM1jnnfUp9iKXRKC3tDVB+TueiKIyqoLg5F7d5q
	WwxacU2qlYCWu+XFRE6Vx3r/zmlqrNAkeU41Xcm7uiD1TuWn9IBK1GUtqmry4GR+
	XmK6EfWqQk5G3lIkYoxud1b8LNK8xSSoPwj6kEwJEVgiOpMn1FesDAySNEkcU1HQ
	wyexRVmuhZO84hYNWyv44zfMuyPstLUmKm75w2U4FAcV7PVPDnGKHldnWxBmp83g
	WArdAgDdBOH8RI9DdyW5LrzOEsV3fiILNOc38wYHI07Mrn/8qHfnvz2eklGbiMe7
	km6bb1ChmaYhnOP8Fww6kpm5/iEx668fbYA==
X-ME-Sender: <xms:8nKXaXnpURQzrJ9Q5AzaGMcuBxWO2CL0yUBjZKyNaEKskXGXu5ygiQ>
    <xme:8nKXaehfoF9bvgK-wJqhe_2U1szJPPojdcRRTV9aYBPCMVZp3YsiZWBxycAt5TbhB
    cOVQKHwNnaw9TVyRH_YSX7ldDWUDvV25ElSIyP5R-uRX5ci8EXJ>
X-ME-Received: <xmr:8nKXaXegFrC_P0Cd6-32WZbeHmXlSu8119CgZvj5ajK2RJIEf6HEWd9EsZ7ke7MmFAtTOeCK7vIpYBQLYI2y-RhIChQfHgCzkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdeihedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnvg
    ifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjohhnrghthhgrnhht
    rghnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:8nKXaWisblHZNmHbDl2JLDaz9gTH_TGiqjO6gkM2aCoJrcW_1MusaA>
    <xmx:8nKXaXynWqFHOxlNXfVT30iWs9W5pINM6yfZ75zpuSuaiHWeEOyVFg>
    <xmx:8nKXaaPWkqOb2tcP34KzN-Efqx5lYQviLPWfr3MTVNPzvBfZX9pvrg>
    <xmx:8nKXaQVMqNh34AUzDrLb-bHg7jEA_BkRcD1DHC5tdaIWR0ecTp5z5A>
    <xmx:83KXaarTwf6zWG9e_M9XWL41at27hlOUCYeWzraRvYzl1i9RlInsQCnL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 15:30:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Elijah Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>
Subject: Re: [PATCH 4/5] merge-ort: prevent the_repository from coming back
In-Reply-To: <CABPp-BF5jLfsndbinaPO_18fxvdUuVOYC8j31==jMXwK6iP0QA@mail.gmail.com>
	(Elijah Newren's message of "Thu, 19 Feb 2026 10:42:28 -0800")
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
	<46c24e0d05a91f830e400914a7e446afab320859.1771406115.git.gitgitgadget@gmail.com>
	<aZcr7DiIteTS9udR@pks.im>
	<CABPp-BF5jLfsndbinaPO_18fxvdUuVOYC8j31==jMXwK6iP0QA@mail.gmail.com>
Date: Thu, 19 Feb 2026 12:30:40 -0800
Message-ID: <xmqq8qco4gsv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

> Yeah, also full disclosure: I do not know why
> prefetch_for_content_merges() needs to use the_repository.  When I
> introduced it back in 2bff554b23e8 (merge-ort: add prefetching for
> content merges, 2021-06-22), I was just looking at diffcore_std() and
> trying to mimic how it did the prefetch.  I don't actually understand
> why the comparison against the_repository is there for either of these
> functions.  Maybe someone else knows and could shed some light?  (cc:
> Jonathan Tan for the diffcore_std() case I was copying from...)

I did a bit of digging for you ;-)

The comparison with the_repository is from 7fbbcb21 (diff: batch
fetching of missing blobs, 2019-04-05), whose original version did
not have it, but was later amended with

  https://lore.kernel.org/git/20190405170934.20441-1-jonathantanmy@google.com/

And after that it survived across evolutions like b14ed5ad (Use
promisor_remote_get_direct() and has_promisor_remote(), 2019-06-25),
95acf11a (diff: restrict when prefetching occurs, 2020-04-07), and
finally a5183d76 (cocci: apply the "promisor-remote.h" part of
"the_repository.pending", 2023-03-28).
