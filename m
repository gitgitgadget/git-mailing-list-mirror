Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55521FECC6
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 19:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882041; cv=none; b=YOh4e2bZ3gFkLEgbtxof4zVF0cdOrlLpsFVYcjPmfdkU/nj8O1Uc11/L/kYbIIh53kpdo0zhczEWs/Mwp2Z7KOskrarzo4nps35L9+vrdjei4S5ImKQL/wHbS+lLG8yiFtrWBi8F6HvDgx1uhvtL76r233H9C+LyIjl4nQtvoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882041; c=relaxed/simple;
	bh=kulxB6xenTeBuGmWXyhfg3q6R+7OpOwpN3J2lIHNoKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QpZYOudK9IWikyI3SJCb+cdkQ0wPeg45faKcSMDSolgH9FSBwml1uO2v39mLIX/TN4nYEJJFIiJAybroHjCbdtH4mvLwI6sinC77inQo2k4lj/UOqdLkSdUFdlHQbGDiXRCdKtQVEuCWKhqbBihR/rfR4q9OMEbKgsk9ia6+coE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F8UF+zzv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ADqWKZzd; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F8UF+zzv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ADqWKZzd"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B737C11401EF;
	Tue, 14 Jan 2025 14:13:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jan 2025 14:13:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736882037; x=1736968437; bh=p/+Qz02OlV
	OOighr9mO+sGc7QwN2yTxcPBe7f3r+1vU=; b=F8UF+zzvG5qU5NsuWXcbVdWSNA
	ttzgOrGhHpaFNV7I1gzPsbnUyBo5AFH/mnaxhwH3We5q68vcg9begyo+7U6XQuTF
	H7376bT1x+206/Tk79JXgX9pwki4us4Ad726P295xqWZY/rwwKVIzIJgy2Lcqxtu
	6g7hmtTVwRo/+ehGV7oeFq5nuFGnByqTfQ4VCHYTcZD1snv5ifjvxsSBEtOouH1H
	TNBpkxW+2gpdCHWCoe8RuktEvLBMSgWzA8uzjLnn7fa6vO4xIDEwnVveObOcOQWF
	dKsD3AWun0TJ2ObJo8bNM/U4dhIneixs3MgKpqgdIochyu/nOHvlSyS5hQug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736882037; x=1736968437; bh=p/+Qz02OlVOOighr9mO+sGc7QwN2yTxcPBe
	7f3r+1vU=; b=ADqWKZzdZTx6FyWvTTfvSbi8acSe3AOnmwbyhXSu+4EfRC3yy5Y
	AmZuYO/5s7M10d+DTmviXNururU9bVnjUZi+8n+xS6PMVX6zGwF1Tg7Wihfliw9T
	b5yg4yGLhPmdAF0EojGPUS9xiQi342MRPOi1Nl+gtGo2NnJIkt35VIXq+o38ZXet
	5GzNhlsg5d1jM8cDlWeYxC5wmXqcBBZkQlHj0qt5SKfv9nuIv2f9tGSnIEZybYnA
	a3FunWUwohGwlxYbV+j3rdh1qm5v/C0ZOVH1HF4+xJ4d8iTT9WpURJgi98ggxFjj
	ZH0mg7hzc6Xftsi8lD/41esGrC3RKqY7Uyw==
X-ME-Sender: <xms:dbeGZ83utRIb2HUAwrBmjEAbbylOC1ViS06Mwgb-tVWVHrx5JcwSrA>
    <xme:dbeGZ3H39J5Mm5WzXlG7fINCt2XdL6D8jcrrXAcBR0Z5H3kCIUFSMDoLG2DrIAnKm
    I7kks4Gbs725TdoRg>
X-ME-Received: <xmr:dbeGZ045KdaqE6q68cd-Y-JGIHut4L-IHJ6cC9_qVhZIQ2KQd2TnJWKcVWsZDhnsIep-Okwa5R9kQnkS6928G0hxbz_dO4Bq2oQ0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedguddvudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:dbeGZ13m1PUYizALtROLN51qinOS0nYJr_4lemxhVSh4skzG845O6A>
    <xmx:dbeGZ_FnnTKajAvZmm1kxFtSUiKXtcGLxn6jETWzp49HYbEnRtqjtw>
    <xmx:dbeGZ-9jeknqj8qSfKrY_3bvZNMN-RReB4h3sUsqt5DEYv5ry42aDw>
    <xmx:dbeGZ0nY1hNFCxdtmcRZMMrwnCz0S8G2qcgW13OqsVQQGA8ymdf5Gw>
    <xmx:dbeGZwMZ2769r1Pwidi45J-WTfw9kBn54ox_YKVChVuo1AnwaWEKHrvM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 14:13:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Evan Martin <evan.martin@gmail.com>,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH 7/9] meson: make the CSPRNG backend configurable
In-Reply-To: <Z4YqtlfxIh4p6qPx@pks.im> (Patrick Steinhardt's message of "Tue,
	14 Jan 2025 10:13:26 +0100")
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
	<20250113-b4-pks-meson-additions-v1-7-97f6a93f691d@pks.im>
	<xmqqr0568uhy.fsf@gitster.g> <Z4YqtlfxIh4p6qPx@pks.im>
Date: Tue, 14 Jan 2025 11:13:55 -0800
Message-ID: <xmqqv7uh2op8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Yup, it's the exact same order as we have in our Makefile and as in
> "wrapper.c". And yes, good idea, I'll add a comment.

Yeah, a comment is a good starting point.  We should say something
along the lines of "if you are tempted to change this, change the
other one to match" or something.

If we can keep a single source of truth and derive these two places
that should stay in sync, that would be ideal, but that can be left
outside the topic for now, I think.

Thanks.
