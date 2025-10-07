Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B634BA3F
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 16:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759854338; cv=none; b=APaRHr4EaLVIeryqqYy9p8pC/+3wleT7EctDM/ehnr+Vabw0wVf3fG6NMgBad0I3ifGSni4c3GXbbd5CjHSsqXhMtrT/DwFAUlPtQ3OTkBl6jNzYEOWKyo0oVUqr+z6qg3tfPYUCwwKMKq7Hsd6+8JnIFHlc+cZxVBS7kMiPP6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759854338; c=relaxed/simple;
	bh=RWrsmNXCtePrFL9vdsywd4I8KsQejrSsBsVwxStUJvk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JGCokz9KzRgC8+sw8vBpw4imclHdvwOQxM2puhol4RVTsazerVzQtlwNF9UauACNgHx5vaf7hpgPRDa0MfBhex6URUhVveAYtIH062i9OLCfnbNTeZ6wY6VYE6ORlvf0QCkVZ6V9qK6mlwwL38/PgQ6YQycaPtVkxI4H8pIK0hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JJqlIQr/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ikjrs9Uj; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JJqlIQr/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ikjrs9Uj"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9B747A028E;
	Tue,  7 Oct 2025 12:25:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 07 Oct 2025 12:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1759854335; x=1759940735; bh=gzTlfElh7K
	+rwwwJGHJ79L5th4UEXFTX4Dtl6/5nzWo=; b=JJqlIQr/xugLwk8sJ22P/DSTlg
	asoBNZ4By6r5GB4fs4qOuWMkFQS68cA37hU1ZSXCwa4s3suIJKus4lKHCi2eWm7K
	b+4yO73XWk27wT/dQKuqk+SmSQFLHCreEQG/7sxr8mwP2uKzAlro2V8FCLCkI0VN
	D5UB3GHsv9+ALn/lFc0t/2WkMV1Yyw9gsEP9PBCO1tXRX58VIcjlQI3981ShG2dA
	IXDzwYhZCnxz9JWofqsIU/uE8SQn+KjwV89bX88Dmpx2cZEXPXaEIO26p9EIKXV6
	CeZlhtKFOnYNQXKiXJnTk+yPQxbHLFF1qpXEYYlyM665CdLwxMrKUD1k/zng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759854335; x=1759940735; bh=gzTlfElh7K+rwwwJGHJ79L5th4UEXFTX4Dt
	l6/5nzWo=; b=ikjrs9UjNH9DFGvXl527pnrz63DGn1krDeVJEgiB3qBFbyDEmlO
	P4dPFcz1TUuwo74rX+M3bzCNTt0mzc85bhkuP3uDmMx0WYyAv66IFQqWOzK3zuBk
	Pdx58X8PvU/j06qDutdvxLfZoWYDCrgj18kQnut6RXiOyiGHtPe6VwW1srXKWfSR
	JoraJI9XHJaf+B8JQvFb0uE9KzsuwqPVm0HEFKQbSVt4Tw1vx5Q7MPA46iyq3Rg6
	IX3YlQ4hzzATLTY2NdCohge/DcL4QYEkofYiDr0mO5h9o0EzJU8SNlZdPtl9Gt1D
	NObXhevFZRWm6h/sbmqNdFhnP0d6YUMbnsg==
X-ME-Sender: <xms:_z7laO4AaVV6k4Xjy5OxMT3FThZj0ukxmEW9LfJ5WUi6Gng4z5VyZA>
    <xme:_z7laOwfIA_76QVmIS36JLbHeVBrb_QaUuPq0ZoNczrGPHxEVxx9jza3sZ_sp19ys
    HMWWqWNAMS8cO_GTmno6X_enDuCcNRYc5WMUznJyULM8z8MLaoC>
X-ME-Received: <xmr:_z7laFwy_gXRHTKfYc6y49-ucMMHZG70fm2SFdti81J9fCyW-nfb1Lw1AgG400g_Bz_QBI2hjaLBwYkGXGNi9T8yMjk3Gx9P27mZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffgffkfggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepteejuefhheegtdehudffudduffegjeetudekffegleeliedtfefhgfdvkeeh
    tdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohig
    rdgtohhm
X-ME-Proxy: <xmx:_z7laGxD66g-4rMAVfB5wubGKx5hH7ffaXuzobW458mmAVMq64KMDw>
    <xmx:_z7laPZ5ZE_F9RJCsiGv0je9T_K7deOHD4FNzAoaCY6S5dEI-bnfTw>
    <xmx:_z7laHVLH9qvDlqJgC05HVPDGB5HJXja6ZmCXGIBpiqbhkOmj4L0tg>
    <xmx:_z7laNiGM1mKNYXxWPI3u0GsQcgPiwLJtoGMuZEXjPQPTqDH9Olodg>
    <xmx:_z7laCMLWU_4nOGzBtNNcsdnNQvlykTHXqKvMil4mECH9VB8PR5HTTuk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 12:25:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v6 0/7] refs/reftable: add consistency checks
In-Reply-To: <aOUVB8hfnYiBm1V2@pks.im> (Patrick Steinhardt's message of "Tue,
	7 Oct 2025 15:26:31 +0200")
References: <20250819-228-reftable-introduce-consistency-checks-v1-0-8b8f6879fa9e@gmail.com>
	<20251007-228-reftable-introduce-consistency-checks-v6-0-638cff42f0b0@gmail.com>
	<aOUVB8hfnYiBm1V2@pks.im>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Tue, 07 Oct 2025 09:25:33 -0700
Message-ID: <xmqqfrbullvm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Oct 07, 2025 at 02:11:24PM +0200, Karthik Nayak wrote:
>> Changes in v6:
>> - In t/t0614-reftable-fsck.sh, create branches instead of root refs.
>>   This worked becuase we don't have reference level checks still
>>   implemented for reftables. Let's avoid confusion of a breaking test
>>   when we add reference level checks. 
>> - Link to v5: https://lore.kernel.org/r/20251006-228-reftable-introduce-consistency-checks-v5-0-f196d386214f@gmail.com
>
> Thanks, this version looks good to me!

Thanks, all.
