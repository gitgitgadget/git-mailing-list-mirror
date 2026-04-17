Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165F130EF82
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 04:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776399948; cv=none; b=GZ5LVkCU0Ptilo0CjlERpQ8O2YMuOmuzVlA49b5toKrOugCgrrSu2+chQTi0qMJu7acARoclLHqnLp1De4wyy0WlE9MXIpTBMyEHVfAbskZj3fUBT6MoVcA9m26rz7eqOKzGZeN2VC8/A0ssjq/quBe3SrVksOXb0z1e1fmtcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776399948; c=relaxed/simple;
	bh=EECI0J6DsxA6xZlmbLrgj67zWCwnrLSwEbYqrBDKWCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aJQ51yVEp4m6Ol9PKsEPcWgg7MJgn+KxC/y2Ze7CHU3y0cvLBqh56E9NZz2DgHRFmc7X9RLZQy0MhI17MjVII2Vw+1bSrtL/6wagOBVE9YFbZFIEHMDVz4gETlCn++InTC7NQ2BoCfj9Zrg6TqF00dQq47vOzf0ncuUrQEU960c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ftYd7ARm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HykAfQMp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ftYd7ARm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HykAfQMp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1F060140006E;
	Fri, 17 Apr 2026 00:25:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Fri, 17 Apr 2026 00:25:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776399946; x=1776486346; bh=jdzv91zQA+
	FF3mxpofPy1ffbzLLoAQVjHk25lPOgAoY=; b=ftYd7ARmWFialfixVltWugzhMN
	3PRD9IF5htC+gYngTEM93zx5rCueG4Tx8nT9iwqcuSfjF+mdxVh7yvg0Js4VQNmh
	nYUDNADbMXzgt1SO7kIuaS7E7vjujoJXpHli19OHvtZK+gGATxFD7XJsmwxTRKdZ
	VQeNcB2T3VN6d6uu56vFCsL4yGsWzl4fkDkLZe9P7RnrLt/svBn4hevOxDqZcE+s
	qSX3nxbTVl9m1cWrV2Ykt2u02PCE+jcpP+Bq/O0bbeJu5IXNsMaZpfzjpRz6dc4o
	pVR87MvErHlDtFqS6ujCJGC08jaARfDdAZCljSWBqmtol40qrxH5XRnQJMBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776399946; x=1776486346; bh=jdzv91zQA+FF3mxpofPy1ffbzLLoAQVjHk2
	5lPOgAoY=; b=HykAfQMpOJLcwJxggKK0NDWmz0A9raXWOzYVVXZFgI0fOOofaM2
	cuGLuJNu6I2Nr4hSOA1Hgwik8pfu/KOk1BhjjqqBAPKpUQ//gjdxSVYmVsG+B7M9
	qsg0o36cWksVn5HEP7zZRK0DmFxm+HaOURYgMFsdbkhVc5Lflie0InQEcplnTYeB
	F229IPoHFM1NzyVGTC44OXDmkswP8XdsLJ1DMMBwOHJwLqElISGNVtyXEDQvUDm0
	T2+LoNOh8hQ050lJQxAWW/HGyYaP5GjBSYg5pAJuuPwrP370WfqtB5A7Xacfa/JO
	uBuGT/JrsWX7M9OgzaTDYjlj+rUk6cdoeoA==
X-ME-Sender: <xms:SbbhaSPhRH2qPwQFlieOwAZqJu3a90N7WrjpiqwWK_HT62-DzREm6Q>
    <xme:SbbhaTgukVHM_v3tM9Wop8RnhwU0KZIi4V_K_SLHgX9XmJMD3QZWt_Y83yLfk11Bb
    JANMQAryZiaI8R192lTM4ndgKj5QFbcA-JnLBPrjnhUpv78WSbvkw>
X-ME-Received: <xmr:Sbbhac7SFN3mQMvKxard5dqcEcK9lhLHiCeMXao1yQ40koHuvprQvg9R_sAn8cPJZ4RHTq8hT5KETuamTlOFgtKuhT90oWyaCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegkeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhorhgvnhii
    ohdrphgvghhorhgrrhhivddttddvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthht
    ohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopegtrghtsehmrghlohhnrdguvghv
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:SbbhaS2Lt94xvOaQr-9ndwspRzY3aDjoOY2dsND-WxRSl-p8y2EsxQ>
    <xmx:SbbhafvfLJB8eWsX1WeA4ZIMp9bDFQeywt5Mf3XTJP9-OXuP6x7jBg>
    <xmx:SbbhaQ6WXOs5yfia-5vdT4EnWBEwuPZbA6BGHv5VljR9vCAmPFtHeg>
    <xmx:SbbhaTd0K6eO5gyzrFEq_XUgI2I8ghDvxtDU5EIfGR31hrqrZ4QeBA>
    <xmx:SrbhaWxNFIqgBLzPLZa8ijhkXQhiu2602G6rXNtZBOeMWNJH5lLz6hgE>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 00:25:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  LorenzoPegorari <lorenzo.pegorari2002@gmail.com>,
  Taylor Blau <me@ttaylorr.com>,  Patrick Steinhardt <ps@pks.im>,  Derrick
 Stolee <stolee@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Tian
 Yuchen <cat@malon.dev>
Subject: Re: [PATCH] CodingGuidelines: st_mtimespec vs st_mtim vs st_mtime
In-Reply-To: <CABPp-BGaN_PtvUVyR8sskpLUev16FjaUbTj21j_Lna73hEYGmw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 16 Apr 2026 16:46:13 -0700")
References: <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
	<cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
	<34c4e793113f22c393a6196d6e99a96d78cc3ab9.1775832056.git.lorenzo.pegorari2002@gmail.com>
	<xmqqo6jqpzxv.fsf@gitster.g> <xmqqzf3aofdj.fsf_-_@gitster.g>
	<CABPp-BGaN_PtvUVyR8sskpLUev16FjaUbTj21j_Lna73hEYGmw@mail.gmail.com>
Date: Thu, 16 Apr 2026 21:25:44 -0700
Message-ID: <xmqqmrz2xlfb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Elijah Newren <newren@gmail.com> writes:

>>  For Perl programs:
>>
>>   - Most of the C guidelines above apply.
>
> Looks good to me.  As a minor nit, "need timestamp" -> "need a timestamp".

Thanks.  Will amend.
