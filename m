Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEA41D555
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760449147; cv=none; b=JP6AnHnsJP/QF1fesYn2sYTURjqYpZxD6+BqYG48xkORjmgrrtoc37RyVv755GeQ8sjJ2q91kG+1jku3j0zVstUd71uQ1i/px93L9bzZv/yrwh0bbDOyJakuYgUvWjrPyJn/E0HNj5iwKuCkgUaia7qidjhio2AlKLekJglmvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760449147; c=relaxed/simple;
	bh=bcz7w+lqvD9Zl1yD7Xh8RwQw6hKUutgNpPqivSSZRpg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gk+We+AsFl57BclnHFMuebbU27ARG8vptSYF8MnD9lKff/aWu7Dby3dZS6MoT2eN1W2VtCX5SeMvUjOZKI1M/3Iry745MQNiY5FL3TM0zSQzcjFeSeeiOfKc+mMs4aiJif6ELOSjV4SCjMhz8i75Al2bQYkfBkK/UE9PqdunQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dbqIr7nN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BQBdqIyi; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dbqIr7nN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BQBdqIyi"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9D4507A0160;
	Tue, 14 Oct 2025 09:39:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 14 Oct 2025 09:39:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760449143;
	 x=1760535543; bh=7MYosLT5Wly5m4yYPwgOStNwcctmxIGoS5Cl1xQ8ESU=; b=
	dbqIr7nNKr6kFrCEm7ocE18RJ3UgdQCHmFUCZISFi0UQOX5YYoXUFf6UHuiGCiQV
	e4O39dyawK3EFvD01G9FFlW0+bka2OEExIqUuKGxrSZzeGnORdilhEqjqozPeZ/h
	SgOHE1MGwctYaNfbGqlQ4lSUaLwZLUMPJjnjDmXQr0Cm06iXvchliK6fY74m703t
	U865HepoNGJSTcdsLFWwkMtSSGeIRlP2fYVPqCFibY3c6BWwbG94kCixYyO+tUha
	GF/+Q/k6rg8CiD94bk3n7qqPp3KOZslFi+9BzfnKG2ZHWPdpxlWMT/TaZZ2wMPsn
	eTE1Ey0IQPywzvDv/herAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760449143; x=
	1760535543; bh=7MYosLT5Wly5m4yYPwgOStNwcctmxIGoS5Cl1xQ8ESU=; b=B
	QBdqIyieSDjWF1i/VOVpReuokc2sOZ2SwLuy2XyY6QdmjSMGdY7Qie9Y0kUaaD6K
	DalW14/bMYWJ3iNrpgtK0qDmGXmAhqFaF1EqwwDgK2xVeotnNg68/nuGNdCP0xLm
	vmxBSulVpqZFcFrQOUOcp2Skc068eEyno0R9jGvOFNgrge1StdXqzyECOxluwhTn
	ba/kI8hJONPoc2IRuAIij7/ZaYvNukXg0anGRDYenb8Dd8Eg5LGK37nJln7U64BB
	I7EKUHFbQFkJQgTl/3mLa0VwhBgIi1b8Su1Q/rQhixD0l4JshR48dVrrdxDrK9VX
	1OV+TXsmL5TQ78cUTE0HA==
X-ME-Sender: <xms:d1LuaFrypZQkDHXXjv_pchIMUW9r6_A2Sli_EXrBqkmG3bmi1bjBoA>
    <xme:d1LuaJ4QK9gbVAfaJl-iGWLrnJyRAAQzxaH9v6cNzVEsLp7YodWvNKasu22kPL6ME
    deQkSXS3GRqss9CS5LmPhasqM3E6qhK0A3stmDTLXAuj8BHPbT7L-E>
X-ME-Received: <xmr:d1LuaEfjL_ynrmOOVDDEjFzmlT42uyq_I0j5qwF76Nf-8tJwAGzGujc3YSWuzV-WMyrKpep9W_rjQ2eWH-Tob9_pDGg5PxKgnBKi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjuhhlihgrsehjvhhnshdrtggrpdhrtghpthhtoh
    epphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:d1LuaG79uAyG4T97dbR3D5iEb9uVJXfGA-ESt6GkY2DVXBcMdJ-mnA>
    <xmx:d1LuaDuQkeumCCHPujHTh37XGpj4GkVUjk8iC_23cU_VGdJNT7OR4A>
    <xmx:d1LuaOjKQIcDLOGD8jwD5cB5rJDQ-Xtd4MtdaIkP7K-9k1RI3aWqPg>
    <xmx:d1LuaGownX7jQRaUnv0Dibvm7M8zoN7rGNXZHYx0lUm_YRRWmZ9-Dg>
    <xmx:d1LuaFJ4pCPenaN22I0BBkAZPil1BAOLYpvNj5LAfgOwHKfAiWRp9bd1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 09:39:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Patrick Steinhardt" <ps@pks.im>,  "Julia Evans"
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Kristoffer Haugsbakk"
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v2] doc: add a explanation of Git's data model
In-Reply-To: <46c6ca15-c1d2-4dd9-a6d3-2538f482b475@app.fastmail.com> (Julia
	Evans's message of "Tue, 14 Oct 2025 05:18:58 -0400")
References: <pull.1981.git.1759512876284.gitgitgadget@gmail.com>
	<pull.1981.v2.git.1759931621272.gitgitgadget@gmail.com>
	<aOjzQ7-88m5e_YJl@pks.im> <xmqq8qhe5040.fsf@gitster.g>
	<aO3jbnXRI67JsAx7@pks.im>
	<46c6ca15-c1d2-4dd9-a6d3-2538f482b475@app.fastmail.com>
Date: Tue, 14 Oct 2025 06:39:01 -0700
Message-ID: <xmqqa51tzjpm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Julia Evans" <julia@jvns.ca> writes:

>> Yeah, I don't necessarily think that we need to mention root refs here.
>> But what I think we need to avoid is the following sentence, as it is
>> misleading:
>>
>>     References are stored in a hierarchy, and Git handles references
>>     differently based on where they are in the hierarchy.
>>
>
> Why do you say that it’s misleading? (what do you think it’s
> implying that is not true?)
>
> What i’m trying to communicate is that branches, tags, etc are
> treated differently from each other and that Git knows how to
> handle them based on where they are in the hierarchy.

FWIW, I had the same reaction to what response you are responding to
said.  I think Patrick assumes that our target audiences would
assume the "hierarchy" begins at "refs/" and "root" things are
outside the hierarchy, but my mental model saw that the hierarchy
began at the root level, most of things are in "refs/", but one
level above it lives things like HEAD and ORIG_HEAD.  I think both
can be valid, but I do not know which views are more common.

Thanks.

