Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A924EE847
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 17:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788542114; cv=none; b=P6u8tTCWWKJgObI0Vr63Nj7TbvQhYPxbZNBIpbwpfDBQIfD7kmzHwM8b8uWd+0oAW25eSqlMf8JcmD8vGJACNg7L+NLjrPJMMOtGpZmJEdIdJoX3otcn2r1Nyy0i+Y44Ssr8Yc9F4C3t5yUyeQr0rWEf67qaf/mgl8p52csDrL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788542114; c=relaxed/simple;
	bh=qLty1GzodKQ2Mxrybm8V40LUWhmoa5GscMQf1ASH3e8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ROJfjSDF/5J0BVXQwr7fMellfbtoAjLdLGmGWGRh2X3moIYxOx5V/K4vNRJECSAr3UO9HoZGLLYx8IaZDQLNxRHyDbdph3jOUIo5m/UhE6SbzJaBEaPk51o8jYDhAfeS6Lu2vjawe/As6SfeB+7uZ+b/RmdcmN15NE1/Nvey+8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PWPAhg9b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VQufDYmH; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PWPAhg9b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VQufDYmH"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 353E5140010D;
	Fri,  4 Sep 2026 13:15:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 13:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1788542112; x=1788628512; bh=xwuG1EPIQn
	Z0fjSv0s2zcQYlujkOvldg7tTxQLaxIy4=; b=PWPAhg9bNgil8tatVAg8qF1KD6
	03FDtqorHLCzc32V08OnaZhN8USeEbu5JEe71dXmSyNqpitI5Mdc8K2YEGi8WDDo
	dUzWrLP9ZEJL/H30Rr1rUqh17Po10Phv9vVyw+FpuMEQEunJnvOTU5awyLqeXwXs
	lzLzwRVdvmETJlazC0j+xluxgCiQcoy4JOEzCg0cpNKx1hzLW2rfLBQzXPUefDyW
	SeFq2HcSsy1G0cV+cKpjU7ZybIkCeRVSIb+DGyxMJdhs0qF2BZ3YYMcq0DWQdPVB
	KA7bQbyAOXSMPL/1Fx7Lxm1VayRyjcCo9pYxJXw/fTHk34NG3NNt+U/bM9pQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788542112; x=1788628512; bh=xwuG1EPIQnZ0fjSv0s2zcQYlujkOvldg7tT
	xQLaxIy4=; b=VQufDYmH9Ks1aNxreNHRVDDcjmU5dcaCQq9W0/8gvLWhlTU5b8J
	8Ofb8oKjp71e1fid5pBAEIcdX+Qs3o8ulwzYKuKtAdpJWbcuE/0L0B3+3qES7/IH
	hBL4qOCZCyGCxw5xtM0bEvJEbjh18nIKsNP+aJLcBVxtKA2yzEBhkpGC3Krze/GO
	45K7U8dZmIyxuihluMLCxm9UQ/Y7b3jn1PA3IoHLS/LLsk4FCraLrT3ibdao8b73
	jp/nfYBk6PRReneF2Xzt2i7Ut7h4HPJHFXm839RZXPtH369Uh0kd/tEyfWiCdfMu
	4R53KLm7xZiKGcLqFaGTQLayLCNd0W1hPJQ==
X-ME-Sender: <xms:oPyaarxk5UMd5NAwtXqKD0b1WZw-Rz-DRuG6oDgc-9i8ioF3rYBKXA>
    <xme:oPyaaqSMq0lw_tVyY2I02QO0DFnZZYmdV-5eADUFshZM3XCAZIAaXhOGiZqjIHRvd
    0XZ4qF1morSZGdWOhgtAn8ciqMNhVUfgWCJlFTAXW_okHc2vfwJOcw>
