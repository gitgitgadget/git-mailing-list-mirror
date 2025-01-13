Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E932563
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 17:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790493; cv=none; b=ZcHWQGiKS7WRFzlX01FIq0ldCZlMlMpz69JrpDh8N6vBG/O5M0WW9HxzYmzFJiWKS6GEXNvqM5rrH5rXPOzewclpTPmC57oGyNHpaOvO3T3fkO48H5AS1fyEjZ1k6yktG6PbImm4cf0C5EvLtekPyvId5OCHjsptsuGIR0LPKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790493; c=relaxed/simple;
	bh=zb+EdWDfmI9QvjHxShMbU19et2f+xOKixQuX9k//pcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MA1ZS2DRC+X2G7XI226dlDhh+WNNW6HOIXr4QUoGavWoRk5qnTC+7KvvtJN9WG5KdpezIdgdIGUwQIZB8m69vD8JKapNYP4smXYZ9hpfie65dv5ZauO15iw19BFVbp81yrnxTPs1Q2BgEhos5ZJcQlvHuNUhR/DLhuyY3eiTL7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0pwYpm2V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igzbHWlU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0pwYpm2V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igzbHWlU"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id E3EB7114010F;
	Mon, 13 Jan 2025 12:48:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jan 2025 12:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736790489; x=1736876889; bh=ewnYHg6DbO
	Lr6lXSLVY+ouZvW44w5aa/fGEk0qzq1ms=; b=0pwYpm2VU6+sbgqk8O0p4ta7ob
	W2lamPdCg547yJW4jk4tJdF2pSDpW7mmi0JILy1PXIEggoxhhoB4t63232No5JGc
	EpLvxegXZTztBBXNfLgxA28LA7xanTTzfCHq8BDe8o0b3Ky/fCSkjwriFs04geK/
	Mmrf7ZQX1FdgFiTFqnFdTrlmwYUHQM8mejCfYRmUI039sYhLiV7my21pRLJIE2TK
	riYRmSXOwJrgbaqsbFJxOhRhN+OWw1xG7L593AY+UIathT67nocOqcH1cGNG5Kg8
	Wb0m5rnHsdsXImpYT+SP7XY0Z5ycQT8V09JV4abj/zn03zzSC29TqUC/GaeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736790489; x=1736876889; bh=ewnYHg6DbOLr6lXSLVY+ouZvW44w5aa/fGE
	k0qzq1ms=; b=igzbHWlUN9Nrlu/KLS0DheSw+9GyOFlQrVsj6kYtykfqjsOayKa
	QY8XeJM/0aJQ0NC9L4kBZOaCLTc6Rs2nlTfEIejy0fcXzolFd1/vU+m5/3zEdxkG
	YfnnpSIaZxmbqP0CsqIAQGoKZRHsfmrVGgR6vAubt2PeVKYv4ZOM6rZs/HhyYjkZ
	V3OgUwYWJ15M9IuHfwOd2awKLV1vL7KkFgQ1JmIxLfAdzV9w7LrSAr36cWLXPMwy
	5/2CC31qB2BMiQFvJBh8YcW2yu3t/Fz+rpQvx2dhst9+Ai7Vlvfeyuqj5nj4lECG
	ge8r2O4ymNsFbKKovsvvMOJpiv/0xuFU6ig==
X-ME-Sender: <xms:2VGFZ2P44zNOj3iu38zYo7izqXYsmDvwCuK2fwAGUfX68W25DNLRZg>
    <xme:2VGFZ0_Qcwaz20z5fgDWuNIB6CloK6oRd6NSgsETnfJhNAH0GOLOO41XKST0uLm38
    sG7cAikR2POXRuonw>
X-ME-Received: <xmr:2VGFZ9QDq07dPnlCQo_Rv1RPX1fVHSvB-wJjqV4zJnFs8hXpCzwzMVDvmCWg3krhulr0DcSRIE7iJLq80ieOZHBotm97I_vxhlgL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehgedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghstghhfi
    grrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:2VGFZ2uFlMgStTGVATnmwFlH4byKgZpKEr_QpfGsasLxPsuood93JQ>
    <xmx:2VGFZ-e0AtzRyKtXGbQ1DNLfT2nIrY0VaZ6_CzTsL01_eFA6jzbqgQ>
    <xmx:2VGFZ60sibMY54dfoV-cWx_2abLYtTgmbNy4OxO8zvvu_EBXZjv-ug>
    <xmx:2VGFZy8FpVdAQG2yXjEzGkLxKGfKhQCh2mliYsNchfolFYY1JtZHtA>
    <xmx:2VGFZ7Hq06EINWtPFx1a3deNlcIq7LFTvFf_-Wyty7yGRZwXYSRxpoiY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jan 2025 12:48:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Evan Martin <evan.martin@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH 6/9] meson: wire up fuzzers
In-Reply-To: <20250113-b4-pks-meson-additions-v1-6-97f6a93f691d@pks.im>
	(Patrick Steinhardt's message of "Mon, 13 Jan 2025 09:33:39 +0100")
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
	<20250113-b4-pks-meson-additions-v1-6-97f6a93f691d@pks.im>
Date: Mon, 13 Jan 2025 09:48:07 -0800
Message-ID: <xmqq5xmia9m0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Meson does not yet know to build our fuzzers. Introduce a new build
> option "fuzzers" and wire up the fuzzers in case it is enabled. Adapt
> our CI jobs so that they build the fuzzers by default.

Nice.  We have shipped a feature release with bunch of meson.build
files, but it has known holes we need to fill, and this is one of
the missing things.  Let's make it a goal to achieve feature parity
within two releases---if we can do so in one release cycle, that
would be great ;-)

Thanks.
