Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E241A8404
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 15:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656052; cv=none; b=m2F/v2AR5m411L/9QeCTvNPc0G3f6FNBkZ4bDGs/A9I7SrA0tJVCkBp2cwmQy8mhfxljkqZrascnBHHXY82gA8jmpUm+cOvAY6MiqQQbEKjPvh5Fr6bYg0+BXUsqnd1j5UsIOL24W6R8WxtNLlxJvmd7UAX1VfaH5gF6HSlIiAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656052; c=relaxed/simple;
	bh=9X61iDaqL29eW0bCGo/6kBNx9/ccEg6zwho8ReIQ+V0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+jARtdpv8fqfiItv+qKGdhKKp6S6fJOxJfWIwttjgKqH1lB9ji5XJyE2vFOXfRH3q/xEkKGXJTXcVAm2p9eL0C7JUzhUJexrtPBQNfscwfh7IesonLGotrYzYurD21BZBYls1iFf8Feg//sktFCXZE/2Z6Ff15cdfKvbzYP7Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hXrJwRr6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AzLLchVN; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hXrJwRr6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AzLLchVN"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6358114022F;
	Wed, 11 Jun 2025 11:34:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Jun 2025 11:34:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749656049; x=1749742449; bh=9X61iDaqL2
	9eW0bCGo/6kBNx9/ccEg6zwho8ReIQ+V0=; b=hXrJwRr6T0Hbqngx6z7k12Eyuo
	MXoUPobN/TlO40iZWBRTBIMJ6s+nUW2wr7H0ZY4wlmep04MrdJOLkkX3goMxk1Wm
	PxXgJKQ79s43NDvs2ni4zYzlHy2Igql0zmHvazU9EsNU1Ps46ZE3jZVLUzmza1jw
	jC7sfm56Zr+NuHPp4YbQnI/oiNX8TwlDOw+PC4U3za0HOIb1RlND0ZO89bsD/gHM
	p4Xjw7lvYfEGWfN4DKag1D+4F9of3kd0dmWhmYqrFjTcIe2r8PqndFXXvut9WO9m
	3w/2HcVK350yzZguYpuYhV7n8AdGQXUPZ6/N2otkR/oPmEGUrfGRGdsWqNIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749656049; x=1749742449; bh=9X61iDaqL29eW0bCGo/6kBNx9/ccEg6zwho
	8ReIQ+V0=; b=AzLLchVNkjWSe/jxLyE7e3q432+uNhdfD/liC/pKL2gfEzEvIQg
	vOAclWEQVfmJBApJtOTmNm3JZ6G3DHchW6VcEgESdxqfjAvZFYOC36r0v0L4v9hT
	1PDQ2E3AHkkQJy6Tt/NkWRJwYa1Ve8+rxvfh295xmj7oZCvpeoFSqT7uAI9sPSlB
	C4lE97k/zeMdKac0OTFIHTEfys65bnHD+9JEAdGZP1/IJUU3Q2nsqYj0g7+J1GyN
	GfWOLE5FWwPfkKQyM5XUeOtf4/gbvVgsXPXpTDrk1/g/ZXod8F+V4y7rRCHA9TIW
	1wyDl0jKWgeL34Vh0sfspMjfzLULVMFYrUQ==
X-ME-Sender: <xms:8aFJaNnalz5V8cDMASSYUeyXdrAGG-h4quaHqYoi3YPDiZ09km1MQg>
    <xme:8aFJaI1ASUtaQ4wuHovjVUN29lMJQQefqljPLYOFBoit1BOSU_1omO2UMQbAE9n1k
    HbFOEloj3oHxtEIpw>
X-ME-Received: <xmr:8aFJaDqCi51B_UvKePRTHtQy9cQNRJYSxPbIJhjafXYxi587AOd5zVFgkN9OYBkvezj81ytkM-9I7rS_Qri0cTlFWT1_AGUkb5k0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehmvgeslhhinhhugidrsggvrghuthihpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:8aFJaNn6wQkHnqUJHOTjwjgSaa498TPZOfHTQaxPyGRwBAFI2gE5zg>
    <xmx:8aFJaL2IRhmWZo-8KYo4dhtf_QwgjaQznQd9-bp43UtOrEqHC221yA>
    <xmx:8aFJaMuiBJc5hMwuSuH0UzhcngIMc5UAix9kFBBA_jdRuGncDO1ouA>
    <xmx:8aFJaPVD_QbhCzjJwNDCnG2QCAvHCXbh1ag5JrWkJtC5obwR_Mmw-A>
    <xmx:8aFJaLpVbJFtnivpf_QKDOzGIPQCDKbrKh6MDFshCH5SsgG3u_cjPj3K>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 11:34:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Li Chen <me@linux.beauty>,  phillipwood <phillip.wood@dunelm.org.uk>,
  git <git@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
In-Reply-To: <407631ab-1184-41b1-8043-fd91d860e845@gmail.com> (phillip's
	message of "Wed, 11 Jun 2025 10:15:26 +0100")
References: <20250610123459.278582-1-me@linux.beauty>
	<20250610123459.278582-2-me@linux.beauty> <xmqq8qlzkukw.fsf@gitster.g>
	<407631ab-1184-41b1-8043-fd91d860e845@gmail.com>
Date: Wed, 11 Jun 2025 08:34:07 -0700
Message-ID: <xmqqa56ejnrk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

phillip.wood123@gmail.com writes:

> Exactly - I was expecting to see a refactoring of interpret_trailers()
> in builtin/interpret-trailers.c that moved most of the function body
> into a new function in trailer.c that added the trailers to an
> strbuf. This seems to be a parallel implementation which doesn't sound
> like the best plan.
>
> I'm going to be off the list for a couple of weeks, I'll take a more
> detailed look at this series when I'm back

Thanks.
