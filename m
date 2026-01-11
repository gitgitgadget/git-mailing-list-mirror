Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2251862
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768110423; cv=none; b=ZDGeA9y32qE0L3HogIsmYdqm3dqEexXZlcENUHaVIVc+P2n6aFGnQ630IN1laV3G7thWiMM7QA/qKU1PqIIEUwRZxm1PbLfokk1cfb0VqLMOHMOFNqNMiVTgJRfBLPQb+SkcG9Hv61N9lSz4gAWA9DKEp5bZC/bnfL2XVSTjokA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768110423; c=relaxed/simple;
	bh=Ogl2dWcIv1Y2xzqFric+I5de+in3TmyR9g2U+4wVUQ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BbmFAI4WGGPtMoz1Jlu/YLsLcBA/33ZaArh8goRsdOu+8yaZCbeL3vr9KgUpNhG7GL4OlhiYHeBq4aUfY9BaBlV4q3y3OtzfXuBRmcFQ8gnyWSNKgk4j/vhqO9FBpAUtrt9i+QUWBEKwHoGvGrifdcvub5TdRJgbIeKxqgdXDGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IjfDssCf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MWll07aO; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IjfDssCf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MWll07aO"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id EF5731D000F6;
	Sun, 11 Jan 2026 00:46:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Sun, 11 Jan 2026 00:47:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768110419; x=1768196819; bh=3MjOwr4EaF
	o2FdGbvCRF0w1b7OQGjmWbeKHNa7olwhQ=; b=IjfDssCf+ZHxSkZOvozEK5qQPD
	j8h7cGPdO/uuFCBLujMgyDT3bNdE80eu7LNCiEJhjDVwOYvnqi73AAQzEJrmbO7y
	JGgsQodRvCl5HGVhmo8qRHbQ95mhkjLtzXf53X/RJxcoWCnWBHNXtrzn2yCVFfL1
	gSXRt2GfTzCDwW3CPGVKMaGxtTr3a9ObqcPWbr9lxDCJCC835C3aSCI4Vjry2j03
	8qWHRMbxkPdekG9t04jGFDxdOmnkpi1SLA6lrK2yz+aeIl7Us1KtV3eoC9Ldp20e
	ROplKkaV3YenIoC3o43HDUhrXNwtGLw1qynrLplnwREOF1Py2PCLCrZX2LyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768110419; x=1768196819; bh=3MjOwr4EaFo2FdGbvCRF0w1b7OQGjmWbeKH
	Na7olwhQ=; b=MWll07aO1CvtzLSuCsODcwtXHehhGr/UHanTWD1ETIY7PLPKlB5
	O5eXISxQOcgxzAtznzkNX22+078MGjiKk9pcUfMiHHQ6ZUED6mI2HW88YmyojE6M
	2fihyV0PohqOBNUtrVmKLzhYucbM0ytk2uPaZiVjaj4D931jdNcJLP0afeIdCpXy
	zV9lU8xiJNeytBFJd3JSLLDE2UGyEcv7kE5ZnNqILV910527xFq6rAOsanSqkF9N
	NOFJmBj97YE0UiB7qMHMgzaAeAkAziu9dU1/pV+//fy379FUeEmJjydoQT1LCL9j
	brd8FnJoYN05xbAvof6AsgeDc97DOXeP2jg==
X-ME-Sender: <xms:UzljadZWYfXdf59OkmRLvf-mbwkiG1gXM8kxD1gnI6qby5Cy2G5jsQ>
    <xme:UzljaYF-L4eHFzClio5IFzK0_zLW0eM5xl7QRXJOkTWwhsbmHHAsTtOnTbtf7bHci
    5Ka-UKGhEQ_rbHAA4MZgpKPXaVKCwHte0bm28-O2PvinnQxU9QiCDg>
X-ME-Received: <xmr:UzljaZwdkABi4a1tGDevGmMKLvF1vu6-yWlSQzR8b3DjjjN0_rPJE3eFNqTivybwdwS5n6BPJT9vpG87BEWfxTvLaSa3kM8oTm7AEPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudefjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptedttdevffeuieeilefffedtiefgfeekveetveevuedtlefhtddugfeltdej
    ledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpsh
    esphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehtoh
    honhesihhothgtlhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhs
    sggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:UzljaSkztC90iGkT_nxwAaXwk7SS7ld-7knw_FpXKSqync4kMoH22Q>
    <xmx:Uzljaalt8lOPEFdX0580commu6uegjLJ5krv5muNsZPrbEJW0AVAuA>
    <xmx:UzljacylusGrUhCLtrGsPyApHtVfZhjDhJUpC0GDhGMH9k7Y87BwUg>
    <xmx:UzljaXpWhvvckkct8Vm2yH8llbkZnEGonwQRvigwJbdXnNYPIki7ag>
    <xmx:UzljaWdTBdFd18KTby2VA16i9AF_TND9PgjTygKtUxF8syXv-IG5rhd4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Jan 2026 00:46:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Justin Tobler <jltobler@gmail.com>,  Toon Claes
 <toon@iotcl.com>,  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 00/10] Start tracking packfiles per object database
 source
In-Reply-To: <20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
	(Patrick Steinhardt's message of "Fri, 09 Jan 2026 09:33:08 +0100")
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
	<20260109-b4-pks-pack-store-via-source-v3-0-877fd7b7bf81@pks.im>
Date: Sat, 10 Jan 2026 21:46:58 -0800
Message-ID: <xmqqcy3gr99p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The latter topic isn't in "next" yet, but the second version of this
> topic only contains two small memory leak fixes. I don't expect it to
> change, and I guess it should land soonish anyway.
>
> Changes in v3:
>   - Fix a commit message typo.
>   - Link to v2: https://lore.kernel.org/r/20251218-b4-pks-pack-store-via-source-v2-0-62849007ce21@pks.im

Looking good.  Let's see if we hear further input from others and
then mark it for 'next'.

Thanks.
