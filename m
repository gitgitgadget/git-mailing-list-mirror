Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9648F2BD008
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862788; cv=none; b=F0oIYItWTstN5rWOCDnyZ49coxOcQDS/4yNhARMXh2uER/zUxMp69r+BN3xvzexgzotb3vlsjov6ZDnmgY5vBX7UIINLcN/DCZkuykQP3jqTp3iFEzkXbqQQms1QCkIB/90KR5jKBipVkOznbrZQh7NOgiic8/Dpw+W4NgOa90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862788; c=relaxed/simple;
	bh=gDssZKWes656Nq+GruRzoKC+QeQJa6CLImBVuUa3Du8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T+UnxO+HXtxY/i4fNkDQN37R1fTjF4Fj3KQxtEPDWyHM5zobh+I+tDxf6XYWlutTdKWgaa/umWwwSnyptrKqdGFoxJZPi+3fESj9gHapvenQaAoexNTapocce3zakux+1Qo/flXhq9Dr0Xeg5FEj40Z5p27vlFkZlQjfkO1btXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NRXd9cZe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=o9aicLq1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NRXd9cZe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="o9aicLq1"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A133A1380473;
	Wed, 21 May 2025 17:26:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 21 May 2025 17:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747862785; x=1747949185; bh=FVgaPoYX2B
	zZWgxiWZ1FtfmnZmo3Pv7xE/PiFHoQCNQ=; b=NRXd9cZeQk+eysVDV2RIHDHkCo
	bLyecVgqdW1vHnh2tiTcK8KjLDRusWJU4C3FOL3yYhlJyPKH2Kd/INJlBFn2RBDh
	v/H0QLjiNpj0rrtgcnneyTif5TcQjcwuL/v7yczra+vcWCos/iLNTpctUkk6BAEI
	gfO/nNCs2G6qLn1OB+Qluy/xFpKw/dgRnNl+R92AlZE/8oKBJvUMbebm+oeLkl4z
	gFhHhxTQ5le+18/ZJbXg06bQfsjTYzwMYwN8rjp9ana3W5TWTCikjikbJMLPMZRl
	Pw7MlBBCMu8z9w2OXVP68W945p1/uzc1EH13ikv4JbIey11Dk1+K8LeaDhhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747862785; x=1747949185; bh=FVgaPoYX2BzZWgxiWZ1FtfmnZmo3Pv7xE/P
	iFHoQCNQ=; b=o9aicLq194XxQIQ/kXjFl73dpUtQMnjYL1lnZh5MUHInd1CDE96
	sug9/RM6fC2fQt3bvp6N0AM2VQqp4T+2tpF0NTBrwOSSQQxj2NY6eRgYPxiylhGh
	+XC+Fu0kKu/XeICzwOSalWx8S1lvHjyEHWhHzEJqNQ/wzy4v3O7slDU/V0fDiAmz
	gI0EpgVvF/lcVAilMEH5OGNLk39VWFEvfhksp3x2xl8LDSqH0nfdLrhajzjxhk+1
	evhMFuBTGyk/M+fefG9SLYY4tqad5N4wgjU3Nh5Y/9UjZuBz3RxOO0qKyil13OyX
	Y/+BPU+a+auqz2cD7vw9VBP0i1CQX96tAwQ==
X-ME-Sender: <xms:AUUuaJAgEAYtx6YAXTHpAEFWTKgqQbYpfg-r3UBMyj6e1Houg0wwrg>
    <xme:AUUuaHhZ1T4TWdwvBwVu570PXYLt_BqbAa05BMYkEqD5eCXk7EZpbV3jtVJ3GrtIV
    DHnOk4FVAGnVFOmgg>
X-ME-Received: <xmr:AUUuaElAOfGE2bmrg3V2ZAVHJXVhg0FUl14MKD04vHesvvUbxfjBby-lHzH-LuMG8f0gcO5lHq7Sj_hQUdpX3bL_rXNS_N0jtMvQ7BY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdegudeiucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefujghffffk
    fgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceogh
    hithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeev
    feehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpe
    hgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgr
    ihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhope
    efpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AUUuaDxhUfsipMskkDIOl_l57qOwI-joCoq9bMIdXrxBDtrh36Z9IA>
    <xmx:AUUuaOQSlgZT6DPLSl4t9vMlNOntOlC3RcbvmwXz2JU0Ccpq1nRa4w>
    <xmx:AUUuaGZ_9UW0VO0wRQKhm0SBBSWU9ZSCHACCWaF3Vu67SH-NVLNepQ>
    <xmx:AUUuaPRzorLiCs_ryHkXRPDUzYo-ITFxDZwHsYGZS6DAioSUYa0WJA>
    <xmx:AUUuaHBlXN0OxI5dIgBl0ws0LMv6xhIjo87_dL77GbfcXrc05mKY91QS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 17:26:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] meson: parse TAP output generated by our tests
In-Reply-To: <xmqqcyc2aqy7.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	21 May 2025 09:06:40 -0700")
References: <20250506-pks-meson-tap-v1-0-5aaab2942a4c@pks.im>
	<aC2xp4Cdb0j6OX-G@pks.im> <xmqqcyc2aqy7.fsf@gitster.g>
Date: Wed, 21 May 2025 14:26:23 -0700
Message-ID: <xmqqfrgx8xkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>>> This new feature is only enabled with Meson 1.8 and newer, which
>>> contains a bugfix that we have upstreamed [1] to make the TAP parser
>>> work in `meson test --interactive` mode.
>>> 
>>> Despite the changes to Meson itself, this patch series also contains a
>>> couple of fixes for our test suite that caused us to not generate proper
>>> TAP output.
>>> 
>>> Thanks!
>>> 
>>> Patrick
>>> 
>>> [1]: https://github.com/mesonbuild/meson/pull/13980
>>
>> Junio, I noticed that this series isn't yet part of the "What's cooking"
>> report. Is that intentional or an oversight?
>
> Neither.  I saw a lively discussion on the patches and was expecting
> to see a finalized updated version, which I would apply.
>
> The "Please hold off" message in the middle did not help X-<.

So the four patches are now sitting somewhere in 'seen'.  Is it the
one that causes this failure, I have to wonder?


https://github.com/git/git/actions/runs/15169816296/job/42656836511#step:4:2113

It is curious that only osx-meson is affected.

Thanks.
