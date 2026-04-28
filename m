Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81593224AF9
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 01:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777340825; cv=none; b=Ve80qIxlALelSeUc9jnM5GO3QHYius/jQIHRVLuqYfLxRuaOUXLa+oICQ04uq6n8mgMB0MsVvidMf5jGpC7YPaCIxl3Yq67ZrdfMJo7uk+4rN10Jjo17qU3m/4k23D6cVQ7VNdncZ15PaSGWNatfQdGED2Nsbf1E9fQvojEQ6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777340825; c=relaxed/simple;
	bh=ZAq11GmAjDduk15HaXPo/vQaJXdSkHLuQGZMGlzyYzg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+NpcCvFHuIUhR1CJZ1rnz7nMtwcBafq1BuWC2zaqqUKIC0Cf6dUT4eRIVc8aYJQJgN1cpX3vS8S3oZ7TANtQOuW983zMGL/ACPX9D2R6CqL7MuTS0gcUFjbdVuhff8nq+SCBWZ3+Hf2h9Yw2470EfoFf6c8qLUq/Lgt2MbQ49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=yD3YTNXt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D0ZRQIzF; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="yD3YTNXt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D0ZRQIzF"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B1E5F1D0021D;
	Mon, 27 Apr 2026 21:47:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 27 Apr 2026 21:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777340823;
	 x=1777427223; bh=8hD2FIiGfA6QR2SnrcJIOvrJd5oLsFY9NJTUCbLkkXU=; b=
	yD3YTNXtX8kBggcp6FlqJcpQZcgYuzaerxWUJjehLjOJ1ljQ7YOt4gX6E5ZSI09K
	xUiZ5HIZXZ5bh4pFmo9r2k03hf1WQnbso/Dx+kQWtL+mukQe3B2sCJ429BnS0qz/
	90k24XZgQXigActDVetzmDYxQH78Oo4gh+7OHuuUx/BLSnTNV1aY9XTFS4db9tcz
	3b+9PH4K8sU6+lUdX7j54u+Ks+DsqppKEzZhBUAc5O1uWs7z69oDbps2jHhfJ6ux
	yEKUDqGhnJeUI8u+iQ8im8mEx3FyJN7AfD1IvhOTVIuLrSEG4bFKU4kxPdzGpB9C
	1R8peXKS75+pO02HfDC+Eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777340823; x=
	1777427223; bh=8hD2FIiGfA6QR2SnrcJIOvrJd5oLsFY9NJTUCbLkkXU=; b=D
	0ZRQIzFlFq32sBefrbzGfHfhC4L7fYrOMcK7l7Ir+KtS1AnuV24+hF4brF7IEEYs
	CxFsC4U2oUQrysnenKH767QcUkU7OiMU/63aqzTMmQADctsypIJwjGVCddNPoDNN
	q+g/6wI2W4YMAw6D3GAH+WBgdZzLez0fTvPZ25v3y8yU7c5Z4u8cFwILcrcBQcTU
	IAie+T4AOLpN9RL+l5RS1l8yAnozZNc9++TPeq0BJlnWUY3F8bj4qTC3vSMLTNEM
	gBQsxtO3DjG6yfpYE329g4/c4E7j7kGz9ebOsJ1yofHwAWDr+47+JMkW3k94L0ND
	6+W+VfABa7DI6lIJtLPGA==
X-ME-Sender: <xms:lxHwaUS3zfUufsWSzEWhVWciS-JktNxWpjABo1WxgvsyNxI0sjewxg>
    <xme:lxHwaTRKj-vRlP1Bvpgg7O6OCGeeMNMN1LDvaiBSkirM9dY4OS9cPbPLvY3vD4Eef
    Jcbpg2-XA0NUbZGoHuQ6Db0XwkrgoFV4WBvD9x0O9NJPkVHRQIRdWg>
X-ME-Received: <xmr:lxHwaR4Ns70DLGLuQyuAmLbDeSg0M_f0kdkffSg0h9QcBSkUAVV43yR6t1MXgqaaoLr4FK6O2uat7KAJz5SyrWLxDV2RcjgQ9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdektddvlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehssggruhgvrhhsfhgvlh
    gusehgrdhutghlrgdrvgguuhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:lxHwaX3jqcIe79sI4eOFduTHS2r1TOWIak1MlN4Z8MDl3p5YPm-SDA>
    <xmx:lxHwaUByLfgd_3VP42hF9JBtnnhpH0GgC7QyV6PlPNB-c8g-kCNzdQ>
    <xmx:lxHwaaNmcEqYYicR7xOhE7fECnxAxROXc-sKmrXD12lTHemmAtYqoQ>
    <xmx:lxHwaRaAGe9eTELNMpGgaz-m3BAhA1D45DAYsRY46nW_YRHKS_1uPA>
    <xmx:lxHwabg19-SQd2KPLOaQP0ugooDWJ14AAO0V_E7lAvJJWpNa1ju09fdg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 21:47:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Scott Bauersfeld via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Scott Bauersfeld <sbauersfeld@g.ucla.edu>
Subject: Re: [PATCH v3] index-pack, unpack-objects: increase input buffer
 from 4 KiB to 128 KiB
In-Reply-To: <469a26e8-4309-4221-abac-e9a09e3f743d@gmail.com> (Derrick
	Stolee's message of "Mon, 27 Apr 2026 16:12:55 -0400")
References: <pull.2282.v2.git.git.1777306114914.gitgitgadget@gmail.com>
	<pull.2282.v3.git.git.1777317998098.gitgitgadget@gmail.com>
	<469a26e8-4309-4221-abac-e9a09e3f743d@gmail.com>
Date: Tue, 28 Apr 2026 10:47:02 +0900
Message-ID: <xmqq8qa726w9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Derrick Stolee <stolee@gmail.com> writes:

> On 4/27/2026 3:26 PM, Scott Bauersfeld via GitGitGadget wrote:
>> From: Scott Bauersfeld <sbauersfeld@g.ucla.edu>
>
>>     Changes since v2
>>     ================
>>     
>>      * Renamed DEFAULT_PACKFILE_BUFFER_SIZE → DEFAULT_IO_BUFFER_SIZE per
>>        Stolee's feedback. The constant is not packfile-specific, since it is
>>        also used by the hashfile layer.
>>      * Stolee noted that WRITE_BUFFER_SIZE in read-cache.c could be
>>        consolidated. That constant was already removed in f6e2cd0625
>>        ("read-cache: delete unused hashing methods", 2021-05-18) when
>>        read-cache.c was converted to use the hashfile API, so there is
>>        nothing left to unify. The rename to DEFAULT_IO_BUFFER_SIZE helps
>>        account for the multiple usages of this constant.
>
> Thank you for discovering this context which made my recommendation
> non-actionable. I was looking at the commit that added the 128K limit,
> which had that in its context, but not at the latest code. My mistake!
>
> I'm very happy with this version and look forward to the performance
> benefits!
>
> Thanks,
> -Stolee

Yes, this version was very pleasant to read.  Thanks both.
