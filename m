Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789071DF258
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 17:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413837; cv=none; b=RZJl+T/AnTYCoBQ8bsoK+FBhBDL2bd/DaZdwrbveguMhAPIjlOiR4co3mRwRD0wsDr5fsFYWxJ8HHm+TOk//2IygGyPnMqfROrWoY9vZiXTCjr/094u5itqOf7qOu/eFwNCzu2D81dpu3IZ603qOzKLkwoM6V2fnOsvf5cPlU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413837; c=relaxed/simple;
	bh=yq+1TR7/klA9d4GMQX6ykbZI0V0YuAV7S3tsxJuvGWc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ucCluNXKLD21zl4L7+Dc3ckfn16D8aU6E1N/nNc4Mz5WeKYxBAl9lzzdxt5uLlJrCLf5cNKQ/SD0K7NVWLQNNONy8HTPug37p7tFa5/Y1nwcN+4ws1TYbvFCk20WTrhiQSs3ERyN4icAB3hZqNhNaaI/xG3VkTTDdvy2byIp0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QySx7MeQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJWF/sSw; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QySx7MeQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJWF/sSw"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 7A18D1D0021A;
	Tue,  5 Aug 2025 13:10:35 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 05 Aug 2025 13:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754413835; x=1754500235; bh=yq+1TR7/kl
	A9d4GMQX6ykbZI0V0YuAV7S3tsxJuvGWc=; b=QySx7MeQxVvuyLXn7MCZwLvis/
	x5RhWL/esoxmnAZq9AifrXkoNMRlBXpny5KFZSjyCMhmJcKquQiwO0HVqLR46qN5
	srBeAWzSe9XhyDNszBNIqs/OxtCTPNdOID+X5F0wbreFPEus03U05o3qsJGHiJGa
	3SBqUI5WBX6j/GtUNw134GDKonMKUBjwzryiUH59jjDJDsq19yxzrmyqp9fo6Pwg
	spo0FWYIR2E6kw+qoIy5u/3rhJxchyVUgmefOJyAGc+BaXxO4JOI+QnfLGNbb5vg
	gSbgtvWqOMAQOnbgzvgNDUD9G2RxodCByzAK1PiidnUiEnLIoz6+Mn+DFRSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754413835; x=1754500235; bh=yq+1TR7/klA9d4GMQX6ykbZI0V0YuAV7S3t
	sxJuvGWc=; b=YJWF/sSwgyU99kSNHjqJo2B5wyUQLp4sH9H9R16G3PA5JEYmdSG
	3jOI52Rh9YOu1dxseD9Q1l9wuKISgx4wIZy6lRHe1pd6Nj9+hhJQSqJHIC2XMjKL
	RKhKs9jVNmc2H8iTe1yBkvwXPDQ8Q8S6+6h7eGSX/TkhkqDuNyLBMAHCSLhna85E
	psN6U6XTG8ijIft+R/IBE33QQpvrTiggG0ZhPsmH2b++ufxAeEwFlc4EFPde5j0c
	OJJ//X5+nP9zMdmZk2AQNABVjMN0GNHa54jZKovhxHB8CK3i16esJay5HdgfhLOZ
	yssM/MvDZQZdc4J0m2azRrmeC7184yX1mPg==
X-ME-Sender: <xms:CzuSaIez8k198QTxt5-XgyQqk8pyRJNTLe2K4sXjfvcv1Bry_up1Xw>
    <xme:CzuSaEzI_z3ulex3zLvQZiIdnA2hKCzGEHm4qw-Nv-iNA9QOJIfvUY-alRIOoYG0p
    c3Cq06HX1A-upymiQ>
X-ME-Received: <xmr:CzuSaGGeDJtxyB38ACA1gIE-0XgpDOyNtjshleMktOwRUbwU3DdVLcg7Vz3OTGq3GS3qpgIWJ_P0G74g_6oR99SGZe0tsDE-duINqfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudehjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:CzuSaAzLVycllYMk-T5sjxHvhY7CEfAT-Gy0F1W-JCDZknQDSAm-NQ>
    <xmx:CzuSaPuJdIYDTzMxoNSCly9_rOymXremU9thY0Mrv2RNoZJFrdogbQ>
    <xmx:CzuSaF1V5VihBZB-CwOX22E5HNunjqVZ0rYTi8VOwNXWTnFXZeP5Eg>
    <xmx:CzuSaC_NP1eg3QTT-890jGxqraIw8-wys9hbd4VylVU7q04R_djaZQ>
    <xmx:CzuSaCpEyMOQuahuLQnvm-1E2Xviv7_aqAO5kpAkXwbCa05VopM59qs5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Aug 2025 13:10:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2025, #01; Sun, 3)
In-Reply-To: <aJIBlIDto33lJEuK@pks.im> (Patrick Steinhardt's message of "Tue,
	5 Aug 2025 15:05:24 +0200")
References: <xmqqms8fbilv.fsf@gitster.g> <aJCBlnHp-db4Nd5w@pks.im>
	<xmqqqzxr88jg.fsf@gitster.g> <aJDI16RBR9QKdtW9@pks.im>
	<20250804154129.GC109984@coredump.intra.peff.net>
	<xmqqectq4ne9.fsf@gitster.g> <aJIBlIDto33lJEuK@pks.im>
Date: Tue, 05 Aug 2025 10:10:33 -0700
Message-ID: <xmqqv7n1zoc6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So with that knowledge I'd rather do the safe thing and abort the
> transaction. It requires less hard-to-test logic and feels safer
> overall.
>
> If we agree on that I can send a final reroll that reverts back to the
> logic we had in v3, which did abort the transaction.

I guess both you and Peff also prefer code that is more maintainable
and easier to reason about, and I am with you two, so let's go back
to the approach of v3.

Thanks.