X-ME-Received: <xmr:oPyaaqVHgMtJmDtsCzdKPJFiVjFWoN2RDcAWAC2Gl6B_KNpaAIkKrWrlO1RoHMqjyDoUPf8XUDjlySt5KLMDhMcXQHa9MPcezg>
X-ME-Proxy-Cause: dmFkZTF4P7S0HXiVgJjMnS8NPHXeG0FkdAKCiIhvLMZmCqxPmtGesfCJJXzyVkNFBaycd2
    RV6Qu0Y2wPNkVAkUKFT8lD3oEB8ETWxBe1j3Y8xuE7ltHyTW0mT402GEkWhiiLaiU0cPiA
    zo/ovCPMy3AaUKtke2bRL2/3Mpw0h0+mMCvYHTAOz//+7lpB3diA0YNeiua7tAfy0FkGRi
    bHQo4SdlRtM52/NrexXOWhtnWpNL+TmoFyCWnvHKn79UtfS370JXa9mvvYxUZ4QBXmD6CN
    9Vq/FR9BVe6r+ZK9uKvkTYyTJGMAuLdpydR1hxCcKXwWN4WoiB6s3sL+N/rKOjS7Xh2SXm
    fl6mg7XsMHYmX5/e7TiV+0coLnaBCTpZIRHAdERDMm7wLiV/esMikPB/JBpifjdLZCR1J5
    uiVk8QvTJhG4dW7UBJjGhWcRxmBi0KpEcuNqPWlbr6vMs/gstAuwbPv5Yh/BD+bI2XhUKx
    k/XZxmGoO4VNb0p3nD1fup5ZoYAguB04VCvYrfeZaVfqTdWroHi7Ftw/1JN3QjobImPvcQ
    TS8bb18K9O4V4pK5xLMJgAMWiOKLa16JUrDt/kqg0HAKBPtevlUOvA8Wrl8Ylllo4w8ZzA
    HWfKEdmN+ZQJRJ0T/tgGKipK3IUYue2AbmEAbF8UAonTsquQeVd18pm/Y9iQ
X-ME-Proxy: <xmx:oPyaakbNOOHie8EOneQDOqrhDSUlDFXIJyJKPdwHp2wGF5rUxzQPPQ>
    <xmx:oPyaao2AZYswqlzYkbs_KqIB8lVa1CUcA4lIDtLkk-HhiVcRPM2eJQ>
    <xmx:oPyaaui3SKIoCMIexR1ivff49BvP5uFHN3G2fT6es3KNDuy5j-dvpw>
    <xmx:oPyaakbR-69rsXLfki3gips7i00FdySazcBC9lV7O3QuYe13uzEeTg>
    <xmx:oPyaah2OpjVSj4tDtWBBMWyB64ruN2WIdXR7k2rJ9a3qk7LiaqrZV4z2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 13:15:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 00/11] Fix inconsistent ref storage format terminology
In-Reply-To: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
	(Patrick Steinhardt's message of "Fri, 04 Sep 2026 12:36:01 +0200")
References: <20260904-b4-pks-unify-ref-storage-format-v1-0-08144e5004ff@pks.im>
Date: Fri, 04 Sep 2026 10:15:10 -0700
Message-ID: <xmqq8q5h3plt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> back when we gained support for reftables we of course introduced the
> ability to control the reference storage format that is used by newly
> created repositories. This infrastructure has grown over time, and
> unfortunately without a lot of consistency:
>
>   - The command line parameter to specify the ref storage format is
>     called "--ref-format=", while the corresponding repository extension
>     is called "refStorage".
>
>   - In most cases we refer to the "ref storage format" in our docs, so
>     calling it "--ref-format=" is inconsistent with them.
>
>   - It is possible to override the ref storage format via an environment
>     variable that is called "GIT_REFERENCE_BACKEND", which is not even
>     remotely consistent with anything else.
>
>   - There is also an "object format", but that format does not control
>     how we store objects but rather whether we use SHA1 or SHA256.
>
> So in summary, it's a huge mess.

Unless you are unifying them all into a single ref-storage-format, I
do not see much practical difference between ref-storage and
ref-format.  They are both with insufficient clarity and details.

ref-format fails to convey "format" of what aspect of ref it is
about (among "storage", "name", and others), ref-storage fails to
convey what aspect of ref storage it is talking about (among
"format", "medium", and others).

